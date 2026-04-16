-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-04-2026 a las 20:23:00
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_votacion`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `candidato`
--

CREATE TABLE `candidato` (
  `candidato_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `propuesta` text DEFAULT NULL,
  `facultad_id` int(11) DEFAULT NULL,
  `cargo_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `candidato`
--

INSERT INTO `candidato` (`candidato_id`, `nombre`, `propuesta`, `facultad_id`, `cargo_id`) VALUES
(1, 'Laura G.', 'Mejorar laboratorios', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE `cargo` (
  `cargo_id` int(11) NOT NULL,
  `nombre_cargo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`cargo_id`, `nombre_cargo`) VALUES
(1, 'Presidente'),
(2, 'Secretario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `estudiante_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `facultad_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`estudiante_id`, `nombre`, `apellido`, `correo`, `facultad_id`) VALUES
(1, 'Juan', 'Pérez', 'juan@correo.com', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facultad`
--

CREATE TABLE `facultad` (
  `facultad_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `decano` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facultad`
--

INSERT INTO `facultad` (`facultad_id`, `nombre`, `decano`) VALUES
(1, 'Ingeniería', 'Dr. Smith'),
(2, 'Artes', 'Dra. García');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voto`
--

CREATE TABLE `voto` (
  `voto_id` int(11) NOT NULL,
  `estudiante_id` int(11) DEFAULT NULL,
  `candidato_id` int(11) DEFAULT NULL,
  `fecha_hora` datetime DEFAULT current_timestamp(),
  `ip_registro` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `candidato`
--
ALTER TABLE `candidato`
  ADD PRIMARY KEY (`candidato_id`),
  ADD KEY `facultad_id` (`facultad_id`),
  ADD KEY `cargo_id` (`cargo_id`);

--
-- Indices de la tabla `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`cargo_id`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`estudiante_id`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `facultad_id` (`facultad_id`);

--
-- Indices de la tabla `facultad`
--
ALTER TABLE `facultad`
  ADD PRIMARY KEY (`facultad_id`);

--
-- Indices de la tabla `voto`
--
ALTER TABLE `voto`
  ADD PRIMARY KEY (`voto_id`),
  ADD UNIQUE KEY `estudiante_id` (`estudiante_id`),
  ADD KEY `candidato_id` (`candidato_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `candidato`
--
ALTER TABLE `candidato`
  MODIFY `candidato_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cargo`
--
ALTER TABLE `cargo`
  MODIFY `cargo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `estudiante_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `facultad`
--
ALTER TABLE `facultad`
  MODIFY `facultad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `voto`
--
ALTER TABLE `voto`
  MODIFY `voto_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `candidato`
--
ALTER TABLE `candidato`
  ADD CONSTRAINT `candidato_ibfk_1` FOREIGN KEY (`facultad_id`) REFERENCES `facultad` (`facultad_id`),
  ADD CONSTRAINT `candidato_ibfk_2` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`cargo_id`);

--
-- Filtros para la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `estudiante_ibfk_1` FOREIGN KEY (`facultad_id`) REFERENCES `facultad` (`facultad_id`);

--
-- Filtros para la tabla `voto`
--
ALTER TABLE `voto`
  ADD CONSTRAINT `voto_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiante` (`estudiante_id`),
  ADD CONSTRAINT `voto_ibfk_2` FOREIGN KEY (`candidato_id`) REFERENCES `candidato` (`candidato_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
