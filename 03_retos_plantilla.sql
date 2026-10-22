-- MISIÓN 3 · COMPLETA Y COMENTA LAS CONSULTAS
USE ai_customer;
-- RETO 1: muestra las tablas y cuenta sus filas.
SELECT * from information_schema.tables where `TABLE_SCHEMA`='ai_customer';
SELECT COUNT(*) FROM information_schema.tables where `TABLE_SCHEMA`='ai_customer';
-- RETO 2: clientes de Madrid, menos de 6 meses, orden por antigüedad, abandono=1.
SELECT * from clientes where ciudad='Madrid' and  abandono=1 and antiguedad_meses < 6 ORDER BY antiguedad_meses ASC;
-- RETO 3: operaciones con nombre de cliente; clientes sin operaciones;
-- Duda: Son 2 querys aparte o quieres 1.
SELECT o.*, c.nombre FROM operaciones o LEFT JOIN clientes c on o.id_cliente = c.id_cliente;
SELECT c.* FROM clientes c LEFT JOIN operaciones o on c.id_cliente = o.id_cliente WHERE o.id_cliente IS NULL;
-- operaciones > 200; operaciones de un cliente.
SELECT o.*, c.nombre FROM operaciones o LEFT JOIN clientes c on o.id_cliente = c.id_cliente WHERE (SELECT COUNT(*) FROM operaciones WHERE id_cliente = o.id_cliente) > 200;

-- RETO 4: gasto total por cliente; operaciones por canal;
SELECT c.nombre,sum(o.importe)as gasto_total, o.canal FROM clientes c LEFT JOIN operaciones o on c.id_cliente = o.id_cliente group by o.canal,c.nombre;

-- ticket medio; clientes con gasto > 500.
-- Duda: no entiendo lo del ticket medio...
SELECT c.nombre,round( avg(o.importe),2) as ticket_medio from clientes c LEFT JOIN operaciones o on c.id_cliente = o.id_cliente group by c.id_cliente having sum(o.importe) > 500;
-- RETO FINAL: una fila por cliente, con antiguedad_meses,num_operaciones, gasto_total, ticket_medio y abandono.
-- Usa LEFT JOIN y COALESCE.
select c.nombre,c.antiguedad_meses, count(o.id_operacion) as num_operaciones, sum(o.importe) as gasto_total,ROUND(AVG(o.importe), 2) as ticket_medio, c.abandono from clientes c left join operaciones o on c.id_cliente = o.id_cliente group by c.id_cliente;

