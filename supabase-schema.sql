-- Bubu & Dudu Finance PWA: secure shared workspace with manually approved anonymous users.
-- Run in Supabase SQL Editor only if you intend to reconcile the schema with this application.
-- This does not delete the existing row in public.shared_finance.

create table if not exists public.shared_finance (
  id text primary key check (id = 'shared'),
  transactions jsonb not null default '[]'::jsonb,
  budgets jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  updated_by uuid references auth.users(id)
);

alter table public.shared_finance enable row level security;

create schema if not exists private;
revoke all on schema private from public;
grant usage on schema private to authenticated;

create table if not exists private.user_device_allowlist (
  user_id uuid primary key references auth.users(id) on delete cascade,
  device_label text not null,
  approved boolean not null default true,
  approved_at timestamptz not null default now()
);
alter table private.user_device_allowlist enable row level security;
revoke all on table private.user_device_allowlist from public, anon, authenticated;

create or replace function private.is_approved_device()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from private.user_device_allowlist d
    where d.user_id = (select auth.uid()) and d.approved = true
  );
$$;
revoke all on function private.is_approved_device() from public, anon;
grant execute on function private.is_approved_device() to authenticated;

-- Remove the older email-based policies and recreate allowlist policies.
drop policy if exists "Only Bubu and Dudu can read shared finance" on public.shared_finance;
drop policy if exists "Only Bubu and Dudu can create shared finance" on public.shared_finance;
drop policy if exists "Only Bubu and Dudu can update shared finance" on public.shared_finance;
drop policy if exists "Authenticated users can read shared finance" on public.shared_finance;
drop policy if exists "Authenticated users can create shared finance" on public.shared_finance;
drop policy if exists "Authenticated users can update shared finance" on public.shared_finance;
drop policy if exists "Approved devices read shared finance" on public.shared_finance;
drop policy if exists "Approved devices create shared finance" on public.shared_finance;
drop policy if exists "Approved devices update shared finance" on public.shared_finance;

revoke all on table public.shared_finance from anon, authenticated;
grant select, insert, update on table public.shared_finance to authenticated;

create policy "Approved devices read shared finance"
on public.shared_finance for select to authenticated
using (id = 'shared' and (select private.is_approved_device()));

create policy "Approved devices create shared finance"
on public.shared_finance for insert to authenticated
with check (id = 'shared' and (select private.is_approved_device()));

create policy "Approved devices update shared finance"
on public.shared_finance for update to authenticated
using (id = 'shared' and (select private.is_approved_device()))
with check (id = 'shared' and (select private.is_approved_device()));

-- Enable Realtime for cross-device updates if not already enabled.
do $$ begin
  alter publication supabase_realtime add table public.shared_finance;
exception when duplicate_object then null;
when undefined_object then null;
end $$;
