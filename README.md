# BDTEC
## Objetivos
* Contar con una plataforma desarrollada por los Institutos Tecnológicos, gratuita, que pueda ser actualizada y adecuada por cada plantel, así como 
ser robustecida por las contribuciones que otros planteles puedan aportar, desarrollar, proveer.
* Emplear tecnología que permita adecuarse a los tiempos tanto actuales así como futuros.
* Ser una nueva versión del Sistema Integral de Información (SII), por lo que sería un sistema modular.

Para realizar la migración, se supondrá que la base de datos se encuentra en _Sybase_ y se detallará mediante un [Wiki](#wiki) los pasos necesarios para 
realizar la migración desde dicho manejador hacia _PostgreSQL_; si bien es la base de datos que se recomienda, debido a que el proyecto está totalmente está 
desarrollado en PDO, podrá llevar a cabo la migración hacia otro tipo de manejador que considere.

El CSS es responsivo, y fue descargado de una página web como template gratuito en Bootstrap; por lo que si un Tecnológico desea emplear otro template o 
deciden aportar temas, serán bienvenidas las aportaciones correspondientes.

## Comenzando
Debido a que el desarrollo fué realizado en el Instituto Tecnológico de Ensenada (ITE), el schema empleado no es el usual (public) sino _ITE_; por lo que si 
llega a cambiar el nombre del schema, deberá de actualizar los procedimientos almacenados (funciones en el caso de Postgre).

Encontrará las siguientes carpetas:
* Tablas.- Se enlistan por separados todas las tablas que se emplean en el proyecto. Adicionalmente, se anexa el esquema gráfico de las tablas (así como sus relaciones) en el archivo comprimido .7z
* Procedimientos.- Los procedimientos almacenados que se han empleado y se requieren para el proyecto.
* Trigger.- Las acciones al momento de realizar ingresos hacia las tablas.

## Wiki
Para mayor información respecto al proceso de migración, puede consultar la [Wiki](https://github.com/rcastrom/bdtec/wiki/Migrar) del proyecto

## Autores ✒️

* **Ricardo Castro Méndez** - *Trabajo Inicial* - [rcastrom](https://github.com/rcastrom)
* **Julia Chávez Remigio** - *Colaboradora y revisora* - [jchavez](mailto:jchavez@ite.edu.mx)


