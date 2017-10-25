create table services (
    service_id      integer            not null
,   service_name    varchar(128)       not null
,   description     varchar(128)
) ENGINE=InnoDB;

create table instances (
    instance_id     integer            not null
,   instance_name   varchar(128)       not null
,   description     varchar(256)
) ENGINE=InnoDB;

create table components (
    component_id    integer            not null
,   component_name   varchar(128)      not null
,   description     varchar(128)
) ENGINE=InnoDB;

alter table services add constraint service_pk primary key (service_id);
alter table services add constraint service_uc unique (service_name);
alter table instances add constraint instance_pk primary key (instance_id);
alter table instances add constraint instance_uc unique (instance_name);
alter table components add constraint component_pk primary key (component_id);
alter table components add constraint component_uc unique (component_name);

alter table services modify column service_id integer not null auto_increment;
alter table instances modify column instance_id integer not null auto_increment;
alter table components modify column component_id integer not null auto_increment;
