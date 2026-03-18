-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-03-2026 a las 01:41:12
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `api-crud`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `api_users`
--

CREATE TABLE `api_users` (
  `Api_user_id` int(11) NOT NULL,
  `Api_user` varchar(60) NOT NULL,
  `Api_password` varchar(255) NOT NULL,
  `Api_role` enum('Admin','Client','Test') NOT NULL,
  `Api_status` enum('Active','Inactive','Blocked','Delete') NOT NULL,
  `Created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `Updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `api_users`
--

INSERT INTO `api_users` (`Api_user_id`, `Api_user`, `Api_password`, `Api_role`, `Api_status`, `Created_at`, `Updated_at`) VALUES
(1, 'user@email.com', '$2b$10$A.RezjA04B1GcvfGDnnve.elhd56BPN.44qUtvgyVG5Jy8IkwxoFi', 'Admin', 'Active', '2026-01-01 17:00:00', NULL),
(2, 'SegDavid', '$2b$10$CVmfWYgn1ANhpPSZQJmHfuYGCUV7mQH.xV.VY7Wdtoap4OIyCh1Em', '', 'Active', '2026-03-17 00:57:38', NULL),
(3, 'terDahgjhv', '$2b$10$C2WQKoNBfMg422UUr.r2U.yrdChxHBfFAgrkqE91Emxl40eiTKT02', '', 'Active', '2026-03-17 00:58:47', NULL),
(4, 'DiomedesDiaz', '$2b$10$Z4/vuvZOUdVCJId1qyCJpuYxpDLYslLoi/CSl8fQIJ6B.cb4TLedS', '', 'Active', '2026-03-17 01:20:05', NULL),
(6, 'david1234', '$2b$10$ee/qNYnOVemWFyZvep.mA.Y5CpRJAzvjz4RgZBTklHdnDWCQLDn5y', '', 'Active', '2026-03-17 02:29:39', NULL),
(10, 'jhdelacruz', '$2b$10$A8LaXKKsbjKoZ2yKRnvSFOYdyS1XXO47m19lkMod89xq6h3LkXsFe', 'Admin', 'Active', '2026-03-18 00:35:52', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `api_users`
--
ALTER TABLE `api_users`
  ADD PRIMARY KEY (`Api_user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `api_users`
--
ALTER TABLE `api_users`
  MODIFY `Api_user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
