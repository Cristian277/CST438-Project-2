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

DROP TABLE IF EXISTS `videoGames`;
CREATE TABLE `videoGames`(
    -- videogame_id, title, genre, platform, rating, pricing;
    `videogame_id` mediumint(20) NOT NULL,
    `title`    varchar(25) COLLATE utf8_unicode_ci NOT NULL,
    `genre`    varchar(25) COLLATE utf8_unicode_ci NOT NULL,
    `rating`   mediumint(20) NOT NULL,
    `pricing`  varchar(500) COLLATE utf8_unicode_ci NOT NULL,
    `companyName`  varchar(500) COLLATE utf8_unicode_ci NOT NULL,
    `summary`  varchar(500) COLLATE utf8_unicode_ci NOT NULL,
    `cover` varchar(500) COLLATE utf8_unicode_ci NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `videoGames` (`videogame_id`, `title`, `genre`, `rating`, `pricing`, `companyName`, `summary`, `cover`) VALUES
(1, 'DOOM', 'FPS',  '9/10', '59.99', 'id Software', 'Hells armies have invaded Earth. Become the Slayer in an epic single-player campaign to conquer demons across dimensions and stop the final destruction of humanity. The only thing they fear... is you.', 'https://upload.wikimedia.org/wikipedia/en/thumb/9/9d/Cover_Art_of_Doom_Eternal.png/220px-Cover_Art_of_Doom_Eternal.png'),
(2, 'Sekiro: Shadows Die Twice', 'Action',  '9/10', '59.99', 'FromSoftware', 'In Sekiro: Shadows Die Twice you are the “one-armed wolf”, a disgraced and disfigured warrior rescued from the brink of death. Bound to protect a young lord who is the descendant of an ancient bloodline, you become the target of many vicious enemies, including the dangerous Ashina clan. When the young lord is captured, nothing will stop you on a perilous quest to regain your honor, not even death itself.', 'https://upload.wikimedia.org/wikipedia/en/thumb/6/6e/Sekiro_art.jpg/220px-Sekiro_art.jpg'),
(3, 'Resident Evil 2 Remake', 'Horror',  '9/10', '39.99', 'CAPCOM', 'The action centers around rookie cop Leon Kennedy and college student Claire Redfield as they fight to survive a mysterious viral outbreak within Raccoon City.', 'https://upload.wikimedia.org/wikipedia/en/f/fd/Resident_Evil_2_Remake.jpg'),
(4, 'Death Stranding', 'Action',  '8/10', '59.99', 'Kojima Productions', 'From legendary game creator Hideo Kojima comes an all-new, genre-defying experience. Sam Bridges must brave a world utterly transformed by the Death Stranding. Carrying the disconnected remnants of our future in his hands, he embarks on a journey to reconnect the shattered world one step at a time.', 'https://steamcdn-a.akamaihd.net/steam/apps/1190460/header.jpg?t=1588149826'),
(5, 'Control', 'Third-Person Shooter',  '8/10', '59.99', 'Remedy Entertainment', 'After a secretive agency in New York is invaded by an otherworldly threat, you become the new Director struggling to regain Control in this supernatural 3rd person action-adventure from Remedy Entertainment and 505 Games', 'https://steamcdn-a.akamaihd.net/steam/apps/870780/header.jpg?t=1572428374'),
(6, 'The Outer Worlds', 'RPG',  '8/10', '59.99', 'Obisidan Entertainment', 'The Outer Worlds is a new single-player sci-fi RPG from Obsidian Entertainment and Private Division. As you explore a space colony, the character you decide to become will determine how this player-driven story unfolds. In the corporate equation for the colony, you are the unplanned variable.', 'https://steamcdn-a.akamaihd.net/steam/apps/578650/header.jpg?t=1557253926'),
(7, 'Outer Wilds', 'Action',  '8/10', '19.99', 'Mobius Digital', 'Named Game of the Year 2019 by Giant Bomb, Polygon, Eurogamer, and The Guardian, Outer Wilds is a critically-acclaimed and award-winning open world mystery about a solar system trapped in an endless time loop.', 'https://steamcdn-a.akamaihd.net/steam/apps/753640/header.jpg?t=1588186650'),
(8, 'Star Wars Fallen Order', 'Action', '7/10', '35.99', 'Respawn Entertainment', 'A galaxy-spanning adventure awaits in Star Wars Jedi: Fallen Order, a 3rd person action-adventure title from Respawn. An abandoned Padawan must complete his training, develop new powerful Force abilities, and master the art of the lightsaber - all while staying one step ahead of the Empire.', 'https://steamcdn-a.akamaihd.net/steam/apps/1172380/header.jpg?t=1588279360'),
(9, 'Apex Legends', 'FPS',  '8/10', 'FREE', 'Electronics Arts', 'Choose from a lineup of outlaws, soldiers, misfits, and misanthropes, each with their own set of skills. The Apex Games welcome all comers – survive long enough, and they call you a Legend.', 'https://upload.wikimedia.org/wikipedia/en/thumb/d/db/Apex_legends_cover.jpg/220px-Apex_legends_cover.jpg'),
(10, 'Zelda: Links Awakening', 'Action',  '8/10', '29.99', 'Grezzo', 'As Link, you awaken in a strange land away from Hyrule, where animals talk and monsters roam. To uncover the truth behind your whereabouts and rouse the legendary Wind Fish, explore Koholint Island and all its trap-ridden dungeons, reimagined in stunning detail for this new release of one of the most beloved The Legend of Zelda games. Along the way, you’ll meet a hilarious assortment of charming characters to which you’ll never want to say goodbye.', 'https://www.nintendo.com/content/dam/noa/en_US/games/switch/t/the-legend-of-zelda-links-awakening-switch/the-legend-of-zelda-links-awakening-switch-hero.jpg'),
(11, 'Gears 5', 'Third-Person Shooter',  '6/10', '59.99', 'The Coalition', 'Free update, Operation 3: Gridiron, is now available. Use Cole and Clayton Carmine’s new abilities in Horde and Escape and try the new Gridiron mode. From one of gaming’s most acclaimed sagas, Gears is bigger than ever, with five thrilling modes and the deepest campaign yet.', 'https://steamcdn-a.akamaihd.net/steam/apps/1097840/header.jpg?t=1588085716'),
(12, 'Astral Chain','Action',  '9/10', '59.99', 'PlatinumGames', 'The few survivors of a massive global disaster gather together in a futuristic megacity. Now it’s your job to protect them against otherworldly invaders–but you’re not alone as a member of a special police task force equipped with sentient armaments called Legions. In this brand-new action game from PlatinumGames, control the protagonist and a Legion simultaneously to chain stylish combos.', 'https://www.nintendo.com/content/dam/noa/en_US/games/switch/a/astral-chain-switch/astral-chain-switch-hero.jpg'),
(13, 'Devil May Cry 5', 'Action',  '9/10', '39.99', 'Ninja Theory', 'The ultimate Devil Hunter is back in style, in the game action fans have been waiting for.', 'https://steamcdn-a.akamaihd.net/steam/apps/601150/header.jpg?t=1582605276'),
(14, 'Borderlands 3', 'FPS',  '9/10', '59.99', 'Gearbox Software', 'The original shooter-looter returns, packing bazillions of guns and a mayhem-fueled adventure! Blast through new worlds & enemies and save your home from the most ruthless cult leaders in the galaxy.', 'https://steamcdn-a.akamaihd.net/steam/apps/397540/header.jpg?t=1587675179'),
(15, 'Days Gone', 'Horror',  '6/10', '39.99', 'SIE Bend Studio', 'At its core, Days Gone is about survivors and what makes them human: desperation, loss, madness, betrayal, friendship, brotherhood, regret, love—and hope. Its about how, even when confronted with such enormous tragedy, hope never dies.', 'https://store.playstation.com/store/api/chihiro/00_09_000/container/US/en/999/UP9000-CUSA08966_00-DAYSGONECOMPLETE/1588468778000/image?w=240&h=240&bg_color=000000&opacity=100&_version=00_09_000'),
(16, 'Modern Warfare', 'FPS',  '8/10', '59.99', 'Infinity Ward', 'Play the blockbuster Campaign, engage in thrilling Multiplayer combat, squad up in cooperative Special Ops experiences, and drop into the massive Battle Royale arena with Warzone.', 'https://hb.imgix.net/d9ffbcf4aa5df29167b21484b9aac12507a9deb9.jpg?auto=compress,format&fit=crop&h=353&w=616&s=523a92154bf15e96dc83c5c113f93bcf'),
(17, 'Metro Exodus', 'FPS',  '8/10', '39.99', '4A Games', 'Flee the shattered ruins of the Moscow Metro and embark on an epic, continent-spanning journey across the post-apocalyptic Russian wilderness. Explore vast, non-linear levels, lose yourself in an immersive, sandbox survival experience, and follow a thrilling story-line.', 'https://steamcdn-a.akamaihd.net/steam/apps/412020/header.jpg?t=1582550242'),
(18, 'Pokémon Sword and Shield', 'RPG',  '8/10', '59.99', 'Game Freak', 'A new generation of Pokémon is coming to the Nintendo Switch™ system. Begin your adventure as a Pokémon Trainer by choosing one of three new partner Pokémon: Grookey, Scorbunny, or Sobble. Then embark on a journey in the new Galar region, where you’ll challenge the troublemakers of Team Yell, while unraveling the mystery behind the Legendary Pokémon Zacian and Zamazenta!', 'https://www.nintendo.com/content/dam/noa/en_US/games/switch/p/pokemon-shield-switch/pokemon-shield-switch-hero.jpg'),
(19, 'Final Fantasy 14', 'RPG',  '9/10', '39.99', 'Square Enix', 'Take part in an epic and ever-changing FINAL FANTASY as you adventure and explore with friends from around the world.', 'https://steamcdn-a.akamaihd.net/steam/apps/39210/header.jpg?t=1587567669'),
(20, 'The Division 2', 'Third-Person Shooter',  '8/10', '59.99', 'Ubisoft', 'You are a member of the Division, an elite group of civilian agents charged with being the last line of defense. With DC at risk, its time to gear up and use your unique skills to take on this new threat.', 'https://upload.wikimedia.org/wikipedia/en/a/af/The_Division_2_art.jpg');


ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`);
  
ALTER TABLE `videoGames`
  ADD PRIMARY KEY (`videogame_id`);
  
ALTER TABLE `users`
  MODIFY `userId` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
  
ALTER TABLE `videoGames`
  MODIFY `videogame_id` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;