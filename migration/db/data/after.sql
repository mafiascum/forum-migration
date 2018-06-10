###
#
# Set users' style ID based on which skin they had set prior to the upgrade.
#
###
SELECT @SILVER_ID:=style_id
FROM phpbb_styles
WHERE style_name='mafSilver';

SELECT @BLACK_ID:=style_id
FROM phpbb_styles
WHERE style_name='mafBlack';

UPDATE phpbb_users, temp_user_old_style SET
	phpbb_users.user_style=
		IF(temp_user_old_style.style_id = 4, @SILVER_ID, #If old style is mafSilver
		IF(temp_user_old_style.style_id = 6, @BLACK_ID, #if old style is mafSepia
		@BLACK_ID ##Every other style(scuMobile, mafTigers, prosilver, mafMobile2, quilDark, mafBlack)
	))
WHERE phpbb_users.user_id=temp_user_old_style.user_id;

DROP TABLE IF EXISTS `temp_user_old_style`;