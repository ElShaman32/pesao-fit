// upload-avatar/index.ts
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

    if (!file) {
      throw new Error("No se proporcionó archivo");
    }

    // Subir a Cloudinary (Cuenta 1 - Perfiles/Avatares)
    const avatarUrl = await uploadToCloudinary(file, "avatar", user.id);

    // Actualizar el perfil del usuario
    const { data: updatedProfile, error: updateError } = await supabaseClient
      .from("profiles")
      .update({ avatar_url: avatarUrl })
      .eq("id", user.id)
      .select()
      .single();

    if (updateError) {
      throw new Error("Error al actualizar el perfil");
    }

    return new Response(
      JSON.stringify({
        success: true,
        avatarUrl: avatarUrl,
        profile: updatedProfile,
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