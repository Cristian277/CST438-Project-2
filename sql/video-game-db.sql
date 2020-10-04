SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
	`userId` mediumint(9) NOT NULL,
	`firstname` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
	`lastname` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
	`username` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
	`password` varchar(72) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`userId`,`firstname`,`lastname`,`username`,`password`) VALUES
(1,'Cristian','Arredondo','CristianArredondo123','123'),
(2,'Christian','Jimenez','ChristianJimenez123','1234'),
(3,'Victor','Cuin','VictorCuin123','12345'),
(4,'Elijah','Hallera','ElijahHallera123','123456');

DROP TABLE IF EXISTS `games`;

CREATE TABLE `games` (
  `gameId` mediumint(9) NOT NULL,
  `userId` mediumint(9) NOT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `yearMade` int(11) DEFAULT NULL,
  `genre` varchar(200) COLLATE utf8_unicode_ci NOT NULL
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `games` (`gameId`, `userId`, `name`,`image`,`yearMade`,`genre`) VALUES
(1,NULL,'Halo 3','https://www.halopedia.org/images/thumb/e/e5/Halo3coverart.JPG/1200px-Halo3coverart.JPG',2007,'First Person Shooter'),
(2,NULL,'Halo 4','https://www.mobygames.com/images/covers/l/281470-halo-4-xbox-360-front-cover.jpg',2012,'First Person Shooter');


ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`);
  
ALTER TABLE `games`
  ADD PRIMARY KEY (`gameId`);
  
ALTER TABLE `users`
  MODIFY `userId` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
  
ALTER TABLE `games`
  MODIFY `gameId` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;