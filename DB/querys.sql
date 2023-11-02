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

