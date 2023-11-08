-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-11-2023 a las 15:06:24
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
LIMIT 10 OFFSET offset
;
    
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
(8, 'Educación', 1),
(9, 'Economía', 1),
(10, 'Internacional', 1),
(11, 'Salud', 1),
(12, 'Política', 1),
(13, 'Deporte', 1),
(14, 'Entretenimiento', 1);

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
(4, 'Pendiente'),
(5, 'Respondido'),
(6, 'Recibido');

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
  `asunto` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `fecha_hora` datetime DEFAULT current_timestamp(),
  `mensaje` mediumtext NOT NULL,
  `estado_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensajes`
--

INSERT INTO `mensajes` (`id`, `nombre`, `asunto`, `email`, `fecha_hora`, `mensaje`, `estado_id`) VALUES
(44, 'Joaquin', 'Queja', 'joaquinvesapa@gmail.com', '2023-11-08 10:03:05', '<p>Este es un mensaje de prueba</p>', 5),
(45, 'Joaquin', 'La notica de messi no me gusta', 'guidoc128@gmail.com', '2023-11-08 10:31:12', '<p>En la noticia de messi dice que Ronaldo es mejor, pero en realidad messi es mejor porque tiene 8 balones de oro.</p>', 5);

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
(23, 'Escándalo en el fútbol femenino español: Jenni Hermoso reveló que recibió amenazas luego de denunciar a Rubiales', 'Joaquin Vesco', 'Argentina', 13, 'Fotos/jenni_hermoso_x1x.jpg_1756841869.jpg', '2023-11-08 00:00:00', '<p>La jugadora de la selección española se expresó nuevamente&nbsp;luego del polémico beso sin consentimiento en la consagración del Mundial femenino. Qué dijo&nbsp;</p><p><strong>Por ROSARIO3</strong></p><p>&nbsp;</p><p><img src=\"https://www.rosario3.com/__export/1699374512091/sites/rosario3/img/2023/11/07/jenni_hermoso_x1x.jpg_1756841869.jpg\" alt=\"Expresó que \" width=\"800\" height=\"450\"></p><p><img src=\"https://www.rosario3.com/__export/1555330252000/sites/rosario3/arte/v2/slider-white-arrow.png\" alt=\"Anterior\" width=\"23\" height=\"40\"></p><p><img src=\"https://www.rosario3.com/__export/1555330252000/sites/rosario3/arte/v2/slider-white-arrow.png\" alt=\"Siguiente\" width=\"23\" height=\"40\"></p><p><strong>1 de 1 |</strong></p><p>Expresó que \"contarlo una y otra vez\" le estaba \"haciendo mucho daño\" pero continuaba hablando del tema para \"soltar de alguna manera\".&nbsp;(Marca)</p><p>La futbolista española<strong> Jenni Hermoso </strong>habló de los episodios más repudiables que le tocó vivir&nbsp;en el último tiempo tras el<a href=\"https://www.rosario3.com/deportes/Jenni-Hermoso-rompio-el-silencio-Sufrimos-mas-de-la-cuenta-en-un-momento-historico-20231011-0003.html\"> beso sin consentimiento de Luis Rubiales en la consagración en el Mundial femenino.&nbsp;</a></p><p>A partir de este hecho, el caso cobró relevancia internacional y&nbsp;la jugadora dejó de ser el centro de la atención por sus méritos deportivos, sino por el accionar del dirigente que, tiempo después, fue destituido de su cargo.&nbsp;\"<strong>He tenido que asumir las&nbsp;consecuencias de un acto que no provoqué, que no había elegido ni premeditado\", </strong>apuntó Hermoso.</p><p>Por primera vez desde la final de la&nbsp;Copa del Mundo, el pasado 20 de agosto, la jugadora del&nbsp;Pachuca&nbsp;se refirió al hecho en una entrevista para la revista \"GQ\" tras haber sido distinguida como \"Mujer GQ del año\" y denunció: <strong>\"He llegado a recibir amenazas, y eso es algo a lo que no te acostumbras nunca\".</strong></p><p>Expresó que \"contarlo una y otra vez\" le estaba \"haciendo mucho daño\" pero continuaba hablando del tema para \"soltar de alguna manera\". \"Sigo trabajando en ello con mi psicóloga. Para mí, la salud mental es tan importante como el entrenamiento diario, como las horas que tengo que dormir para salir al campo.&nbsp;Gracias a ella me siento fuerte y no estoy derrumbada o pensando en no querer jugar más al fútbol\", reveló Hermoso sobre su presente luego de las amenazas y sobreexposición mediática que sufrió en los últimos meses.</p><p>En esta línea, destacó la lucha de las mujeres y aseguró que luego de todo lo vivido es \"más consciente de lo que realmente significa la palabra feminismo\".</p><p>\"Nosotras, en el fútbol, hemos vivido en primera persona la lucha por la igualdad. Nos han llamado caprichosas. Siempre se ha dicho que queríamos cobrar igual que los chicos y no era verdad.<strong>&nbsp;Me da mucha rabia que digan que el fútbol femenino no genera tanto como el masculino. Obviamente, lo sabemos y nunca hemos pedido cobrar como ellos.</strong> Simplemente, queríamos lo más básico:&nbsp;tener un salario mínimo, que se nos respetara y se nos diera la oportunidad de poder hacer algo muy grande.&nbsp;En cuanto la hemos tenido, hemos ganado un campeonato del mundo\".</p><p>Al volver a referirse al<a href=\"https://www.rosario3.com/deportes/Jennifer-Hermoso-denuncio-a-Luis-Rubiales-en-la-Justicia-por-el-escandalo-en-el-futbol-femenino-de-Espana-20230906-0041.html\"> episodio de Rubiales</a>, agradeció todo el apoyo que recibió, aunque consideró que los jugadores hombres se expresaran más abiertamente sobre el tema: \"Entiendo que cada uno piense como piense y a mí también me encantaría poder centrarme solo en mi deporte, pero&nbsp;cuando ves situaciones injustas, tienes que estar de un lado o de otro.<strong>&nbsp;La gente me odiará o me querrá, pero tengo mi manera de pensar y no me importa decirlo abiertamente:&nbsp;el apoyo de ellos no sé si hubiera hecho todo más sencillo, pero desde luego nos hubiera ayudado mucho\".</strong></p><p>&nbsp;</p><p><br>&nbsp;</p>', 1),
(24, 'Los dardos del Kun Agüero a los hinchas de Boca Juniors tras la derrota en la final de la Copa Libertadores', 'Joaquin Vesco', 'Argentina', 13, 'Fotos/L5TS3IVHHNATHJN63CEL3EVGXU.png', '2023-11-07 00:00:00', '<p>La final de la <strong>Copa Libertadores</strong> que <a href=\"https://www.infobae.com/deportes/2023/11/07/la-particular-decision-de-mariano-herron-con-uno-de-los-jugadores-que-fue-protagonista-del-alargue-entre-boca-y-fluminense/\"><i><strong>Boca Juniors</strong></i></a> perdió ante <strong>Fluminense </strong>en el <i>Maracaná </i>aún sigue fresca y <a href=\"https://www.infobae.com/deportes/2023/07/24/el-emotivo-mensaje-del-kun-aguero-luego-de-que-su-hijo-regresara-a-la-argentina-el-dolor-sigue-igual/\"><i><strong>Sergio Agüero</strong></i></a> realizó algunos comentarios de lo que observó a través de la pantalla y, de paso, les dejó un mensaje a los hinchas <i>xeneizes</i>, que siguen lamentándose por haber desperdiciado la oportunidad de ganar la séptima estrella en el torneo continental.</p><p>&nbsp;</p><p>El <i>Kun</i>, surgido de las inferiores de <strong>Independiente </strong>y fanático del <i>Rojo </i>de Avellaneda, habló en su canal de <i>Twitch</i> luego de su <a href=\"https://www.infobae.com/deportes/2023/11/07/el-kun-aguero-anuncio-que-messi-sera-copropietario-de-su-equipo-de-esports-ahora-somos-dos/\"><i>anuncio bomba sobre la llegada de Lionel Messi al equipo Krü de esports como copropietario</i></a> y dejó algunas perlitas que no pasaron por alto entre los usuarios.</p><p>&nbsp;</p><p><strong>“Pobres los de Boca.</strong> Bueno, che, no se pongan mal, ya está. Eso fue medio raro porque acabo de ver a dos amigos míos acá en <i>Krü </i>que son de Boca y fueron a la cancha. Hoy los vi y vinieron tristes.<strong> Yo les di un abrazo y les dije: ‘Qué va a ser, Rey de Copas hay uno solo</strong>. Se pierde, se gana y tienen que estar orgullosos que llegaron a la final de la Libertadores. No es fácil’”, contó <strong>Agüero </strong>delante del micrófono. Y continuó: “Como venía jugando Boca hay que reconocer que es espectacular, hay que reconocer el esfuerzo de los jugadores. También, ¿qué querés?<strong> El primer tiempo era 99% posesión de balón de Fluminense contra 1% de Boca: ¿Cómo querés hacer un gol así? No me jodan. Es imposible así”</strong>.</p><p>&nbsp;</p><p>Por otra parte, el ex futbolista destacó que el peruano<strong> Luis Advíncula</strong>, autor del gol que derivó en el empate parcial, fue la figura del equipo que dirigió <strong>Jorge Almirón</strong>. “Fue el mejor jugador de Boca, sin dudas. Desde el principio. Al 11 (Keno) le metió dos murras y olvidate, ya no la tocó más. Y ahí metió y metió y fue merecídisimo su gol. Yo me acuerdo que algunos hinchas de Boca lo puteaban a Advíncula. Yo les decía: ‘Dejalo en paz al pibe que está jugando. A veces juega mal, otras veces bien’. Pasa que somos muy pasionales acá en la Argentina y vamos más allá. Pero Advíncula la rompió. Me gustaron también el mediocampista zurdo, Equi Fernández, y Merentiel”, opinó el<i> Kun</i>.</p><p>&nbsp;</p><p>En cuanto a la expulsión de <strong>Frank Fabra</strong> por la agresión a Nino, <strong>Agüero </strong>reconoció que estuvo bien expulsado por el árbitro Wilmar Roldán. “¿Qué querés? Metió un cachetazo y lo tuvieron que echar. <strong>Se olvidó de que había VAR, antes zafabas como loco”</strong>. Además, sobre el rendimiento en la final de<strong> Valentín Barco</strong>, resaltó: “El Colo no jugó su mejor partido, <strong>pero lo hubiese bancado todo el partido</strong>, qué se yo. Es pibe, joven, hay que estar ahí con 18 años en una final. Hay que bancar a los jugadores, les digo a los hinchas de Boca. Ya está, borrón y cuenta nueva”.</p>', 1),
(25, 'Ángel Di María, cada vez más cerca de volver al fútbol argentino: el guiño de Rosario Central que volvió locos a los hinchas', 'Joaquin Vesco', 'Argentina', 13, 'Fotos/di maria.png', '2023-11-07 00:00:00', '<p>Hace poco menos de un mes, en una entrevista con el programa <i>Todo Pasa</i>, por <i>Urbana Play</i>, <strong>Ángel Di María</strong> confirmó que su aventura en la <strong>selección argentina</strong> finalizará en la Copa América de Estados Unidos. “<strong>Es lo último.</strong> Vine a Benfica, me dan la posibilidad de poder seguir estando en la Selección en un buen nivel. <strong>Quiero estar, me gustaría estar en la próxima Copa América</strong>. Estoy haciendo todo para poder estar en el club y cada vez que me toca ir a la Selección. Ojalá se me dé poder ir a esta Copa América y, como ya lo venía diciendo, va a ser la última”.</p><p>&nbsp;</p><p>Pero eso no significa que los fanáticos, que vibraron con su magia en el Mundial de Qatar que consagró a la Albiceleste, dejarán de disfrutar de sus corridas y gambetas. El delantero, de 35 años, volvió a advertir que el epílogo de su carrera lo encontrará en el club que lo vio nacer: <strong>Rosario Central</strong>.</p><p>“En mi cabeza siempre estuvo. Como estuvo volver al Benfica, está volver a Central. Lo dije muchísimo. No me gusta mucho hablar del tema porque después empiezan con que siempre hablo y nunca termina pasando, pero el fútbol es así. Te va llevando. Siempre dije que quería volver cuando todavía me sienta bien, y creo que estoy en plenitud todavía. Mi contrato acá se termina en 2024 y es obvio que está esa opción. Tengo muy buena relación con Gonzalo (Belloso, presidente de Rosario Central). Hablo bastante con él. Él sabe que tengo esa intención. Sé que las puertas están abiertas y cuando se tenga que dar, se dará. Ahora, estoy feliz acá. Quería venir un año para disfrutar de Lisboa otra vez”, señaló en la misma nota.</p><p>Pues bien, ese momento parece cada vez más cercano. O está más cerca que nunca. El periodista Fernando Carrafiello, de <i>radio La Red </i>y <i>Cadena 3 Rosario</i>, aseguró que <strong>“en junio del año que viene, Di María se comprometió a volver a Central”</strong>. La fecha coincide con la finalización del vínculo con el Benfica. Y el desembarco se daría, precisamente, después de la Copa América.</p><p>&nbsp;</p><p>El posteo del Canalla que agitó las aguas en Rosario.</p><p>&nbsp;</p><p>Al dato se sumó un posteo que enloqueció a los hinchas del Canalla, que está haciendo una muy buena temporada, al punto de ubicarse cuarto en la tabla general, ocupando la última plaza que otorga pasaje para la <strong>Copa Libertadores 2024</strong>. Ante este hecho, a dos fechas de la finalización de la clasificación, el club realizó una publicación en las redes sociales.</p><p>&nbsp;</p><p>En la misma se puede advertir la ventana de un avión y, frente al pasajero, la camiseta de Central, el pasaporte, y una valija con distintas imágenes, entre las que se destaca la de Miguel Russo y la Copa Conmebol, certamen internacional que la institución obtuvo en 1995.</p><p>&nbsp;</p><p><strong>“Cuando quiera anunciar lo que vendrá en 2024, no diré nada, pero habrá señales”</strong>, reza el texto que acompaña la imagen en la red social X (antes Twitter). En el posteo, la entidad arrobó a la Conmebol. Como respuesta, surgieron las apuestas. <strong>“Vuelve Fideo”</strong>, rubricó un seguidor. “Grande Fideo, solamente les vamos a poder putear diez jugadores”, aguijoneó un fanático de la Selección cuyo corazón no está con Central. “Ahora nos volvimo’ a ilusionar”, apeló un tercero al hit “Muchachos”, que musicalizó la gesta de Argentina en Qatar.</p><p>Medalla de oro en los Juegos Olímpicos y multicampeón con la Albiceleste (juvenil y Mayor). Dueño de una envidiable trayectoria en Europa, con pasos por el Real Madrid, PSG, Juventus y Manchester United. Y un lazo indeleble con la institución que resultó el trampolín para convertirse en leyenda. Todos los caminos de Ángel Di María conducen al Gigante de Arroyito. Muy pronto.</p>', 1),
(26, 'La agenda completa de la jornada de Champions League con la presentación de Real Madrid, Bayern Múnich y Manchester United', 'Guido Cardarelli', 'Buenos Aires, Argentina', 13, 'Fotos/champions.png', '2023-11-05 00:00:00', '<p>Después de una <a href=\"https://www.infobae.com/deportes/2023/11/07/la-agenda-completa-de-la-jornada-de-champions-league-con-la-presentacion-de-manchester-city-barcelona-y-psg/\"><i>jornada de martes</i></a> en la que <strong>Manchester City</strong> y <strong>RB Leipzig</strong> ya se accedieron a los octavos de final de la <strong>UEFA Champions League</strong>, este miércoles se completará la cuarta fecha de la fase de grupos de la competición de clubes más prestigiosa de Europa con la participación de grandes equipos como <strong>Real Madrid</strong>, <strong>Bayern Múnich </strong>y <strong>Manchester United</strong>, quienes apuntarán a encarrillar sus respectivas clasificaciones a la siguiente fase.</p><p>&nbsp;</p><p>&nbsp;</p><p>El <strong>Real Madrid</strong>, máximo ganador de este certamen, está cerca de pasar de ronda y buscará asegurar su boleto ante <strong>Sporting Braga</strong> en el <i>Santiago Bernabéu</i>. Después de ganar sus tres primeros compromisos en el <strong>Grupo C</strong>, es líder de su zona y necesita ganar o empatar para sellar su boleto a la siguiente fase. No obstante, <strong>Jude Bellingham</strong> es duda (luxación en el hombro izquierdo) y podría ser una baja sensible para <strong>Ancelotti </strong>en un duelo clave para sus aspiraciones.</p><p>En el Grupo D, la <strong>Real Sociedad</strong> y el <strong>Inter de Milán</strong> están en la cima con 7 puntos. El elenco vasco recibe en <i>Anoeta </i>al <strong>Benfica</strong>, mientras que el cuadro <i>rossonero </i>visita al <strong>RB Salzburg</strong>. Ambos tienen la posibilidad de lograr el pase matemático a octavos si ganan sus respectivos partidos.</p><p>Por otra parte, el<strong> Bayern Múnich</strong> podría sellar su clasificación a la siguiente ronda desde el Grupo A si vence al <strong>Galatarasay </strong>en el <i>Allianz Arena</i>. Con puntaje perfecto, <i>Los Bávaros</i> superan holgadamente a los turcos (4 puntos), <strong>Manchester United</strong> (3) y Copenhague (1). Además, el <strong>Arsenal FC</strong> es líder del Grupo B con 6 puntos y podría clasificarse a octavos si vence al <strong>Sevilla </strong>(2 puntos) en Londres y en simultáneo el <strong>Lens </strong>(5) gana en su visita al <strong>PSV </strong>(2).</p><p>&nbsp;</p><p>&nbsp;</p><p><strong>Napoli-Union Berlin</strong></p><p><strong>CHAMPIONS LEAGUE - FECHA 4</strong></p><figure class=\"table\"><table><tbody><tr><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=459\" alt=\"Napoli\" width=\"65\" height=\"65\"></td><td>Napoli</td><td>&nbsp;</td><td>vs</td><td>&nbsp;</td><td>1. FC Union Berlin</td><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=816\" alt=\"1. FC Union Berlin\" width=\"65\" height=\"65\"></td></tr><tr><td colspan=\"7\">UEFA Champions Leaguemiércoles 8 noviembre 2023</td></tr></tbody></table></figure><p>Estadio</p><p>Diego Armando Maradona</p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=459\" alt=\"Napoli\" width=\"20\" height=\"20\"></p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=816\" alt=\"1. FC Union Berlin\" width=\"20\" height=\"20\"></p><p>&nbsp;</p><p>14:45</p><p><strong>Hora:</strong> 18:45 CET (17:45 GMT) / 14:45 Argentina, Uruguay, Chile y Paraguay / 13:45 Bolivia, Venezuela y Miami (Estados Unidos) / 12:45 Perú, Colombia y Ecuador / 11:45 Ciudad de México</p><p>&nbsp;</p><p>&nbsp;</p><p><strong>TV: </strong>ESPN 2</p><p><strong>Real Sociedad-Benfica</strong></p><p><strong>CHAMPIONS LEAGUE - FECHA 4</strong></p><figure class=\"table\"><table><tbody><tr><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=188\" alt=\"Real Sociedad\" width=\"65\" height=\"65\"></td><td>Real Sociedad</td><td>&nbsp;</td><td>vs</td><td>&nbsp;</td><td>Benfica</td><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=251\" alt=\"Benfica\" width=\"65\" height=\"65\"></td></tr><tr><td colspan=\"7\">UEFA Champions Leaguemiércoles 8 noviembre 2023</td></tr></tbody></table></figure><p>Estadio</p><p>Reale Arena</p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=188\" alt=\"Real Sociedad\" width=\"20\" height=\"20\"></p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=251\" alt=\"Benfica\" width=\"20\" height=\"20\"></p><p>&nbsp;</p><p>14:45</p><p><strong>Hora:</strong> 18:45 CET (17:45 GMT) / 14:45 Argentina, Uruguay, Chile y Paraguay / 13:45 Bolivia, Venezuela y Miami (Estados Unidos) / 12:45 Perú, Colombia y Ecuador / 11:45 Ciudad de México</p><p><strong>TV: </strong>Fox Sports</p><p><strong>Arsenal-Sevilla</strong></p><p><strong>CHAMPIONS LEAGUE - FECHA 4</strong></p><figure class=\"table\"><table><tbody><tr><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=3\" alt=\"Arsenal\" width=\"65\" height=\"65\"></td><td>Arsenal</td><td>&nbsp;</td><td>vs</td><td>&nbsp;</td><td>Sevilla</td><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=179\" alt=\"Sevilla\" width=\"65\" height=\"65\"></td></tr><tr><td colspan=\"7\">UEFA Champions Leaguemiércoles 8 noviembre 2023</td></tr></tbody></table></figure><p>Estadio</p><p>Emirates Stadium</p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=3\" alt=\"Arsenal\" width=\"20\" height=\"20\"></p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=179\" alt=\"Sevilla\" width=\"20\" height=\"20\"></p><p>&nbsp;</p><p>17:00</p><p><strong>Hora:</strong> 21:00 CET (20:00 GMT) / 17:00 Argentina, Uruguay, Chile y Paraguay / 16:00 Bolivia, Venezuela y Miami (Estados Unidos) / 15:00 Perú, Colombia y Ecuador / 14:00 Ciudad de México</p><p><strong>TV: </strong>Fox Sports 2</p><p><strong>Bayern Munich-Galatasaray</strong></p><p><strong>CHAMPIONS LEAGUE - FECHA 4</strong></p><figure class=\"table\"><table><tbody><tr><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=156\" alt=\"FC Bayern München\" width=\"65\" height=\"65\"></td><td>FC Bayern München</td><td>&nbsp;</td><td>vs</td><td>&nbsp;</td><td>Galatasaray</td><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=208\" alt=\"Galatasaray\" width=\"46\" height=\"65\"></td></tr><tr><td colspan=\"7\">UEFA Champions Leaguemiércoles 8 noviembre 2023</td></tr></tbody></table></figure><p>Estadio</p><p>Allianz Arena</p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=156\" alt=\"FC Bayern München\" width=\"20\" height=\"20\"></p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=208\" alt=\"Galatasaray\" width=\"14\" height=\"20\"></p><p>&nbsp;</p><p>17:00</p><p><strong>Hora:</strong> 21:00 CET (20:00 GMT) / 17:00 Argentina, Uruguay, Chile y Paraguay / 16:00 Bolivia, Venezuela y Miami (Estados Unidos) / 15:00 Perú, Colombia y Ecuador / 14:00 Ciudad de México</p><p><strong>TV: </strong>ESPN 3</p><p><strong>Copenhague-Manchester United</strong></p><p><strong>CHAMPIONS LEAGUE - FECHA 4</strong></p><figure class=\"table\"><table><tbody><tr><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=569\" alt=\"FC København\" width=\"65\" height=\"65\"></td><td>FC København</td><td>&nbsp;</td><td>vs</td><td>&nbsp;</td><td>Manchester United</td><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=1\" alt=\"Manchester United\" width=\"65\" height=\"65\"></td></tr><tr><td colspan=\"7\">UEFA Champions Leaguemiércoles 8 noviembre 2023</td></tr></tbody></table></figure><p>Estadio</p><p>Parken</p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=569\" alt=\"FC København\" width=\"20\" height=\"20\"></p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=1\" alt=\"Manchester United\" width=\"20\" height=\"20\"></p><p>&nbsp;</p><p>17:00</p><p><strong>Hora:</strong> 21:00 CET (20:00 GMT) / 17:00 Argentina, Uruguay, Chile y Paraguay / 16:00 Bolivia, Venezuela y Miami (Estados Unidos) / 15:00 Perú, Colombia y Ecuador / 14:00 Ciudad de México</p><p><strong>TV: </strong>ESPN 2</p><p><strong>RB Salzburg-Inter</strong></p><p><strong>CHAMPIONS LEAGUE - FECHA 4</strong></p><figure class=\"table\"><table><tbody><tr><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=857\" alt=\"FC Red Bull Salzburg\" width=\"65\" height=\"65\"></td><td>FC Red Bull Salzburg</td><td>&nbsp;</td><td>vs</td><td>&nbsp;</td><td>Internazionale</td><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=127\" alt=\"Internazionale\" width=\"65\" height=\"65\"></td></tr><tr><td colspan=\"7\">UEFA Champions Leaguemiércoles 8 noviembre 2023</td></tr></tbody></table></figure><p>Estadio</p><p>Red Bull Arena Salzburg</p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=857\" alt=\"FC Red Bull Salzburg\" width=\"20\" height=\"20\"></p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=127\" alt=\"Internazionale\" width=\"20\" height=\"20\"></p><p>&nbsp;</p><p>17:00</p><p><strong>Hora:</strong> 21:00 CET (20:00 GMT) / 17:00 Argentina, Uruguay, Chile y Paraguay / 16:00 Bolivia, Venezuela y Miami (Estados Unidos) / 15:00 Perú, Colombia y Ecuador / 14:00 Ciudad de México</p><p><strong>TV: </strong>ESPN</p><p><strong>PSV-Lens</strong></p><p><strong>CHAMPIONS LEAGUE - FECHA 4</strong></p><figure class=\"table\"><table><tbody><tr><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=204\" alt=\"PSV\" width=\"65\" height=\"65\"></td><td>PSV</td><td>&nbsp;</td><td>vs</td><td>&nbsp;</td><td>Lens</td><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=142\" alt=\"Lens\" width=\"65\" height=\"65\"></td></tr><tr><td colspan=\"7\">UEFA Champions Leaguemiércoles 8 noviembre 2023</td></tr></tbody></table></figure><p>Estadio</p><p>Philips Stadion</p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=204\" alt=\"PSV\" width=\"20\" height=\"20\"></p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=142\" alt=\"Lens\" width=\"20\" height=\"20\"></p><p>&nbsp;</p><p>17:00</p><p><strong>Hora:</strong> 21:00 CET (20:00 GMT) / 17:00 Argentina, Uruguay, Chile y Paraguay / 16:00 Bolivia, Venezuela y Miami (Estados Unidos) / 15:00 Perú, Colombia y Ecuador / 14:00 Ciudad de México</p><p><strong>TV: </strong>Fox Sports 3</p><p><strong>Real Madrid-Braga</strong></p><p><strong>CHAMPIONS LEAGUE - FECHA 4</strong></p><figure class=\"table\"><table><tbody><tr><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=186\" alt=\"Real Madrid\" width=\"65\" height=\"65\"></td><td>Real Madrid</td><td>&nbsp;</td><td>vs</td><td>&nbsp;</td><td>Sporting Braga</td><td><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=65&amp;id=372\" alt=\"Sporting Braga\" width=\"65\" height=\"65\"></td></tr><tr><td colspan=\"7\">UEFA Champions Leaguemiércoles 8 noviembre 2023</td></tr></tbody></table></figure><p>Estadio</p><p>Santiago Bernabéu</p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=186\" alt=\"Real Madrid\" width=\"20\" height=\"20\"></p><p><img src=\"https://omo.akamai.opta.net/image.php?secure=true&amp;h=omo.akamai.opta.net&amp;sport=football&amp;entity=team&amp;description=badges&amp;dimensions=20&amp;id=372\" alt=\"Sporting Braga\" width=\"20\" height=\"20\"></p><p>&nbsp;</p><p>17:00</p><p><strong>Hora:</strong> 21:00 CET (20:00 GMT) / 17:00 Argentina, Uruguay, Chile y Paraguay / 16:00 Bolivia, Venezuela y Miami (Estados Unidos) / 15:00 Perú, Colombia y Ecuador / 14:00 Ciudad de México</p><p><strong>TV: </strong>Fox Sports</p>', 1),
(27, 'El mensaje de Enzo Fernández tras la patada de Cuti Romero y la dolencia que preocupó antes de los clásicos ante Uruguay y Brasil', 'Guido Cardarelli', 'Inglaterra', 13, 'Fotos/enzo.png', '2023-11-02 00:00:00', '<p>Este lunes, durante la primera mitad del clásico de Londres entre <strong>Tottenham </strong>y <strong>Chelsea,</strong> se produjo un encontronazo entre dos campeones del mundo con la selección argentina. Iban 27 minutos cuando el VAR llamó al árbitro para revisar <strong>una acción en el área que tuvo como protagonistas a Enzo Fernández y Cuti Romero</strong>.</p><p>&nbsp;</p><p>Tras un balón corto,<strong> el defensor de los locales le fue con la plancha al ex River, aplicándole los tapones de su botín derecho en el tobillo izquierdo al volante</strong> del conjunto de Pochettino. Tras observar la situación en el monitor, el árbitro Michael Oliver no dudó: sancionó el penal y le mostró la tarjeta roja al ex Belgrano. A pesar de haber sufrido la dura entrada, Enzo fue el encargado de intentar calmar a su compañero del seleccionado, que se quejó de manera airosa tras ver la tarjeta roja.</p><p>Luego de esa dura entrada, antes de los 15′ del complemento, <strong>Enzo intentó bajar una pelota en el área grande de los Spurs pero falló en el control y</strong> <strong>se tiró en el suelo</strong>. Acto seguido,<strong> </strong>se llevó las manos al tobillo derecho, frunció el ceño y le hizo una seña al banco con destino a su entrenador para que lo reemplace. Luego de eso, llamó a Mijailo Mudryk y retiró del campo de juego al jugador de 22 años.</p><p>Frente a dicha imagen, sonaron las alarmas en el combinado argentino, ya que restan pocos días para la doble fecha que se jugará en noviembre por las Eliminatorias Sudamericanas con dos clásicos (ante Uruguay el jueves 16 y contra Brasil el martes 21).</p><p>&nbsp;</p><p>El mensaje de Enzo Fernández tras salir por una molestia en Chelsea</p><p>Más allá de las especulaciones sobre una posible lesión, fue el propio Fernández el que llevó tranquilidad a sus seguidores con un mensaje que publicó en su cuenta de Instagram. <strong>“Gracias a todos por sus mensajes. Estoy bien, trabajando en mi recuperación para llegar de la mejor manera al fin de semana”</strong>, escribió en una historia en la que se lo ve con una cara sonriente. El mismo texto fue publicado en inglés por el mediocampista de Argentina.</p><p>&nbsp;</p><p>En la previa de su viaje al país para sumarse a la concentración del combinado nacional que dirige Lionel Scaloni, el Chelsea de Enzo Fernández tendrá un gran compromiso el próximo fin de semana. Este domingo 12 de noviembre, recibirá desde las 13.30 (hora argentina) al Manchester City de Julián Álvarez, que marcha como único líder del torneo de la Premier League.</p><p>En lo que va de la temporada, el ex mediocampista de River es una de las piezas clave del equipo londinense. Lleva disputados 13 partidos -10 por la competición inglesa y tres por la Carabao Cup- en los que disputó 964 minutos y convirtió un gol. En todos los encuentros fue titular, excepto en el duelo ante el Brentford, en el que no fue convocado por el técnico argentino.</p><p>Por el lado de Romero, habrá que ver cuál será la sanción que se le impondrá tras la expulsión en el cruce ante el Chelsea. El marcador central se convirtió en una pieza fundamental para el entrenador de los Spurs Ange Postecoglou. El 1-4 en contra significó la primera derrota para Tottenham en lo que va de la Premier -llevaba ocho victorias y dos empates-, que perdió el liderazgo en manos del equipo de Pep Guardiola.</p>', 1),
(28, 'Sebastián Villa tendría acordada su incorporación a un club europeo: el singular destino en el que recalaría', 'Joaquin Vesco', 'Argentina', 13, 'Fotos/villa.png', '2023-11-08 00:00:00', '<p>El colombiano <strong>Sebastián Villa</strong> tendría todo listo para volver a jugar al fútbol y su futuro estaría en Europa. A más de cinco meses de <a href=\"https://www.infobae.com/sociedad/policiales/2023/06/02/sebastian-villa-fue-condenado-por-violencia-de-genero-pero-no-ira-a-prision/\"><i><strong>haber sido condenado por violencia de género</strong></i></a>, con una pena de dos años y un mes de ejecución condicional, el de <strong>Boca Juniors</strong> (tiene contrato hasta fines de 2024, aunque él se declaró en libertad de acción y existe un conflicto legal) buscó alternativas para continuar con su carrera y este fin de semana viajaría al Viejo Mundo para cerrar su futuro.</p><p>&nbsp;</p><p>Y estaría en el <strong>Beroe Stara Zagora</strong> de la Primera Liga de Bulgaria. Se ubica octavo en el campeonato y allí el punta de 27 años recalaría tratando de ponerle punto final a la puja con Boca Juniors, que tras el fallo de la Justicia el 2 de junio lo apartó del plantel profesional. En consecuencia, sus abogados le sugirieron que rompiera el vínculo alegando que le impedían trabajar. El club negó eso ya que puso a disposición a un preparador físico y sus instalaciones. Y realizó una presentación por incumplimiento del contrato laboral.</p><p>A pesar de las tensiones, el colombiano buscó nuevos rumbos, se entrenó con un equipo español y hasta viajó a Turquía para negociar con el Kasimpasa, que terminó desistiendo de la idea de contratarlo para no tener problemas con el Xeneize. Incluso aceptó un ofrecimiento para jugar en la Kings League en 2024, aunque habrá que ver qué ocurrirá con el compromiso ante este cambio de planes.</p><p>Ahora, la entidad búlgara asoma como su nuevo equipo, sumándolo como agente libre. Resta saber si en La Ribera aceptarán este acuerdo o llevarán el caso a la FIFA. En sus últimas intervenciones en las redes sociales, el colombiano se mostró entrenando en un gimnasio y luego en un vuelo en su país. Este fin de semana<strong> Villa</strong> se trasladaría a <strong>Europa</strong> para hacer la revisión médica y firmar el contrato.</p><p>&nbsp;</p><p>Villa jugó su último último partido como profesional el 1° de junio en la derrota de 1-0 ante Arsenal en Sarandí. Fue un día antes de que le dictaran sentencia. Luego comenzó su período de inactividad profesional más allá de mostrarse entrenando en sus redes sociales.</p><p>&nbsp;</p><p>En el <strong>Beroe Stara Zagora </strong>hay 12<strong> </strong>futbolistas argentinos y entrenador también es de este país. Se trata de los arqueros<strong> Rodrigo García y Juan Pablo Lungarzo</strong>; los defensores <strong>Franco Ramos Mingo, Luciano Squadrone y Enzo Espinoza</strong>; los volantes<strong> Thiago Ceijas (capitán), Segundo Pachamé, Francesco Celeste y Enzo Hoyos</strong>; y los delanteros <strong>Francisco Politino, Santiago Godoy y Gonzalo Issa</strong>. El plantel está a cargo de <strong>José Luis Acciari</strong>.</p><p>&nbsp;</p><p>Su última historia en su cuenta de Instagram (@sebastian14villa)</p><p>Cabe recordar que después de ser condenado a dos años y un mes de prisión por violencia de género contra su expareja <strong>Daniela Cortés</strong>, Villa enfrentará otro juicio en la Argentina, en este caso por violación sexual con acceso carnal.</p><p>De ser hallado culpable, el ex Deportes Tolima podría recibir una pena de prisión efectiva. La Cámara de Apelaciones de Lomas de Zamora dio a conocer la elevación de la causa, lo que podría acarrearle a Villa una pena de hasta<strong> 15 años de cárcel</strong>.</p><p>La denunciante,<strong> Tamara Doldan, </strong>de 26 años, que fue pareja de Villa, aseguró haber sido agredida sexualmente por el futbolista en un country de la localidad bonaerense de Canning en junio de 2021.</p>', 1),
(29, 'El técnico del Al Nassr encendió la alarma en torno a Cristiano Ronaldo: “No se mostró en forma”', 'Guido Cardarelli', 'Arabia Saudita', 13, 'Fotos/ronaldo.png', '2023-11-07 00:00:00', '<p><strong>Cristiano Ronaldo</strong>, al igual que <strong>Lionel Messi</strong>, le ha demostrado al mundo del fútbol que la edad no es un impedimento para seguir en la elite. Sin embargo, esto no significa que los años no pesen en su físico y que necesite tener regímenes, entrenamientos o cuidados diferentes con el paso del tiempo para protegerse. Y, en este sentido, en <strong>Arabia Saudita </strong>se han encendido las alarmas en torno al artillero del <strong>Al Nassr</strong>.</p><p>&nbsp;</p><p>Es que el cuadro saudí debe jugar este martes un compromiso por la <strong>Champions de Asia </strong>frente al <strong>Al Duhail </strong>de <strong>Qatar </strong>y el entrenador Luís Castro anticipó que su máxima figura no será de la partida. “Cristiano no está en condiciones de jugar, los medios deben tenerme respeto. <strong>No digo que yo haya decidido que no juegue, el jugador no se mostró en forma</strong>”, sostuvo ante las consultas de los periodistas.</p><p>“Está ausente por cansancio. Hace unos días jugó un partido que se fue a la prórroga (de la copa local) y hace 48 horas un partido importante del campeonato”, remarcó al argumentar que <strong>Ronaldo </strong>necesitan tiempo para recuperarse a sus 38 años y, evidentemente, ya no puede jugar tantos minutos como el resto de sus compañeros. E insistió: “De todos modos, no es el primer partido que Cristiano no juega. Tras una serie de partidos, necesita recuperar. Entiendo que a la gente le guste ver jugar a Ronaldo, pero<strong> Al Nassr no es sólo Cristiano</strong>. Tenemos jugadores como Sadio Mané o Brozovic”.</p><p>Esta temporada, <i>CR7 </i>lleva anotados 21 goles en 22 partidos con su equipo, una cifra descomunal que lo convierte en uno de los máximos goleadores del planeta en la actualidad. Su último grito fue el fin de semana, cuando le marcó al Al Khaleej por la liga saudí, partido en el que también dio una asistencia.</p><p>&nbsp;</p><p>Además, el partido de este martes es perfecto para que <strong>Ronaldo </strong>descanse. Es que el equipo de Luís Castro es líder de su zona con tres triunfos en igual cantidad de presentaciones y enfrenta a un equipo que apenas tiene un punto. Por lo que puede prescindir de su máxima figura.</p><p>En cuanto al torneo doméstico, el <strong>Al Nassr </strong>marcha segundo con 28 puntos, cinco por debajo del Al Hilal, cuando apenas van 12 fechas de las 34 que dura el campeonato. Además, el artillero portugués es el máximo anotador con 12 conquistas y el máximo asistidor, con 7 pases-gol.</p>', 1),
(30, 'Angustiante momento para Neymar: robaron la casa de su novia en Brasil y mantuvieron como rehenes a sus suegros', 'Joaquin Vesco', 'Brasil', 13, 'Fotos/nemar.png', '2023-11-05 00:00:00', '<p>En las últimas horas se conoció que la casa de la influencer brasileña <strong>Bruna Biancardi</strong>, madre de la hija recién nacida del futbolista <strong>Neymar</strong>, fue asaltada en la madrugada de este martes y sus padres estuvieron como rehenes. Afortunadamente no hubo heridos.</p><p>&nbsp;</p><p>Según informó la Secretaría de Seguridad Pública de São Paulo, la Policía Civil “investiga un robo domiciliario” ocurrido en la residencia ubicada en la ciudad de Cotia y en el que “tres hombres armados entraron en la casa y redujeron a las víctimas”.</p><p>Quienes se encontraban en el lugar eran los padres de <strong>Biancardi</strong>, es decir los suegros del ex PSG, quienes estuvieron retenidos en la residencia amenazados de muerte durante el tiempo que robó el atraco. Por mera casualidad, la novia de <strong>Neymar </strong>y su hija, que nació el mes pasado, no se encontraban en al vivienda.</p><p>”Los sospechosos robaron bolsos, relojes y joyas. Un joven de 20 años fue detenido en el acto. El segundo autor ya ha sido identificado y continúan las investigaciones para identificar al tercero y detenerlo”, agregó el comunicado del organismo.</p><p>&nbsp;</p><p>En sus redes sociales, <strong>Biancardi </strong>publicó un mensaje para “tranquilizar a los amigos y familiares” y confirmó el asalto, en el que sus padres, de 52 y 50 años, estuvieron como “rehenes” de los autores del robo. La influencer señaló que ella, <strong>Mavie </strong>y su hermana no estaban en la casa en el momento del robo. “Gracias a Dios está todo bien y las cosas materiales se reconquistan”.</p><p>La Secretaría de Seguridad Pública indicó a la agencia EFE que la Policía de Cotia, en la región metropolitana de Sao Paulo, maneja “todas las hipótesis” en las investigaciones y que dará “más información cuando el caso esté finalizado. Hasta el momento Neymar no se ha manifestado públicamente al respecto.</p><p>Neymar junto a Bruna y su hija (Instagram)</p><p>En octubre pasado, el jugador de 31 años mostró con orgullo a su niña recién nacida y compartió algunas imágenes desde la sala de la clínica en la que se ve a su primogénito,&nbsp;<strong>Davi Lucca da Silva Santos</strong>, de 11 años, sosteniendo en sus brazos a su hermanita&nbsp;<strong>Mavie</strong>.&nbsp;<strong>“Mis mayores amores”</strong>, escribió&nbsp;<i>Ney&nbsp;</i>con las iniciales de los nombres de sus hijos.</p><p>&nbsp;</p><p>Más allá de rumores de separación o peleas que habían surgido en las semanas previas respecto a la relación sentimental entre <strong>Neymar </strong>y <strong>Bruna</strong>, que comenzó en enero de 2022, ambos compartieron la publicación del momento que les marcó sus vidas, como el nacimiento de su hija Mavie, con felicidad y alegría, más allá de las diferencias.</p><p>El jugador le fue infiel a su pareja que transitaba el embarazo en Brasil y lo confesó públicamente con un mensaje en sus redes sociales en julio de 2023. “Bru, ya me he disculpado por mis errores, por la exposición innecesaria, pero me siento obligado a reafirmar esto públicamente. Si un asunto privado se ha vuelto público, la disculpa tiene que ser pública”, expresó&nbsp;<i>Ney</i>. El 19 de septiembre, tras la doble fecha de Eliminatorias Sudamericanas,&nbsp;<a href=\"https://www.infobae.com/deportes/2023/09/19/filtraron-un-video-de-con-dos-mujeres-en-una-discoteca-a-un-mes-de-convertirse-en-padre-la-reaccion-de-su-pareja/\"><i><strong>Neymar</strong>&nbsp;asistió a una fiesta en una discoteca de Barcelona junto al streamer Ibai Llanos</i></a>&nbsp;y se lo vio rodeado de dos mujeres. Su pareja volvió a expresarse en redes: “”Buenas tardes.&nbsp;<strong>Soy consciente de lo que pasó y nuevamente estoy decepcionada</strong>.&nbsp;<strong>Pero en la recta final de mi embarazo mi foco y preocupación se dirigen exclusivamente a mi hija</strong>&nbsp;y eso es todo en lo que voy a pensar por el momento. Gracias por los amables mensajes”.</p>', 1),
(31, 'Messi y Agüero vuelven a estar juntos: “Bueno, vamo\' a jugar”', 'Mateo Bodini', 'Rosario, Santa Fe', 13, 'Fotos/messi, kun.png', '2023-11-07 00:00:00', '<p><strong>Lionel Messi y Sergio Agüero vuelven a formar una sociedad</strong>, aunque esta vez no será dentro de la cancha ni en las concentraciones de la selección argentina. El Kun anunció que se unió con Leo y que ahora <strong>ambos son dueños de KRÜ Esports, el equipo de deportes electrónicos creado por el delantero ya retirado de la actividad profesional</strong>.</p><p>El ex futbolista de Manchester City e Independiente, entre otros clubes, anunció el <strong>sorpresivo movimiento para el ambiente</strong> con un video en sus redes sociales. Hablando a cámara, mencionó algunos de los logros conseguidos desde la fundación del equipo, hace tres años.&nbsp;</p><p>&nbsp;</p><p>Sobre el final del relato y en tono serio, aseguró que ya no era el dueño KRÜ, pero luego de unos segundos de silencio y seriedad, reveló que ahora<strong> los propietarios son dos porque se sumó su amigo rosarino</strong>.&nbsp;</p><p>&nbsp;</p><p>“Ahora somos dos”, dijo el Kun. En otro plano, <strong>apareció Messi, con remera blanca, auriculares y una botella de agua frente a una notebook</strong>. “Bueno, vamo\' a jugar”, le respondió.</p><p><strong>Lo concreto es que Leo entra al mundo de los esports</strong> y pasa a formar una sociedad con el Kun que los vuelve a unir, para incursionar en algo totalmente nuevo para el rosarino.</p>', 1),
(32, 'Rosario Central presentó su nueva camiseta alternativa y la vestirá el sábado ante River', 'Mateo Bodini', 'Rosario, Santa Fe', 13, 'Fotos/camiseta_alternativa_rc.jpg_1756841869.png', '2023-11-08 00:00:00', '<p><strong>El Canalla tiene nueva pilcha para recibir a River este sábado</strong>.&nbsp;Central presentó su nueva camiseta alternativa, como un <strong>homenaje a los orígenes del club.</strong> El equipo saltará al Gigante para jugar contra el Millonario con este estreno. El jueves estará a la venta en la tienda online.</p><p>&nbsp;</p><p><strong>La casaca está inspirada en la bandera escocesa </strong>y tiene&nbsp;un diseño similar en&nbsp;fondo azul, con unas franjas cruzadas blancas, mangas y cuello amarillo.</p><p>&nbsp;</p><p>La marca que viste al primer equipo,&nbsp;Umbro,&nbsp;reunió a un grupo de hinchas para la sesión de fotos de presentación de las camisetas.</p><p>Uno de los detalles es la fecha 24/12/1889, que recuerda esa Nochebuena en que un grupo de entusiastas del Ferrocarril Central Argentino de Rosario decidieron crear un club, eligieron como presidente al escocés Colin Bain Calder y le pusieron como nombre Central Argentine Railway Athletic Club.</p><p>\"Nuestro nacimiento, nuestro origen. Presentamos la nueva camiseta oficial 3 de Rosario Central. Desde Escocía al mundo y desde 1889 para toda la vida\", fue el mensaje de la empresa en redes sociales.</p>', 1),
(33, 'Astore evaluará a fin de año la gestión de Heinze y Guiñazú: \"El técnico no depende del resultado con Boca\"', 'Marcelo Benitez', 'Rosario, Santa Fe', 13, 'Fotos/newells.png', '2023-11-08 00:00:00', '<p>Todo se complicó en Newell´s. <strong>La derrota con Sarmiento generó ruido&nbsp;en las tribunas, pero el eco rebotó en las paredes de las oficinas de la comisión directiva</strong>. Hace tiempo que los dirigentes están&nbsp;divididos respecto de&nbsp;la decisión a&nbsp;tomar sobre&nbsp;la continuidad de Heinze.</p><p>&nbsp;</p><p>La caída del clásico fue un detonante como para poner sobre la mesa el debate de qué&nbsp;hacer con la conducción. Después llegaron los triunfos esperanzadores con San Lorenzo y Tigre y nuevamente el apoyo del presidente rojinegro, Ignacio Astore, volvió a recuperar peso dentro del círculo áulico&nbsp;del club.</p><p>&nbsp;</p><p>La derrota ante Godoy Cruz y el empate con Platense&nbsp;desalentaron el ánimo rojinegro porque otra vez había que pelear para convencer a más de uno de que el camino era el correcto, que solo era cuestión de tiempo, algo que no se tiene nunca en el futbol, algo difícil de procesar. Pero,&nbsp;<strong>en esta parada,&nbsp;ratificando la apuesta por&nbsp;Gabriel Heinze estaba solo Ignacio Astore.&nbsp;</strong></p><p>Sarmiento fue el límite para cambiar la forma de pensar del presidente rojinegro, porque consultado por <i><strong>Rosario3,</strong></i>&nbsp;el mandamás aseguró: <strong>\"Sigo sosteniendo el apoyo porque sé lo que trabaja pero los resultados mandan, el fútbol es así</strong>\".&nbsp;</p>', 1),
(34, 'Un argentino entre los 10 mejores técnicos de clubes del mundo, según una revista británica', 'Marcelo Benitez', 'España', 13, 'Fotos/simeone.png', '2023-11-06 00:00:00', '<p><strong>El argentino Diego Simeone</strong>, quien dirige al Atlético de Madrid de España,<strong> ocupa el décimo puesto del ranking de los 50 mejores técnicos del mundo</strong> elaborado por una revista británica especializada en fútbol y que encabeza <strong>el catalán Pep Guardiola, del Manchester City</strong> inglés.</p><p>&nbsp;</p><p>En ese contexto, la revista inglesa <strong>Fourfourtwo (4-4-2)</strong> elabora un escalafón que lidera Guardiola, <strong>seguido por el alemán Jurgen Klopp (Liverpool), el Italiano Carlos Ancelotti (Real Madrid)</strong>, el español Mikel Arteta (Arsenal) y el alemán Thomas Tuchel (Bayern Munich).</p><p>Simeone se ubica décimo en el escalafón. Sobre su presente y carrera destacaron&nbsp;\"la longevidad\" y sus \"impresionantes\" logros, especialmente \"frente al poder del Barcelona y el Real Madrid\".</p><p>&nbsp;</p><p>\"No sólo haber competido, sino también por haberles ganado\", señalaron en la publicación.</p><p>Entre los 50 mejores figuran otros dos argentinos: <strong>el santafesino Mauricio Pochettino, 18º&nbsp;y a cargo del Chelsea inglés</strong>, y Martín Demichelis, de River Plate&nbsp;en el casillero 35.</p><p>Sobre Pochettino, desde Fourfourtwo valolaron: \"La temporada pasada parece haber revitalizado a Pochettino cuando regresó a la Premier League con el Chelsea. En medio de una serie de salidas y llegadas de jugadores y problemas fuera del campo, el argentino ha logrado que su equipo juegue un fútbol emocionante con talento prometedor\".</p><p>&nbsp;</p><p>De Demichelis, en tanto, remarcó: \"Se le encomendó una tarea difícil: llegó a River Plate para reemplazar al icónico Marcelo Gallardo. Terminó ganando sus primeros siete partidos seguidos sin encajar ningún gol y rápidamente se hizo con el título de liga. Podría dirigir en Europa algún día\".</p>', 1),
(35, 'fdaf', 'dfdsa', 'fdsa', 11, 'Fotos/', '2023-11-20 00:00:00', '<p>fdsfdsa</p>', 2);
INSERT INTO `noticias` (`id`, `titulo`, `autor`, `ubicacion`, `categoria_id`, `imagen_url`, `fecha_hora`, `cuerpo`, `estado_id`) VALUES
(36, 'Massa en El Tres: su promesa de acompañar a Pullaro en seguridad y el agradecimiento al socialismo', 'Guido Cardarelli', 'Rosario, Santa Fe', 12, 'Fotos/massa.jpg', '2023-11-08 00:00:00', '<p>El ministro y candidato presidencial estuvo en la provincia y avisó que en el combate a la delincuencia será “un socio” si le toca gobernar. Aseguró que “la reducción de la inflación se va a dar naturalmente” y dijo que ante Milei, “los argentinos deciden quién le cuidará a sus hijos”</p><p>&nbsp;</p><p>El ministro de Economía y candidato presidencial por Unión por la Patria (UxP)<strong>, Sergio Massa,</strong> habló este martes <strong>mano a mano con El Tres durante su visita a la provincia </strong>y prometió ser “un socio” del gobernador electo, Maximiliano Pullaro, en materia de inseguridad. Al mismo tiempo, agradeció al socialismo por apoyar su idea de “unidad nacional”.</p><p><strong>“En la lucha contra la inseguridad voy a ser no un aliado sino un socio.</strong> Con los intendentes de Rosario y Santa Fe, con el nuevo gobernador y con el saliente. La seguridad<strong> para mí va a ser un tema central</strong>”, avisó Massa en <i>Telenoche Rosario.</i></p><p>Entrevistado por la periodista Ivana Fux desde la capital santafesina –también estuvo en Rafaela y Sunchales– el rival de Javier Milei en el balotaje del domingo 19 ratificó su compromiso a <strong>“pelear para que los santafesinos y los rosarinos vivan sin miedo” </strong>y también su decisión de “instalar la agencia federal en (la vieja estación) Central Córdoba”, en bulevar 27 de Febrero al 1900.</p><p>Habló también de “<strong>40 mil millones de inversión</strong> para cámaras, móviles, sistemas de monitoreo, patrullajes” y de su ayuda “<strong>señalando a los jueces cómplices </strong>del delito del narcotráfico”.</p><p>&nbsp;</p><p><strong>Guiño al socialismo</strong></p><p>En términos netamente políticos, el candidato de UxP <strong>agradeció al socialismo </strong>que como partido manifestó sin rodeos su apoyo de cara a la segunda vuelta de elecciones. “<strong>Valoro su posición de llamar orgánicamente a apoyar un gobierno de unidad nacional</strong>”, expresó.</p><p>Consultado si puede haber <strong>socialistas en un eventual gabinete,</strong> respondió sin dudar: “<strong>Sí. Hay gente valiosa, como gente de la industria de Santa Fe</strong> que vamos a necesitar, como gente del agro con la que estuve en Córdoba”.</p><p>“La Argentina que viene nos obliga a todos a sentarnos a la mesa, <strong>necesita del esfuerzo pero sobre todo del talento de todos</strong>”, aseveró.</p><p><strong>Inflación, cepo y los temas más candentes de la campaña</strong></p><p>En tren de promesas, Massa confirmó también su idea de que “<strong>la reducción de la inflación se va a dar naturalmente </strong>y no por una genialidad de Massa” a partir de un proceso económico que dejará atrás la sequía y abrirá el campo exportador.</p><p>&nbsp;</p><p>“<strong>La gente sabe que este fue el año de la peor crisis porque la sequía nos destrozó</strong>”, dijo el ministro, y además subrayó su idea de que también <strong>el cepo cambiario tienda a desaparecer </strong>como tal hacia fines del año que viene si él es presidente.</p><p>&nbsp;</p><p>Confió en imponerse el 19 ya que “la mayoría de los argentinos quieren <strong>la educación pública, la industria nacional, el trabajo con derechos, que las Malvinas sean argentinas</strong> y no de los kelpers”,</p><p>Auguró que también el electorado sabrá evaluar “sobre todas las cosas<strong> la estabilidad emocional para gobernar </strong>un país como el nuestro, mirando para adelante” y sentenció: “En definitiva, el 19 de noviembre<strong> lo que decidirán los argentinos es quién le cuidará a sus hijos</strong>”.</p>', 1),
(37, 'El video de la gira por Rafaela: Omar Perotti al volante, Sergio Massa de copiloto y Gabriel Katopodis pasajero', 'Joaquin Vesco', 'Rosario, Santa Fe', 12, 'Fotos/massayperotti_ok_1_crop1699389719994.jpg_1756841869.png', '2023-11-07 00:00:00', '<p>Este martes, el ministro de Economía y candidato a Presidente, <strong>Sergio Massa, llegó a la provincia de Santa Fe</strong> para reunirse con distintos protagonistas del sector productivo. En ese contexto, circuló un video recién llegado a la ciudad de <strong>Rafaela</strong>, donde un grupo de personas lo esperaba para saludarlo.&nbsp;</p><p>&nbsp;</p><p>En las imágenes se observa a Omar Perotti conduciendo un vehículo, de copiloto Massa y sentado atrás Gabriel Katopodis, ministro de Obras Públicas de Argentina. Según trascendió, <strong>el gobernador de Santa Fe fue a buscar al candidato de Unión por la Patria al aeropuerto de Sunchales y lo trasladó hasta su ciudad de origen, </strong>donde<strong>&nbsp;</strong>habilitará el Depósito Fiscal construido en el Parque de Actividades Económicas de esa ciudad.</p><p>&nbsp;</p><p>Luego de las reuniones pactadas allí, Massa continuará su viaje a Sauce Viejo, donde se reunirá con empresarios e industriales. En todas las instancias estará acompañado por Perotti.&nbsp;</p>', 1),
(38, 'Tras el acuerdo con Milei, Bullrich se refirió a la interna de JxC: \"Ya era un envase que estaba muy destruido\"', 'Mateo Bodini', 'Argentina', 12, 'Fotos/bullrich_crop1699278098410.jpg_1756841869.jpg', '2023-11-08 00:00:00', '<p><strong>Patricia Bullrich</strong>, ex candidata presidencial de Juntos por el Cambio (JxC), analizó el presente de la coalición&nbsp;tras la&nbsp;derrota electoral&nbsp;del pasado 22 de octubre, el acuerdo con Javier Milei y <strong>aseveró que el espacio \"estaba muy destruido\"</strong>.</p><p>En diálogo con&nbsp;LN+, la titular del&nbsp;PRO&nbsp;aclaró que si bien&nbsp;JxC&nbsp;ya era \"<strong>un envase muy destruido</strong>\",<strong> remarcó que&nbsp;\"no es el fin\"</strong>.&nbsp;De esa manera, destacó la importancia de \"hablar desde qué lugar y qué base se reconstruye\". \"El tema fundamental son las ideas y a dónde vamos\", vaticinó.</p><p>Al ser consultada sobre si la decisión de apoyar al candidato de La Libertad Avanza (LLA) el próximo 19 de noviembrei fue o no apresurada, Bullrich respondió: \"La decisión que tomamos es sin condicionamientos.&nbsp;<strong>Tomamos una decisión solos, pero media hora después la UCR iba a tomar la suya</strong>. Ellos también la tomaron solos y no en el marco de Juntos por el Cambio y un día antes ya lo había hecho la CC. Nos jugamos a una idea y siempre me juego\".</p><p>&nbsp;</p><p>Rodríguez Larreta: “No veo una gran mayoría del PRO que suscriba a las ideas de extrema derecha de Milei”</p><p>&nbsp;</p><p>Maximiliano Pullaro en la tapa de Gente de los Personajes del Año 2023</p><p>\"Eso fue lo que se debatió en las Paso&nbsp;y&nbsp;<strong>había diferentes maneras de pensar sobre hacia donde llevar el país</strong>\", explicó.</p><p>Respecto al plano electoral,<strong>&nbsp;lamentó haber quedado en el camino rumbo al balotaje</strong>. En esa misma línea, afirmó que&nbsp;el debate que se presenta dentro de la coalición&nbsp;\"es el mismo que está atravesando gran parte de la ciudadanía\".</p><p>En ese sentido, manifestó: \"<strong>Hoy el país debate lo mismo</strong>, si va hacia el cambio y la transformación, en el que las personas puedan vivir libremente y crecer con empresas, trabajando, con posibilidades y educación,&nbsp;o un modelo corporativo donde las partes políticas se arreglan entre si y la gente las mira de afuera\".</p>', 1),
(39, 'La Canasta Básica Alimentaria subió 9,5% en Rosario y superó los $48.000 en octubre', 'Marcelo Benitez', 'Buenos Aires, Argentina', 9, 'Fotos/verduleria_supermercado.jpg_1756841869.jpg', '2023-11-07 00:00:00', '<p>&nbsp;</p><p>Se trata del listado de alimentos y cantidades necesarias para cubrir los requerimientos nutricionales. El informe de la Usina de Datos de la UNR detalló que se registró una desaceleración respecto de septiembre cuando el incremento había sido del&nbsp;18,9 %. Verduras y pan, entre los que más aumentaron</p><p>&nbsp;</p><p>Frutas, verduras y hortalizas con fuertes subas en octubre.&nbsp;(Ana Isla/Rosario3)</p><p>La <strong>Canasta Básica Alimentaria</strong> (CBA) en la ciudad de <strong>Rosario alcanzó el valor de $ 48.364,61 para un adulto</strong>, en octubre de 2023 según el relevamiento de la Usina de Datos de la Universidad Nacional de Rosario (UNR). La cifra representa un<strong> aumento del 9,50 %</strong> con respecto al mes anterior.</p><p>El informe también detalla que entre octubre de 2022 y 2023, la CBA aumentó todos los meses, siendo el mayor incremento el del mes de agosto de este año. El aumento interanual, respecto al costo de la CBA en el mismo mes del año anterior, es de <strong>227,9%</strong>.</p><p>El documento difundido por el equipo de <a href=\"https://rephip.unr.edu.ar/\">profesionales de la UNR</a>, reveló que luego del pico del 25,8 % de aumento en agosto se observó una desaceleración en el aumento de la CBA para el mes de <strong>septiembre con un incremento del 18,9 %</strong>.</p><p>&nbsp;</p><p>En octubre, esto se rectifica nuevamente con un aumento del 9,5 %; lo cual representa una <strong>variación 9 puntos menor con respecto al mes anterior</strong>.</p><p>&nbsp;</p><p>Los rubros que registraron <strong>mayores aumentos de precios en términos porcentuales</strong> fueron las “Verduras y Hortalizas” (32,0%), el “Pan” (32,0%), las “Legumbres” (27,4%) y los “Cereales y Derivados” (12,2%).</p><p>En el mismo período, si se toma como referencia la CBA para un adulto equivalente, los rubros con<strong> mayor crecimiento, en términos absolutos</strong>, durante el último mes fueron: el Pan ($1.684,8), las Verduras y Hortalizas ($1.159,5) y las Carnes ($1.025,8).</p><p>La CBA comprende un<strong> listado de alimentos y cantidades necesarias para cubrir los requerimientos nutricionales</strong> de un hombre de 30 a 60 años por mes. La Usina de Datos de la UNR estableció un método para relevar el costo de la Canasta Alimentaria Básica en la ciudad de Rosario a fin de contar con una fuente propia de datos sobre este importante indicador de referencia en la estimación de los ingresos necesarios para la <strong>satisfacción de las necesidades básicas de la región</strong>.</p>', 1),
(40, 'Pese a la suba de 4,7% en octubre, las ventas minoristas acumulan una baja de 2,4% interanual', 'Mateo Bodini', 'Rosario, Santa Fe', 9, 'Fotos/ventas_madre.jpg_1756841869.jpg', '2023-11-07 00:00:00', '<p>El dato se desprende del informe elaborado por la Confederación Argentina de la Mediana Empresa. En el relevamiento, la entidad indicó que la parte de la variación positiva respondió&nbsp;al \"impulso la semana previa a las elecciones\" y a la celebración del Día de la Madre</p><p>&nbsp;</p><p>La mayor retracción anual en las ventas de octubre se dio en Alimentos y Bebidas (-8%) y el mayor incremento se pudo ver en Calzado y Marroquinería (6,6%).&nbsp;(Archivo/Télam)</p><p>Las <strong>ventas minoristas registraron un incremento de 4,7 por ciento en octubre</strong>, respecto del mes anterior, de acuerdo con un relevamiento de la <strong>Confederación Argentina de la Mediana Empresa</strong> (Came).</p><p>La entidad indicó que \"<strong>las ventas tuvieron un impulso la semana previa a las elecciones</strong>, cuando muchas personas tomaron decisiones de consumo anticipado para evitar posibles aumentos de precios\".</p><p>Medidas contra octubre de 2022,&nbsp;cayeron un 0,7&nbsp;&nbsp;por ciento en la medición a precios constantes. <strong>En los primeros diez meses del año el comercio minorista acumula un descenso de 2,4 por ciento&nbsp;interanual.</strong></p><p>La variación por rubros</p><p><br>En octubre, tres de los siete rubros registraron caídas interanuales en sus ventas y cuatro tuvieron alzas: <strong>la mayor retracción anual se dio en Alimentos y Bebidas (-8%) y el mayor incremento se pudo ver en Calzado y Marroquinería (6,6%).</strong></p><p>En Alimentos y Bebidas, las ventas se retrajeron 8% anual en octubre, a precios constantes, y acumulan una caída de 2,9 por ciento en los primeros diez meses del año frente al mismo período de 2022; mientras que en la comparación intermensual se mantuvieron sin cambios.</p><p>Los consumidores adoptaron una estrategia de compra más cautelosa, adquiriendo únicamente lo esencial, comparando precios y fragmentando sus compras.</p><p>En el rubro de Bazar y Muebles las ventas subieron 6,4 por ciento&nbsp;anual en octubre, a precios constantes, y acumulan una caída de 1,1 por ciento&nbsp;en los primeros diez meses del año frente al mismo período de 2022; en tanto, en la comparación intermensual subieron 7,7 por ciento. En esta categoría hubo un repunte de la demanda, especialmente en la semana previa al Día de la Madre.</p><p>&nbsp;</p><p>En Calzado y Marroquinería, las ventas subieron 6,6% anual en octubre, a precios constantes, y acumulan un alza de 1,1 por ciento&nbsp;en los primeros diez meses del año frente al mismo período de 2022; y en la comparación intermensual también tuvieron un alza de 2,2 por ciento.</p><p>Came&nbsp;señaló que \"el Día de la Madre traccionó a ese rubro, ayudado también por promociones lanzadas por los comercios. El producto estrella fue el calzado deportivo. Frente al buen resultado, algunos comercios sospechan cierto anticipo de compras de fin de año para escapar de los incrementos futuros\".</p><p>Farmacia registró una baja interanual en las ventas de 5,4 por ciento&nbsp;en octubre, aunque aún acumulan un crecimiento de 2,4 por ciento&nbsp;en los primeros diez meses del año frente al mismo período de 2022; mientras que en la comparación intermensual subieron 7,8 por ciento.</p><p>\"<strong>Hubo faltantes de drogas, demoras en las entregas, cortes de artículos importados</strong> y se sumó, especialmente este mes, que hubo productos que quedaron sin precios y por lo tanto las farmacias optaron por no vender hasta que se clarifique el costo de reposición\", detalló el informe.</p><p>Perfumería registró una baja de 1 por ciento&nbsp;interanual en las ventas, con una caída también de 1por ciento&nbsp;en los primeros diez meses del año frente al mismo período de 2022 y en la comparación intermensual se mantuvieron sin cambios.</p><p>En el rubro Ferretería, materiales eléctricos y materiales de la construcción, las ventas subieron 5,2 por ciento&nbsp;anual en octubre y acumulan una caída de 0,5 por ciento&nbsp;en los primeros diez meses del año frente al mismo período de 2022; en la comparación intermensual subieron 8,5 por ciento.</p><p><strong>Los comercios se encontraron con un nivel de stock suficiente debido a que acumularon inventarios previendo la incertidumbre antes de las elecciones, similar a lo sucedido en agosto.</strong></p><p>En Textil e Indumentaria, las ventas subieron 4,1 por ciento&nbsp;anual y acumulan una caída de 6,1 por ciento&nbsp;en los primeros diez meses del año frente al mismo período de 2022; al tiempo que en la comparación intermensual subieron 6,1 por ciento.</p><p>\"El Día de la Madre fue uno de los principales motores de ventas, junto con atractivas ofertas que los consumidores aprovecharon a pesar de la constante escalada de precios en el mercado. El enfoque en promociones y eventos especiales ha sido esencial para mantener la actividad comercial\", concluyó.</p>', 1),
(41, 'Con descuentos y promociones, cuándo es el Black Friday Argentina 2023', 'Mateo Bodini', 'Buenos Aires, Argentina', 9, 'Fotos/comercio_electronico_crop1699191994397.jpg_1756841869.jpg', '2023-11-08 00:00:00', '<p>El evento de descuentos y promociones que se desarrolla en el país desde 2013 está previsto para el cuarto viernes de noviembre, es decir, el 24. Tres consejos a la hora de comprar</p><p>&nbsp;</p><p>Las ventas se realizan tanto online como en comercios.</p><p><strong>El viernes 24 de noviembre se desarrollará una nueva edición del Black Friday</strong>, el evento que “adelanta” las compras navideñas, según la tradición en parte del mundo.</p><p>La jornada tiene marcada su fecha en el calendario desde 2013: el cuarto viernes de noviembre, y el origen es estadounidense. En ella se pueden conseguir cantidad de productos con<strong> descuentos y promociones, ya sea en comercios físicos y online.</strong></p><p>Si bien el Black Friday dura un día, cada vez más negocios deciden extenderlo durante fin de semana o toda la semana siguiente convirtiendo al evento en la Black Week.</p><p>El evento <strong>no es organizado por la Cámara Argentina de Comercio Electrónico</strong> (Cace) como ocurre con el CyberMonday, entonces, hay que revisar de manera independiente las web de marcas y empresas para conocer las ofertas.</p><p>Consejos</p><p><br>El tener que entrar a distintas páginas o locales y comparar precios, puede resultar un poco abrumador y es posible caer en promociones poco beneficiosas. Por eso, <strong>consultar semanas antes los precios </strong>de los productos que te interesa comprar puede ayudar a tener una noción más clara y real respecto a las ofertas.&nbsp;</p><p>También es recomendable<strong> consultar el historial de precios.</strong> De esta forma, se puede corroborar el porcentaje de descuento y saber si esa oferta conviene realmente.</p><p>Otro consejo útil es <strong>informarse de la política de pagos, cambios y garantía de los productos</strong> del comercio o sitio&nbsp;en el que se realizó la compra..</p>', 1),
(42, 'La producción mundial de vino cayó a sus niveles más bajos en 60 años como consecuencia de fenómenos climáticos', 'Mateo Bodini', 'Noruega', 10, 'Fotos/botellavino.jpg_1756841869.jpg', '2023-11-05 00:00:00', '<p>La <strong>producción mundial de vino</strong> cayó a su nivel más bajo en seis décadas este 2023 como consecuencia de fenómenos meteorológicos como <strong>heladas, sequías y lluvias diluvianas</strong> que tuvieron efectos negativos sobre todo en Sudamérica y España.</p><p>Según una estimación de la Organización Internacional de la Viña y el Vino (OIV) publicada este martes, <strong>el volumen global cayó un 7% este año con respecto al 2022</strong>.&nbsp;</p><p>Francia, el mayor productor mundial en volumen, mantuvo estable su producción y volvió a posicionarse por encima de Italia, en donde la producción cayó un 12% respecto a 2022; y España, en donde se registró una caída del 14%.</p><p>En cuanto a la situación en los países productores del hemisferio sur, <strong>Chile, Argentina y Brasil registraron caídas del 20, 23 y 30 por ciento respectivamente.</strong></p><figure class=\"image\"><img style=\"aspect-ratio:800/532;\" src=\"https://www.rosario3.com/export/sites/rosario3/img/2023/11/07/produccixn.jpg_157097993.jpg\" alt=\"\" width=\"800\" height=\"532\"><figcaption><i>Todos los países sudamericanos productores de vino registraron una caída significativa durante el último año.</i></figcaption></figure><p>Todos los grandes países sudamericanos productores de vino registraron una caída significativa de la producción respecto a 2022.</p><p>En <strong>Chile</strong>, primer productor del hemisferio sur, el volumen de vino es 20% inferior a la alta producción del año pasado y un 18% inferior a su media quinquenal. Entre otros factores, esto se explica porque la cosecha se vio gravemente afectada por incendios forestales y sequías.</p><p><strong>Argentina </strong>registró una caída que se explica, principalmente, por las <strong>heladas primaverales y granizadas</strong>. La producción nacional alcanzó los 8,8 millones de hectolitros, lo que representa un 23% menos que el año pasado y el <strong>volumen registrado más bajo en la historia del país.</strong></p><figure class=\"image\"><img style=\"aspect-ratio:800/450;\" src=\"https://www.rosario3.com/export/sites/rosario3/img/2023/11/07/uvasvino.jpg_674994428.jpg\" alt=\"\" width=\"800\" height=\"450\"><figcaption><i>El volumen global de producción de vino cayó un 7% interanual en el 2023.</i></figcaption></figure><p>La producción cayó también con fuerza Brasil (-30%) y en Uruguay (-34%), según las estimaciones de la OIV. Entre los otros grandes productores de vino del hemisferio sur, Australia sufrió un desplome de su producción de 24% y Sudáfrica de 10%.</p><p>España se mantiene como tercer productor mundial con un volumen estimado de 30,7 millones de hectolitros, el más bajo de los últimos 20 años producto de una grave sequía y temperaturas extremas que golpearon fuertemente a las viñas.</p>', 1),
(43, 'Pánico a bordo: les pidieron que se pusieran los chalecos salvavidas mientras cruzaban el Triángulo de las Bermudas', 'Guido Cardarelli', 'Arabia Saudita', 10, 'Fotos/a_1.png_1756841869.png', '2023-11-07 00:00:00', '<p>Un grupo de turistas fueron puestos en alerta mientras el barco en el que pasaban unos días de vacaciones se dirigía hacia el tramo del Océano Atlántico conocido por misteriosos naufragios y aviones desaparecidos</p><p>&nbsp;</p><p>El transatlántico puede albergar hasta 2.860 pasajeros y 1.160 tripulantes.&nbsp;(Facebook Virgin Voyages)</p><p>Pasajeros del crucero Valiant Lady quedaron aterrorizados cuando se les pidió que \"se coloquen&nbsp;los chalecos salvavidas\" mientras el barco navega hacia el Triángulo de las Bermudas. El transatlántico de lujo navegaba de Barcelona a Miami cuando<strong> entró en alerta máxima y ordenó a todos los pasajeros que se dirigieran a sus camarotes</strong> y buscaran medicamentos urgentes si los necesitaban.</p><p>El Valiant Lady tiene solo un año y es uno de los cruceros más nuevos del mundo. El enorme transatlántico <strong>puede albergar hasta 2.860 pasajeros y 1.160 tripulantes</strong> y su construcción costó 575 millones de libras esterlinas.&nbsp;Había partido desde Barcelona, España a Miami, Estados Unidos, el 29 de octubre.</p><p>Según publicó el diario británico The Sun, los pasajeros quedaron desconcertados y mientras algunos acataron las órdenes, otros buscaban respuestas por parte de la tripulación. Finalmente personal del navío <strong>les dijo a los pasajeros, después de unos 15 minutos de pánico, que se trataba de un simulacro</strong>&nbsp;compartido accidentalmente con todo el barco a las personas que usaban la aplicación y las pantallas de televisión.</p><p>&nbsp;</p><p>En las redes sociales el hecho no pasó desapercibido y muchos recurrieron para&nbsp;contar la aterradora experiencia, un hombre dijo: \"Me puse mi traje de neopreno, mi chaleco salvavidas y grité todo el camino hasta C7 sólo para darme cuenta de que no era verdad\". Otro dijo: \"¿Alguien más pensó que <strong>era un poco preocupante que todo sucediera justo cuando el barco se acercaba al Triángulo de las Bermudas?\".</strong></p><p>Pero algunos también dijeron que sabían que era una falsa alarma y no veían que sus vidas estuvieran en peligro. Uno bromeó: \"Abrió algunos espacios en cubierta, por lo que es posible que necesite que suene mañana\". Otro dijo: \"Una verdadera notificación de emergencia comenzaría con las siete pulsaciones de la bocina del barco y las alarmas interiores\".</p>', 1),
(44, 'El mensaje de Charly García tras su homenaje en Nueva York: “En Walker street y... yo”', 'Joaquin Vesco', 'New York', 10, 'Fotos/charly_garcia.jpg_1756841869.jpg', '2023-11-09 00:00:00', '<p>A poco de conocer sobre el homenaje que le realizaron, al bautizar la emblemática esquina donde se tomó la imagen de tapa de su disco Clicks Modernos, el propio <strong>Charly García </strong>envió una carta en agradecimiento al cónsul argentino en<strong> Nueva York</strong> Santiago Villalba, por propiciar su homenaje.</p><p><strong>“Me siento honrado por la invitación y por que me hayan elegido para que una esquina lleve mi nombre. </strong>No conozco muchos artistas de fama mundial a los que les haya sucedido esto nada menos que en una ciudad como <strong>New York, una metrópoli tan importante para mí y donde solo ahí se podía lograr el sonido de Clicks Modernos”</strong>, fueron las palabras del padre del rock nacional argentino en la misiva.</p><p>&nbsp;</p><p>Este lunes por la tarde <a href=\"https://www.rosario3.com/ocio/Desde-este-lunes-Charly-Garcia-tendra-su-esquina-en-Nueva-York-20231105-0025.html\">se descubrió la placa que indica el nuevo nombre de la esquina neoyorquina Charly García Corner</a>, donde sonaron algunas de sus canciones del disco Clicks Modernos de la mano de algunos músicos amigos.</p><p>Al mensaje sumó palabras sentidas y remató con una astuta y graciosa frase:<strong> “Estoy feliz. Emocionado. No veo las horas de decirle a un taxista: \'Dejeme acá. En&nbsp;Walker St...&nbsp;y yo\'”</strong>. Y luego cerró la carta volviendo a agradecer: “Muchísimas gracias a todos los que lograron esto”</p>', 1),
(45, 'Respiración consciente: de qué se trata y por qué resulta tan importante', 'Marcelo Benitez', 'Inglaterra', 11, 'Fotos/whatsapp_image_2023-11-06_at_09_58_15_1.jpg_1756841869.jpg', '2023-11-08 00:00:00', '<p>Por lo general, <strong>no se suele prestar&nbsp;la suficiente atención a un acto tan vital como el de la respiración</strong>. Simplemente, el inconsciente se encarga de que <strong>esa función se produzca automáticamente</strong>. Normalmente,<strong> el ritmo respiratorio de un adulto está en torno a 12 respiraciones por minuto. Sin embargo, esta tasa se eleva notablemente</strong>, en algunas alteraciones de <strong>estrés y ansiedad</strong> y <strong>puede llegar a la hiperventilación.</strong></p><p>En este aspecto, el<strong> Lic. en Kinesiología y Fisiatría y C.O Osteopatía Carlos Catuch junto al P.F. Profesional, Coach Ontológico y Entrenador Holístico, Gonzalo Demarchi</strong>, destacaron que<strong> la hiperventilación está en el origen o mantenimiento de las crisis de angustia.</strong></p><p>\"<strong>Con la hiperventilación se expulsa una cantidad excesiva de dióxido de carbono, lo que provoca cambios químicos en la sangre alterando los mecanismos por el cual el cerebro controla el sistema nervioso y creando diversa sintomatología</strong>: nauseas, mareos, dolor de cabeza, sudor frio, hormigueo, palpitaciones, etc. <strong>La forma de reducir muchos de estos síntomas y volver a tener las riendas de nuestro bienestar</strong> es realizando la<strong> respiración diafragmática</strong>\", destacaron.</p><p>&nbsp;</p><p>\"<strong>¿Has visto a un bebe respirar? ¿Has podido observar cómo se mueve su abdomen con las inhalaciones y las exhalaciones? Es una respiración de vida, profunda</strong>; es la respiración diafragmática. En cambio, seguramente<strong> si te fijás en tu propia respiración</strong> te darás cuenta de que tu respiración es superficial, <strong>apenas aprovechás la parte superior de tus pulmones</strong>\", indicaron los expertos.</p><p>La <strong>respiración diafragmática es una técnica que entrena el autocontrol del ritmo y la profundidad respiratoria.</strong> <strong>Cuando se practica, se logran estabilizar los niveles de oxígeno en sangre</strong> con lo que la persona experimenta una disminución de la repuesta del sistema nervioso simpático asociada a la hiperventilación; normalización de los niveles de Ph sanguíneo, se reduce la vasoconstricción y el ritmo cardíaco y se recupera el flujo sanguíneo normal.</p><p>&nbsp;</p><p><strong>Aprender a vivir de una forma relajada no es algo que pueda conseguirse en cinco minutos</strong> y requiere, como todo, de una<strong> disciplina y una práctica continuadas.</strong>&nbsp;En tal sentido, subrayaron: \"<strong>La respiración de una forma consciente nos brinda la oportunidad de conectarnos con nosotros mismos a cada instante,</strong> de esta manera nuestra mente estará siempre preparada y receptiva para los continuos cambios, adversidades o alteraciones que podamos sufrir\".</p><p><strong>Tomar consciencia de un acto tan vital como el de la respiración mediante una técnica sencilla</strong> es una gran herramienta para <strong>favorecer tanto el bienestar mental como el&nbsp;psicológico. </strong>Algunos de los <strong>beneficios de la respiración consciente</strong> son:</p><p>-Reducción del estrés y la ansiedad.</p><p>-Mejora de la concentración y la memoria.</p><p>-Regulación de la frecuencia cardiaca y presión arterial.</p><p>-Mejora la calidad del sueño.</p><p>-Aumento de la energía y la productividad.</p><p>-Mejora la resiliencia emocional.</p><p>-Mayor claridad mental y estado de ánimo.</p><p>-Fortalecimiento del sistema inmune.</p><p><br>Antifrágil</p><p>Carlos Catuch - (ig: osteopata.carloscatuch ) &nbsp;C.O osteopatía Gonzalo Demarchi - (ig: gonzademarchi_pf)<br>P.F. Profesional<br>Coach Ontológico<br>Entrenador Holístico</p>', 1),
(46, 'Un “ortiva” en Ahora Caigo: Darío Barassi se metió en la pelea de una pareja y empeoró la situación', 'Guido Cardarelli', 'Buenos Aires, Argentina', 14, 'Fotos/barassi_crop1699446868938.jpg_1756841869.jpg', '2023-11-08 00:00:00', '<p>Tentado por el testimonio de una participante de <i>Ahora Caigo</i> (El Trece, <i>El Tres</i>),<strong> Darío Barassi intervino en el conflicto de una pareja con la intención de solucionar la situación, pero la empeoró.</strong></p><p>La concursante de nombre Flor hablaba de su trabajo, de su afición por los tatuajes cuando le cambió la cara al referirse al vínculo que la unía al joven que la acompañó al programa.</p><p><strong>“No quería venir”</strong>, dijo Flor. Barassi se tentó al ver al joven en soledad y a un costado. “¿Por qué no tenías ganas?”, preguntó el conducto y la respuesta fue: “Planes laborales, nada más”.</p><p>&nbsp;</p><p>A partir de ese momento ella contó cómo se conocieron y que no conviven, aunque él pasaba muchos días en su domicilio.</p><p>“Pará,<strong> hablás de él con odio, ¿pasó algo?</strong>”, interrogó con humor Barassi, sin pensar la respuesta definitiva.</p><p>“Yo lo amo, pero <strong>estoy medio&nbsp;enojada</strong> últimamente. Esto no se tenía que ventilar, pero <strong>él fue insistente al principio y ahora es más seco. No es como antes.</strong> Era todo divino, pero bueno”, se quejó Flor.</p>', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `id` int(11) NOT NULL,
  `respuesta` longtext DEFAULT NULL,
  `estado_id` int(11) DEFAULT 1,
  `mensaje_respondido_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `respuestas`
--

INSERT INTO `respuestas` (`id`, `respuesta`, `estado_id`, `mensaje_respondido_id`) VALUES
(9, '<p>Respondiendo mensaje de queja</p><h3>A</h3>', 1, 44),
(10, '<p>Ronaldo es mejor porque corre mas</p>', 1, 45);

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
(1, 'Joaquin Vesco Aparicio', 'admin', 'admin', 1),
(10, 'joaquin', 'joaquin', 'ajoquin', 1),
(11, 'guido', 'guido', '1234', 1);

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
-- Estructura Stand-in para la vista `v_get_respuestas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_get_respuestas` (
`RespuestaId` int(11)
,`Respuesta` longtext
,`MensajeRespondidoId` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_get_total_mensajes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_get_total_mensajes` (
`Total` bigint(21)
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
-- Estructura para la vista `v_get_respuestas`
--
DROP TABLE IF EXISTS `v_get_respuestas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_get_respuestas`  AS SELECT `r`.`id` AS `RespuestaId`, `r`.`respuesta` AS `Respuesta`, `r`.`mensaje_respondido_id` AS `MensajeRespondidoId` FROM `respuestas` AS `r` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_get_total_mensajes`
--
DROP TABLE IF EXISTS `v_get_total_mensajes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_get_total_mensajes`  AS SELECT count(0) AS `Total` FROM `mensajes` WHERE `mensajes`.`estado_id` = 6 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_total_noticias`
--
DROP TABLE IF EXISTS `v_total_noticias`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_total_noticias`  AS SELECT count(0) AS `Total` FROM `noticias` WHERE `noticias`.`estado_id` = 1 ;

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
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mensaje_respondido_id` (`mensaje_respondido_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `imagenes`
--
ALTER TABLE `imagenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `noticias`
--
ALTER TABLE `noticias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`mensaje_respondido_id`) REFERENCES `mensajes` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
