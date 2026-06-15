create table if not exists public.cucuta_predictions (
  player_index smallint primary key check (player_index between 0 and 21),
  predictions jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.cucuta_predictions enable row level security;

grant select, insert, update
on table public.cucuta_predictions
to anon, authenticated;

drop policy if exists "Public read Cucuta predictions"
on public.cucuta_predictions;

create policy "Public read Cucuta predictions"
on public.cucuta_predictions
for select
to anon, authenticated
using (true);

drop policy if exists "Public insert Cucuta predictions"
on public.cucuta_predictions;

create policy "Public insert Cucuta predictions"
on public.cucuta_predictions
for insert
to anon, authenticated
with check (player_index between 0 and 21);

drop policy if exists "Public update Cucuta predictions"
on public.cucuta_predictions;

create policy "Public update Cucuta predictions"
on public.cucuta_predictions
for update
to anon, authenticated
using (player_index between 0 and 21)
with check (player_index between 0 and 21);
