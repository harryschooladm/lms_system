// hello.ts
import "https://deno.land/x/supabase@1.3.1/mod.js";
import { serve } from "https://deno.land/std/http/mod.ts";

serve(async (req) => {
  const data = { message: "Hello from Deno Edge Function!" };
  return new Response(JSON.stringify(data), {
    headers: { "Content-Type": "application/json" },
  });
});

