-- MySQL Script generated by MySQL Workbench
-- Thu Nov  3 08:41:56 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema football
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema football
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `football` DEFAULT CHARACTER SET utf8 ;
USE `football` ;

-- -----------------------------------------------------
-- Table `football`.`league`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `football`.`league` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `football`.`club`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `football`.`club` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `league_id` INT NOT NULL,
  `current_score` INT NOT NULL DEFAULT 0,
  `year_since_in_current_league` INT NOT NULL,
  `position_in_league` INT NOT NULL,
  `total_league_titles` INT NOT NULL DEFAULT 0,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_club_league1_idx` (`league_id` ASC) VISIBLE,
  CONSTRAINT `fk_club_league1`
    FOREIGN KEY (`league_id`)
    REFERENCES `football`.`league` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `football`.`national_team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `football`.`national_team` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NOT NULL,
  `did_win_national_cup` TINYINT NOT NULL DEFAULT 0,
  `last_won_national_cup` DATE NULL DEFAULT NULL,
  `players_total_value` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `football`.`player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `football`.`player` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `market_value` INT NOT NULL,
  `last_transfer` DATE NULL DEFAULT NULL,
  `is_injured` TINYINT NOT NULL DEFAULT 0,
  `has_a_club` TINYINT NOT NULL DEFAULT 0,
  `club_id` INT NULL,
  `number_in_club` INT NULL DEFAULT NULL,
  `is_in_national_team` TINYINT NOT NULL DEFAULT 0,
  `national_team_id` INT NULL DEFAULT NULL,
  `number_in_national_team` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_player_club1_idx` (`club_id` ASC) VISIBLE,
  INDEX `fk_player_national team1_idx` (`national_team_id` ASC) VISIBLE,
  CONSTRAINT `fk_player_club1`
    FOREIGN KEY (`club_id`)
    REFERENCES `football`.`club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_national team1`
    FOREIGN KEY (`national_team_id`)
    REFERENCES `football`.`national_team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `football`.`national_cup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `football`.`national_cup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `who_won` VARCHAR(45) NULL DEFAULT 'null',
  `year_of_the_competition_start` INT NOT NULL,
  `did_finish` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `football`.`coach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `football`.`coach` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `club_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `how_long_has_been_coach` INT NOT NULL,
  `year_since_in_current_club` INT NOT NULL,
  PRIMARY KEY (`id`, `club_id`),
  INDEX `fk_coach_team1_idx` (`club_id` ASC) VISIBLE,
  CONSTRAINT `fk_coach_team1`
    FOREIGN KEY (`club_id`)
    REFERENCES `football`.`club` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `football`.`national_team_has_national_cup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `football`.`national_team_has_national_cup` (
  `national_team_id` INT NOT NULL,
  `national_cup_id` INT NOT NULL,
  PRIMARY KEY (`national_team_id`, `national_cup_id`),
  INDEX `fk_national_team_has_national_cup_national_cup1_idx` (`national_cup_id` ASC) VISIBLE,
  INDEX `fk_national_team_has_national_cup_national_team1_idx` (`national_team_id` ASC) VISIBLE,
  CONSTRAINT `fk_national_team_has_national_cup_national_team1`
    FOREIGN KEY (`national_team_id`)
    REFERENCES `football`.`national_team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_national_team_has_national_cup_national_cup1`
    FOREIGN KEY (`national_cup_id`)
    REFERENCES `football`.`national_cup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


insert into league (name, country)
values ("Serie A", "Italy"),
("Primera Divisi??n", "Spain"),
("Bundesliga", "Germany");

insert into club (name, league_id, current_score, year_since_in_current_league, position_in_league, total_league_titles, country)
values ("Napoli", 1, 32, 1975, 1, 5, "Italy"),
("Valencia", 2, 22, 1985, 3, 1, "Spain"),
("Getafe", 2, 42, 1990, 1, 3, "Spain"),
("Juventus", 1, 30, 1900, 2, 15, "Italy"),
("Dortmund", 3, 12, 1965, 10, 4, "Germany"),
("Wolfsburg", 3, 15, 1999, 7, 0, "Germany");

insert into coach (club_id, name, age, how_long_has_been_coach, year_since_in_current_club)
values (2, "John Doe", 66, 20, 2018),
(4, "Anonimus", 90, 61, 2000);

insert into national_cup (name, who_won, year_of_the_competition_start, did_finish) 
values ("World cup", "Italy", 2022, 1),
("European cup", "Spain", 1998, 1),
("European cup", null, 2022, 0);

insert into national_team (country, did_win_national_cup, last_won_national_cup, players_total_value)
values ("Italy", 1, "2022-06-30", 1455500),
("Germany", 1, "2018-05-25", 3455500),
("Hungary", 0, null, 545000);

insert into national_team_has_national_cup (national_team_id, national_cup_id) 
values (1, 2),
(1, 1),
(2, 2),
(2, 1),
(3, 1),
(1, 3),
(2, 3),
(3, 3);

insert into player (name, nationality, age, position, market_value, last_transfer, is_injured, has_a_club, club_id, number_in_club, is_in_national_team, national_team_id, number_in_national_team)
values ("Dominik Szoboszlai", "Hungarian", 24, "CAM", 34000000, "2020-04-25", 0, 1, 5, 17, 1, 1, 17),
("Ronaldo", "Brasilian", 45, "ST", 15000000, "2015-07-11", 1, 0, null, null, 0, null, null),
("David Beckham", "English", 40, "LW", 17000000, "2008-08-25", 0, 0, null, null, 0, null, null),
("Kevin DeBruyne", "Belgian", 31, "CAM", 115000000, "2010-12-05", 0, 1, 3, 8, 1, 3, 9),
("Bruno Fernandes", "Portugalian", 30, "CAM", 95000000, "2019-03-16", 0, 1, 4, 7, 1, 2, 12);