-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema esportsdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `esportsdb` ;

-- -----------------------------------------------------
-- Schema esportsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `esportsdb` DEFAULT CHARACTER SET utf8 ;
USE `esportsdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `role` ENUM('User', 'Author', 'Admin') NOT NULL DEFAULT 'User',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profile` ;

CREATE TABLE IF NOT EXISTS `profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(200) NULL,
  `avatar_url` VARCHAR(5000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_profile_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_profile_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game` ;

CREATE TABLE IF NOT EXISTS `game` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NULL,
  `genre` VARCHAR(500) NULL,
  `img_url` VARCHAR(5000) NULL,
  `website_url` VARCHAR(5000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `article` ;

CREATE TABLE IF NOT EXISTS `article` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NULL,
  `content` TEXT NULL,
  `img_url` VARCHAR(5000) NULL,
  `profile_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `game_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_article_profile1_idx` (`profile_id` ASC),
  INDEX `fk_article_game1_idx` (`game_id` ASC),
  CONSTRAINT `fk_article_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_article_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `region` ;

CREATE TABLE IF NOT EXISTS `region` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `organization` ;

CREATE TABLE IF NOT EXISTS `organization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  `region_id` INT NOT NULL,
  `logo_url` VARCHAR(5000) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_organization_region1_idx` (`region_id` ASC),
  CONSTRAINT `fk_organization_region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `region` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `team` ;

CREATE TABLE IF NOT EXISTS `team` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `organization_id` INT NOT NULL,
  `game_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_team_orginazation1_idx` (`organization_id` ASC),
  INDEX `fk_team_game1_idx` (`game_id` ASC),
  CONSTRAINT `fk_team_orginazation1`
    FOREIGN KEY (`organization_id`)
    REFERENCES `organization` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_team_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `player` ;

CREATE TABLE IF NOT EXISTS `player` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `handle` VARCHAR(200) NULL,
  `img_url` VARCHAR(5000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team_join_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `team_join_player` ;

CREATE TABLE IF NOT EXISTS `team_join_player` (
  `team_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  PRIMARY KEY (`team_id`, `player_id`),
  INDEX `fk_team_has_player_player1_idx` (`player_id` ASC),
  INDEX `fk_team_has_player_team1_idx` (`team_id` ASC),
  CONSTRAINT `fk_team_has_player_team1`
    FOREIGN KEY (`team_id`)
    REFERENCES `team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_team_has_player_player1`
    FOREIGN KEY (`player_id`)
    REFERENCES `player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `series`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `series` ;

CREATE TABLE IF NOT EXISTS `series` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  `description` TEXT NULL,
  `img_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `series_match`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `series_match` ;

CREATE TABLE IF NOT EXISTS `series_match` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `series_id` INT NOT NULL,
  `team1_id` INT NOT NULL,
  `team2_id` INT NOT NULL,
  `start_date` DATE NULL,
  `start_time` TIME NULL,
  `title` VARCHAR(1000) NULL,
  `winner_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_matchh_series1_idx` (`series_id` ASC),
  INDEX `fk_series_match_team1_idx` (`team1_id` ASC),
  INDEX `fk_series_match_team2_idx` (`team2_id` ASC),
  INDEX `fk_series_match_team3_idx` (`winner_id` ASC),
  CONSTRAINT `fk_matchh_series1`
    FOREIGN KEY (`series_id`)
    REFERENCES `series` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_series_match_team1`
    FOREIGN KEY (`team1_id`)
    REFERENCES `team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_series_match_team2`
    FOREIGN KEY (`team2_id`)
    REFERENCES `team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_series_match_team3`
    FOREIGN KEY (`winner_id`)
    REFERENCES `team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `game_stat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game_stat` ;

CREATE TABLE IF NOT EXISTS `game_stat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `game_id` INT NOT NULL,
  `stat_name` VARCHAR(200) NULL,
  `stat_description` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_game_stats_game1_idx` (`game_id` ASC),
  UNIQUE INDEX `uq_game_stats_game_stat_name` (`game_id` ASC, `stat_name` ASC),
  CONSTRAINT `fk_game_stats_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `player_match`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `player_match` ;

CREATE TABLE IF NOT EXISTS `player_match` (
  `player_id` INT NOT NULL,
  `series_match_id` INT NOT NULL,
  INDEX `fk_player_match_player1_idx` (`player_id` ASC),
  INDEX `fk_player_match_series_match1_idx` (`series_match_id` ASC),
  PRIMARY KEY (`player_id`, `series_match_id`),
  CONSTRAINT `fk_player_match_player1`
    FOREIGN KEY (`player_id`)
    REFERENCES `player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_match_series_match1`
    FOREIGN KEY (`series_match_id`)
    REFERENCES `series_match` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `player_match_stat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `player_match_stat` ;

CREATE TABLE IF NOT EXISTS `player_match_stat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `player_match_player_id` INT NOT NULL,
  `player_match_series_match_id` INT NOT NULL,
  `game_stat_id` INT NOT NULL,
  `value` DOUBLE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_player_match_stats_player_match1_idx` (`player_match_player_id` ASC, `player_match_series_match_id` ASC),
  INDEX `fk_player_match_stats_game_stats1_idx` (`game_stat_id` ASC),
  CONSTRAINT `fk_player_match_stats_player_match1`
    FOREIGN KEY (`player_match_player_id` , `player_match_series_match_id`)
    REFERENCES `player_match` (`player_id` , `series_match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_match_stats_game_stats1`
    FOREIGN KEY (`game_stat_id`)
    REFERENCES `game_stat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NULL,
  `article_id` INT NOT NULL,
  `profile_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_article1_idx` (`article_id` ASC),
  INDEX `fk_comment_profile1_idx` (`profile_id` ASC),
  CONSTRAINT `fk_comment_article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite_organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_organization` ;

CREATE TABLE IF NOT EXISTS `favorite_organization` (
  `profile_id` INT NOT NULL,
  `organization_id` INT NOT NULL,
  PRIMARY KEY (`profile_id`, `organization_id`),
  INDEX `fk_profile_has_organization_organization1_idx` (`organization_id` ASC),
  INDEX `fk_profile_has_organization_profile1_idx` (`profile_id` ASC),
  CONSTRAINT `fk_profile_has_organization_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_has_organization_organization1`
    FOREIGN KEY (`organization_id`)
    REFERENCES `organization` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite_team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_team` ;

CREATE TABLE IF NOT EXISTS `favorite_team` (
  `profile_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  PRIMARY KEY (`profile_id`, `team_id`),
  INDEX `fk_profile_has_team_team1_idx` (`team_id` ASC),
  INDEX `fk_profile_has_team_profile1_idx` (`profile_id` ASC),
  CONSTRAINT `fk_profile_has_team_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_has_team_team1`
    FOREIGN KEY (`team_id`)
    REFERENCES `team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite_game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_game` ;

CREATE TABLE IF NOT EXISTS `favorite_game` (
  `profile_id` INT NOT NULL,
  `game_id` INT NOT NULL,
  PRIMARY KEY (`profile_id`, `game_id`),
  INDEX `fk_profile_has_game_game1_idx` (`game_id` ASC),
  INDEX `fk_profile_has_game_profile1_idx` (`profile_id` ASC),
  CONSTRAINT `fk_profile_has_game_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_has_game_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_player` ;

CREATE TABLE IF NOT EXISTS `favorite_player` (
  `profile_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  PRIMARY KEY (`profile_id`, `player_id`),
  INDEX `fk_profile_has_player_player1_idx` (`player_id` ASC),
  INDEX `fk_profile_has_player_profile1_idx` (`profile_id` ASC),
  CONSTRAINT `fk_profile_has_player_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_has_player_player1`
    FOREIGN KEY (`player_id`)
    REFERENCES `player` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS esportsuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'esportsuser'@'localhost' IDENTIFIED BY 'esportsuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'esportsuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`) VALUES (1, 'admin', '$2a$10$VGLMyEKzMsCtE4F3avV.dOH6oih0SlVJLLbf95eCJFy8XCOo.jNAO', 1, 'admin');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`) VALUES (2, 'Serg', '$2a$10$FQ.CowO3PyO2yJfioH/bCeC7kwULaiUSuPakOKhyDpXDdr5CWYawS', 1, 'author');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`) VALUES (3, 'User', '$2a$10$mV5sZxWE4dIUFCysSxFt7uQOkud5MtUG/JNSwYPqVqwSp/HUybj1e', 1, 'user');

COMMIT;


-- -----------------------------------------------------
-- Data for table `profile`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `email`, `avatar_url`) VALUES (1, 1, 'bobby', 'dobbs', 'bobdobbs@esports.com', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/8/88/Cloud9logo_square.png/1200px-Cloud9logo_square.png');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `email`, `avatar_url`) VALUES (2, 2, 'Sergio', 'Samoiloff', 'serg@esports.com', 'assets/images/noisia-logo.png');
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `email`, `avatar_url`) VALUES (3, 3, 'User', 'Resu', 'user@esports.com', 'assets/images/stock-gamer.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `game`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `game` (`id`, `title`, `genre`, `img_url`, `website_url`) VALUES (1, 'League of Legends', 'MOBA', 'https://am-a.akamaihd.net/image/?resize=166:64&f=http%3A%2F%2Fassets.lolesports.com%2Fwatch%2Ffooter%2Flol.png', 'https://www.lolesports.com');
INSERT INTO `game` (`id`, `title`, `genre`, `img_url`, `website_url`) VALUES (2, 'Counterstrike: Global Offensive', 'FPS', 'https://pro.eslgaming.com/csgo/proleague/wp-content/uploads/2019/04/ESL-Pro-League.svg', 'https://pro.eslgaming.com/csgo/proleague/teams/');
INSERT INTO `game` (`id`, `title`, `genre`, `img_url`, `website_url`) VALUES (3, 'Overwatch', 'FPS', NULL, 'https://playoverwatch.com/en-us/');
INSERT INTO `game` (`id`, `title`, `genre`, `img_url`, `website_url`) VALUES (4, 'Rocket League', 'Sports', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `article`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (1, 'Astralis Complete ES3TAG Signing', 'The Danish player will finally return to activity after over three months on the sidelines.\n\nAstralis have officially completed the signing of Patrick \"⁠es3tag⁠\" Hansen, who joins the four-time Major champions on a free transfer following the expiry of his contract with Heroic, the organisation he had represented since mid-2017.\n\nThe 24-year-old finally sealed a move on Wednesday after months of waiting, having agreed to join Astralis on March 22, when he had just three months left on his contract with Heroic. The agreement had a rippling effect that saw the transfer of Heroic\'s lineup to FunPlus Phoenix fall through at the final hurdle despite the team having already been unveiled by the Chinese organisation and played an official match under its banner in Flashpoint.\n\nes3tag\'s arrival brings Astralis\' roster to seven players after Jakob \"⁠JUGi⁠\" Hansen was signed in May, also on a free transfer. The Danish AWPer has already played for the team but is expected to have a marginal role from now on as Lukas \"⁠gla1ve⁠\" Rossander and Andreas \"⁠Xyp9x⁠\" Højsleth will be reintroduced to action after the player break.\n\nIn a recent \'HLTV Confirmed\' show, Astralis star Nicolai \"⁠device⁠\" Reedtz confirmed that gla1ve will resume playing sometime in August but stressed that Xyp9x doesn\'t have a return date in sight and will not be rushed back in order to avoid unnecessary stress. This means that es3tag could make his debut for Astralis at ESL One Cologne, which is slated to take place from August 21-30.\n\nWhen asked about the decision to add es3tag, device praised his teammate\'s versatility — \"he can AWP, lurk and play map control\" — and the ability to make those around him better players.\n\nes3tag spent three years on Heroic following his transfer from Tricked in June 2017. He helped the team to win Games Clash Masters 2018, Toyota Master Bangkok 2018 and DreamHack Open Atlanta 2019, playing his final match on March 15 in a 2-1 defeat to Cloud9 in Flashpoint before being moved to the bench as Heroic began to plan for life without him.\n\nWith this signing, Astralis now have:\n\nDenmark Nicolai \"⁠device⁠\" Reedtz\nDenmark Peter \"⁠dupreeh⁠\" Rasmussen\nDenmark Andreas \"⁠Xyp9x⁠\" Højsleth\nDenmark Lukas \"⁠gla1ve⁠\" Rossander\nDenmark Emil \"⁠Magisk⁠\" Reif\nDenmark Patrick \"⁠es3tag⁠\" Hansen\nDenmark Jakob \"⁠JUGi⁠\" Hansen\n\nDenmark Danny \"⁠zonic⁠\" Sørensen (coach)', 'https://static.hltv.org/images/galleries/1693-medium/1593615649.6472.jpeg', 2, NULL, 1, 2);
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (2, 'Renegades Confirm Mithr Addition', 'The Danish coach Torbjørn \"⁠mithR⁠\" Nyborg who trialed for Renegades in May has now officially joined the team, the organization has announced.\n\nmithR and Renegades linked up for of the first Regional Major Ranking event, ESL One: Road to Rio - Oceania, with the Dane filling in the coach position for the Australian team that has been vacant since the departure of Neil \"⁠NeiL_M⁠\" Murphy. Following a two-week trial period, mithR started working with the team in June, and has now penned a deal with Renegades.\n\nChristopher \"⁠dexter⁠\" Nong and co. won 11 of the 13 series they played since starting their cooperation with the Danish tactician, who has been working with the team remotely, confirming their dominance in the region by winning ESL One: Road to Rio - Oceania and DreamHack Masters Spring - Oceania, and placing second in the ESL ANZ Championship S11, after a 3-1 loss to ORDER.\n\nDespite their good run in Oceania, lack of international play set Renegades on a freefall in the rankings, going from #20 in February to their current rank of #48. The Australian squad will have to wait until the player break is over to try and recover lost ground. Renegades have a spot in the ESL Pro League Season 12, but whether they will be able to compete in the tournament against the best teams in the world depends largely on the coronavirus pandemic and the measures that will be employed to combat it come September.\n\nRenegades are now:\n\nAustralia Christopher \"⁠dexter⁠\" Nong\nAustralia Liam \"⁠malta⁠\" Schembri\nAustralia Joshua \"⁠INS⁠\" Potter\nAustralia Jordan \"⁠Hatz⁠\" Bajic\nNew Zealand Simon \"⁠Sico⁠\" Williams\n\nDenmark Torbjørn \"⁠mithR⁠\" Nyborg (coach)', 'https://img-cdn.hltv.org/gallerypicture/cvi6WHetHKZKSVb2SLYG00.jpg?ixlib=java-2.1.0&w=800&s=8ab76181a6399113fd8a0d1b3bdfed48', 2, NULL, 1, 2);
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (3, 'EG Take Down Gen.G To Set Up Upper Bracket Final Clash Againt Liquid', 'Evil Geniuses sent Gen.G down to the lower bracket of the cs_summit 6 North America playoffs with a two-map series victory (16-14 Train, 16-10 Inferno).\n\nAfter topping a stacked field in Group A of cs_summit 6 North America by securing wins over Liquid and FURIA, Evil Geniuses were faced with the prospect of taking on Gen.G in their upper bracket semi-final match-up. Damian \"⁠daps⁠\" Steele\'s side, who had secured the second spot in playoffs out of Group B following victories over Chaos and Cloud9, entered the series on flat-footing, unable to make up for a slow start on Train before capitulating on EG\'s pick of Inferno to fall in 0-2 fashion.\n\nThe victory sets Evil Geniuses up against Liquid in the upper bracket final, where Jake \"⁠Stewie2K⁠\" Yip and company will look to claim revenge for their group stage loss. Meanwhile, Gen.G will fight for their tournament lives in the lower bracket against 100 Thieves at 16:00  on Thursday.\n\nAn inner bombsite attack proved unsuccessful in the opening pistol for Gen.G, although a repeat effort with an ensuing force-buy paid off to even the score. However, Deagle doubles from Peter \"⁠stanislaw⁠\" Jarguz and Vincent \"⁠Brehze⁠\" Cayonte allowed EG to answer back, with the team running with the momentum as they shut down Gen.G\'s attempts to enter bombsites round after round to lead 9-1. It was only at the closing moments of the half that the DreamHack Anaheim champions found their footing, capitalizing off of multi-kills from daps and Sam \"⁠s0m⁠\" Oh to claw back four additional rounds as the sides swapped over.\n\nThree USP frags from Hansel \"⁠BnTeT⁠\" Ferdinand gave Gen.G the chance to close the gap between them and their opposition as they gained the upper hand on the defense, daps continuing to find frags as the team pushed their way up to tie the scoreline at 11-11. Entry kills out of ladder from Ethan \"⁠Ethan⁠\" Arnold put EG back in control, seeing the team rapidly attain match point. It seemed as if Gen.G would force overtime after triples from s0m and daps gave their side two additional rounds, but a quad kill and 1vs3 clutch from Tsvetelin \"⁠CeRq⁠\" Dimitrov in the final round of regulation saw EG steal away the victory, 16-14.\n\nEthan continued to be a terror for Gen.G as Inferno got underway, finding frags in banana and being a nuisance as the rest of his team capitalized on the space created. Rounds for Gen.G were few and far between and they continued to turtle up on bombsites, mustering just four rounds by the break as EG pulled ahead with eleven of their own.\n\nA comeback seemed to be in the cards as a quad kill from s0m in the second half kicked off string of five straight rounds for Gen.G, putting them just two rounds behind their opposition. It seemed that daps\' side would make good on that effort as they answered EG\'s first round win with one of their own, but an AWP triple from CeRq kept his side in the running as they regained control, with Ethan adding multi-kill rounds of his own to help EG close out the map 16-10.', 'https://img-cdn.hltv.org/gallerypicture/BXF1-z2XmLKD_mac48tvcB.jpg?ixlib=java-2.1.0&w=800&s=b748ecd1a0a7c969b7c49e56190b11dd', 2, NULL, 1, 2);
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (4, 'BIG Defeat Fnatic To Book CS_Summit 6 Upper Bracket Final Spot', 'The German team will move on to face Vitality for their second consecutive grand final appearance.\n\nBIG are through to the upper bracket final of cs_summit 6 Europe following a convincing victory over fnatic in two maps. The DreamHack Masters Spring champions continued their good run of form as they held off a team sitting two places above them in the rankings despite an impressive performance from Ludvig \"⁠Brollan⁠\" Brolin, who had on Overpass his highest rating of the year (1.95).\n\nThe Germans were on the front foot from the off on Overpass, racing to a 3-0 lead and then staying ahead after a period of pressure from fnatic. A sneaky defuse by Florian \"⁠syrsoN⁠\" Rische in a 1v2 situation was a heavy blow for the Swedes, but they kept their composure and ended the half in the lead thanks to some stellar rounds by Brollan, who had 19 kills to his name.\n\nThe Swedish youngster continued his one-man crusade in the second half with more stunning individual plays, including a 1v3 clutch, as he desperately tried to keep fnatic in the game during a keenly-contested period of the game. Rounds continued going both ways as neither side managed to stamp their authority on proceedings, but then a stunning clutch from Nils \"⁠k1to⁠\" Gruhne turned the tide in BIG\'s favor, setting the team up for a 16-13 finish.\n\nNuke began with fnatic taking the lead, but there was no follow-up as BIG responded immediately and took control of the game. Johannes \"⁠tabseN⁠\" Wodarz\'s troops rallied to a 5-1 lead and put together another string of rounds late in the half to secure a 9-6 score. After switching sides, the Swedes still attempted a comeback, but their hopes were crushed once BIG had money in the bank as they went on a dominant 7-1 run to extend their winning streak on Nuke to seven games.', 'https://img-cdn.hltv.org/gallerypicture/9-JzI1-YsbnupN0sWGf10P.jpg?ixlib=java-2.1.0&w=800&s=35ace767257f92ac55951f8c5c4fbc3b', 2, NULL, 1, 2);
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (5, 'NAVI, Astralis, Liquid Among Teams To Attend ESL One Cologne', 'There are now just six spots left at the showpiece event, which will be decided next week.\n\nESL has revealed the names of the first 18 teams that will attend this year\'s ESL One Cologne event, which will run from August 21-30. The tournament organiser has also set a cut-off date of July 6 to determine the last six teams based on its ESL Pro Tour world ranking.\n\nCurrent world No.1 Natus Vincere is among the eight teams already confirmed for the main tournament, in which they will be joined by the top eight sides coming from the Play-In stage. This will phase will act as a qualifier and will feature 14 teams determined by the ESL Pro Tour rankings plus the winners of the ESL European Championship and of ESL Meisterschaft Spring, Heretics and Sprout respectively.\n\nESL One Cologne will be held as a broadcast tournament without a live audience. HLTV.org reported two weeks ago that ESL remained hopeful that it would be able to host the tournament in its studio in Cologne, though a final decision will depend on the evolution of the global health crisis and on the travel restrictions that European Union authorities will impose in the coming weeks.\n\nThe German tournament, which will have $1 million on offer, was initially scheduled for July 6-12 with playoffs at the Lanxess-Arena. On May 5, it was officially postponed after German authorities had decided to suspend all large events in the country at least until the end of August in an effort to contain the spread of the coronavirus.', 'https://img-cdn.hltv.org/gallerypicture/zO1gs4jql3zJG3YpwyJOEV.jpg?ixlib=java-2.1.0&w=800&s=87dc915912092460dcb55339dec5c152', 2, NULL, 1, 2);
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (6, 'Liquid Send 100 Thieves To CS_Summit 6 North America Lower Bracket', 'Liquid, the Group A runners up, and 100 Thieves, the Group B winners, were paired up to meet in the first round of the cs_summit 6 North America playoffs upper bracket. Jonathan \"⁠EliGE⁠\" Jablonowski and company, who came from defeating FURIA for the first time this year in the group stage\'s decider match, kept their momentum in their opening playoff match against 100 Thieves, winning it after three hard-fought maps, and will now face Gen.G or Evil Geniuses in the upper bracket final.\n\nLiquid’s first attack on Nuke was on the A site, where they planted in a 5vs5 and defended the round to take the lead. A three-kill round with upgraded pistols by Jay \"⁠Liazz⁠\" Tregillgas put 100 Thieves right back in the match as they tired it up 2-2 ahead of the first gun round, which they were able to win cleanly. The Australian side then went up 5-2 before Liquid could once again make it through the defenses. The North American side tied it up, 5-5, and although 100 Thieves held on to their lead momentarily, they eventually trailed 7-8 at the half.\n\nLiquid increased their lead to 10-7 before 100 Thieves won their first round with AKs as Joakim \"⁠jkaem⁠\" Myrbostad downed four CT players. They were then able to bring it back to even, 10-10, but were stopped by Keith \"⁠NAF⁠\" Markovic who tallied a triple to keep Liquid ahead. The two teams then went back-and-forth, but it was eventually Jake \"⁠Stewie2K⁠\" Yip and company who were able to come out on top on their map pick, 16-12.\n\n100 Thieves planted on A in the first round on Dust2, but were unable to stop the retake as Liquid took the lead. Not for long, however, as the forcebuy went the way of the attackers who were quick to put some distance on the scoreboard, going up 4-1. Their lead by the tenth round was minimal, 6-4, as Liquid went on to tie it back up, but a final offensive to tally three rounds put 100 Thieves ahead 9-6.\n\nDoubles by jkaem and Liazz eased 100 Thieves into the CT side as they extended their lead. Liquid were able to plant on the B site in a 2vs2, but Liazz and Sean \"⁠Gratisfaction⁠\" Kaiwai retook the site to keep charging ahead, 12-7. Liquid then found their footing, giving their rivals no chance as they regained the lead, 13-12, going into the second map’s home stretch, but were unable to close it out as 100 Thieves brought it back to 16-13.\n\nLiquid were first out of the gate on Inferno, winning the first pistol round on the CT side. 100 Thieves were successful on their first full buy with a strike on the A site. The Terrorists then went on a tear, winning six rounds in a row. Liquid tied it back up, 6-6, with EliGE leading the way, as they went on to win the half 8-7.\n\n100 Thieves tied it up on the second pistol round, taking the momentary lead before Liquid tied it back up wielding AKs, 9-9. Two opening kills by Gratisfaction with a desert eagle followed by two more by jkaem kept their team in the game, 10-12, as they struggled with money, but were unable to follow it up the next gun round as Liquid ran away with the map, 16-12, closing the series out to proceed through the tournament\'s upper bracket.', 'https://img-cdn.hltv.org/gallerypicture/tRJ7P4GPc5HH9eH7KMdvlG.jpg?ixlib=java-2.1.0&w=800&s=98622574593b6e0021a3e22879f2c4cb', 3, NULL, 1, 2);
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (7, 'Gen.G Claim Revenge Over Cloud9; Secure Final CS_Summit 6 Playoffs Spot', 'Gen.G pulled off a reverse-sweep against Cloud9 to earn the last spot in the playoffs of cs_summit 6 North America.\n\nThe two teams were left to face off in a rematch of their opening bout after Cloud9 were unable to prevail over 100 Thieves in the winners\' match, while Gen.G kept themselves in tournament contention by seeing to the elimination of Chaos. An identical veto phase put the same maps on the table ⁠— Vertigo, Inferno, and Nuke ⁠—, and this time around, it was Gen.G who came out the victors, requiring all three maps to edge out a victory.\n\nIt seemed like Johnny \"⁠JT⁠\" Theodosiou and company would repeat the results of their previous effort against Gen.G in even quicker fashion as they cruised through Vertigo, leaving their opponents with just five rounds to their name. An early start on Inferno kept Cloud9 in control, but a stabilization from Gen.G allowed the team to rally back into the series as they edged out wins on Inferno and Nuke to take the win, setting up an upper bracket semi-final clash against Evil Geniuses.\n\nIn a post-match interview following Gen.G\'s win over Chaos on Friday, Damian \"⁠daps⁠\" Steele had mentioned how his team had been struggling to get to the \"next stage\" in terms of their depth in-game, elaborating further by explaining that they\'d had difficulties with their defaults. Those same issues persisted as their series against Cloud9 got underway, with Gen.G failing to find ground on the T side of their Vertigo pick as the American-South African roster ran rampant. Aran \"⁠Sonic⁠\" Groesbeek remained deathless seven rounds into the map before a triple kill from Timothy \"⁠autimatic⁠\" Ta finally took him down to give Gen.G their first, but additional rounds were few and far between as Cloud9 ran away with the map 16-5.\n\nCloud9 maintained momentum into Inferno as they took three rounds in their opening salvo, but found themselves up against a brick wall not long after as the AWP of autimatic combined with stellar site holds from Sam \"⁠s0m⁠\" Oh and Kenneth \"⁠koosta⁠\" Suen to give Gen.G the lead. A JT quadruple kill was the sole saving grace in what was a dismal end to the half for Cloud9, with Gen.G pulling ahead 9-6 as the sides swapped over.\n\nThree in a row to kick off the second half put Gen.G well ahead, although multi-kill rounds from Ricky \"⁠floppy⁠\" Kemery helped Cloud9 keep the scoreline close with four rounds of their own. However, entry frags from Hansel \"⁠BnTeT⁠\" Ferdinand and s0m put Cloud9 on the back foot once again, and although the American-South African side fought until the closing moments, it was the tenacity of Gen.G that prevailed to force the series to a Nuke decider.\n\nA strong showing from koosta, an aggressive pace, and tight-knit trading saw Gen.G remain in the lead at the onset of Nuke, running up a 6-1 scoreline on the T side before Cloud9 began to claw back. A change in strategy and different points of attack did not pay off for daps\' crew, who found themselves on the losing end of the half as the trio of Ian \"⁠motm⁠\" Hardy, floppy, and Josh \"⁠oSee⁠\" Ohm came to life to take eight rounds straight for a 9-6 lead.\n\nautimatic and koosta combined to grant Gen.G a win in the final pistol of the series, with the team converting against the ensuing eco to close the gap to 9-8. Cloud9 once again fought back with four of their own, pushing up to thirteen rounds, but ended up on the receiving end of the treatment they gave Gen.G in the first half as eight rounds straight went the way of daps\' side, allowing them to edge out a 16-13 victory.', 'https://img-cdn.hltv.org/gallerypicture/JwlhOzSU2PRKRX8mFVcT4N.jpg?ixlib=java-2.1.0&w=800&s=60950f8f281195b42786017b845bfbba', 3, NULL, 1, 2);
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (8, 'Natus Vincere Defeat Spirit 2-0 To Win WePlay! Clutch Island', 'Shaky form throughout the event didn\'t stop Natus Vincere from showing up big in the grand final of the WePlay! Clutch Island as they took a convincing 2-0 win over Spirit (16-9 Mirage, 16-9 Dust2).\n\nThe WePlay! Clutch Island grand final was the first match between the two highest-ranked CIS sides at the moment, with the four highest-rated players in the event facing off: Nikolay \"⁠mir⁠\" Bityukov and Artem \"⁠iDISBALANCE⁠\" Egorov for Spirit and Aleksandr \"⁠s1mple⁠\" Kostyliev and Denis \"⁠electronic⁠\" Sharipov for Natus Vincere.\n\nThe underdogs on the rise, Spirit, weren\'t able to repeat their ESL One: Road to Rio - CIS result by claiming the first place today, as their individuals fell flat against the regional powerhouse. In the end, Natus Vincere secured a comfortable 2-0 win to claim the victory and 2000 RMR points despite some unconvincing play throughout the event, which they kicked off with a loss to Gambit Youngsters.\n\nSpirit started 2-0 on the CT side of Mirage, but Natus Vincere quickly showed why they picked the map as they edged out a couple of close rounds to start their streak. Kirill \"⁠Boombl4⁠\" Mikhailov, s1mple, and Ilya \"⁠Perfecto⁠\" Zalutskiy were causing a lot of issues for Spirit, who were unable to secure a rifle round until round 14.\n\nLeonid \"⁠chopper⁠\" Vishnyakov\'s men won the last two of the half and brought the score from 14-4 to 14-9 with some good offensive play, but key frags from Boombl4 and Perfecto closed out the Mirage, 16-9.\n\nOn Dust2, Spirit started off their offensive side with a five-round streak, before the double AWP came out for Natus Vincere and they went on to win seven out of the next nine rounds.\n\nAfter an 8-7 half in favor of mir and co., Boombl4\'s men pulled into the lead with a 4-0 run, and at 13-9, Perfecto unlocked the A bombsite with three kills to break the back of Spirit. Natus Vincere reached 15 quickly, and just when it seemed like their opponents were going to put one on the board, s1mple came out big with a 1v2 clutch to finish the match, 16-9.', 'https://img-cdn.hltv.org/gallerypicture/eUFDDCaIVKfmx-nuHkfiJd.jpg?ixlib=java-2.1.0&w=800&s=cb70b4d0d55aba8f2aca8131c04b6b3d', 3, NULL, 1, 2);
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (9, 'Immortals to start Academy team lineup in LCS', 'Immortals will start their current North American Academy lineup for both of their League of Legends Championship Series matches this weekend.\n\nThe lineup consists of top laner Kieran \"Allorim\" Logue, jungler Jake \"Xmithie\" Puchero, mid laner David \"Insanity\" Challe, bot laner Apollo \"Apollo\" Price, and support Nickolas \"Hakuho\" Surgent. The same starting five also started in both of Immortals Academy\'s games this past week, finishing 1-1 with a win over Golden Guardians Academy and a loss to Cloud9 Academy.\n\n\"The plan coming into this week was that we\'re always evaluating, and the next person up on that list is really Insanity,\" interim Immortals general manager Mike Schwartz said. \"I know a lot of people have been wanting to see him out there, and he\'s been performing well in Academy thus far.\" Schwartz added that he sat down with the roster to ensure that the players were prepared and said that if they weren\'t it would be on the Immortals organization, not the team.\n\n\"When we had that discussion with them they were all pretty gung-ho about it,\" Schwartz said. \"I said, \'Listen, it\'s going to be a long week for you guys.\' It\'s a bit of a gauntlet, but they were more than willing to get back in LCS. I\'m definitely happy to put them out there and see what they can do.\"\n\nThis roster decision follows a major managerial shake-up in the Immortals organization following an 0-4 start to the season. On Wednesday, the team released LCS head coach Thomas \"Zaboutine\" Si-Hassen and general manager Keaton Cryer. Schwartz is acting general manager, and Immortals assistant head coach Adrien \"GotoOne\" Picard and Immortals Academy head coach Paul \"Malaclypse\" Decsi have stepped up to help coach the LCS team.\n\n\"We obviously came out of spring split and it was a disappointment for us,\" Schwartz said of the timing. \"Coming back into the LCS we had missed out on making the playoffs, and coming into this split, you look at that length of time and the results were unacceptable for an organization with a history like ours, and we knew that we really couldn\'t go on, and we had those changes coming in as soon as possible.\"\n\nImmortals have been under heavy scrutiny from the North American League of Legends community for their decision to sit Xmithie in favor of former Academy jungler Nicholas \"Potluck\" Pollock as well using a starting bottom lane of Johnny \"Altec\" Ru and Austin \"Gate\" Yu over Apollo and Hakuho respectively. Schwartz said that Potluck showed strong synergy with Immortals\' LCS mid laner Jérémy \"Eika\" Valdenaire, while Xmithie had good synergy with Insanity. \"I know it\'s kind of been a sticking point for NA fans in general, but we did run some internal practices before the summer split started and Potluck came out of that and we wanted to make it clear that he earned the spot to start, and we have seen some really good things from him especially coming through in the first couple of weeks,\" Schwartz said. \"Our performance overall is unacceptable. 0-4 is not what we wanted as a company or an organization, but within that, looking towards some of those younger pieces we have is a plus for us and something we had planned for.\"\n\nThis includes Potluck, who started in Immortals\' first four games of the split, and now Insanity, who will start in the mid lane for Immortals this weekend and will make his LCS debut.\n\nImmortals will face Golden Guardians on Saturday and first-place Cloud9 on Sunday.', 'https://a.espncdn.com/combiner/i?img=%2Fphoto%2F2020%2F0627%2Fr713062_1296x729_16%2D9.jpg&w=920&h=518&scale=crop&cquality=80&location=origin&format=jpg', 1, NULL, 1, 1);
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (10, 'Everything we know about Lillia, League’s potential new champion', 'Riot Games’ latest Champion Roadmap dropped early in June and let fans know the developer was counting the days to release two champions at the same time in a “big” summer event. Though Riot didn’t include any names so far, the tease of a “dreamy” jungler was enough confirmation of Lillia’s arrival, who was first datamined in January. Jungle mains have been on the lookout for a new champion for a while. Kayn, the last official jungler release, was back in 2017.\n\nAlthough there are still many unknowns, here’s everything we know so far based on the trail of clues the Riot left behind for players to follow.\n\nWho is Lillia?\nThere aren’t any resources available at the moment that shed any light on Lillia’s past, in terms of lore.  She looks to have a shy characteristic that can get spooked easily, based on Riot’s roadmap. The author of the article does a little bit of roleplay and invites readers to find Lillia in the jungle. While warning readers about how dangerous Lillia can be when she’s startled, the author slowly starts dozing off. Right before falling to sleep, the author lets out that we’d have to stay awake despite the temptation of warmness and safety.\n\nA couple of mysterious voice lines that were found in the Public Beta Environment (PBE) also allowed us to imagine what her backstory could be.\n\n“They took your home, Lillia.” says the first voice. “Do not forget this loss. Do not forget this loss. Let it course through you.” She looks to have a shy characteristic that can get spooked easily, based on Riot’s roadmap. The author of the article does a little bit of roleplay and invites readers to find Lillia in the jungle. While warning readers about how dangerous Lillia can be when she’s startled, the author slowly starts dozing off. Right before falling to sleep, the author lets out that we’d have to stay awake despite the temptation of warmness and safety.\n\nA couple of mysterious voice lines that were found in the Public Beta Environment (PBE) also allowed us to imagine what her backstory could be.\n\n“They took your home, Lillia.” says the first voice. “Do not forget this loss. Do not forget this loss. Let it course through you.” “Poor lost spirits beckoning to bloom…” says the second voice. “I’ve been waiting for you.”\n\nWhile we don’t know who or what reads these lines, it could also mean that Lillia may be working with a revenge-driven spirit since the voice is entirely different from what one would imagine a “dreamy jungler” sounds like.\n\nWhat are Lillia’s abilities?\nWhile Riot hasn’t released any of Lillia’s abilities officially, her teases indicate that she’ll have a kit that allows her to put enemy champions to sleep. It could potentially be similar to Zoe’s Sleepy Trouble Bubble, or Riot can also decide to introduce a new mechanic in the process. When does Lillia release on live servers?\nRiot mentioned that both Lillia and the other teased champion, speculated to be Yone, were planned to be released into Summoner’s Rift during the big summer event. Though the developer didn’t give any dates for the event, recent additions to the PBE potentially gave away the release date.\n\nA new loot item called “Lillia’s Haiku” was found in PBE, and it reads, “you have discovered Lillia in the forest.” The item’s description also includes a line saying it would become openable on July 22 at 2pm CT.', 'https://cdn1.dotesports.com/wp-content/uploads/2020/06/30172018/Lillia-tease-art.jpg', 1, NULL, 1, 1);
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (11, 'Stunt says he has been released by 100 Thieves', 'The 100 Thieves LCS roster is getting a new look this week, and as a part of the changes, support William “Stunt” Chen has been replaced. \n\nUnlike the other player being swapped out of the starting roster, Meteos, Stunt said he has been released by 100 Thieves after the team lost their fifth game of the Summer Split yesterday. Stunt said he was informed he was off of the team a few hours after losing to TSM in one of the most hectic games this season. Stunt joined 100 Thieves in May 2018 after being traded from FlyQuest. He played on the team’s Academy League roster for three splits before being promoted to a full-time LCS spot before the 2020 Spring Split, which Stunt described as “one of the most meaningful experiences of [his] career.”\n\n“[PapaSmithy] told me he would make sure I finally got the opportunity to play my first full split of LCS, and it really meant a lot to me considering I’ve never really felt this trust and stability before,” Stunt said. “Honestly we weren’t really a team that gelled naturally, but every single one of us worked so hard day in and day out to create the best version of our team that we could.” During the split, 100 Thieves finished third in the regular season before losing to Cloud9 and TSM in the playoffs. 100T general manager Christopher “PapaSmithy” Smith said today the organization was confident it should keep the same roster going into Summer Split because of the results.\n\nUnfortunately, the team has struggled so far this split. Through three weeks, the team is tied for eighth place with a 1-5 record. Yesterday’s 48-minute loss to TSM seemed to be the proverbial nail in the coffin for Meteos and Stunt, the latter of which struggled in the bot lane matchup against Doublelift and Biofrost.\n\nFor their Friday Night League matchup against Golden Guardians this week, 100 Thieves will start Juan “Contractz” Arturo Garcia and Philippe “Poome” Lavoie-Giguere at jungler and support, respectively.', 'https://cdn1.dotesports.com/wp-content/uploads/2020/06/29200504/49518800276_884cae8338_k.jpg', 1, NULL, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `region`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `region` (`id`, `name`) VALUES (1, 'North America');
INSERT INTO `region` (`id`, `name`) VALUES (2, 'Pacific');
INSERT INTO `region` (`id`, `name`) VALUES (3, 'Atlantic');

COMMIT;


-- -----------------------------------------------------
-- Data for table `organization`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (1, 'Cloud 9', 1, 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/8/88/Cloud9logo_square.png/1200px-Cloud9logo_square.png', 'Multi game E-sports team');
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (2, 'Team Liquid', 1, 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/f/f4/Team_Liquidlogo_square.png', 'Multi game E-sports team');
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (3, '100 Thieves', 1, 'https://gol.gg/_img/teams_icon/100-thieves-2020png.png', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (4, 'CLG', 1, 'https://gol.gg/_img/teams_icon/clg-2020.png', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (5, 'Dignatas', 1, 'https://gol.gg/_img/teams_icon/dignitas-2020.png', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (6, 'Evil Geniuses', 1, 'https://gol.gg/_img/teams_icon/evil-geniuses-2020.png', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (7, 'Fly Quest', 1, 'https://gol.gg/_img/teams_icon/flyquest-2020.png', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (8, 'Golden Guardians', 1, 'https://gol.gg/_img/teams_icon/golden-guardians-2020.png', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (9, 'Immortals', 1, 'https://gol.gg/_img/teams_icon/immortals-2020.png', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (10, 'TSM', 1, 'https://gol.gg/_img/teams_icon/team-solomid-2020.png', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (11, 'Fnatic', 1, 'https://static.hltv.org/images/team/logo/4991', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (12, 'Mousesports', 1, 'https://static.hltv.org/images/team/logo/4494', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (13, 'Astralis', 1, 'https://static.hltv.org/images/team/logo/6665', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (14, 'Natus Vincere', 1, 'https://static.hltv.org/images/team/logo/4608', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (15, 'ATK', 1, 'https://static.hltv.org/images/team/logo/9943', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (16, 'Renegades', 1, 'https://static.hltv.org/images/team/logo/6211', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (17, 'G2', 1, 'https://static.hltv.org/images/team/logo/5995', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (18, 'MIBR', 1, 'https://static.hltv.org/images/team/logo/9215', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (19, 'FaZe', 1, 'https://static.hltv.org/images/team/logo/6667', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (20, 'Sharks', 1, 'https://static.hltv.org/images/team/logo/8113', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (21, 'North', 1, 'https://static.hltv.org/images/team/logo/7533', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (22, 'Heroic', 1, 'https://static.hltv.org/images/team/logo/7175', NULL);
INSERT INTO `organization` (`id`, `name`, `region_id`, `logo_url`, `description`) VALUES (23, 'Tyloo', 1, 'https://static.hltv.org/images/team/logo/4863', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `team`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (1, 1, 1);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (2, 2, 1);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (3, 3, 1);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (4, 4, 1);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (5, 5, 1);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (6, 6, 1);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (7, 7, 1);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (8, 8, 1);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (9, 9, 1);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (10, 10, 1);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (11, 11, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (12, 12, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (13, 13, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (14, 14, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (15, 15, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (16, 16, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (17, 17, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (18, 18, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (19, 19, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (20, 20, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (21, 21, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (22, 22, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (23, 23, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (24, 2, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (25, 3, 2);
INSERT INTO `team` (`id`, `organization_id`, `game_id`) VALUES (26, 6, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `player`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (1, 'Robert', 'Huang', 'Blaber', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/f/f9/C9_Blaber_2020_Split_2.png/440px-C9_Blaber_2020_Split_2.png?version=84f498ff676923862cf4e52e15158b68');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (2, 'Jo', 'Yong-in', 'CoreJJ', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/d/d7/TL_CoreJJ_2020_Split_1.png/440px-TL_CoreJJ_2020_Split_1.png?version=0308de419868e786752c51ac20c003b5');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (3, NULL, NULL, 'Licorice', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/b/b7/C9_Licorice_2020_Split_2.png/440px-C9_Licorice_2020_Split_2.png?version=c159f1f1f496e457a1557865224a3ccb');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (4, NULL, NULL, 'Nisqy', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/8/84/C9_Nisqy_2020_Split_2.png/440px-C9_Nisqy_2020_Split_2.png?version=1b910febafee7a934974bc99e3598da6');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (5, NULL, NULL, 'Zven', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/0/0e/C9_Zven_2020_Split_2.png/440px-C9_Zven_2020_Split_2.png?version=0169affaccd0ebb10d2e3b0648857372');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (6, NULL, NULL, 'Vulcan', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/4/48/C9_Vulcan_2020_Split_2.png/440px-C9_Vulcan_2020_Split_2.png?version=6c91d882e6696bc9748b748a3fcd013a');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (7, NULL, NULL, 'Impact', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/9/9e/TL_Impact_2020_Split_1.png/440px-TL_Impact_2020_Split_1.png?version=b06331bcce008d10ae2d989be3cf09aa');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (8, NULL, NULL, 'Broxah', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/b/be/TL_Broxah_2020_Split_1.png/440px-TL_Broxah_2020_Split_1.png?version=8cea5f52f574bf0d695feae9eddafa0f');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (9, NULL, NULL, 'Jensen', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/f/f3/TL_Jensen_2020_Split_1.png/440px-TL_Jensen_2020_Split_1.png?version=868add6c5e08630a7819d5f8035064b7');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (10, NULL, NULL, 'Tactical', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/1/18/TL_Tactical_2020_Split_1.png/440px-TL_Tactical_2020_Split_1.png?version=769121c963f280c5c238cf5e6fdc51f7');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (11, NULL, NULL, 'allorim', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (12, NULL, NULL, 'Xmithie', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/3/3f/IMT_Xmithie_2020_Split_1.png/440px-IMT_Xmithie_2020_Split_1.png?version=060e18676c3347cd1193fb5f85572d4a');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (13, NULL, NULL, 'Insanity', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (14, NULL, NULL, 'Apollo', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/8/8d/IMT_Apollo_2020_Split_1.png/440px-IMT_Apollo_2020_Split_1.png?version=da3a1a23b225789d2d4ca25ea7265723');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (15, NULL, NULL, 'Hakuho', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/5/57/IMT_Hakuho_2020_Split_1.png/440px-IMT_Hakuho_2020_Split_1.png?version=8a0f23d2e8ab43ff1e8fd2fbeaefc078');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (16, NULL, NULL, 'ssumday', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (17, NULL, NULL, 'Meteos', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (18, NULL, NULL, 'Ryoma', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (19, NULL, NULL, 'Cody Sun', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (20, NULL, NULL, 'Stunt', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (21, NULL, NULL, 'Ruin', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (22, NULL, NULL, 'Wiggily', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (23, NULL, NULL, 'Pobelter', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (24, NULL, NULL, 'Stixxay', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (25, NULL, NULL, 'Smoothie', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (26, NULL, NULL, 'Lourlo', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (27, NULL, NULL, 'Akaadian', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (28, NULL, NULL, 'Froggen', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (29, NULL, NULL, 'Johnsun', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (30, NULL, NULL, 'Aphromoo', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (31, NULL, NULL, 'Kumo', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (32, NULL, NULL, 'Svenskeren', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (33, NULL, NULL, 'Jiizuke', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (34, NULL, NULL, 'Bang', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (35, NULL, NULL, 'Zeyzal', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (36, NULL, NULL, 'Solo', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (37, NULL, NULL, 'Santorin', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (38, NULL, NULL, 'PowerOfEvil', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (39, NULL, NULL, 'Mash', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (40, NULL, NULL, 'IgNar', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (41, NULL, NULL, 'Hauntzer', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (42, NULL, NULL, 'Closer', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (43, NULL, NULL, 'Damonte', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (44, NULL, NULL, 'FBI', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (45, NULL, NULL, 'Huhi', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (46, NULL, NULL, 'BrokenBlade', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (47, NULL, NULL, 'Spica', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (48, NULL, NULL, 'Bjergsen', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (49, NULL, NULL, 'Doublelift', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (50, NULL, NULL, 'Biofrost', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (51, NULL, NULL, 'Brollan', 'https://s.starladder.com/uploads/user_discipline_logo/1/6/6/0/thumb_270_ea8deb265f7cdabc743b3139bd88db60.png');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (52, NULL, NULL, 'Golden', 'https://s.starladder.com/uploads/user_discipline_logo/8/e/8/c/thumb_270_7a70a33fbb955c83a1ef595b98f1379d.png');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (53, NULL, NULL, 'Flusha', 'https://s.starladder.com/uploads/user_discipline_logo/2/4/8/d/thumb_270_28c547baab1f323947067e80d08845c1.png');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (54, NULL, NULL, 'KRIMZ', 'https://s.starladder.com/uploads/user_discipline_logo/3/d/2/7/thumb_270_fd40e85a7ac935453132682e43c56096.png');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (55, NULL, NULL, 'JW', 'https://s.starladder.com/uploads/user_discipline_logo/9/d/4/5/thumb_270_ee1e1d45e22527085d5dd8d21cfb7e1e.png');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (56, NULL, NULL, 'Ropz', 'http://www.mousesports.com/storage/Players/CSGO/2003_ropz.png');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (57, NULL, NULL, 'woxic', 'http://www.mousesports.com/storage/Players/CSGO/2003_woxic.png');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (58, NULL, NULL, 'Frozen', 'http://www.mousesports.com/storage/Players/CSGO/2003_frozen.png');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (59, NULL, NULL, 'ChrisJ', 'http://www.mousesports.com/storage/Players/CSGO/2003_chrisj.png');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (60, NULL, NULL, 'Karrigan', 'http://www.mousesports.com/storage/Players/CSGO/2003_karrigan.png');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (61, NULL, NULL, 'Magisk', 'https://www.datocms-assets.com/17359/1590650205-magiskcutout.png?w=600&fit=crop&crop=faces&auto=format,compress');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (62, NULL, NULL, 'gLa1ve', 'https://www.datocms-assets.com/17359/1590650130-gla1vecutout.png?w=600&fit=crop&crop=faces&auto=format,compress');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (63, NULL, NULL, 'Dupreeh', 'https://www.datocms-assets.com/17359/1590650065-dupreehcutout.png?w=600&fit=crop&crop=faces&auto=format,compress');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (64, NULL, NULL, 'Xyp9x', 'https://www.datocms-assets.com/17359/1590650163-xyp9xcutout.png?w=600&fit=crop&crop=faces&auto=format,compress');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (65, NULL, NULL, 'Device', 'https://www.datocms-assets.com/17359/1590650102-dev1cecutout.png?w=600&fit=crop&crop=faces&auto=format,compress');
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (66, NULL, NULL, 'Boombl4', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (67, NULL, NULL, 's1mple', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (68, NULL, NULL, 'Electronic', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (69, NULL, NULL, 'Flamie', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (70, NULL, NULL, 'GuardiaN', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (71, NULL, NULL, 'oSee', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (72, NULL, NULL, 'motm', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (73, NULL, NULL, 'Floppy', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (74, NULL, NULL, 'JT', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (75, NULL, NULL, 'Sonic', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (76, NULL, NULL, 'Sico', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (77, NULL, NULL, 'Malta', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (78, NULL, NULL, 'INS', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (79, NULL, NULL, 'DickStacy', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (80, NULL, NULL, 'Dexter', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (81, NULL, NULL, 'huNter', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (82, NULL, NULL, 'kennyS', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (83, NULL, NULL, 'AmaNEk', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (84, NULL, NULL, 'Nexa', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (85, NULL, NULL, 'JaCkz', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (86, NULL, NULL, 'fer', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (87, NULL, NULL, 'TACO', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (88, NULL, NULL, 'LUCAS1', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (89, NULL, NULL, 'kNgV', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (90, NULL, NULL, 'FalleN', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (91, NULL, NULL, 'Rain', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (92, NULL, NULL, 'NiKo', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (93, NULL, NULL, 'Coldzera', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (94, NULL, NULL, 'Broky', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (95, NULL, NULL, 'Olofmeister', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (96, NULL, NULL, 'Luken', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (97, NULL, NULL, 'Meyern', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (98, NULL, NULL, 'Leo_druNky', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (99, NULL, NULL, 'Exit', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (100, NULL, NULL, 'Jnt', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (101, NULL, NULL, 'JUGi', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (102, NULL, NULL, 'Aizy', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (103, NULL, NULL, 'Gade', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (104, NULL, NULL, 'Kjaerbye', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (105, NULL, NULL, 'Cajnub', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (106, NULL, NULL, 'Stavn', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (107, NULL, NULL, 'Snappi', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (108, NULL, NULL, 'Es3tag', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (109, NULL, NULL, 'b0RUP', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (110, NULL, NULL, 'cadiaN', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (111, NULL, NULL, 'BnTeT', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (112, NULL, NULL, 'Attacker', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (113, NULL, NULL, 'Summer', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (114, NULL, NULL, 'Freeman', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (115, NULL, NULL, 'Somebody', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (116, NULL, NULL, 'Twistzz', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (117, NULL, NULL, 'NAF', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (118, NULL, NULL, 'EliGE', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (119, NULL, NULL, 'nitr0', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (120, NULL, NULL, 'Stewie2K', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (121, NULL, NULL, 'AZR', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (122, NULL, NULL, 'Jkaem', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (123, NULL, NULL, 'Liazz', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (124, NULL, NULL, 'Gratisfaction', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (125, NULL, NULL, 'JKS', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (126, NULL, NULL, 'CeRq', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (127, NULL, NULL, 'Stanislaw', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (128, NULL, NULL, 'Ethan', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (129, NULL, NULL, 'Brehze', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (130, NULL, NULL, 'tarik', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `team_join_player`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (1, 1);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (1, 3);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (1, 4);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (1, 5);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (1, 6);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (2, 2);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (2, 7);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (2, 8);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (2, 9);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (2, 10);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (3, 16);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (3, 17);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (3, 18);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (3, 19);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (3, 20);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (4, 21);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (4, 22);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (4, 23);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (4, 24);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (4, 25);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (5, 26);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (5, 27);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (5, 28);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (5, 29);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (5, 30);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (6, 31);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (6, 32);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (6, 33);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (6, 34);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (6, 35);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (7, 36);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (7, 37);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (7, 38);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (7, 39);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (7, 40);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (8, 41);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (8, 42);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (8, 43);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (8, 44);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (8, 45);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (9, 11);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (9, 12);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (9, 13);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (9, 14);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (9, 15);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (10, 46);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (10, 47);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (10, 48);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (10, 49);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (10, 50);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (11, 51);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (11, 52);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (11, 53);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (11, 54);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (11, 55);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (12, 56);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (12, 57);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (12, 58);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (12, 59);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (12, 60);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (13, 61);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (13, 62);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (13, 63);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (13, 64);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (13, 65);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (14, 66);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (14, 67);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (14, 68);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (14, 69);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (14, 70);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (15, 71);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (15, 72);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (15, 73);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (15, 74);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (15, 75);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (16, 76);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (16, 77);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (16, 78);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (16, 79);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (16, 80);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (17, 81);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (17, 82);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (17, 83);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (17, 84);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (17, 85);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (18, 86);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (18, 87);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (18, 88);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (18, 89);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (18, 90);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (19, 91);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (19, 92);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (19, 93);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (19, 94);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (19, 95);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (20, 96);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (20, 97);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (20, 98);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (20, 99);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (20, 100);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (21, 101);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (21, 102);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (21, 103);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (21, 104);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (21, 105);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (22, 106);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (22, 107);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (22, 108);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (22, 109);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (22, 110);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (23, 111);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (23, 112);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (23, 113);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (23, 114);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (23, 115);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (24, 116);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (24, 117);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (24, 118);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (24, 119);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (24, 120);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (25, 121);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (25, 122);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (25, 123);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (25, 124);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (25, 125);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (26, 126);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (26, 127);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (26, 128);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (26, 129);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (26, 130);

COMMIT;


-- -----------------------------------------------------
-- Data for table `series`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `series` (`id`, `name`, `description`, `img_url`) VALUES (1, 'LCS Sumer Split', 'North America League of Legends pro circuit', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/c/c8/LCS_2020_Logo.png');
INSERT INTO `series` (`id`, `name`, `description`, `img_url`) VALUES (2, 'CS:GO Season 10 Finals', 'ESL Pro League Season 10 Finals', 'www.overwatchleague.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `series_match`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (1, 1, 1, 2, '2020-06-26', '13:00:00', 'Match 1', 1);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (2, 1, 1, 9, '2020-06-28', '14:00:00', NULL, 1);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (3, 1, 3, 10, '2020-06-27', '15:00:00', NULL, 10);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (4, 1, 5, 6, '2020-06-28', '15:00:00', NULL, 6);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (5, 1, 8, 7, '2020-06-28', '16:00:00', NULL, 8);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (6, 2, 11, 12, '2019-12-08', '13:00:00', NULL, 12);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (7, 2, 13, 12, '2019-12-07', '12:00:00', NULL, 12);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (8, 2, 14, 11, '2019-12-07', '13:00:00', NULL, 11);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (9, 2, 26, 12, '2019-12-06', '12:00:00', NULL, 12);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (10, 2, 11, 24, '2019-12-06', '13:00:00', NULL, 11);

COMMIT;


-- -----------------------------------------------------
-- Data for table `game_stat`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `game_stat` (`id`, `game_id`, `stat_name`, `stat_description`) VALUES (1, 1, 'Kills', 'Total number of kills in a match');
INSERT INTO `game_stat` (`id`, `game_id`, `stat_name`, `stat_description`) VALUES (2, 1, 'Deaths', 'Total number of deaths in a match');
INSERT INTO `game_stat` (`id`, `game_id`, `stat_name`, `stat_description`) VALUES (3, 2, 'Kills', 'Total number of kills in a match');
INSERT INTO `game_stat` (`id`, `game_id`, `stat_name`, `stat_description`) VALUES (4, 2, 'Deaths', 'Total number of deaths in a match');
INSERT INTO `game_stat` (`id`, `game_id`, `stat_name`, `stat_description`) VALUES (5, 1, 'CS', 'Total number of minions killed in match');
INSERT INTO `game_stat` (`id`, `game_id`, `stat_name`, `stat_description`) VALUES (6, 1, 'Assist', 'Total number of assist in a game');
INSERT INTO `game_stat` (`id`, `game_id`, `stat_name`, `stat_description`) VALUES (7, 2, 'Assist', NULL);
INSERT INTO `game_stat` (`id`, `game_id`, `stat_name`, `stat_description`) VALUES (8, 2, 'ADR', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `player_match`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (1, 1);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (2, 1);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (3, 1);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (4, 1);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (5, 1);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (6, 1);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (7, 1);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (8, 1);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (9, 1);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (10, 1);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (1, 2);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (3, 2);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (4, 2);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (5, 2);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (6, 2);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (11, 2);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (12, 2);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (13, 2);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (14, 2);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (15, 2);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (51, 6);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (52, 6);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (53, 6);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (54, 6);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (55, 6);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (56, 6);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (57, 6);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (58, 6);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (59, 6);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (60, 6);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (61, 7);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (62, 7);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (63, 7);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (64, 7);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (65, 7);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (56, 7);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (57, 7);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (58, 7);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (59, 7);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (60, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `player_match_stat`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (1, 3, 1, 1, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (2, 3, 1, 2, 4);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (3, 3, 1, 6, 5);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (4, 3, 1, 5, 205);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (5, 1, 1, 1, 6);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (6, 1, 1, 2, 1);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (7, 1, 1, 6, 4);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (8, 1, 1, 5, 196);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (9, 4, 1, 1, 3);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (10, 4, 1, 2, 2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (11, 4, 1, 6, 6);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (12, 4, 1, 5, 226);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (13, 5, 1, 1, 2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (14, 5, 1, 2, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (15, 5, 1, 6, 6);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (16, 5, 1, 5, 297);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (17, 6, 1, 1, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (18, 6, 1, 2, 1);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (19, 6, 1, 6, 9);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (20, 6, 1, 5, 28);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (21, 7, 1, 1, 3);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (22, 7, 1, 2, 4);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (23, 7, 1, 6, 1);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (24, 7, 1, 5, 203);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (25, 8, 1, 1, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (26, 8, 1, 2, 2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (27, 8, 1, 6, 2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (28, 8, 1, 5, 174);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (29, 9, 1, 1, 3);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (30, 9, 1, 2, 2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (31, 9, 1, 6, 5);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (32, 9, 1, 5, 242);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (33, 10, 1, 1, 2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (34, 10, 1, 2, 1);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (35, 10, 1, 6, 2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (36, 10, 1, 5, 277);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (37, 2, 1, 1, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (38, 2, 1, 2, 2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (39, 2, 1, 6, 4);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (40, 2, 1, 5, 26);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (41, 3, 2, 1, 3);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (42, 3, 2, 2, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (43, 3, 2, 6, 10);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (44, 3, 2, 5, 249);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (45, 1, 2, 1, 8);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (46, 1, 2, 2, 2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (47, 1, 2, 6, 6);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (48, 1, 2, 5, 173);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (49, 4, 2, 1, 1);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (50, 4, 2, 2, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (51, 4, 2, 6, 10);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (52, 4, 2, 5, 236);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (53, 5, 2, 1, 6);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (54, 5, 2, 2, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (55, 5, 2, 6, 5);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (56, 5, 2, 5, 259);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (57, 6, 2, 1, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (58, 6, 2, 2, 1);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (59, 6, 2, 6, 11);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (60, 6, 2, 5, 34);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (61, 11, 2, 1, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (62, 11, 2, 2, 7);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (63, 11, 2, 6, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (64, 11, 2, 5, 196);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (65, 12, 2, 1, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (66, 12, 2, 2, 4);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (67, 12, 2, 6, 3);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (68, 12, 2, 5, 118);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (69, 13, 2, 1, 1);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (70, 13, 2, 2, 1);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (71, 13, 2, 6, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (72, 13, 2, 5, 219);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (73, 14, 2, 1, 2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (74, 14, 2, 2, 3);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (75, 14, 2, 6, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (76, 14, 2, 5, 234);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (77, 15, 2, 1, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (78, 15, 2, 2, 3);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (79, 15, 2, 6, 3);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (80, 15, 2, 5, 30);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (81, 51, 6, 3, 28);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (82, 51, 6, 4, 19);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (83, 51, 6, 7, 5);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (84, 51, 6, 8, 106.0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (85, 52, 6, 3, 16);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (86, 52, 6, 4, 16);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (87, 52, 6, 7, 0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (88, 52, 6, 8, 61.3);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (89, 53, 6, 3, 10);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (90, 53, 6, 4, 16);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (91, 53, 6, 7, 9);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (92, 53, 6, 8, 54.0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (93, 54, 6, 3, 12);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (94, 54, 6, 4, 19);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (95, 54, 6, 7, 5);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (96, 54, 6, 8, 62.0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (97, 55, 6, 3, 14);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (98, 55, 6, 4, 21);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (99, 55, 6, 7, 4);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (100, 55, 6, 8, 56.6);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (101, 56, 6, 3, 27);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (102, 56, 6, 4, 13);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (103, 56, 6, 7, 1);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (104, 56, 6, 8, 81.7);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (105, 57, 6, 3, 22);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (106, 57, 6, 4, 17);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (107, 57, 6, 7, 8);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (108, 57, 6, 8, 85.9);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (109, 58, 6, 3, 16);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (110, 58, 6, 4, 14);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (111, 58, 6, 7, 5);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (112, 58, 6, 8, 71.7);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (113, 59, 6, 3, 14);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (114, 59, 6, 4, 16);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (115, 59, 6, 7, 6);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (116, 59, 6, 8, 56.9);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (117, 60, 6, 3, 12);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (118, 60, 6, 4, 20);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (119, 60, 6, 7, 5);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (120, 60, 6, 8, 60.9);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (121, 61, 7, 3, 35);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (122, 61, 7, 4, 32);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (123, 61, 7, 7, 3);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (124, 61, 7, 8, 79.5);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (125, 62, 7, 3, 28);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (126, 62, 7, 4, 30);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (127, 62, 7, 7, 17);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (128, 62, 7, 8, 76.7);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (129, 63, 7, 3, 26);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (130, 63, 7, 4, 31);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (131, 63, 7, 7, 4);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (132, 63, 7, 8, 71.4);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (133, 64, 7, 3, 18);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (134, 64, 7, 4, 33);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (135, 64, 7, 7, 4);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (136, 64, 7, 8, 67.1);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (137, 65, 7, 3, 15);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (138, 65, 7, 4, 27);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (139, 65, 7, 7, 5);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (140, 65, 7, 8, 42.0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (141, 56, 7, 3, 26);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (142, 56, 7, 4, 25);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (143, 56, 7, 7, 9);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (144, 56, 7, 8, 75.2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (145, 57, 7, 3, 38);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (146, 57, 7, 4, 22);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (147, 57, 7, 7, 2);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (148, 57, 7, 8, 81.7);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (149, 58, 7, 3, 30);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (150, 58, 7, 4, 25);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (151, 58, 7, 7, 8);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (152, 58, 7, 8, 75.3);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (153, 59, 7, 3, 29);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (154, 59, 7, 4, 25);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (155, 59, 7, 7, 8);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (156, 59, 7, 8, 81.0);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (157, 60, 7, 3, 29);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (158, 60, 7, 4, 25);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (159, 60, 7, 7, 13);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (160, 60, 7, 8, 81.2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `comment` (`id`, `content`, `article_id`, `profile_id`, `create_date`, `enabled`) VALUES (1, 'awesome', 1, 1, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_organization`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `favorite_organization` (`profile_id`, `organization_id`) VALUES (1, 1);
INSERT INTO `favorite_organization` (`profile_id`, `organization_id`) VALUES (2, 1);
INSERT INTO `favorite_organization` (`profile_id`, `organization_id`) VALUES (2, 2);
INSERT INTO `favorite_organization` (`profile_id`, `organization_id`) VALUES (2, 3);
INSERT INTO `favorite_organization` (`profile_id`, `organization_id`) VALUES (2, 4);
INSERT INTO `favorite_organization` (`profile_id`, `organization_id`) VALUES (2, 5);
INSERT INTO `favorite_organization` (`profile_id`, `organization_id`) VALUES (2, 6);
INSERT INTO `favorite_organization` (`profile_id`, `organization_id`) VALUES (2, 7);
INSERT INTO `favorite_organization` (`profile_id`, `organization_id`) VALUES (2, 8);
INSERT INTO `favorite_organization` (`profile_id`, `organization_id`) VALUES (2, 9);
INSERT INTO `favorite_organization` (`profile_id`, `organization_id`) VALUES (2, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_team`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (1, 1);
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (2, 1);
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (2, 2);
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (2, 3);
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (2, 4);
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (2, 5);
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (2, 6);
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (2, 7);
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (2, 8);
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (2, 9);
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (2, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_game`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `favorite_game` (`profile_id`, `game_id`) VALUES (1, 1);
INSERT INTO `favorite_game` (`profile_id`, `game_id`) VALUES (2, 1);
INSERT INTO `favorite_game` (`profile_id`, `game_id`) VALUES (2, 2);
INSERT INTO `favorite_game` (`profile_id`, `game_id`) VALUES (2, 3);
INSERT INTO `favorite_game` (`profile_id`, `game_id`) VALUES (2, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_player`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (1, 1);
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (2, 5);
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (2, 9);
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (2, 11);
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (2, 20);
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (2, 33);
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (2, 19);
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (2, 37);
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (2, 45);
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (2, 50);
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (2, 41);

COMMIT;

