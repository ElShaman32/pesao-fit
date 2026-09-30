// upload-progress-photo/index.ts
import { createClient } from "npm:@supabase/supabase-js@2";
import { uploadToCloudinary } from "../_shared/cloudinary.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      throw new Error("No autorizado");
    }

    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_ANON_KEY")!,
      {
        global: { headers: { Authorization: authHeader } },
      }
    );

    const { data: { user }, error: userError } = await supabaseClient.auth.getUser();
    if (userError || !user) {
      throw new Error("Usuario no autenticado");
    }

    const formData = await req.formData();
    const file = formData.get("file") as File;
    const category = formData.get("category") as string; // 'front', 'back', 'side', 'other'
    const photoDate = formData.get("photoDate") as string;
    const notes = formData.get("notes") as string;

    if (!file || !category || !photoDate) {
      throw new Error("Faltan datos requeridos");
    }

    // Obtener el gym_id del usuario
    const { data: membership, error: membershipError } = await supabaseClient
      .from("memberships")
      .select("gym_id, role")
      .eq("user_id", user.id)
      .eq("status", "active")
      .single();

    if (membershipError || !membership) {
      throw new Error("No tienes una membresía activa");
    }

    // Crear nombre de archivo con fecha y categoría
    const dateFormatted = photoDate.replace(/-/g, "");
    const filename = `${dateFormatted}_${category}`;

    // Subir a Cloudinary (Cuenta 2 - Progreso)
    const folderPath = `progress/${user.id}`;
    const photoUrl = await uploadToCloudinary(file, "progress_photo", `${user.id}/${filename}`);

    // Crear thumbnail URL
    const thumbnailUrl = photoUrl.replace(
      "/upload/",
      "/upload/w_150,h_150,c_thumb/"
    );

    // Guardar en la base de datos
    const { data: progressPhoto, error: insertError } = await supabaseClient
      .from("progress_photos")
      .insert({
        client_id: user.id,
        gym_id: membership.gym_id,
        photo_url: photoUrl,
        thumbnail_url: thumbnailUrl,
        photo_date: photoDate,
        category: category,
        notes: notes,
        uploaded_by: user.id,
      })
      .select()
      .single();

    if (insertError) {
      throw new Error("Error al guardar la foto de progreso");
    }

    return new Response(
      JSON.stringify({
        success: true,
        photo: progressPhoto,
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