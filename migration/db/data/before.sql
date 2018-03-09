CREATE TABLE `phpbb_config_text` (
	`config_name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
	`config_value` mediumtext COLLATE utf8_bin NOT NULL,
	PRIMARY KEY (`config_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `temp_post_approved`;

CREATE TABLE `temp_post_approved`(
	`post_id` int(11) unsigned not null,
	`post_approved` tinyint(3) unsigned not null,
	PRIMARY KEY(`post_id`)
) ENGINE=MyISAM;

INSERT INTO `temp_post_approved`
SELECT
	`post_id`,
	`post_approved`
FROM phpbb_posts;

ALTER TABLE `phpbb_posts`
DROP KEY `post_subject`,
DROP KEY `post_approved`,
DROP `post_approved`,
ADD `post_visibility` tinyint(3) NOT NULL DEFAULT '0',
ADD `post_delete_time` int(11) unsigned NOT NULL DEFAULT '0',
ADD `post_delete_reason` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
ADD `post_delete_user` int(10) unsigned NOT NULL DEFAULT '0',
ADD KEY `post_visibility` (`post_visibility`),
CHANGE `post_id` `post_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
CHANGE `poster_id` `poster_id` int(10) unsigned NOT NULL DEFAULT '0',
CHANGE `post_edit_user` `post_edit_user` int(10) unsigned NOT NULL DEFAULT '0',
CHANGE `topic_id` `topic_id` int(10) unsigned NOT NULL DEFAULT '0';

UPDATE `phpbb_posts`, `temp_post_approved` SET
	`phpbb_posts`.`post_visibility`=`temp_post_approved`.`post_approved`
WHERE `phpbb_posts`.`post_id`=`temp_post_approved`.`post_id`;

DROP TABLE `temp_post_approved`;
