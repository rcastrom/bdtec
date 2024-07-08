# BDTEC
## Objetivos
* Contar con una plataforma desarrollada por los Institutos Tecnológicos, gratuita, que pueda ser actualizada y adecuada por cada plantel, así como 
ser robustecida por las contribuciones que otros planteles puedan aportar, desarrollar, proveer.
* Emplear tecnología que permita adecuarse a los tiempos tanto actuales así como futuros.
* Ser una nueva versión del Sistema Integral de Información (SII); por lo que sería un sistema modular.

Para realizar la migración, se supondrá que la base de datos se encuentra en _Sybase_ y se detallará mediante un [Wiki](#wiki) los pasos necesarios para 
realizar la migración desde dicho manejador hacia _PostgreSQL_; si bien es la base de datos que se recomienda, debido a que el proyecto está totalmente está 
desarrollado en PDO, podrá llevar a cabo la migración hacia otro tipo de manejador que considere.
En caso que usted con SIE, también es posible llevar a cabo la migración correspondiente. [SIE](#sie)

## Base de datos
En éste proyecto, se incluye una base de datos lista para ser usada en _PostgreSQL_; si bien la mayoría de las tablas estarán en blance, existen algunas que ya contendrán información, siendo éstas:
* Actividades_apoyo. 
* Apoyo_docencia.
* Categorías.
* Entidades_federativas. 
* Estatus_alumno.
* Evaluación_aspectos.
* Motivos. (En realidad, debería llamarse movimiento).
* Municipios (Extraido hasta el año 2022).
* Nivel_escolar.
* Organigrama.
* Personal_nombramientos. 
* Preguntas.
* Puestos. 
* Tipos de ingreso.

Toda ésta información fue extraída de la base de datos de SII; y puesto que son comunes para los tecnológicos, por eso se integran como información ya pre establecida.

### Importante
Debido a que el desarrollo fué realizado en el Instituto Tecnológico de Ensenada (ITE), el schema empleado no es el usual (public) sino _ITE_; por lo que si 
llega a cambiar el nombre del schema, deberá de actualizar los procedimientos almacenados (funciones en el caso de Postgre).


## Contenido
Encontrará las siguientes carpetas:
* Tablas.- Se enlistan por separados todas las tablas que se emplean en el proyecto. Adicionalmente, se anexa el esquema gráfico de las tablas (así como sus relaciones) en el archivo comprimido .tar.gz
* Procedimientos.- Los procedimientos almacenados que se han empleado y se requieren para el proyecto.
* Trigger.- Las acciones al momento de realizar ingresos hacia las tablas.

## Wiki
Para mayor información respecto al proceso de migración, puede consultar la [Wiki](https://github.com/rcastrom/bdtec/wiki/Migrar) del proyecto

## SIE
En caso de que en su tecnológico estén empleando a SIE, también es posible llevar a cabo la migración correspondiente

## Autores ✒️

* **Ricardo Castro Méndez** - *Trabajo Inicial* - [rcastrom](https://github.com/rcastrom)
* **Julia Chávez Remigio** - *Colaboradora y revisora* - [jchavez](mailto:jchavez@ite.edu.mx)


