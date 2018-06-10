UPDATE phpbb_posts SET
	post_text=REGEXP_REPLACE(post_text, "<!--(\\d+)-->", "SEEDSTART\1SEEDEND");
WHERE LOCATE("<!--", post_text) != 0;

UPDATE phpbb_privmsgs SET
	message_text=REGEXP_REPLACE(message_text, "<!--(\\d+)-->", "SEEDSTART\1SEEDEND");
WHERE LOCATE("<!--", message_text) != 0;
