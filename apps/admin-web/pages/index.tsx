import { createSupabaseClient } from '../lib/supabase';
import Layout from '../components/Layout';

export default function Home() {
  const supabase = createSupabaseClient();

  return (
    <Layout>
      <div className="text-center">
        <h2 className="text-xl">Welcome to the Admin Dashboard!</h2>
      </div>
    </Layout>
  );
}
