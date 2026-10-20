-- Bubu & Dudu Finance PWA — shared data table
-- Jalankan sekali di Supabase > SQL Editor > New query.
-- Buat hanya dua akun yang diizinkan di Authentication > Users.
-- Matikan public sign-ups di Authentication settings.

create table if not exists public.shared_finance (
  id text primary key check (id = 'shared'),
  transactions jsonb not null default '[]'::jsonb,
  budgets jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  updated_by uuid references auth.users(id)
);

alter table public.shared_finance enable row level security;

-- Hanya akun yang berhasil login dapat membaca atau mengubah data.
-- Dengan public sign-ups dinonaktifkan dan hanya dua akun dibuat manual,
-- akses dibatasi pada dua pengguna tersebut.
drop policy if exists "Authenticated users can read shared finance" on public.shared_finance;
create policy "Authenticated users can read shared finance"
  on public.shared_finance for select to authenticated using (true);

drop policy if exists "Authenticated users can create shared finance" on public.shared_finance;
create policy "Authenticated users can create shared finance"
  on public.shared_finance for insert to authenticated with check (true);

drop policy if exists "Authenticated users can update shared finance" on public.shared_finance;
create policy "Authenticated users can update shared finance"
  on public.shared_finance for update to authenticated using (true) with check (true);

-- Aktifkan Realtime agar perubahan dari perangkat lain diterima langsung.
do $$ begin
  alter publication supabase_realtime add table public.shared_finance;
exception when duplicate_object then null;
when undefined_object then null;
end $$;
