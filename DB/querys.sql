--Getall de noticias con detalle de las categorias
DELIMITER //
CREATE PROCEDURE sp_get_noticias(
  IN noticia_id int;
)
BEGIN
	IF(noticia_id = 0) 
    THEN  SET @param = CONCAT('%','%');
    ELSE
    	SET @param = CONCAT('%', noticia_id, '%');
    END IF;
	
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
    WHERE n.id like @param;
    
END; //
DELIMITER ;



BEGIN
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
    WHERE n.categoria_id like categoria_id AND n.estado_id = 1;


END


DELIMITER //
CREATE PROCEDURE sp_get_total_noticias_por_categoria(IN categoria_id INT)
BEGIN
	SELECT COUNT(*) as Total FROM noticias WHERE noticias.categoria_id = categoria_id AND noticias.estado_id = 1;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_get_mensajes(
    IN mensaje_id INT,
    IN estado_mensaje INT,
    IN offset INT
)
BEGIN
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
END;
//
DELIMITER ;