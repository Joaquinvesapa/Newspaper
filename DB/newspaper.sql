-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 08, 2023 at 04:06 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `newspaper`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_categorias` (IN `categoria_id` INT)   BEGIN
SELECT 
	c.id as CategoriaId,
    c.denominacion as Categoria,
    c.estado_id as EstadoId
FROM categorias c
WHERE (categoria_id = -1 OR c.id = categoria_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_mensajes` (IN `mensaje_id` INT, IN `estado_mensaje` INT, IN `offset` INT)   BEGIN
    SELECT
        m.id as MensajeId,
        m.nombre as Nombre,
        m.email as Email,
        m.asunto as Asunto,
        m.fecha_hora as FechaHora,
        m.mensaje as Mensaje,
        m.estado_id as EstadoId,
        e.denominacion as Estado
    FROM mensajes m
    INNER JOIN estados e ON e.id = m.estado_id
    WHERE m.estado_id = estado_mensaje 
      AND (mensaje_id = -1 OR m.id = mensaje_id)
    ORDER BY m.fecha_hora DESC
    LIMIT 20 OFFSET offset;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_noticias` (IN `noticia_id` INT, IN `offset` INT)   BEGIN
    SELECT 
        n.id as NoticiaId,
        n.titulo as Titulo,
        n.autor as Autor,
        n.ubicacion as Ubicacion,
        n.fecha_hora as FechaHora,
        n.imagen_url as ImagenUrl,
        n.cuerpo as Cuerpo,
        n.categoria_id as CategoriaId,
        c.denominacion as Categoria
    FROM noticias n
    INNER JOIN categorias c ON c.id = n.categoria_id
    WHERE (noticia_id = -1 or n.id = noticia_id) AND n.estado_id != 2
ORDER BY n.fecha_hora DESC
LIMIT 10 OFFSET offset;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_noticias_por_categoria` (IN `categoria_id` INT, IN `offset` INT)   BEGIN
 
SELECT 
        n.id as NoticiaId,
         n.titulo as Titulo,
        n.autor as Autor,
        n.ubicacion as Ubicacion,
        n.fecha_hora as FechaHora,
        n.imagen_url as ImagenUrl,
        n.cuerpo as Cuerpo,
        n.categoria_id as CategoriaId,
        c.denominacion as Categoria
    FROM noticias n
    INNER JOIN categorias c ON c.id = n.categoria_id
    WHERE n.categoria_id like categoria_id AND n.estado_id = 1
    LIMIT 10 OFFSET offset;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_total_noticias_por_categoria` (IN `categoria_id` INT)   BEGIN
	SELECT COUNT(*) as Total FROM noticias WHERE noticias.categoria_id = categoria_id AND noticias.estado_id = 1;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `denominacion` varchar(50) DEFAULT NULL,
  `estado_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categorias`
--

INSERT INTO `categorias` (`id`, `denominacion`, `estado_id`) VALUES
(8, 'Educación', 1),
(9, 'Economía', 1),
(10, 'Internacional', 1),
(11, 'Salud', 1),
(12, 'Política', 1),
(13, 'Deporte', 1),
(14, 'Entretenimiento', 1);

-- --------------------------------------------------------

--
-- Table structure for table `estados`
--

CREATE TABLE `estados` (
  `id` int(11) NOT NULL,
  `denominacion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `estados`
--

INSERT INTO `estados` (`id`, `denominacion`) VALUES
(1, 'Activo'),
(2, 'Inactivo'),
(3, 'Enviado'),
(4, 'Pendiente'),
(5, 'Respondido'),
(6, 'Recibido');

-- --------------------------------------------------------

--
-- Table structure for table `imagenes`
--

