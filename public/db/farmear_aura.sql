-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.4.3 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para farmear_aura
CREATE DATABASE IF NOT EXISTS `farmear_aura` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `farmear_aura`;

-- Volcando estructura para tabla farmear_aura.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `apellido` varchar(80) NOT NULL,
  `email` varchar(120) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla farmear_aura.clientes: ~7 rows (aproximadamente)
INSERT INTO `clientes` (`id_cliente`, `nombre`, `apellido`, `email`, `telefono`) VALUES
	(1, 'Lucía', 'Fernández', 'lucia.fernandez@example.com', '+54 9 11 5234-1001'),
	(2, 'Martín', 'Gómez', 'martin.gomez@example.com', '+54 9 11 5234-1002'),
	(3, 'Camila', 'Rodríguez', 'camila.rodriguez@example.com', '+54 9 11 5234-1003'),
	(4, 'Joaquín', 'López', 'joaquin.lopez@example.com', '+54 9 11 5234-1004'),
	(5, 'Valentina', 'Martínez', 'valentina.martinez@example.com', '+54 9 11 5234-1005'),
	(6, 'Santiago', 'Pérez', 'santiago.perez@example.com', '+54 9 11 5234-1006'),
	(7, 'Sofía', 'Díaz', 'sofia.diaz@example.com', '+54 9 11 5234-1007');

-- Volcando estructura para tabla farmear_aura.consultas
CREATE TABLE IF NOT EXISTS `consultas` (
  `id_consulta` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_consulta`),
  KEY `fk_consultas_cliente` (`id_cliente`),
  CONSTRAINT `fk_consultas_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla farmear_aura.consultas: ~4 rows (aproximadamente)
INSERT INTO `consultas` (`id_consulta`, `id_cliente`, `nombre`, `email`, `mensaje`, `fecha_envio`, `estado`) VALUES
	(1, 1, 'Lucía Fernández', 'lucia.fernandez@example.com', 'Hola, quería saber si La Cripta del Alquimista es apta para personas que nunca hicieron una sala de escape.', '2026-10-20 10:15:00', 1),
	(2, 3, 'Camila Rodríguez', 'camila.rodriguez@example.com', 'Somos un grupo de 6 y queremos reservar El Último Grimorio. ¿Tienen descuento para grupos?', '2026-10-21 16:40:00', 1),
	(3, 5, 'Valentina Martínez', 'valentina.martinez@example.com', 'Quiero festejar el cumpleaños de mi hermano menor. ¿El Castillo se puede reservar para chicos de 10 años?', '2026-10-22 12:05:00', 0),
	(4, 6, 'Santiago Pérez', 'santiago.perez@example.com', '¿Puedo cambiar el horario de mi reserva de la Estación Abandonada para otro día de esta semana?', '2026-10-23 09:30:00', 0);

-- Volcando estructura para tabla farmear_aura.horarios
CREATE TABLE IF NOT EXISTS `horarios` (
  `id_horario` int NOT NULL AUTO_INCREMENT,
  `id_sala` int NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `estado` enum('Disponible','Reservado') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Disponible',
  PRIMARY KEY (`id_horario`),
  KEY `fk_horarios_sala` (`id_sala`),
  CONSTRAINT `fk_horarios_sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla farmear_aura.horarios: ~10 rows (aproximadamente)
INSERT INTO `horarios` (`id_horario`, `id_sala`, `fecha`, `hora_inicio`, `hora_fin`, `estado`) VALUES
	(1, 1, '2026-10-27', '14:00:00', '15:00:00', 'Disponible'),
	(2, 2, '2026-10-27', '16:00:00', '17:15:00', 'Disponible'),
	(3, 3, '2026-10-28', '15:00:00', '16:30:00', 'Disponible'),
	(4, 4, '2026-10-28', '18:00:00', '18:45:00', 'Disponible'),
	(5, 1, '2026-10-29', '19:00:00', '20:00:00', 'Disponible'),
	(6, 2, '2026-10-30', '20:00:00', '21:15:00', 'Disponible'),
	(7, 3, '2026-10-30', '21:00:00', '22:30:00', 'Disponible'),
	(9, 1, '2026-10-31', '21:30:00', '22:30:00', 'Disponible'),
	(11, 1, '2026-10-31', '21:30:00', '22:30:00', 'Reservado'),
	(12, 2, '2026-11-01', '17:00:00', '18:15:00', 'Reservado');

-- Volcando estructura para tabla farmear_aura.reservas
CREATE TABLE IF NOT EXISTS `reservas` (
  `id_reserva` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_horario` int NOT NULL,
  `cantidad_participantes` int NOT NULL,
  `estado` enum('Pendiente','Confirmada','Cancelada') NOT NULL DEFAULT 'Pendiente',
  PRIMARY KEY (`id_reserva`),
  KEY `fk_reservas_cliente` (`id_cliente`),
  KEY `fk_reservas_horario` (`id_horario`),
  CONSTRAINT `fk_reservas_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `fk_reservas_horario` FOREIGN KEY (`id_horario`) REFERENCES `horarios` (`id_horario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla farmear_aura.reservas: ~3 rows (aproximadamente)
INSERT INTO `reservas` (`id_reserva`, `id_cliente`, `id_horario`, `cantidad_participantes`, `estado`) VALUES
	(1, 3, 3, 6, 'Confirmada'),
	(2, 5, 4, 5, 'Pendiente'),
	(3, 6, 2, 4, 'Confirmada');

-- Volcando estructura para tabla farmear_aura.salas
CREATE TABLE IF NOT EXISTS `salas` (
  `id_sala` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `dificultad` enum('Facil','Media','Dificil') NOT NULL,
  `capacidad_minima` int NOT NULL,
  `capacidad_maxima` int NOT NULL,
  `duracion_minutos` int NOT NULL,
  PRIMARY KEY (`id_sala`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla farmear_aura.salas: ~4 rows (aproximadamente)
INSERT INTO `salas` (`id_sala`, `nombre`, `descripcion`, `dificultad`, `capacidad_minima`, `capacidad_maxima`, `duracion_minutos`) VALUES
	(1, 'La Cripta del Alquimista', 'Un laboratorio oculto, una fórmula imposible y 60 minutos para descubrir la salida.', 'Media', 2, 6, 60),
	(2, 'Estación Abandonada', 'Un tren detenido en el tiempo. Una última señal. Y algo que no debería estar ahí.', 'Media', 2, 8, 75),
	(3, 'El Último Grimorio', 'Magia, símbolos y secretos prohibidos. La sala para quienes quieren ir al límite.', 'Dificil', 3, 6, 90),
	(4, 'El Castillo', 'Una aventura fantástica pensada para que los más chicos también puedan jugar.', 'Facil', 2, 6, 45);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
