-- this script check and create table for myconnect system

-- create table time_nonces
CREATE TABLE IF NOT EXISTS `time_nonces` (
    `id` varchar(64) NOT NULL,
    `nonce` varchar(64),
    `timestamp` timestamp DEFAULT CURRENT_TIMESTAMP,
    `create_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    `expire_after` integer,
    `sender_id` varchar(64),
    `sender_app_id` varchar(66),
    PRIMARY KEY (`id`));

-- create table db_tasks
CREATE TABLE `db_tasks` (
    `task_id` varchar(36),
    `parent_task_id` varchar(36),
    `method` varchar(64),
    `sender_id` varchar(64),
    `sender_app_id` varchar(66),
    `receiver_id` varchar(64),
    `description` text,
    `future_id` varchar(36),
    `start_time` bigint,
    `due_time` bigint,
    `from_client` boolean DEFAULT false,
    `app_id` varchar(66),
    `params` mediumblob,
    `callback` text,
    `status` integer,
    `error` text,
    `create_time` timestamp,
    `last_modify_time` timestamp,
    PRIMARY KEY (`task_id`));

CREATE UNIQUE INDEX uix_db_tasks_task_id ON `db_tasks`(task_id);

-- create table db_apps
CREATE TABLE `db_apps` (
    `id` varchar(64),
    `name` varchar(256),
    `admin_id` varchar(64),
    `desc` varchar(1024),
    `status` integer,
    `deleted` boolean DEFAULT false,
    `create_time` timestamp,
    `last_modify_time` timestamp,
    PRIMARY KEY (`id`));

CREATE UNIQUE INDEX uix_db_apps_id ON `db_apps`(`id`);

-- create table db_programs
CREATE TABLE `db_programs` (
    `id` varchar(64),
    `desc` varchar(1024),
    `name` varchar(256),
    `build_name` varchar(256),
    `submitted_by` varchar(64),
    `developer` varchar(256),
    `program_version` varchar(64),
    `approved` boolean,
    `id_l` mediumblob,
    `pub_impl` mediumblob,
    `pub_conf` mediumblob,
    `imported_packages` longblob,
    `shared_object` longblob,
    `dependencies` longblob,
    `deleted` boolean DEFAULT false,
    `create_time` timestamp,
    `last_modify_time` timestamp,
    PRIMARY KEY (`id`,`program_version`));

-- create table db_users
CREATE TABLE `db_users` (
    `id` varchar(64),
    `name` varchar(256),
    `desc` varchar(1024),
    `cert` blob,
    `end_point` varchar(64),
    `enable_tls` boolean,
    `status` integer,
    `roles` integer,
    `online` boolean,
    `deleted` boolean DEFAULT false,
    `create_time` timestamp,
    `last_modify_time` timestamp,
    PRIMARY KEY (`id`));

CREATE UNIQUE INDEX uix_db_users_id ON `db_users`(`id`);

-- create table db_app_users
CREATE TABLE `db_app_users` (
    `app_id` varchar(64),
    `app_name` varchar(256),
    `user_id` varchar(64),
    `user_name` varchar(256),
    `user_desc` varchar(64),
    `approved` boolean DEFAULT false,
    `deleted` boolean DEFAULT false,
    `create_time` timestamp,
    `last_modify_time` timestamp,
    PRIMARY KEY (`app_id`,`user_id`));

-- create table db_public_keys
CREATE TABLE `db_public_keys` (
    `user_id` varchar(64),
    `type` int,
    `alias` int,
    `key` blob,
    `deleted` boolean DEFAULT false,
    `create_time` timestamp,
    `last_modify_time` timestamp,
    PRIMARY KEY (`user_id`,`type`,`alias`));

-- create table table_versions
CREATE TABLE `table_versions` (
    `table` varchar(100) NOT NULL UNIQUE,
    `version` timestamp NOT NULL,
    PRIMARY KEY (`table`));

-- create table db_node_apps
CREATE TABLE `db_node_apps` (
    `id` varchar(64),
    `priv_key_hash` varchar(64),
    `key_type` integer,
    `key_alias` integer,
    `ssl_key_hash` varchar(64),
    `volume_path` varchar(1024),
    `status` integer,
    `p2_p_port` integer,
    `api_port` integer,
    `program_version` varchar(64),
    `ip` varchar(64),
    `deleted` boolean DEFAULT false,
    `create_time` timestamp,
    `last_modify_time` timestamp,
    `extra_secrets` blob,
    PRIMARY KEY (`id`,`program_version`,`ip`));