// _shared/cloudinary.ts
import { createClient } from "npm:@supabase/supabase-js@2";

// Configuración de las dos cuentas de Cloudinary
export const CLOUDINARY_ACCOUNTS = {
  1: { // Cuenta para perfiles/avatares
    cloudName: Deno.env.get("CLOUDINARY_CLOUD_NAME_1")!,
    apiKey: Deno.env.get("CLOUDINARY_API_KEY_1")!,
    apiSecret: Deno.env.get("CLOUDINARY_API_SECRET_1")!,
  },
  2: { // Cuenta para progreso/pagos
    cloudName: Deno.env.get("CLOUDINARY_CLOUD_NAME_2")!,
    apiKey: Deno.env.get("CLOUDINARY_API_KEY_2")!,
    apiSecret: Deno.env.get("CLOUDINARY_API_SECRET_2")!,
  },
};

// Mapeo de tipos de archivo a carpetas, cuentas y transformaciones
export const FILE_TYPE_MAPPING = {
  avatar: {
    account: 1,
    folder: "avatars",
    maxSize: 5 * 1024 * 1024, // 5MB
    allowedFormats: ["jpg", "jpeg", "png", "webp"],
    transformation: "w_200,h_200,c_fill,q_auto,f_auto", // Avatar 200x200
  },
  gym_logo: {
    account: 1,
    folder: "gyms",
    maxSize: 5 * 1024 * 1024, // 5MB
    allowedFormats: ["jpg", "jpeg", "png", "webp"],
    transformation: "w_400,h_400,c_fit,q_auto,f_auto", // Logo 400x400
  },
  exercise_image: {
    account: 1,
    folder: "exercises",
    maxSize: 10 * 1024 * 1024, // 10MB
    allowedFormats: ["jpg", "jpeg", "png", "webp"],
    transformation: "w_800,q_auto,f_auto", // Ejercicio 800px ancho
  },
  payment_receipt: {
    account: 2,
    folder: "receipts",
    maxSize: 10 * 1024 * 1024, // 10MB
    allowedFormats: ["jpg", "jpeg", "png", "pdf"],
    transformation: "w_1000,q_auto,f_auto", // Comprobante 1000px ancho
  },
  progress_photo: {
    account: 2,
    folder: "progress",
    maxSize: 10 * 1024 * 1024, // 10MB
    allowedFormats: ["jpg", "jpeg", "png", "webp"],
    transformation: "w_1200,q_auto,f_auto", // Progreso 1200px ancho
  },
};

// Función para subir archivo a Cloudinary
export async function uploadToCloudinary(
  file: File,
  fileType: keyof typeof FILE_TYPE_MAPPING,
  customFilename?: string
): Promise<string> {
  const mapping = FILE_TYPE_MAPPING[fileType];
  const account = CLOUDINARY_ACCOUNTS[mapping.account];

  // Validar tipo de archivo
  const extension = file.name.split('.').pop()?.toLowerCase();
  if (!mapping.allowedFormats.includes(extension!)) {
    throw new Error(`Formato no permitido. Formatos válidos: ${mapping.allowedFormats.join(', ')}`);
  }

  // Validar tamaño
  if (file.size > mapping.maxSize) {
    throw new Error(`Archivo demasiado grande. Máximo ${mapping.maxSize / 1024 / 1024}MB`);
  }

  // Preparar el FormData
  const formData = new FormData();
  formData.append("file", file);
  formData.append("api_key", account.apiKey);
  formData.append("upload_preset", "pesao_fit_preset");
  
  // Construir la ruta completa
  let fullPath = mapping.folder;
  if (customFilename) {
    fullPath += `/${customFilename}`;
  }
  formData.append("folder", fullPath);
  formData.append("public_id", customFilename || file.name.split('.')[0]);

  // Subir a Cloudinary
  const response = await fetch(
    `https://api.cloudinary.com/v1_1/${account.cloudName}/auto/upload`,
    {
      method: "POST",
      body: formData,
    }
  );

  if (!response.ok) {
    const error = await response.json();
    throw new Error(`Error de Cloudinary: ${error.error?.message || 'Error desconocido'}`);
  }

  const result = await response.json();
  
  // Agregar transformaciones a la URL
  const optimizedUrl = result.secure_url.replace(
    "/upload/",
    `/upload/${mapping.transformation}/`
  );
  
  return optimizedUrl;
}

// Función para generar firma de Cloudinary (si no usas unsigned upload)
export async function generateCloudinarySignature(
  params: Record<string, string>,
  apiSecret: string
): Promise<string> {
  const sortedParams = Object.keys(params)
    .sort()
    .map((key) => `${key}=${params[key]}`)
    .join("&");

  const signatureString = `${sortedParams}${apiSecret}`;
  const encoder = new TextEncoder();
  const data = encoder.encode(signatureString);
  const hash = await crypto.subtle.digest("SHA-1", data);
  
  return Array.from(new Uint8Array(hash))
    .map((b) => b.toString(16).padStart(2, "0"))
    .join("");
}