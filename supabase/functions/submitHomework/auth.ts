// auth.ts
import "https://deno.land/x/supabase@1.3.1/mod.js";
import { serve } from "https://deno.land/std/http/mod.ts";

serve(async (req) => {
  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) throw new Error("Missing Authorization header");

    const token = authHeader.split(" ")[1];
    const { payload } = await fetch(
      `${Deno.env.get("SUPABASE_URL")}/auth/v1/token?arg=${token}`
    ).then(res => res.json());

    return new Response(JSON.stringify({ user: payload }), {
      headers: { "Content-Type": "application/json" },
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { "Content-Type": "application/json" },
      status: 401,
    });
  }
});

