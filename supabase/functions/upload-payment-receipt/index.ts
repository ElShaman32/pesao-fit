// upload-payment-receipt/index.ts
import { createClient } from "npm:@supabase/supabase-js@2";
import { uploadToCloudinary } from "../_shared/cloudinary.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

Deno.serve(async (req) => {
  // Manejar CORS preflight
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    // Verificar autenticación
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      throw new Error("No autorizado");
    }

    // Crear cliente de Supabase
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_ANON_KEY")!,
      {
        global: { headers: { Authorization: authHeader } },
      }
    );

    // Obtener usuario autenticado
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser();
    if (userError || !user) {
      throw new Error("Usuario no autenticado");
    }

    // Obtener datos del formulario
    const formData = await req.formData();
    const file = formData.get("file") as File;
    const paymentId = formData.get("paymentId") as string;

    if (!file || !paymentId) {
      throw new Error("Faltan datos requeridos: archivo y ID de pago");
    }

    // Validar que el pago existe y pertenece al usuario o es admin
    const { data: payment, error: paymentError } = await supabaseClient
      .from("payments")
      .select("*")
      .eq("id", paymentId)
      .single();

    if (paymentError || !payment) {
      throw new Error("Pago no encontrado");
    }

    // Verificar permisos (cliente dueño del pago o trainer/owner del gym)
    const { data: membership } = await supabaseClient
      .from("memberships")
      .select("role")
      .eq("user_id", user.id)
      .eq("gym_id", payment.gym_id)
      .single();

    if (payment.client_id !== user.id && !["owner", "trainer"].includes(membership?.role || "")) {
      throw new Error("No tienes permisos para subir este comprobante");
    }

    // Subir a Cloudinary (Cuenta 2 - Progreso/Pagos)
    const filename = `${paymentId}`;
    const receiptUrl = await uploadToCloudinary(file, "payment_receipt", filename);

    // Actualizar el pago con la URL del comprobante
    const { data: updatedPayment, error: updateError } = await supabaseClient
      .from("payments")
      .update({ receipt_url: receiptUrl, status: "pending" })
      .eq("id", paymentId)
      .select()
      .single();

    if (updateError) {
      throw new Error("Error al actualizar el pago");
    }

    return new Response(
      JSON.stringify({
        success: true,
        receiptUrl: receiptUrl,
        payment: updatedPayment,
      }),
      {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 200,
      }
    );
  } catch (error) {
    return new Response(
      JSON.stringify({ success: false, error: error.message }),
      {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 400,
      }
    );
  }
});