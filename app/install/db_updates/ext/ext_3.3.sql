ALTER TABLE `app_ext_import_templates` ADD `filepath` VARCHAR(255) NOT NULL AFTER `is_active`, ADD `import_action` VARCHAR(16) NOT NULL AFTER `filepath`, ADD `filetype` VARCHAR(8) NOT NULL AFTER `import_action`, ADD `parent_item_id` INT NOT NULL AFTER `filetype`, ADD `text_delimiter` VARCHAR(16) NOT NULL AFTER `parent_item_id`, ADD `update_use_column` VARCHAR(16) NOT NULL AFTER `text_delimiter`;

ALTER TABLE `app_ext_import_templates` ADD `file_encoding` VARCHAR(16) NOT NULL AFTER `filetype`;

ALTER TABLE `app_ext_import_templates` ADD `start_import_line` TINYINT NOT NULL AFTER `update_use_column`;

CREATE TABLE IF NOT EXISTS `app_ext_email_notification_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `action_type` varchar(64) NOT NULL,
  `send_to_users` text NOT NULL,
  `send_to_user_group` text NOT NULL,
  `send_to_email` text NOT NULL,
  `subject` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `notes` text NOT NULL,
  `listing_type` varchar(16) NOT NULL,
  `listing_html` text NOT NULL,
  `listing_fields` text NOT NULL,
  `notification_days` varchar(255) NOT NULL,
  `notification_time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `app_ext_ipages` CHANGE `description` `description` LONGTEXT;

ALTER TABLE `app_ext_call_history` CHANGE `phone` `phone` VARCHAR(64);

ALTER TABLE `app_ext_pivot_map_reports` ADD `is_public_access` TINYINT(1) NOT NULL DEFAULT '0' AFTER `users_groups`;

ALTER TABLE `app_ext_track_changes` ADD `track_actions` VARCHAR(255) NOT NULL AFTER `menu_icon`;

ALTER TABLE `app_ext_ganttchart` ADD `settings` TEXT NOT NULL AFTER `highlight_critical_path`;

ALTER TABLE `app_ext_email_rules` ADD `send_from_name` VARCHAR(255) NOT NULL AFTER `description`, ADD `send_from_email` VARCHAR(255) NOT NULL AFTER `send_from_name`;

ALTER TABLE `app_ext_call_history` ADD `module` VARCHAR(64) NOT NULL AFTER `is_new`, ADD INDEX `idx_module` (`module`);



