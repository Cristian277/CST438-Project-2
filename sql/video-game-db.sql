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
	`password` varchar(72) COLLATE utf8_unicode_ci NOT NULL,
  `userMoney` DECIMAL(5,2) DEFAULT 200.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `games`;

CREATE TABLE `games` (
  `gameId` mediumint(9) NOT NULL,
  `userId` mediumint(9),
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `yearMade` int(11) DEFAULT NULL,
  `genre` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `gamePrice` DOUBLE(16,2) NOT NULL,
  `summary`  varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `quantity` mediumint(9) NOT NULL,
  `purchased` BOOLEAN DEFAULT false
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `games` (`gameId`, `userId`, `name`,`image`,`yearMade`,`genre`,`gamePrice`,`summary`,`quantity`) VALUES
(1, NULL, 'Halo 3', 'https://www.halopedia.org/images/thumb/e/e5/Halo3coverart.JPG/1200px-Halo3coverart.JPG', 2007,'First Person Shooter', 20.99,'Summary Coming Soon..', 3),
(2, NULL, 'Sekiro: Shadows Die Twice', 'https://upload.wikimedia.org/wikipedia/en/thumb/6/6e/Sekiro_art.jpg/220px-Sekiro_art.jpg', 2019, 'Action', 25.99,'Summary Coming Soon...', 5),
(3, NULL, 'The Division 2', 'https://upload.wikimedia.org/wikipedia/en/a/af/The_Division_2_art.jpg', 2019, 'Third-Person Shooter', 10.99,'Summary Coming Soon..', 2),
(4, NULL, 'Halo 4', 'https://www.mobygames.com/images/covers/l/281470-halo-4-xbox-360-front-cover.jpg', 2012,'First Person Shooter', 5.99,'Summary Coming Soon..', 1),
(5, NULL, 'Metro Exodus', 'https://steamcdn-a.akamaihd.net/steam/apps/412020/header.jpg?t=1582550242', 2019,'FPS', 39.99, 'Flee the shattered ruins of the Moscow Metro and embark on an epic, continent-spanning journey across the post-apocalyptic Russian wilderness. Explore vast, non-linear levels, lose yourself in an immersive, sandbox survival experience, and follow a thrilling story-line.', 5),
(6, NULL, 'Pokémon Sword and Shield', 'https://www.nintendo.com/content/dam/noa/en_US/games/switch/p/pokemon-shield-switch/pokemon-shield-switch-hero.jpg', 2019,'RPG', 59.99, 'A new generation of Pokémon is coming to the Nintendo Switch™ system. Begin your adventure as a Pokémon Trainer by choosing one of three new partner Pokémon: Grookey, Scorbunny, or Sobble. Then embark on a journey in the new Galar region, where you’ll challenge the troublemakers of Team Yell, while unraveling the mystery behind the Legendary Pokémon Zacian and Zamazenta!', 5),
(7, NULL, 'Final Fantasy 14 Online', 'https://steamcdn-a.akamaihd.net/steam/apps/39210/header.jpg?t=1587567669', 2014, 'RPG', 39.99, 'Take part in an epic and ever-changing FINAL FANTASY as you adventure and explore with friends from around the world.', 5),
(8, NULL, 'Resident Evil 2 Remake', 'https://upload.wikimedia.org/wikipedia/en/f/fd/Resident_Evil_2_Remake.jpg', 2019,'Horror',39.99,'The action centers around rookie cop Leon Kennedy and college student Claire Redfield as they fight to survive a mysterious viral outbreak within Raccoon City.', 5),
(9, NULL, 'Death Stranding', 'https://steamcdn-a.akamaihd.net/steam/apps/1190460/header.jpg?t=1588149826', 2019, 'Action', 59.99, 'From legendary game creator Hideo Kojima comes an all-new, genre-defying experience. Sam Bridges must brave a world utterly transformed by the Death Stranding. Carrying the disconnected remnants of our future in his hands, he embarks on a journey to reconnect the shattered world one step at a time.', 5),
(10, NULL, 'Control', 'https://steamcdn-a.akamaihd.net/steam/apps/870780/header.jpg?t=1572428374', 2019, 'Third-Person Shooter', 59.99, 'After a secretive agency in New York is invaded by an otherworldly threat, you become the new Director struggling to regain Control in this supernatural 3rd person action-adventure from Remedy Entertainment and 505 Games', 5),
(11, NULL, 'The Outer Worlds', 'https://steamcdn-a.akamaihd.net/steam/apps/578650/header.jpg?t=1557253926', 2019, 'RPG', 59.99, 'The Outer Worlds is a new single-player sci-fi RPG from Obsidian Entertainment and Private Division. As you explore a space colony, the character you decide to become will determine how this player-driven story unfolds. In the corporate equation for the colony, you are the unplanned variable.', 5),
(12, NULL, 'Outer Wilds', 'https://steamcdn-a.akamaihd.net/steam/apps/753640/header.jpg?t=1588186650', 2019, 'Action', 19.99, 'Named Game of the Year 2019 by Giant Bomb, Polygon, Eurogamer, and The Guardian, Outer Wilds is a critically-acclaimed and award-winning open world mystery about a solar system trapped in an endless time loop.', 5),
(13, NULL, 'Star Wars Fallen Order', 'https://steamcdn-a.akamaihd.net/steam/apps/1172380/header.jpg?t=1588279360', 2019, 'Action', 35.99, 'A galaxy-spanning adventure awaits in Star Wars Jedi: Fallen Order, a 3rd person action-adventure title from Respawn. An abandoned Padawan must complete his training, develop new powerful Force abilities, and master the art of the lightsaber - all while staying one step ahead of the Empire.', 5);

ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`);
  
ALTER TABLE `games`
  ADD PRIMARY KEY (`gameId`);
  
ALTER TABLE `users`
  MODIFY `userId` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
  
ALTER TABLE `games`
  MODIFY `gameId` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;