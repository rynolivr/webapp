drop table if exists repos;
create table repos (
  name text,
  owner text,
  matched text,
  status text,
  file text,
  fixer text,
  id serial,
  created_at time,
  updated_at time
);
