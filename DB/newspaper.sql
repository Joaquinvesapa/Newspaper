-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 27, 2023 at 04:45 AM
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
-- Database: `mvc_example`
--
CREATE DATABASE IF NOT EXISTS `mvc_example` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `mvc_example`;

-- --------------------------------------------------------

--
-- Table structure for table `note`
--

CREATE TABLE `note` (
  `id` int(11) NOT NULL,
  `title` varchar(75) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `note`
--

INSERT INTO `note` (`id`, `title`, `content`) VALUES
(1, 'Nota Número 1', 'no sé qué puede tener.'),
(2, 'Nota Número 2', 'Segunda nota xx');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `usu_id` int(11) NOT NULL,
  `usu_nombre` varchar(30) NOT NULL,
  `usu_clave` varchar(40) NOT NULL,
  `usu_nivel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`usu_id`, `usu_nombre`, `usu_clave`, `usu_nivel`) VALUES
(1, 'dante', '5f4dcc3b5aa765d61d8327deb882cf99', 1),
(11, 'droselli719', '676f1a060deceaf096c52c550c205338', 2),
(16, 'martin', 'c20ad4d76fe97759aa27a0c99bff6710', 3),
(17, 'admin', 'admin', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `note`
--
ALTER TABLE `note`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usu_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `note`
--
ALTER TABLE `note`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- Database: `newspaper`
--
CREATE DATABASE IF NOT EXISTS `newspaper` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `newspaper`;

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
(1, 'Educacion', 1),
(2, 'Economia', 1),
(3, 'Internacional', 1),
(4, 'Salud', 1),
(5, 'Politica', 1),
(6, 'Deporte', 1),
(7, 'Entretenimiento', 1);

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
(4, 'Pendiente');

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
  `email` varchar(250) NOT NULL,
  `mensaje` mediumtext NOT NULL,
  `estado_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mensajes`
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

--
-- Dumping data for table `noticias`
--

INSERT INTO `noticias` (`id`, `titulo`, `autor`, `ubicacion`, `categoria_id`, `imagen_url`, `fecha_hora`, `cuerpo`, `estado_id`) VALUES
(1, '“Sabe quién soy”: la sorpresa que se llevó el Peque Schwartzman el día que conoció a Lionel Messi', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing.png', '2023-10-14 00:00:00', '<p>El tenista contó que en la previa al Mundial de Rusia 2018 coincidió en Barcelona con el futbolista de la Selección y mantuvo un breve diálogo que guardó en su memoria.</p><p>&nbsp;</p><p><a href=\"https://www.infobae.com/deportes/tenis/2023/03/12/la-terminante-decision-que-tomo-diego-schwartzman-para-poner-fin-a-la-crisis-de-confianza-por-la-que-atraviesa/\"><i><strong>Diego Schwartzman</strong></i></a> tuvo el privilegio de conocer a <a href=\"https://www.infobae.com/deportes/2023/10/26/lionel-messi-es-candidato-a-quedarse-con-otro-premio-en-la-mls-los-dos-argentinos-que-compiten-por-convertirse-en-el-mvp/\"><i><strong>Lionel Messi</strong></i></a><strong> </strong>y charlar con el futbolista campeón del mundo en más de una oportunidad. El tenista, que actualmente ocupa el puesto 104 en el ranking ATP, compartió cómo fue su <strong>primera experiencia</strong> con el rosarino, con quien se encontró en la ciudad de Barcelona y mantuvo un breve diálogo con <i>La Pulga</i>.</p><p>&nbsp;</p><p>En una charla informal con otros tenistas que publicó la cuenta de <strong>UTS Tour</strong> (Ultimate Tennis Showdown) en su perfil de <i>Instagram</i>, el <i>Peque </i>contó su anécdota con el goleador histórico de la selección argentina, a quien vio por última vez hace unas 13 semanas en un partido de<strong> Inter Miami </strong>en el <i>DRV PNK Stadium</i> de Fort Lauderdale.</p><p>“Ya lo había conocido algunos años atrás, pero incluso cuando lo conoces y lo ves personalmente<strong> no quieres decirle nada</strong> porque hay demasiado respeto. Es decirle solamente: ‘Hola, Leo’”, comenzó <strong>Schwartzman </strong>antes de relatar su primer encuentro con el astro del fútbol.</p><p>El tenista porteño continuó con la historia: “La primera vez que lo conocí a Messi fue antes de la Copa del Mundo de Rusia en 2018. Había perdido con Rafa (Nadal) en los cuartos de final de Roland Garros y había estado un set arriba con un quiebre a favor. Después de ese partido tenía mi vuelo desde Barcelona y él se estaba preparando para el Mundial allí con la selección argentina. <strong>Así que fui allá con algunos jugadores y hablé con él”</strong>.</p>', 1),
(2, 'Una leyenda del fútbol inglés aseguró que Messi debe ganar el Balón de Oro: “Se lo merece por el Mundial”', 'Joaquin Vesco Aparicio', 'Rosario, Santa Fe', 6, 'Fotos/cloudfront-us-east-1.images.arcpublishing (1).png', '2023-10-26 00:00:00', '<p>Michael Owen explicó que a Erling Haaland no le alcanzará con haber marcado más de 50 goles ni haber obtenido el triplete con Manchester City</p><p>&nbsp;</p><p>Este lunes se entregará el<strong> Balón de Oro</strong> en <strong>París </strong>y todo parece indicar que el que subirá al escenario será, nuevamente, <strong>Lionel Messi</strong>. El argentino, que compite con otros 29 futbolistas entre los que destacan <strong>Kylian Mbappé </strong>y <strong>Erling Haaland</strong>, podría recibir su octavo galardón, más que cualquier otro jugador en la historia. En este contexto, en medio del debate sobre si es meritorio semejante reconocimiento, el inglés <strong>Michael Owen </strong>opinó al respecto.</p><p>&nbsp;</p><p>El ex delantero que brilló en <strong>Liverpool </strong>y <strong>Real Madrid</strong>, entre otros equipos, aseguró en diálogo con el portal español Marca que no hay dudas de que <i>La Pulga</i> debe ser ele elegido: “El nivel que ha alcanzado Leo durante tantos años seguidos es increíble. Lo de los ocho Balones de Oro lo explica todo. No hace falta decir nada más. Y lo respeto más por cómo, a sus 35 años, ha conseguido llegar a lo máximo, que es ganar el Mundial estando a un gran nive<strong>l. Es increíble que Haaland, que marcó más de 50 goles, hizo el triplete... no se lo vaya a llevar, pero será porque está Messi, que lo merece por ganar el Mundial.</strong> Es una carrera increíble. Felicidades a Leo”.</p><p>&nbsp;</p><p>Owen es palabra autorizada para hablar de este premio, ya que él lo ganó en 2001, cuando se impuso en la votación final al español <strong>Raúl</strong>, el alemán <strong>Oliver Kahn </strong>y a <strong>David Beckham</strong>. Justamente, con respecto al actual presidente del <strong>Inter Miami</strong>, comentó: “Era un jugador único, un personaje muy particular. Su vida es muy diferente a la nuestra. Es una <i>celebrity</i>. Por eso, mi relación con él respeto a mi relación con otros compañeros era diferente. Ahora no trabaja en la TV, no entrena, tiene un equipo... No lo veo tanto como a otros, pero somos amigos”.</p><p>&nbsp;</p><p>Además, en relación a los jóvenes talentos no dudó en destacar a Jude Bellingham, uno de los mejores futbolistas del Real Madrid en esta temporada: “Tiene opciones (de ganar un Balón de Oro), sin duda. Es un jugador especial. Para ganarlo, debes ser el mejor de un gran equipo. Y si el Madrid gana la Liga o la Champions, puede alcanzarlo”.</p>', 1),
(3, 'Título de la noticia 3', 'Autor 3', 'Rosario, Santa Fe', 3, '../Fotos/economia-min-e1518715223904.png', '2023-10-14 15:45:00', 'Contenido de la noticia 3', 2);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `estados`
--
ALTER TABLE `estados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `imagenes`
--
ALTER TABLE `imagenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `noticias`
--
ALTER TABLE `noticias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`);
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"newspaper\",\"table\":\"noticias\"},{\"db\":\"mvc_example\",\"table\":\"usuario\"},{\"db\":\"mvc_example\",\"table\":\"note\"},{\"db\":\"newspapr\",\"table\":\"usuarios\"},{\"db\":\"newspapr\",\"table\":\"noticias\"},{\"db\":\"newspapr\",\"table\":\"mensajes\"},{\"db\":\"newspapr\",\"table\":\"estados\"},{\"db\":\"newspapr\",\"table\":\"categorias\"},{\"db\":\"newspapr\",\"table\":\"imagenes\"},{\"db\":\"practicaphp\",\"table\":\"trabajos\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'mvc_example', 'usuario', '{\"sorted_col\":\"`usuario`.`usu_id` ASC\"}', '2023-10-24 02:39:08'),
('root', 'practicaphp', 'trabajos', '{\"CREATE_TIME\":\"2023-10-03 01:26:09\",\"col_order\":[0,1,2,3],\"col_visib\":[1,1,1,1]}', '2023-10-03 05:18:56');

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2023-10-27 02:45:01', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"en_GB\",\"Console\\/Height\":-38.01360000000001}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `practicaphp`
--
CREATE DATABASE IF NOT EXISTS `practicaphp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `practicaphp`;

-- --------------------------------------------------------

--
-- Table structure for table `alumnos`
--

CREATE TABLE `alumnos` (
  `AluNombre` varchar(30) DEFAULT NULL,
  `AluLegajo` int(11) DEFAULT NULL,
  `AluOtrosDatos` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `alumnos`
--

INSERT INTO `alumnos` (`AluNombre`, `AluLegajo`, `AluOtrosDatos`) VALUES
('Juan Pérez', 1001, 'Fecha de nacimiento: 15/05/2000'),
('María Rodríguez', 1002, 'Fecha de nacimiento: 20/08/2001'),
('Carlos Gómez', 1003, 'Fecha de nacimiento: 10/02/1999'),
('Laura Martínez', 1004, 'Fecha de nacimiento: 05/11/2002'),
('Alejandro López', 1005, 'Fecha de nacimiento: 25/07/2000');

-- --------------------------------------------------------

--
-- Table structure for table `asignaturas`
--

CREATE TABLE `asignaturas` (
  `AsiAsignatura` int(11) DEFAULT NULL,
  `AsiNombre` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `asignaturas`
--

INSERT INTO `asignaturas` (`AsiAsignatura`, `AsiNombre`) VALUES
(101, 'Matemáticas'),
(102, 'Historia'),
(103, 'Programación'),
(104, 'Literatura'),
(105, 'Biología');

-- --------------------------------------------------------

--
-- Table structure for table `autos`
--

CREATE TABLE `autos` (
  `Marca` varchar(30) DEFAULT NULL,
  `Modelo` varchar(30) DEFAULT NULL,
  `Anio` int(11) DEFAULT NULL,
  `Color` varchar(30) DEFAULT NULL,
  `PrecioVenta` decimal(7,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `autos`
--

INSERT INTO `autos` (`Marca`, `Modelo`, `Anio`, `Color`, `PrecioVenta`) VALUES
('Toyota', 'Camry', 2020, 'Azul', 9895.90),
('Honda', 'Civic', 2019, 'Rojo', 5996.12),
('Ford', 'Focus', 2018, 'Negro', 292.88),
('Chevrolet', 'Malibu', 2021, 'Blanco', 3476.03),
('Nissan', 'Altima', 2017, 'Gris', 6501.51),
('Toyota', 'Rav4', 2022, 'Plateado', 2079.49),
('Honda', 'Accord', 2016, 'Verde', 892.90),
('Ford', 'Fusion', 2020, 'Azul Oscuro', 8226.02),
('Chevrolet', 'Cruze', 2019, 'Negro Mate', 8451.40),
('Nissan', 'Maxima', 2018, 'Rojo Intenso', 7578.94),
('Toyota', 'Corolla', 2017, 'Blanco Perla', 2540.51),
('Honda', 'Fit', 2021, 'Gris Plomo', 9965.73),
('Ford', 'Escape', 2016, 'Dorado', 2207.10),
('Chevrolet', 'Impala', 2022, 'Negro Brillante', 1138.32),
('Nissan', 'Sentra', 2017, 'Plateado Metálico', 9070.32),
('Toyota', 'Highlander', 2018, 'Azul Eléctrico', 1936.64),
('Honda', 'Pilot', 2019, 'Verde Militar', 2472.24),
('Ford', 'Mustang', 2020, 'Amarillo', 6551.29),
('Chevrolet', 'Equinox', 2016, 'Gris Oscuro', 5339.71),
('Nissan', 'Rogue', 2021, 'Rojo Carmesí', 7044.68);

-- --------------------------------------------------------

--
-- Table structure for table `ciudades`
--

CREATE TABLE `ciudades` (
  `CodLoc` int(11) NOT NULL,
  `NomLoc` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ciudades`
--

INSERT INTO `ciudades` (`CodLoc`, `NomLoc`) VALUES
(1, 'Buenos Aires'),
(2, 'Cordoba'),
(3, 'Rosario'),
(4, 'Mendoza'),
(5, 'Tucuman'),
(6, 'La Plata'),
(7, 'Mar del Plata'),
(8, 'Salta'),
(9, 'Santa Fe'),
(10, 'San Juan');

-- --------------------------------------------------------

--
-- Table structure for table `docentes`
--

CREATE TABLE `docentes` (
  `DocDocente` varchar(8) DEFAULT NULL,
  `DocNombre` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `docentes`
--

INSERT INTO `docentes` (`DocDocente`, `DocNombre`) VALUES
('D001', 'Profesor Smith'),
('D002', 'Profesora Johnson'),
('D003', 'Profesor García'),
('D004', 'Profesora Davis'),
('D005', 'Profesor Rodríguez');

-- --------------------------------------------------------

--
-- Table structure for table `ejercicios`
--

CREATE TABLE `ejercicios` (
  `id` int(11) NOT NULL,
  `denominacion` varchar(50) DEFAULT NULL,
  `ruta` varchar(50) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  `desc_redu` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ejercicios`
--

INSERT INTO `ejercicios` (`id`, `denominacion`, `ruta`, `menu_id`, `desc_redu`) VALUES
(1, 'Ejercicio 1', './Practica - 1/Ejercicio - 1.php', 1, 'Ingresar por medio de un programa HTML un valor entero N. Luego llamar por el método POST a un programa PHP, que genere un vector $vec de N elementos, el cual contenga los primeros N números naturales primos.'),
(2, 'Ejercicio 2', './Practica - 1/Ejercicio - 2.php', 1, 'En este ejercicio se deben contabilizar la cantidad de particulas totales e indivicuales por los planetas: Mercurio, Venus, Tierra, Marte, Júpiter, Saturno, Urano, Neptuno y Plutón. '),
(3, 'Ejercicio 3', './Practica - 2/Ejercicio - 3.php', 2, 'Cargar dos vectores con números al azar de 6 elementos cada uno. El primer\r\nvector se llama $origen y el segundo $destino. Debe realizar una función que\r\ninforme la cantidad de elementos repetidos que hay en cada vector, y además\r\nla posición que ocupa en ambos vectores.'),
(4, 'Ejercicio 4', './Practica - 2/Ejercicio - 4.php', 2, 'Escribir un programa en PHP que cargue en un array las notas de 30 alumnos\r\nde un curso (hacerlo con números al azar entre 0 y 10). Luego deberá armar\r\nuna función llamada Abanderado que devolverá la nota de los 3 mejores\r\nalumnos. Fuera de la función, deberá imprimir las 3 notas y la ubicación de\r\ncada una dentro del array.'),
(5, 'Practica 3', './Practica - 3/Practica - 3.php', 3, 'Crearemos una tabla de valores de seno y coseno de 0 a 2 en incrementos de 0.01. Los valores negativos que resulten los queremos mostrar en rojo, y los valores positivos en azul. Un color diferente cada fila que se imprima.'),
(6, 'Practica 4', './Practica - 4/Practica - 4.php', 4, 'Escribir un programa en HTML que pida dos números. El primero será un número entero que indica el número en base 10 (decimal) que vamos a querer convertir. El segundo número será la base (validar que sea entero de 1 a 9) a la que queremos convertir el primer número ingresado. Luego llamar a un programa php con el método POST, que convierta el número en base 10, a la base que indica el segundo número. Hacerlo por medio de una función, y en el script principal que muestre: \r\nXXX en base 10 = YYY en base NN (donde XXX es el número que se quiere convertir, YYY es el número calculado en la función, y NN es la base que ingresó el usuario a la que se quería convertir). '),
(12, 'Ejercicio PHP-2022-001', './Practica - 5/Ejercicio PHP-2022-001.php', 11, 'Realizar una aplicación que solicite una localidad, un mes y un año y liste todos los viajes que tuvieron como origen o destino esa localidad, acumulando la cantidad de kilos transportados, en el mes y año ingresados cuando la localidad sea destino y descuente los kilos cuando la localidad es origen. '),
(13, 'Ejercicio PHP-2022-002', './practica - 6/Ejercicio PHP-2022-002.php', 12, 'Desarrollar un sitio en PHP donde muestre el capital acumulado por la concesionaria por cada marca de auto. '),
(14, 'Ejercicio PHP-2022-003', './Practica - 7/Ejercicio PHP-2022-003.php', 13, 'Realizar una página web, en HTML, con un solo botón que diga procesar. Al hacer click sobre el mismo deberá llamar a una página PHP que dispare el programa para generar un informe de alumnos, con la cantidad de veces que rindió, la cantidad de veces que aprobó y su promedio.'),
(15, 'Ejercicio PHP-2022-004', './Practica - 8/Ejercicio PHP-2022-004.php', 14, 'Ingresando por teclado un número de empleado, muestre el nombre del mismo junto a la cantidad total de horas trabajadas y el importe neto cobrado por el total de horas trabajadas. Luego de mostrado el dato se debe actualizar el archivo para que en el campo “actualizado” diga “SI”. Si en el campo “actualizado”, antes de hacer el proceso, dice “SI” no se debe hacer nada.');

-- --------------------------------------------------------

--
-- Table structure for table `empleados`
--

CREATE TABLE `empleados` (
  `NumeroEmpleado` int(11) NOT NULL,
  `Nombre` varchar(30) DEFAULT NULL,
  `Documento` varchar(8) DEFAULT NULL,
  `EstadoCivil` varchar(15) DEFAULT NULL,
  `CantidadHijos` int(11) DEFAULT NULL,
  `ValorHora` decimal(5,2) DEFAULT NULL,
  `Actualizado` varchar(2) DEFAULT 'NO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `empleados`
--

INSERT INTO `empleados` (`NumeroEmpleado`, `Nombre`, `Documento`, `EstadoCivil`, `CantidadHijos`, `ValorHora`, `Actualizado`) VALUES
(1, 'Juan Perez', '12345678', 'Soltero', 0, 15.50, 'NO'),
(2, 'Maria Rodriguez', '98765432', 'Casado', 2, 18.75, 'NO'),
(3, 'Carlos Gomez', '34567890', 'Soltero', 1, 20.00, 'NO'),
(4, 'Ana Martinez', '56789012', 'Divorciado', 3, 22.50, 'NO'),
(5, 'Pedro Sanchez', '87654321', 'Casado', 2, 19.25, 'NO'),
(6, 'Laura Fernandez', '43210987', 'Soltero', 0, 17.75, 'NO'),
(7, 'Jorge Ramirez', '65432109', 'Divorciado', 1, 21.00, 'NO'),
(8, 'Silvia Herrera', '89012345', 'Casado', 2, 23.50, 'NO'),
(9, 'Luis Torres', '21098765', 'Soltero', 0, 16.80, 'NO'),
(10, 'Carmen Castro', '54321098', 'Casado', 1, 24.00, 'NO'),
(11, 'Miguel Diaz', '10987654', 'Divorciado', 2, 19.75, 'NO'),
(12, 'Elena Navarro', '87654321', 'Soltero', 0, 18.20, 'NO'),
(13, 'Raul Nuñez', '23456789', 'Casado', 3, 25.00, 'NO'),
(14, 'Martha Jimenez', '56789012', 'Divorciado', 2, 20.50, 'NO'),
(15, 'Carlos Vargas', '89012345', 'Soltero', 0, 17.00, 'NO'),
(16, 'Sofia Romero', '12345678', 'Casado', 1, 26.00, 'NO'),
(17, 'Daniel Ortega', '34567890', 'Divorciado', 2, 21.80, 'NO'),
(18, 'Victoria Sanchez', '98765432', 'Soltero', 0, 19.50, 'NO'),
(19, 'Gabriel Lopez', '43210987', 'Casado', 1, 27.50, 'NO'),
(20, 'Valeria Torres', '65432109', 'Divorciado', 2, 22.30, 'NO');

-- --------------------------------------------------------

--
-- Table structure for table `examenes`
--

CREATE TABLE `examenes` (
  `ExaFecha` datetime DEFAULT NULL,
  `AluLegajo` int(11) DEFAULT NULL,
  `DocDocente` varchar(8) DEFAULT NULL,
  `ExaNota` decimal(4,2) DEFAULT NULL,
  `AsiAsignatura` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `examenes`
--

INSERT INTO `examenes` (`ExaFecha`, `AluLegajo`, `DocDocente`, `ExaNota`, `AsiAsignatura`) VALUES
('2023-01-15 10:00:00', 1001, 'D001', 8.50, 101),
('2023-02-20 14:30:00', 1002, 'D002', 7.20, 102),
('2023-03-10 09:45:00', 1003, 'D003', 9.00, 103),
('2023-04-05 11:15:00', 1004, 'D004', 6.80, 104),
('2023-05-25 13:00:00', 1005, 'D005', 8.90, 105),
('2023-01-15 10:00:00', 1001, 'D001', 8.50, 101),
('2023-01-15 10:00:00', 1001, 'D001', 6.50, 101),
('2023-01-15 10:00:00', 1001, 'D001', 7.50, 101),
('2023-01-15 10:00:00', 1001, 'D001', 8.50, 101),
('2023-02-20 14:30:00', 1002, 'D002', 7.20, 102),
('2023-02-20 14:30:00', 1002, 'D002', 2.20, 102),
('2023-02-20 14:30:00', 1002, 'D002', 7.20, 102),
('2023-02-20 14:30:00', 1002, 'D002', 5.20, 102),
('2023-03-10 09:45:00', 1003, 'D003', 9.00, 103),
('2023-03-10 09:45:00', 1003, 'D003', 9.00, 103),
('2023-03-10 09:45:00', 1003, 'D003', 10.00, 103),
('2023-04-05 11:15:00', 1004, 'D004', 6.80, 104),
('2023-04-05 11:15:00', 1004, 'D004', 6.80, 104),
('2023-04-05 11:15:00', 1004, 'D004', 6.80, 104),
('2023-05-25 13:00:00', 1005, 'D005', 8.90, 105),
('2023-05-25 13:00:00', 1005, 'D005', 5.90, 105),
('2023-05-25 13:00:00', 1005, 'D005', 8.90, 105),
('2023-05-25 13:00:00', 1005, 'D005', 7.90, 105),
('2023-05-25 13:00:00', 1005, 'D005', 10.00, 105),
('2023-05-25 13:00:00', 1005, 'D005', 5.90, 105);

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(11) NOT NULL,
  `denominacion` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `denominacion`) VALUES
(1, 'Practica 1'),
(2, 'Practica 2'),
(3, 'Practica 3'),
(4, 'Practica 4'),
(11, 'Practica 5'),
(12, 'Practica 6'),
(13, 'Practica 7'),
(14, 'Practica 8');

-- --------------------------------------------------------

--
-- Table structure for table `trabajos`
--

CREATE TABLE `trabajos` (
  `id` int(11) NOT NULL,
  `NumeroEmpleado` int(11) DEFAULT NULL,
  `FechaDeTrabajo` datetime DEFAULT NULL,
  `CantidadHorasTrabajadas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trabajos`
--

INSERT INTO `trabajos` (`id`, `NumeroEmpleado`, `FechaDeTrabajo`, `CantidadHorasTrabajadas`) VALUES
(1, 1, '2022-11-22 01:35:06', 2),
(2, 1, '2023-03-01 01:35:06', 2),
(3, 1, '2023-03-01 01:35:06', 2),
(4, 1, '2023-04-15 01:35:06', 5),
(5, 1, '2023-09-26 01:35:06', 5),
(6, 2, '2022-11-13 01:35:06', 1),
(7, 2, '2023-03-07 01:35:06', 1),
(8, 2, '2023-03-08 01:35:06', 7),
(9, 2, '2023-03-11 01:35:06', 3),
(10, 2, '2023-09-19 01:35:06', 3),
(11, 3, '2022-10-05 01:35:06', 5),
(12, 3, '2022-12-09 01:35:06', 5),
(13, 3, '2023-01-25 01:35:06', 2),
(14, 3, '2023-02-27 01:35:06', 2),
(15, 3, '2023-08-26 01:35:06', 7),
(16, 4, '2022-11-27 01:35:06', 6),
(17, 4, '2023-01-29 01:35:06', 2),
(18, 4, '2023-03-13 01:35:06', 1),
(19, 4, '2023-03-15 01:35:06', 2),
(20, 4, '2023-09-09 01:35:06', 2),
(21, 5, '2022-11-20 01:35:06', 6),
(22, 5, '2023-02-12 01:35:06', 6),
(23, 5, '2023-02-25 01:35:06', 5),
(24, 5, '2023-04-10 01:35:06', 4),
(25, 5, '2023-09-05 01:35:06', 2),
(26, 6, '2022-12-13 01:35:06', 6),
(27, 6, '2023-01-08 01:35:06', 6),
(28, 6, '2023-01-09 01:35:06', 7),
(29, 6, '2023-05-01 01:35:06', 1),
(30, 6, '2023-08-19 01:35:06', 5),
(31, 7, '2022-11-15 01:35:06', 2),
(32, 7, '2022-12-03 01:35:06', 1),
(33, 7, '2022-12-25 01:35:06', 1),
(34, 7, '2023-01-09 01:35:06', 7),
(35, 7, '2023-02-08 01:35:06', 8),
(36, 8, '2022-10-20 01:35:06', 7),
(37, 8, '2023-02-07 01:35:06', 8),
(38, 8, '2023-06-27 01:35:06', 7),
(39, 8, '2023-07-02 01:35:06', 7),
(40, 8, '2023-08-05 01:35:06', 4),
(41, 9, '2022-10-18 01:35:06', 2),
(42, 9, '2023-01-25 01:35:06', 2),
(43, 9, '2023-03-09 01:35:06', 3),
(44, 9, '2023-03-09 01:35:06', 1),
(45, 9, '2023-07-02 01:35:06', 7),
(46, 10, '2022-11-18 01:35:06', 3),
(47, 10, '2023-01-21 01:35:06', 7),
(48, 10, '2023-07-17 01:35:06', 6),
(49, 10, '2023-08-16 01:35:06', 1),
(50, 10, '2023-09-27 01:35:06', 5),
(51, 11, '2023-01-25 01:35:06', 6),
(52, 11, '2023-03-24 01:35:06', 4),
(53, 11, '2023-05-28 01:35:06', 6),
(54, 11, '2023-07-14 01:35:06', 2),
(55, 11, '2023-09-27 01:35:06', 6),
(56, 12, '2022-11-06 01:35:06', 3),
(57, 12, '2022-11-15 01:35:06', 8),
(58, 12, '2023-01-23 01:35:06', 4),
(59, 12, '2023-08-12 01:35:06', 1),
(60, 12, '2023-10-02 01:35:06', 2),
(61, 13, '2022-10-11 01:35:06', 8),
(62, 13, '2022-12-14 01:35:06', 7),
(63, 13, '2023-01-01 01:35:06', 8),
(64, 13, '2023-04-22 01:35:06', 5),
(65, 13, '2023-06-18 01:35:06', 6),
(66, 14, '2023-02-26 01:35:06', 5),
(67, 14, '2023-06-14 01:35:06', 8),
(68, 14, '2023-07-24 01:35:06', 2),
(69, 14, '2023-09-15 01:35:06', 5),
(70, 14, '2023-09-18 01:35:06', 2),
(71, 15, '2022-10-11 01:35:06', 1),
(72, 15, '2023-01-17 01:35:06', 8),
(73, 15, '2023-01-22 01:35:06', 5),
(74, 15, '2023-03-03 01:35:06', 3),
(75, 15, '2023-05-31 01:35:06', 5),
(76, 16, '2022-10-08 01:35:06', 3),
(77, 16, '2023-01-19 01:35:06', 5),
(78, 16, '2023-01-30 01:35:06', 2),
(79, 16, '2023-03-27 01:35:06', 1),
(80, 16, '2023-05-01 01:35:06', 4),
(81, 17, '2023-02-11 01:35:06', 3),
(82, 17, '2023-02-26 01:35:06', 2),
(83, 17, '2023-03-19 01:35:06', 6),
(84, 17, '2023-05-07 01:35:06', 3),
(85, 17, '2023-06-03 01:35:06', 8),
(86, 18, '2022-12-18 01:35:06', 2),
(87, 18, '2023-01-04 01:35:06', 1),
(88, 18, '2023-04-23 01:35:06', 4),
(89, 18, '2023-05-19 01:35:06', 8),
(90, 18, '2023-08-10 01:35:06', 2),
(91, 19, '2022-10-18 01:35:06', 7),
(92, 19, '2022-11-04 01:35:06', 3),
(93, 19, '2023-01-09 01:35:06', 7),
(94, 19, '2023-01-30 01:35:06', 1),
(95, 19, '2023-09-20 01:35:06', 1),
(96, 20, '2022-12-23 01:35:06', 8),
(97, 20, '2023-03-17 01:35:06', 8),
(98, 20, '2023-07-05 01:35:06', 3),
(99, 20, '2023-07-07 01:35:06', 3),
(100, 20, '2023-07-13 01:35:06', 8);

-- --------------------------------------------------------

--
-- Table structure for table `viajes`
--

CREATE TABLE `viajes` (
  `LocOrigen` int(11) DEFAULT NULL,
  `LocDestino` int(11) DEFAULT NULL,
  `Cantkg` decimal(6,2) DEFAULT NULL,
  `FecViaje` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `viajes`
--

INSERT INTO `viajes` (`LocOrigen`, `LocDestino`, `Cantkg`, `FecViaje`) VALUES
(9, 10, 6282.82, '2023-10-01'),
(10, 9, 2475.33, '2023-10-02'),
(9, 10, 9999.99, '2023-10-03'),
(10, 9, 214.93, '2023-10-04'),
(9, 10, 490.08, '2023-10-05'),
(4, 9, 1805.63, '2023-10-06'),
(6, 9, 7557.90, '2023-10-07'),
(8, 9, 9999.99, '2023-10-08'),
(2, 9, 9999.99, '2023-10-09'),
(1, 9, 9999.99, '2023-10-10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ciudades`
--
ALTER TABLE `ciudades`
  ADD PRIMARY KEY (`CodLoc`);

--
-- Indexes for table `ejercicios`
--
ALTER TABLE `ejercicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_id` (`menu_id`);

--
-- Indexes for table `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`NumeroEmpleado`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trabajos`
--
ALTER TABLE `trabajos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `NumeroEmpleado` (`NumeroEmpleado`);

--
-- Indexes for table `viajes`
--
ALTER TABLE `viajes`
  ADD KEY `LocOrigen` (`LocOrigen`),
  ADD KEY `LocDestino` (`LocDestino`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ejercicios`
--
ALTER TABLE `ejercicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `empleados`
--
ALTER TABLE `empleados`
  MODIFY `NumeroEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `trabajos`
--
ALTER TABLE `trabajos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ejercicios`
--
ALTER TABLE `ejercicios`
  ADD CONSTRAINT `ejercicios_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`);

--
-- Constraints for table `trabajos`
--
ALTER TABLE `trabajos`
  ADD CONSTRAINT `trabajos_ibfk_1` FOREIGN KEY (`NumeroEmpleado`) REFERENCES `empleados` (`NumeroEmpleado`);

--
-- Constraints for table `viajes`
--
ALTER TABLE `viajes`
  ADD CONSTRAINT `viajes_ibfk_1` FOREIGN KEY (`LocOrigen`) REFERENCES `ciudades` (`CodLoc`),
  ADD CONSTRAINT `viajes_ibfk_2` FOREIGN KEY (`LocDestino`) REFERENCES `ciudades` (`CodLoc`);
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Database: `trafico`
--
CREATE DATABASE IF NOT EXISTS `trafico` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `trafico`;

-- --------------------------------------------------------

--
-- Table structure for table `ciudades`
--

CREATE TABLE `ciudades` (
  `CodLoc` int(11) NOT NULL,
  `NomLoc` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ciudades`
--

INSERT INTO `ciudades` (`CodLoc`, `NomLoc`) VALUES
(1, 'Buenos Aires'),
(2, 'Córdoba'),
(3, 'Rosario'),
(4, 'Mendoza'),
(5, 'Tucumán'),
(6, 'La Plata'),
(7, 'Mar del Plata'),
(8, 'Salta'),
(9, 'Santa Fe'),
(10, 'San Juan');

-- --------------------------------------------------------

--
-- Table structure for table `ejercicios`
--

CREATE TABLE `ejercicios` (
  `id` int(11) NOT NULL,
  `denominacion` varchar(30) DEFAULT NULL,
  `ruta` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ejercicios`
--

INSERT INTO `ejercicios` (`id`, `denominacion`, `ruta`) VALUES
(1, 'Ejercicio 1', './Practica - 1/Ejercicio - 1.php'),
(2, 'Ejercicio 2', './Practica - 1/Ejercicio - 2.php');

-- --------------------------------------------------------

--
-- Table structure for table `viajes`
--

CREATE TABLE `viajes` (
  `LocOrigen` int(11) DEFAULT NULL,
  `LocDestino` int(11) DEFAULT NULL,
  `Cantkg` decimal(6,2) DEFAULT NULL,
  `FecViaje` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `viajes`
--

INSERT INTO `viajes` (`LocOrigen`, `LocDestino`, `Cantkg`, `FecViaje`) VALUES
(1, 2, 150.75, '2022-10-01'),
(3, 5, 200.50, '2022-10-02'),
(7, 8, 1000.25, '2022-10-03'),
(4, 6, 1800.00, '2022-10-04'),
(10, 1, 120.75, '2022-10-05'),
(2, 9, 2500.50, '2022-10-06'),
(5, 4, 3000.25, '2022-10-07'),
(8, 7, 800.00, '2022-10-08'),
(6, 3, 150.75, '2022-10-09'),
(9, 10, 200.50, '2022-10-10'),
(2, 3, 1800.00, '2022-10-11'),
(4, 5, 1200.75, '2022-10-12'),
(6, 7, 250.50, '2022-10-13'),
(8, 9, 300.25, '2022-10-14'),
(1, 2, 150.75, '2022-11-01'),
(3, 5, 200.50, '2022-11-02'),
(7, 8, 1000.25, '2022-11-03'),
(4, 6, 1800.00, '2022-11-04'),
(10, 1, 120.75, '2022-11-05'),
(2, 9, 2500.50, '2022-11-06'),
(5, 4, 3000.25, '2022-11-07'),
(8, 7, 800.00, '2022-11-08'),
(6, 3, 150.75, '2022-11-09'),
(9, 10, 200.50, '2022-11-10'),
(2, 3, 1800.00, '2022-11-11'),
(4, 5, 1200.75, '2022-11-12'),
(6, 7, 250.50, '2022-11-13'),
(8, 9, 300.25, '2022-11-14'),
(1, 2, 150.75, '2022-12-01'),
(3, 5, 200.50, '2022-12-02'),
(7, 8, 1000.25, '2022-12-03'),
(4, 6, 1800.00, '2022-12-04'),
(10, 1, 120.75, '2022-12-05'),
(2, 9, 2500.50, '2022-12-06'),
(5, 4, 3000.25, '2022-12-07'),
(8, 7, 800.00, '2022-12-08'),
(6, 3, 150.75, '2022-12-09'),
(9, 10, 200.50, '2022-12-10'),
(2, 3, 1800.00, '2022-12-11'),
(4, 5, 1200.75, '2022-12-12'),
(6, 7, 250.50, '2022-12-13'),
(8, 9, 300.25, '2022-12-14'),
(1, 2, 150.75, '2023-10-01'),
(3, 5, 200.50, '2023-10-02'),
(7, 8, 1000.25, '2023-10-03'),
(4, 6, 1800.00, '2023-10-04'),
(10, 1, 120.75, '2023-10-05'),
(2, 9, 2500.50, '2023-10-06'),
(5, 4, 3000.25, '2023-10-07'),
(8, 7, 800.00, '2023-10-08'),
(6, 3, 150.75, '2023-10-09'),
(9, 10, 200.50, '2023-10-10'),
(2, 3, 1800.00, '2023-10-11'),
(4, 5, 1200.75, '2023-10-12'),
(6, 7, 250.50, '2023-10-13'),
(8, 9, 300.25, '2023-10-14'),
(1, 2, 150.75, '2023-11-01'),
(3, 5, 200.50, '2023-11-02'),
(7, 8, 1000.25, '2023-11-03'),
(4, 6, 1800.00, '2023-11-04'),
(10, 1, 120.75, '2023-11-05'),
(2, 9, 2500.50, '2023-11-06'),
(5, 4, 3000.25, '2023-11-07'),
(8, 7, 800.00, '2023-11-08'),
(6, 3, 150.75, '2023-11-09'),
(9, 10, 200.50, '2023-11-10'),
(2, 3, 1800.00, '2023-11-11'),
(4, 5, 1200.75, '2023-11-12'),
(6, 7, 250.50, '2023-11-13'),
(8, 9, 300.25, '2023-11-14'),
(1, 2, 150.75, '2023-12-01'),
(3, 5, 200.50, '2023-12-02'),
(7, 8, 1000.25, '2023-12-03'),
(4, 6, 1800.00, '2023-12-04'),
(10, 1, 120.75, '2023-12-05'),
(2, 9, 2500.50, '2023-12-06'),
(5, 4, 3000.25, '2023-12-07'),
(8, 7, 800.00, '2023-12-08'),
(6, 3, 150.75, '2023-12-09'),
(9, 10, 200.50, '2023-12-10'),
(2, 3, 1800.00, '2023-12-11'),
(4, 5, 1200.75, '2023-12-12'),
(6, 7, 250.50, '2023-12-13'),
(8, 9, 300.25, '2023-12-14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ciudades`
--
ALTER TABLE `ciudades`
  ADD PRIMARY KEY (`CodLoc`);

--
-- Indexes for table `ejercicios`
--
ALTER TABLE `ejercicios`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `viajes`
--
ALTER TABLE `viajes`
  ADD KEY `LocOrigen` (`LocOrigen`),
  ADD KEY `LocDestino` (`LocDestino`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ejercicios`
--
ALTER TABLE `ejercicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `viajes`
--
ALTER TABLE `viajes`
  ADD CONSTRAINT `viajes_ibfk_1` FOREIGN KEY (`LocOrigen`) REFERENCES `ciudades` (`CodLoc`),
  ADD CONSTRAINT `viajes_ibfk_2` FOREIGN KEY (`LocDestino`) REFERENCES `ciudades` (`CodLoc`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
