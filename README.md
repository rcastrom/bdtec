# BDTEC
## Objetivos
* Contar con una plataforma desarrollada por los Institutos Tecnológicos, gratuita, que pueda ser actualizada y adecuada por cada plantel, así como 
ser robustecida por las contribuciones que otros planteles puedan aportar, desarrollar, proveer.
* Emplear tecnología que permita adecuarse a los tiempos tanto actuales así como futuros.
* Ser una nueva versión del Sistema Integral de Información (SII), por lo que sería un sistema modular.

Para realizar la migración, se supondrá que la base de datos originalmente está _Sybase_ y se expondrá mediante un Wiki el como realizar la migración 
desde dicho manejador hacia _PostgreSQL_; si bien, dado que es la base de datos que se recomienda, debido a que el proyecto está totalmente está 
desarrollado en PDO, podrá llevar a cabo la migración hacia otro tipo de manejador que considere.

El CSS es responsivo, y fue descargado de una página web como template gratuito en Bootstrap; si el Tecnológico desea emplear otro template o deciden aportar
temas, serán bienvenidas las aportaciones correspondientes.

## Comenzando
Debido a que el desarrollo fué realizado en el Instituto Tecnológico de Ensenada (ITE), el schema empleado no es el usual (public) sino _ITE_; si usted desea
cambiar el nombre del schema, tendrá que actualizar los procedimientos almacenados para renombrarlos.

Encontrará las siguientes carpetas:
* Tablas.- Se enlistan por separados, todas las tablas que se emplean en el proyecto.
* Procedimientos.- Los procedimientos almacenados que se han empleado y se requieren para el proyecto.
* Trigger.- Las acciones al momento de realizar ingresos hacia las tablas.

## Autores ✒️

* **Ricardo Castro Méndez** - *Trabajo Inicial* - [rcastrom](https://github.com/rcastrom)
* **Julia Chávez Remigio** - *Colaboradora y revisora* - [jchavez](mailto:jchavez@ite.edu.mx)


