import { Request, Response } from '@sveltejs/kit';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(PROCESS.ENV.SUPABASE_URL, PROCESS.ENV.SUPABASE_SERVICE_KEY);

export async function POST(req: Request, res: Response) {
    const { assignment_id, student_id, text, voice_url } = req.body;

    try {
        const { data, error } = await supabase
            .from('submissions')
            .insert({
                assignment_id,
                student_id,
                text_submission: text,
                voice_submission_url: voice_url,
            });

        if (error) {
            return res.status(400).json({ message: error.message });
        }

        return res.status(200).json({ message: 'Homework submitted successfully!', data });
    } catch (err) {
        return res.status(500).json({ message: 'Internal Server Error', error: err.message });
    }
}
