-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Amistades
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Amistades
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Amistades` DEFAULT CHARACTER SET utf8 ;
USE `Amistades` ;

-- -----------------------------------------------------
-- Table `Amistades`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Amistades`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT NOW(),
  `updated_at` DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Amistades`.`friendships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Amistades`.`friendships` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `friend_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT NOW(),
  `update_at` DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (`user_id`, `friend_id`, `id`),
  INDEX `fk_users_has_users_users1_idx` (`friend_id` ASC) VISIBLE,
  INDEX `fk_users_has_users_users_idx` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

use amistades;

-- Consulta: crea 6 usuarios nuevos
INSERT INTO users (first_name, last_name)
VALUES 
('Amy', ' Giver'),
('Eli', ' Byers'),
('Marky', ' Mark'),
('Big', ' Bird'),
('Sam', ' Mc'),
('La rana', ' René');

-- Consulta: haz que el usuario 1 sea amigo del usuario 2, 4 y 6
INSERT INTO friendships (user_id, friend_id)
VALUES (1,2),
       (1,4),
       (1,6);
-- Consulta: haz que el usuario 2 sea amigo del usuario 1, 3 y 5
INSERT INTO friendships (user_id, friend_id)
VALUES (2,1),
       (2,3),
       (2,5);
       
-- Consulta: haz que el usuario 3 sea amigo del usuario 2 y 5
INSERT INTO friendships (user_id, friend_id)
VALUES (3,2),
       (3,5);
       
-- Consulta: haz que el usuario 4 sea amigo del usuario 3
INSERT INTO friendships (user_id, friend_id)
VALUES (4,3);
    
-- Consulta: haz que el usuario 5 sea amigo del usuario 1 y 6
INSERT INTO friendships (user_id, friend_id)
VALUES (5,1),
	   (5,6);
    
-- Consulta: haz que el usuario 6 sea amigo del usuario 2 y 3
INSERT INTO friendships (user_id, friend_id)
VALUES (6,2),
	   (6,3);
       
-- Consulta: muestra las relaciones creadas como se muestra en la imagen de arriba
SELECT u1.first_name, u1.last_name, u2.first_name AS friend_first_name, u2.last_name AS friend_last_name
FROM users u1
JOIN friendships f ON u1.id = f.user_id
LEFT JOIN users u2 ON f.friend_id = u2.id;


-- Consulta NINJA: Devuelve todos los usuarios que son amigos del primer usuario, asegúrate de que sus nombres se muestren en los resultados.
SELECT u2.first_name, u2.last_name, u1.id, u1.first_name
FROM users u1
JOIN friendships f ON u1.id = f.user_id
JOIN users u2 ON f.friend_id = u2.id
WHERE u1.id = 1;


-- Consulta NINJA: Devuelve el recuento de todas las amistades
SELECT COUNT(*) AS todas_las_amistades
FROM friendships;

-- Consulta NINJA: averigua quién tiene más amigos y devuelve la cuenta de sus amigos.
SELECT u.first_name, u.last_name, COUNT(f.friend_id) AS total_amigos
FROM users u
JOIN friendships f ON u.id = f.user_id
GROUP BY u.id
ORDER BY total_amigos DESC
LIMIT 1;

-- Consulta NINJA: Devuelve los amigos del tercer usuario en orden alfabético
SELECT u2.first_name, u2.last_name
FROM users u1
JOIN friendships f ON u1.id = f.user_id
JOIN users u2 ON f.friend_id = u2.id
WHERE u1.id = 3
ORDER BY u2.first_name;