-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-03-2026 a las 16:08:40
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
-- Base de datos: `constructora_bd`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaciones`
--

CREATE TABLE `asignaciones` (
  `id` int(11) NOT NULL,
  `id_proyecto` int(11) DEFAULT NULL,
  `id_trabajador` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `dias_trabajados` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asignaciones`
--

INSERT INTO `asignaciones` (`id`, `id_proyecto`, `id_trabajador`, `fecha_inicio`, `fecha_fin`, `dias_trabajados`) VALUES
(1, 1, 1, '2024-01-01', NULL, 0),
(2, 1, 2, '2024-01-01', NULL, 0),
(3, 2, 3, '2023-05-10', '2023-11-20', 194),
(4, 2, 4, '2023-05-10', '2023-11-20', 194);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiales`
--

CREATE TABLE `materiales` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `unidad` varchar(20) DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL CHECK (`stock` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materiales`
--

INSERT INTO `materiales` (`id`, `nombre`, `unidad`, `precio_unitario`, `stock`) VALUES
(1, 'Cemento', 'Bulto', 25000.00, 100),
(2, 'Arena', 'm3', 45000.00, 15),
(3, 'Ladrillo', 'Unidad', 1200.00, 500),
(4, 'Hierro', 'Varilla', 35000.00, 8),
(5, 'Pintura', 'Galon', 85000.00, 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `nit` varchar(20) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `especialidad` varchar(50) DEFAULT NULL,
  `contacto` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `nit`, `nombre`, `especialidad`, `contacto`) VALUES
(1, '9001-1', 'Ferretería Central', 'Construcción', '300123'),
(2, '8002-2', 'Suministros SAS', 'Acabados', '310456');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

CREATE TABLE `proyectos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ubicacion` varchar(150) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin_estimada` date DEFAULT NULL,
  `presupuesto` decimal(15,2) DEFAULT NULL CHECK (`presupuesto` > 0),
  `estado` enum('planificacion','ejecucion','terminado','pausado') DEFAULT NULL,
  `porcentaje_avance` decimal(5,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proyectos`
--

INSERT INTO `proyectos` (`id`, `nombre`, `ubicacion`, `fecha_inicio`, `fecha_fin_estimada`, `presupuesto`, `estado`, `porcentaje_avance`) VALUES
(1, 'Edificio Sol', 'Norte', '2024-01-01', '2024-12-31', 500000.00, 'ejecucion', 0.00),
(2, 'Puente Real', 'Sur', '2023-05-10', '2023-11-20', 300000.00, 'terminado', 100.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajadores`
--

CREATE TABLE `trabajadores` (
  `id` int(11) NOT NULL,
  `documento` varchar(20) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `salario_dia` decimal(10,2) DEFAULT NULL CHECK (`salario_dia` > 0),
  `estado` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajadores`
--

INSERT INTO `trabajadores` (`id`, `documento`, `nombre`, `cargo`, `salario_dia`, `estado`) VALUES
(1, '101', 'Juan Perez', 'Obrero', 50000.00, 'activo'),
(2, '102', 'Ana Rios', 'Ingeniera', 150000.00, 'activo'),
(3, '103', 'Luis Mora', 'Maestro', 80000.00, 'activo'),
(4, '104', 'Leo Cruz', 'Soldador', 70000.00, 'activo'),
(5, '105', 'Marta Gil', 'Arquitecta', 140000.00, 'activo'),
(6, '106', 'Jose Paz', 'Obrero', 50000.00, 'activo');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignaciones`
--
ALTER TABLE `asignaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_proyecto` (`id_proyecto`),
  ADD KEY `id_trabajador` (`id_trabajador`);

--
-- Indices de la tabla `materiales`
--
ALTER TABLE `materiales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nit` (`nit`);

--
-- Indices de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `trabajadores`
--
ALTER TABLE `trabajadores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `documento` (`documento`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignaciones`
--
ALTER TABLE `asignaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `materiales`
--
ALTER TABLE `materiales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `trabajadores`
--
ALTER TABLE `trabajadores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignaciones`
--
ALTER TABLE `asignaciones`
  ADD CONSTRAINT `asignaciones_ibfk_1` FOREIGN KEY (`id_proyecto`) REFERENCES `proyectos` (`id`),
  ADD CONSTRAINT `asignaciones_ibfk_2` FOREIGN KEY (`id_trabajador`) REFERENCES `trabajadores` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
