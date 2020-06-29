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
  PRIMARY KEY (`id`),
  INDEX `fk_article_profile1_idx` (`profile_id` ASC),
  CONSTRAINT `fk_article_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `profile` (`id`)
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
-- Table `team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `team` ;

CREATE TABLE IF NOT EXISTS `team` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `img_url` VARCHAR(5000) NULL,
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
  `stream_url` VARCHAR(5000) NULL,
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
  `team1_title` VARCHAR(45) NULL,
  `team2_title` VARCHAR(45) NULL,
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

COMMIT;


-- -----------------------------------------------------
-- Data for table `profile`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `profile` (`id`, `user_id`, `first_name`, `last_name`, `email`, `avatar_url`) VALUES (1, 1, 'bobby', 'dobbs', 'bobdobbs@esports.com', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/8/88/Cloud9logo_square.png/1200px-Cloud9logo_square.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `article`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`) VALUES (1, 'test', 'test article', 'https://specials-images.forbesimg.com/imageserve/5e0f8f19db7a9600065d7cec/960x0.jpg?fit=scale', 1, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `region`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `region` (`id`, `name`) VALUES (1, 'North America');

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `game`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `game` (`id`, `title`, `genre`, `img_url`, `website_url`) VALUES (1, 'League of Legends', 'MOBA', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/c/c8/LCS_2020_Logo.png', 'https://www.lolesports.com');
INSERT INTO `game` (`id`, `title`, `genre`, `img_url`, `website_url`) VALUES (2, 'Counterstrike: Global Offensive', 'FPS', NULL, 'https://blog.counter-strike.net/');
INSERT INTO `game` (`id`, `title`, `genre`, `img_url`, `website_url`) VALUES (3, 'Overwatch', 'FPS', NULL, 'https://playoverwatch.com/en-us/');
INSERT INTO `game` (`id`, `title`, `genre`, `img_url`, `website_url`) VALUES (4, 'Rocket League', 'Sports', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `team`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (1, 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/8/88/Cloud9logo_square.png/1200px-Cloud9logo_square.png', 1, 1);
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (2, 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/f/f4/Team_Liquidlogo_square.png', 2, 1);
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (3, NULL, 3, 1);
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (4, NULL, 4, 1);
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (5, NULL, 5, 1);
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (6, NULL, 6, 1);
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (7, NULL, 7, 1);
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (8, NULL, 8, 1);
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (9, NULL, 9, 1);
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (10, NULL, 10, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `player`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (1, 'Robert', 'Huang', 'Blaber', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (2, 'Jo', 'Yong-in', 'CoreJJ', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (3, NULL, NULL, 'Licorice', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (4, NULL, NULL, 'Nisqy', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (5, NULL, NULL, 'Zven', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (6, NULL, NULL, 'Vulcan', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (7, NULL, NULL, 'Impact', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (8, NULL, NULL, 'Broxah', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (9, NULL, NULL, 'Jensen', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (10, NULL, NULL, 'Tactical', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (11, NULL, NULL, 'allorim', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (12, NULL, NULL, 'Xmithie', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (13, NULL, NULL, 'Insanity', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (14, NULL, NULL, 'Apollo', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (15, NULL, NULL, 'Hakuho', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (16, NULL, NULL, 'ssumday', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (17, NULL, NULL, 'Meteos', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (18, NULL, NULL, 'Ryoma', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (19, NULL, NULL, 'Cody Sun', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (20, NULL, NULL, 'Stunt', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (21, NULL, NULL, 'Ruin', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (22, NULL, NULL, 'Wiggily', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (23, NULL, NULL, 'Pobelter', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (24, NULL, NULL, 'Stixxay', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (25, NULL, NULL, 'Smoothie', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (26, NULL, NULL, 'Lourlo', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (27, NULL, NULL, 'Akaadian', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (28, NULL, NULL, 'Froggen', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (29, NULL, NULL, 'Johnsun', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (30, NULL, NULL, 'Aphromoo', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (31, NULL, NULL, 'Kumo', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (32, NULL, NULL, 'Svenskeren', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (33, NULL, NULL, 'Jiizuke', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (34, NULL, NULL, 'Bang', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (35, NULL, NULL, 'Zeyzal', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (36, NULL, NULL, 'Solo', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (37, NULL, NULL, 'Santorin', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (38, NULL, NULL, 'PowerOfEvil', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (39, NULL, NULL, 'Mash', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (40, NULL, NULL, 'IgNar', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (41, NULL, NULL, 'Hauntzer', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (42, NULL, NULL, 'Closer', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (43, NULL, NULL, 'Damonte', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (44, NULL, NULL, 'FBI', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (45, NULL, NULL, 'Huhi', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (46, NULL, NULL, 'BrokenBlade', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (47, NULL, NULL, 'Spica', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (48, NULL, NULL, 'Bjergsen', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (49, NULL, NULL, 'Doublelift', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (50, NULL, NULL, 'Biofrost', NULL);

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `series`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `series` (`id`, `name`, `description`, `img_url`) VALUES (1, 'LCS Sumer Split', 'North America League of Legends pro circuit', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/c/c8/LCS_2020_Logo.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `series_match`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `team1_title`, `team2_title`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (1, 1, 1, 2, NULL, NULL, NULL, NULL, 'Match 1', 1);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `team1_title`, `team2_title`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (2, 1, 1, 9, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `team1_title`, `team2_title`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (3, 1, 3, 10, NULL, NULL, NULL, NULL, NULL, 10);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `team1_title`, `team2_title`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (4, 1, 5, 6, NULL, NULL, NULL, NULL, NULL, 6);
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `team1_title`, `team2_title`, `start_date`, `start_time`, `title`, `winner_id`) VALUES (5, 1, 8, 7, NULL, NULL, NULL, NULL, NULL, 8);

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_team`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `favorite_team` (`profile_id`, `team_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_game`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `favorite_game` (`profile_id`, `game_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_player`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `favorite_player` (`profile_id`, `player_id`) VALUES (1, 1);

COMMIT;

