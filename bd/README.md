# BDTEC
## Indicaciones
La base de datos es la empleada para el proyecto SII, que está completamente en blanco, a fin de que pueda realizar la migración necesaria.
Se encuentra en PostgreSQL, por lo que se mencionan los pasos a seguir

### Restauración
Ingrese primero al usuario postgres
```
sudo -i -u postgres
```

Posteriormente, ingrese la instrucción correspondiente
```
psql -h localhost -p 5432 -U postgres -f bdtec.sql bdtec
```
El sistema le solicitará la contraseña para el usuario Postgres. Acto seguido, se restaurará lo contenido en el archivo sql hacia la base de datos "bdtec".


## Autores ✒️

* **Ricardo Castro Méndez** - *Trabajo Inicial* - [rcastrom](https://github.com/rcastrom)
* **Julia Chávez Remigio** - *Colaboradora y revisora* - [jchavez](mailto:jchavez@ite.edu.mx)


