-- MISIÓN 3 · COMPLETA Y COMENTA LAS CONSULTAS
USE ai_customer;
-- RETO 1: muestra las tablas y cuenta sus filas.
SHOW TABLES;
DESCRIBE clientes;
DESCRIBE operaciones;
-- claves primarias y foráneas
SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA = 'ai_customer';
-- recuento de filas
SELECT 'clientes' AS tabla, COUNT(*) AS filas FROM clientes
UNION ALL
SELECT 'operaciones', COUNT(*) FROM operaciones;
-- RETO 2: clientes de Madrid, menos de 6 meses, orden por antigüedad, abandono=1.
SELECT * FROM clientes WHERE ciudad = 'Madrid';
SELECT * FROM clientes WHERE antiguedad_meses < 6;
SELECT * FROM clientes ORDER BY antiguedad_meses DESC;
SELECT * FROM clientes WHERE abandono = 1;
-- RETO 3:
-- operaciones con nombre de cliente;
SELECT o.*, c.nombre FROM operaciones o INNER JOIN clientes c ON o.id_cliente = c.id_cliente;
-- clientes sin operaciones;
SELECT c.* FROM clientes c LEFT JOIN operaciones o ON c.id_cliente = o.id_cliente WHERE o.id_operacion IS NULL;
-- operaciones > 200;
SELECT o.*, c.nombre FROM operaciones o INNER JOIN clientes c ON o.id_cliente = c.id_cliente WHERE o.importe > 200;
-- operaciones de un cliente.
SELECT c.nombre, o.* FROM operaciones o INNER JOIN clientes c ON o.id_cliente = c.id_cliente WHERE c.id_cliente = 1;
-- RETO 4:
-- gasto total por cliente;
SELECT c.id_cliente, c.nombre, COALESCE(SUM(o.importe), 0) AS gasto_total
FROM clientes c LEFT JOIN operaciones o ON c.id_cliente = o.id_cliente
GROUP BY c.id_cliente, c.nombre;
-- operaciones por canal;
SELECT canal, COUNT(*) AS num_operaciones FROM operaciones GROUP BY canal;
-- ticket medio;
SELECT c.id_cliente, c.nombre, ROUND(COALESCE(AVG(o.importe), 0), 2) AS ticket_medio
FROM clientes c LEFT JOIN operaciones o ON c.id_cliente = o.id_cliente
GROUP BY c.id_cliente, c.nombre;
-- clientes con gasto > 500.
SELECT c.id_cliente, c.nombre, SUM(o.importe) AS gasto_total
FROM clientes c INNER JOIN operaciones o ON c.id_cliente = o.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING SUM(o.importe) > 500;
-- RETO FINAL: una fila por cliente, con antiguedad_meses,num_operaciones, gasto_total, ticket_medio y abandono.
-- Usa LEFT JOIN y COALESCE.
SELECT c.id_cliente, c.antiguedad_meses,
       COUNT(o.id_operacion) AS num_operaciones,
       COALESCE(SUM(o.importe), 0) AS gasto_total,
       ROUND(COALESCE(AVG(o.importe), 0), 2) AS ticket_medio,
       c.abandono
FROM clientes c
LEFT JOIN operaciones o ON c.id_cliente = o.id_cliente
GROUP BY c.id_cliente, c.antiguedad_meses, c.abandono
ORDER BY c.id_cliente;
-- validación: número de filas (deben ser 30) e id_cliente distintos (sin duplicados)
SELECT COUNT(*) AS filas, COUNT(DISTINCT id_cliente) AS clientes_distintos
FROM (
  SELECT c.id_cliente
  FROM clientes c
  LEFT JOIN operaciones o ON c.id_cliente = o.id_cliente
  GROUP BY c.id_cliente
) AS dataset;
