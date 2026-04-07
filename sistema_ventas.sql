-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-04-2026 a las 03:23:47
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
-- Base de datos: `sistema_ventas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `abastecer_producto` (IN `p_id_producto` INT, IN `p_cantidad_nueva` INT)   BEGIN
    -- Sumamos la nueva cantidad al stock que ya existe
    UPDATE productos 
    SET stock = stock + p_cantidad_nueva
    WHERE id_producto = p_id_producto;
    
    -- Mensaje de confirmación simple
    SELECT CONCAT("Stock actualizado. Producto ID: ", p_id_producto) AS Confirmacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_venta` (IN `p_id_producto` INT, IN `p_cantidad` INT, OUT `p_total` DECIMAL(10,2), OUT `p_mensaje` VARCHAR(100))   BEGIN
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_stock INT;

    -- Obtener precio y stock actual
    SELECT precio, stock INTO v_precio, v_stock
    FROM productos WHERE id_producto = p_id_producto;

    -- Validar stock suficiente
    IF v_stock < p_cantidad THEN
        SET p_total = 0;
        SET p_mensaje = "Error: stock insuficiente";
    ELSE
        SET p_total = v_precio * p_cantidad;
        SET p_mensaje = CONCAT("Venta OK. Total: ", p_total);
        
        -- Actualizar el stock en la tabla productos
        UPDATE productos SET stock = stock - p_cantidad
        WHERE id_producto = p_id_producto;
        
        -- Opcional: Insertar en la tabla de ventas para que quede registro
        INSERT INTO detalle_ventas (id_producto, cantidad_vendida, total_pago) 
        VALUES (p_id_producto, p_cantidad, p_total);
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `id_detalle` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad_vendida` int(11) DEFAULT NULL,
  `total_pago` decimal(10,2) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`id_detalle`, `id_producto`, `cantidad_vendida`, `total_pago`, `fecha`) VALUES
(1, 3, 2, 90000.00, '2026-03-15 15:51:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `precio`, `stock`) VALUES
(3, 'Memoria RAM 16GB', 45000.00, 8);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `fk_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD CONSTRAINT `fk_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