CREATE TABLE `imagenes` (
  `id` int(11) NOT NULL,
  `ruta` varchar(250) NOT NULL,
  `alt` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `imagenes`
--

INSERT INTO `imagenes` (`id`, `ruta`, `alt`) VALUES
(1, 'orm-php/public/images/destaque-economia.png', 'Imagen sobre economia');

-- --------------------------------------------------------

--
-- Table structure for table `mensajes`
--

CREATE TABLE `mensajes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `asunto` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `fecha_hora` datetime DEFAULT current_timestamp(),
  `mensaje` mediumtext NOT NULL,
  `estado_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `noticias`
--

CREATE TABLE `noticias` (
  `id` int(11) NOT NULL,
  `titulo` varchar(250) NOT NULL,
  `autor` varchar(50) NOT NULL,
  `ubicacion` varchar(100) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `imagen_url` varchar(250) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `cuerpo` longtext NOT NULL,
  `estado_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `respuestas`
--

CREATE TABLE `respuestas` (
  `id` int(11) NOT NULL,
  `respuesta` longtext DEFAULT NULL,
  `estado_id` int(11) DEFAULT 1,
  `mensaje_respondido_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `apenom` varchar(30) DEFAULT NULL,
  `nombre_usuario` varchar(40) DEFAULT NULL,
  `contrasenia` varchar(30) DEFAULT NULL,
  `estado_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `apenom`, `nombre_usuario`, `contrasenia`, `estado_id`) VALUES
(1, 'Joaquin Vesco Aparicio', 'admin', 'admin', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_get_categorias`
-- (See below for the actual view)
--
CREATE TABLE `v_get_categorias` (
`CategoriaId` int(11)
,`Categoria` varchar(50)
,`EstadoId` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_get_respuestas`
-- (See below for the actual view)
--
CREATE TABLE `v_get_respuestas` (
`RespuestaId` int(11)
,`Respuesta` longtext
,`MensajeRespondidoId` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_get_total_mensajes`
-- (See below for the actual view)
--
CREATE TABLE `v_get_total_mensajes` (
`Total` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_total_noticias`
-- (See below for the actual view)
--
CREATE TABLE `v_total_noticias` (
`Total` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `v_get_categorias`
--
DROP TABLE IF EXISTS `v_get_categorias`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_get_categorias`  AS SELECT `c`.`id` AS `CategoriaId`, `c`.`denominacion` AS `Categoria`, `c`.`estado_id` AS `EstadoId` FROM `categorias` AS `c` ;

-- --------------------------------------------------------

--
-- Structure for view `v_get_respuestas`
--
DROP TABLE IF EXISTS `v_get_respuestas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_get_respuestas`  AS SELECT `r`.`id` AS `RespuestaId`, `r`.`respuesta` AS `Respuesta`, `r`.`mensaje_respondido_id` AS `MensajeRespondidoId` FROM `respuestas` AS `r` ;

-- --------------------------------------------------------

--
-- Structure for view `v_get_total_mensajes`
--
DROP TABLE IF EXISTS `v_get_total_mensajes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_get_total_mensajes`  AS SELECT count(0) AS `Total` FROM `mensajes` WHERE `mensajes`.`estado_id` = 6 ;

-- --------------------------------------------------------

--
-- Structure for view `v_total_noticias`
--
DROP TABLE IF EXISTS `v_total_noticias`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_total_noticias`  AS SELECT count(0) AS `Total` FROM `noticias` WHERE `noticias`.`estado_id` = 1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_id` (`estado_id`);

--
-- Indexes for table `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `imagenes`
--
ALTER TABLE `imagenes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_id` (`estado_id`);

--
-- Indexes for table `noticias`
--
ALTER TABLE `noticias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_id` (`estado_id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indexes for table `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mensaje_respondido_id` (`mensaje_respondido_id`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_id` (`estado_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `estados`
--
ALTER TABLE `estados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `imagenes`
--
ALTER TABLE `imagenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `noticias`
--
ALTER TABLE `noticias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categorias`
--
ALTER TABLE `categorias`
  ADD CONSTRAINT `categorias_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`);

--
-- Constraints for table `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`);

--
-- Constraints for table `noticias`
--
ALTER TABLE `noticias`
  ADD CONSTRAINT `noticias_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`),
  ADD CONSTRAINT `noticias_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);

--
-- Constraints for table `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`mensaje_respondido_id`) REFERENCES `mensajes` (`id`);

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
