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
  PRIMARY KEY (`id`),
  INDEX `fk_matchh_series1_idx` (`series_id` ASC),
  INDEX `fk_series_match_team1_idx` (`team1_id` ASC),
  INDEX `fk_series_match_team2_idx` (`team2_id` ASC),
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

COMMIT;


-- -----------------------------------------------------
-- Data for table `game`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `game` (`id`, `title`, `genre`, `img_url`, `website_url`) VALUES (1, 'League of Legends', 'MOBA', 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/c/c8/LCS_2020_Logo.png', 'www.lolesports.com');
INSERT INTO `game` (`id`, `title`, `genre`, `img_url`, `website_url`) VALUES (2, 'Counterstrike: Global Offensive', 'FPS', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `team`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (1, 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/thumb/8/88/Cloud9logo_square.png/1200px-Cloud9logo_square.png', 1, 1);
INSERT INTO `team` (`id`, `img_url`, `organization_id`, `game_id`) VALUES (2, 'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/f/f4/Team_Liquidlogo_square.png', 2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `player`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (1, 'Robert', 'Huang', 'Blaber', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `stream_url`) VALUES (2, 'Jo', 'Yong-in', 'CoreJJ', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `team_join_player`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (1, 1);
INSERT INTO `team_join_player` (`team_id`, `player_id`) VALUES (2, 2);

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
INSERT INTO `series_match` (`id`, `series_id`, `team1_id`, `team2_id`, `team1_title`, `team2_title`, `start_date`, `start_time`, `title`) VALUES (1, 1, 1, 2, NULL, NULL, NULL, NULL, 'Match 1');

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `player_match`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (1, 1);
INSERT INTO `player_match` (`player_id`, `series_match_id`) VALUES (2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `player_match_stat`
-- -----------------------------------------------------
START TRANSACTION;
USE `esportsdb`;
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (1, 1, 1, 1, 5);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (2, 1, 1, 2, 1);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (3, 2, 1, 1, 4);
INSERT INTO `player_match_stat` (`id`, `player_match_player_id`, `player_match_series_match_id`, `game_stat_id`, `value`) VALUES (4, 2, 1, 2, 3);

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

