-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-11-2023 a las 13:05:55
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `newspaper`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_categorias` (IN `categoria_id` INT)   BEGIN
SELECT 
	c.id as CategoriaId,
    c.denominacion as Categoria,
    c.estado_id as EstadoId
FROM categorias c
WHERE (categoria_id = -1 OR c.id = categoria_id);
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

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `denominacion` varchar(50) DEFAULT NULL,
  `estado_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `denominacion`, `estado_id`) VALUES
(1, 'Educacion', 1),
(2, 'Economia', 1),
(3, 'Internacional', 1),
(4, 'Salud', 1),
(5, 'Politica', 1),
(6, 'Deporte', 1),
(7, 'Entretenimiento', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `id` int(11) NOT NULL,
  `denominacion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estados`
--

INSERT INTO `estados` (`id`, `denominacion`) VALUES
(1, 'Activo'),
(2, 'Inactivo'),
(3, 'Enviado'),
(4, 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes`
--

CREATE TABLE `imagenes` (
  `id` int(11) NOT NULL,
  `ruta` varchar(250) NOT NULL,
  `alt` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `imagenes`
--

INSERT INTO `imagenes` (`id`, `ruta`, `alt`) VALUES
(1, 'orm-php/public/images/destaque-economia.png', 'Imagen sobre economia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `email` varchar(250) NOT NULL,
  `mensaje` mediumtext NOT NULL,
  `estado_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensajes`
--

INSERT INTO `mensajes` (`id`, `nombre`, `email`, `mensaje`, `estado_id`) VALUES
(1, 'Juan Pérez', 'juan@example.com', 'Hola, me interesa su producto. ¿Podría proporcionarme más información?', 2),
(2, 'María Gómez', 'maria@example.com', 'Quisiera saber si tienen descuentos para compras al por mayor. Saludos.', 1),
(3, 'Pepe', 'joaquinvesapa@gmail.com', 'Hola mundo', 2),
(4, 'Ana Torres', 'ana@example.com', 'Felicidades por el nuevo producto. ¿Cuándo estará disponible en mi región?', 2),
(5, 'Luis García', 'luis@example.com', '¿Tienen alguna promoción especial para clientes frecuentes?', 1),
(6, 'juancito', 'juancito@gmail.com', 'Hola mundo jajajaj', 1),
(7, 'Paco', 'maria@gmail.com', 'JKJAKJAKA  mundo jajajaj', 1),
(8, 'Virginia', 'Virginia@gmail.com', 'jfidoajdfi', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noticias`
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

--
-- Volcado de datos para la tabla `noticias`
--

INSERT INTO `noticias` (`id`, `titulo`, `autor`, `ubicacion`, `categoria_id`, `imagen_url`, `fecha_hora`, `cuerpo`, `estado_id`) VALUES
(1, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>El tenista contó que en la previa al Mundial de Rusia 2018 coincidió en Barcelona con el futbolista de la Selección y mantuvo un breve diálogo que guardó en su memoria.</p><p>&nbsp;</p><p><a href=\"https://www.infobae.com/deportes/tenis/2023/03/12/la-terminante-decision-que-tomo-diego-schwartzman-para-poner-fin-a-la-crisis-de-confianza-por-la-que-atraviesa/\"><i><strong>Diego Schwartzman</strong></i></a> tuvo el privilegio de conocer a <a href=\"https://www.infobae.com/deportes/2023/10/26/lionel-messi-es-candidato-a-quedarse-con-otro-premio-en-la-mls-los-dos-argentinos-que-compiten-por-convertirse-en-el-mvp/\"><i><strong>Lionel Messi</strong></i></a><strong> </strong>y charlar con el futbolista campeón del mundo en más de una oportunidad. El tenista, que actualmente ocupa el puesto 104 en el ranking ATP, compartió cómo fue su <strong>primera experiencia</strong> con el rosarino, con quien se encontró en la ciudad de Barcelona y mantuvo un breve diálogo con <i>La Pulga</i>.</p><p>&nbsp;</p><p>En una charla informal con otros tenistas que publicó la cuenta de <strong>UTS Tour</strong> (Ultimate Tennis Showdown) en su perfil de <i>Instagram</i>, el <i>Peque </i>contó su anécdota con el goleador histórico de la selección argentina, a quien vio por última vez hace unas 13 semanas en un partido de<strong> Inter Miami </strong>en el <i>DRV PNK Stadium</i> de Fort Lauderdale.</p><p>“Ya lo había conocido algunos años atrás, pero incluso cuando lo conoces y lo ves personalmente<strong> no quieres decirle nada</strong> porque hay demasiado respeto. Es decirle solamente: ‘Hola, Leo’”, comenzó <strong>Schwartzman </strong>antes de relatar su primer encuentro con el astro del fútbol.</p><p>El tenista porteño continuó con la historia: “La primera vez que lo conocí a Messi fue antes de la Copa del Mundo de Rusia en 2018. Había perdido con Rafa (Nadal) en los cuartos de final de Roland Garros y había estado un set arriba con un quiebre a favor. Después de ese partido tenía mi vuelo desde Barcelona y él se estaba preparando para el Mundial allí con la selección argentina. <strong>Así que fui allá con algunos jugadores y hablé con él”</strong>.</p>', 1),
(2, 'Una leyenda del fútbol inglés aseguró que Messi debe ganar el Balón de Oro: “Se lo merece por el Mundial”', 'Paco', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing (1).png', '2023-10-26 00:00:00', '<p>Michael Owen explicó que a Erling Haaland no le alcanzará con haber marcado más de 50 goles ni haber obtenido el triplete con Manchester City</p><p>&nbsp;</p><p>Este lunes se entregará el<strong> Balón de Oro</strong> en <strong>París </strong>y todo parece indicar que el que subirá al escenario será, nuevamente, <strong>Lionel Messi</strong>. El argentino, que compite con otros 29 futbolistas entre los que destacan <strong>Kylian Mbappé </strong>y <strong>Erling Haaland</strong>, podría recibir su octavo galardón, más que cualquier otro jugador en la historia. En este contexto, en medio del debate sobre si es meritorio semejante reconocimiento, el inglés <strong>Michael Owen </strong>opinó al respecto.</p><p>&nbsp;</p><p>El ex delantero que brilló en <strong>Liverpool </strong>y <strong>Real Madrid</strong>, entre otros equipos, aseguró en diálogo con el portal español Marca que no hay dudas de que <i>La Pulga</i> debe ser ele elegido: “El nivel que ha alcanzado Leo durante tantos años seguidos es increíble. Lo de los ocho Balones de Oro lo explica todo. No hace falta decir nada más. Y lo respeto más por cómo, a sus 35 años, ha conseguido llegar a lo máximo, que es ganar el Mundial estando a un gran nive<strong>l. Es increíble que Haaland, que marcó más de 50 goles, hizo el triplete... no se lo vaya a llevar, pero será porque está Messi, que lo merece por ganar el Mundial.</strong> Es una carrera increíble. Felicidades a Leo”.</p><p>&nbsp;</p><p>Owen es palabra autorizada para hablar de este premio, ya que él lo ganó en 2001, cuando se impuso en la votación final al español <strong>Raúl</strong>, el alemán <strong>Oliver Kahn </strong>y a <strong>David Beckham</strong>. Justamente, con respecto al actual presidente del <strong>Inter Miami</strong>, comentó: “Era un jugador único, un personaje muy particular. Su vida es muy diferente a la nuestra. Es una <i>celebrity</i>. Por eso, mi relación con él respeto a mi relación con otros compañeros era diferente. Ahora no trabaja en la TV, no entrena, tiene un equipo... No lo veo tanto como a otros, pero somos amigos”.</p><p>&nbsp;</p><p>Además, en relación a los jóvenes talentos no dudó en destacar a Jude Bellingham, uno de los mejores futbolistas del Real Madrid en esta temporada: “Tiene opciones (de ganar un Balón de Oro), sin duda. Es un jugador especial. Para ganarlo, debes ser el mejor de un gran equipo. Y si el Madrid gana la Liga o la Champions, puede alcanzarlo”.</p>', 1),
(3, 'Título de la noticia 3', 'Autor 3', 'Rosario, Santa Fe', 3, '../Fotos/economia-min-e1518715223904.png', '2023-10-14 15:45:00', 'Contenido de la noticia 3', 2),
(4, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(5, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(6, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(7, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(8, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(9, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(10, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(11, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(12, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(13, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(14, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(15, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(16, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(17, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1),
(18, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>Dongui</p>', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `apenom` varchar(30) DEFAULT NULL,
  `nombre_usuario` varchar(40) DEFAULT NULL,
  `contrasenia` varchar(30) DEFAULT NULL,
  `estado_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `apenom`, `nombre_usuario`, `contrasenia`, `estado_id`) VALUES
(1, 'Joaquin Vesco Aparicio', 'admin', 'admin', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_get_categorias`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_get_categorias` (
`CategoriaId` int(11)
,`Categoria` varchar(50)
,`EstadoId` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_total_noticias`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_total_noticias` (
`Total` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `v_get_categorias`
--
DROP TABLE IF EXISTS `v_get_categorias`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_get_categorias`  AS SELECT `c`.`id` AS `CategoriaId`, `c`.`denominacion` AS `Categoria`, `c`.`estado_id` AS `EstadoId` FROM `categorias` AS `c` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_total_noticias`
--
DROP TABLE IF EXISTS `v_total_noticias`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_total_noticias`  AS SELECT count(0) AS `Total` FROM `noticias` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_id` (`estado_id`);

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `imagenes`
--
ALTER TABLE `imagenes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_id` (`estado_id`);

--
-- Indices de la tabla `noticias`
--
ALTER TABLE `noticias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_id` (`estado_id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_id` (`estado_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `imagenes`
--
ALTER TABLE `imagenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `noticias`
--
ALTER TABLE `noticias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD CONSTRAINT `categorias_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`);

--
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`);

--
-- Filtros para la tabla `noticias`
--
ALTER TABLE `noticias`
  ADD CONSTRAINT `noticias_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`),
  ADD CONSTRAINT `noticias_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
