create table services (
    service_id      integer            not null
,   service_name    varchar(128)       not null
,   description     varchar(128)
);

create table instances (
    instance_id     integer            not null
,   instance_name   varchar(128)       not null
,   description     varchar(256)
);

create table components (
    component_id    integer            not null
,   component_name   varchar(128)      not null
,   description     varchar(128)
);

alter table services add constraint service_pk primary key (service_id);
alter table services add constraint service_uc unique (service_name);
alter table instances add constraint instance_pk primary key (instance_id);
alter table instances add constraint instance_uc unique (instance_name);
alter table components add constraint component_pk primary key (component_id);
alter table components add constraint component_uc unique (component_name);

create sequence service_id_seq minvalue 1 start 1 increment 1;
create sequence instance_id_seq minvalue 1 start 1 increment 1;
create sequence component_id_seq minvalue 1 start 1 increment 1;
