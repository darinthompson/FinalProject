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
INSERT INTO `article` (`id`, `title`, `content`, `img_url`, `profile_id`, `create_date`, `enabled`, `game_id`) VALUES (1, 'test', 'test article', 'https://specials-images.forbesimg.com/imageserve/5e0f8f19db7a9600065d7cec/960x0.jpg?fit=scale', 1, NULL, 1, 1);

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
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (12, NULL, NULL, 'Xmithie', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (13, NULL, NULL, 'Insanity', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (14, NULL, NULL, 'Apollo', NULL);
INSERT INTO `player` (`id`, `first_name`, `last_name`, `handle`, `img_url`) VALUES (15, NULL, NULL, 'Hakuho', NULL);
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

