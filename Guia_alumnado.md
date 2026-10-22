# MISIÓN 3 — Los datos tienen que vivir en algún sitio: SQL
**Programación y Entornos en IA · Máster en IA · Duración: 4 horas**

## Contexto
Tu equipo desarrolla AI Customer Intelligence. La información de clientes y operaciones se encuentra dispersa. Debes organizarla en una base de datos relacional y extraer variables para un futuro modelo de abandono.

## Preparación
Instala MySQL 8 y un cliente SQL (MySQL Workbench o DBeaver). Conecta a un servidor local con permisos de creación de bases de datos. Descarga los archivos del paquete. Ejecuta primero `01_creacion.sql` y después `02_datos.sql`. La carga inicial contiene 30 clientes y operaciones de ejemplo; algunos clientes no tienen operaciones.

## Reto 1 · 40 minutos
Comprueba la estructura, las claves y los recuentos de filas. Explica por qué la relación clientes→operaciones es 1:N y qué impide la clave foránea.

## Reto 2 · 15 minutos
Escribe consultas para clientes de Madrid, antigüedad inferior a 6 meses, orden descendente de antigüedad y clientes con abandono=1. Documenta las diferencias entre WHERE y ORDER BY.

## Reto 3 · 40 minutos
Muestra operaciones junto con el nombre de su cliente. Identifica clientes sin operaciones con LEFT JOIN. Filtra operaciones de importe superior a 200 y las de un cliente concreto. Explica INNER JOIN frente a LEFT JOIN.

## Reto 4 · 35 minutos
Calcula gasto total por cliente, operaciones por canal, ticket medio y clientes con gasto superior a 500. Explica la diferencia entre WHERE y HAVING.

## Reto final · 30 minutos
Genera una fila por cliente con `id_cliente`, `antiguedad_meses`, `num_operaciones`, `gasto_total`, `ticket_medio` y `abandono`. Incluye clientes sin operaciones y sustituye los agregados nulos por cero. Comprueba el número de filas y la ausencia de duplicados.

## Entrega
Repositorio GitHub con scripts `01_creacion.sql`, `02_datos.sql`, `03_retos.sql`, `04_dataset_ia.sql`, `README.md` y un breve informe de resultados (máximo 2 páginas). En el informe explica las decisiones de modelado, los JOIN, las agregaciones y las validaciones.

## IA generativa
Se permite como asistente de depuración, pero debes explicar cada consulta y demostrar su ejecución. Se valorará la interpretación de resultados, no solo obtener código.

## Puente a la Misión 4
Conectar Python a MySQL, ejecutar la consulta de features y cargar el resultado en un DataFrame de pandas.
