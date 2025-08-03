// submitHomework.ts
import { serve } from "https://deno.land/std/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

serve(async (req) => {
  const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  };

  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
      {
        global: {
          headers: { Authorization: req.headers.get('Authorization')! },
        },
      }
    );

    const { assignment_id, student_id, text_answer, audio_url } = await req.json();

    // Validate user authentication
    const { data: { user }, error: authError } = await supabaseClient.auth.getUser();
    if (authError || !user) {
      throw new Error('Unauthorized');
    }

    // Create homework submission
    const { data: submission, error: submissionError } = await supabaseClient
      .from('homework_submissions')
      .insert({
        assignment_id,
        student_id: user.id,
        text_answer,
        audio_url,
        status: 'submitted'
      })
      .select()
      .single();

    if (submissionError) throw submissionError;

    // Trigger AI grading in background
    const gradePromise = gradeHomework(submission.id, text_answer, audio_url);

    return new Response(
      JSON.stringify({ 
        success: true, 
        submission_id: submission.id,
        message: 'Homework submitted successfully. AI grading in progress.' 
      }),
      { 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 200 
      }
    );
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { 
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 400 
      }
    );
  }
});

async function gradeHomework(submission_id: string, text_answer: string, audio_url: string) {
  // This would be implemented with OpenAI integration
  // For now, we'll simulate AI grading
  const supabaseClient = createClient(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
  );

  // Simulate AI processing delay
  await new Promise(resolve => setTimeout(resolve, 2000));

  // Update submission with AI results
  const { error } = await supabaseClient
    .from('homework_submissions')
    .update({
      ai_score: Math.floor(Math.random() * 30) + 70, // Random score 70-100
      ai_feedback: 'Good effort! Your answer demonstrates understanding of the key concepts.',
      status: 'graded',
      graded_at: new Date().toISOString()
    })
    .eq('id', submission_id);

  if (error) console.error('Grading error:', error);
}
