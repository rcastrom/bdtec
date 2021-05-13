PGDMP                         y           sii     13.3 (Ubuntu 13.3-1.pgdg16.04+1)     13.3 (Ubuntu 13.3-1.pgdg16.04+1) *   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17209    sii    DATABASE     X   CREATE DATABASE sii WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'es_MX.UTF-8';
    DROP DATABASE sii;
                postgres    false            �           0    0    DATABASE sii    ACL     .   GRANT TEMPORARY ON DATABASE sii TO amaterasu;
                   postgres    false    3464                        2615    16387    ITE    SCHEMA        CREATE SCHEMA "ITE";
    DROP SCHEMA "ITE";
             	   amaterasu    false            �           1247    16389    T_apellidos_persona    DOMAIN     D   CREATE DOMAIN "ITE"."T_apellidos_persona" AS character varying(55);
 )   DROP DOMAIN "ITE"."T_apellidos_persona";
       ITE       	   amaterasu    false    6            �           1247    16391    T_calificacion    DOMAIN     2   CREATE DOMAIN "ITE"."T_calificacion" AS smallint;
 $   DROP DOMAIN "ITE"."T_calificacion";
       ITE       	   amaterasu    false    6            �           1247    16393 	   T_carrera    DOMAIN     1   CREATE DOMAIN "ITE"."T_carrera" AS character(3);
    DROP DOMAIN "ITE"."T_carrera";
       ITE       	   amaterasu    false    6            �           1247    16395    T_ciudad    DOMAIN     :   CREATE DOMAIN "ITE"."T_ciudad" AS character varying(100);
    DROP DOMAIN "ITE"."T_ciudad";
       ITE       	   amaterasu    false    6            �           1247    16397 
   T_creditos    DOMAIN     .   CREATE DOMAIN "ITE"."T_creditos" AS smallint;
     DROP DOMAIN "ITE"."T_creditos";
       ITE       	   amaterasu    false    6            �           1247    16399    T_curp    DOMAIN     7   CREATE DOMAIN "ITE"."T_curp" AS character varying(18);
    DROP DOMAIN "ITE"."T_curp";
       ITE       	   amaterasu    false    6            �           1247    16401    T_especialidad    DOMAIN     >   CREATE DOMAIN "ITE"."T_especialidad" AS character varying(5);
 $   DROP DOMAIN "ITE"."T_especialidad";
       ITE       	   amaterasu    false    6            �           1247    16403    T_estado_civil    DOMAIN     6   CREATE DOMAIN "ITE"."T_estado_civil" AS character(1);
 $   DROP DOMAIN "ITE"."T_estado_civil";
       ITE       	   amaterasu    false    6            �           1247    16405    T_fecha    DOMAIN     '   CREATE DOMAIN "ITE"."T_fecha" AS date;
    DROP DOMAIN "ITE"."T_fecha";
       ITE       	   amaterasu    false    6            �           1247    16407    T_folio_acta    DOMAIN     5   CREATE DOMAIN "ITE"."T_folio_acta" AS character(12);
 "   DROP DOMAIN "ITE"."T_folio_acta";
       ITE       	   amaterasu    false    6            �           1247    16409    T_lugar_nac    DOMAIN     3   CREATE DOMAIN "ITE"."T_lugar_nac" AS character(2);
 !   DROP DOMAIN "ITE"."T_lugar_nac";
       ITE       	   amaterasu    false    6            �           1247    16411 	   T_materia    DOMAIN     9   CREATE DOMAIN "ITE"."T_materia" AS character varying(7);
    DROP DOMAIN "ITE"."T_materia";
       ITE       	   amaterasu    false    6            �           1247    16413    T_no_de_control    DOMAIN     I   CREATE DOMAIN "ITE"."T_no_de_control" AS character varying(10) NOT NULL;
 %   DROP DOMAIN "ITE"."T_no_de_control";
       ITE       	   amaterasu    false    6            �           1247    16415 	   T_periodo    DOMAIN     9   CREATE DOMAIN "ITE"."T_periodo" AS character varying(5);
    DROP DOMAIN "ITE"."T_periodo";
       ITE       	   amaterasu    false    6            �           1247    16417 
   T_promedio    DOMAIN     2   CREATE DOMAIN "ITE"."T_promedio" AS numeric(5,2);
     DROP DOMAIN "ITE"."T_promedio";
       ITE       	   amaterasu    false    6            �           1247    16419 
   T_reticula    DOMAIN     .   CREATE DOMAIN "ITE"."T_reticula" AS smallint;
     DROP DOMAIN "ITE"."T_reticula";
       ITE       	   amaterasu    false    6            �           1247    16421    T_sexo    DOMAIN     7   CREATE DOMAIN "ITE"."T_sexo" AS character(1) NOT NULL;
    DROP DOMAIN "ITE"."T_sexo";
       ITE       	   amaterasu    false    6                       1255    16422    alta_horario()    FUNCTION     r
  CREATE FUNCTION "ITE".alta_horario() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
vexcesohoras char(13);
vcount int; 
vcount1 int; 
vcount2 int; 
vparalelo char(20) := null;
BEGIN
	IF NEW.dia_semana =1 THEN 
	vexcesohoras := 'domingo'; 
        ELSIF NEW.dia_semana = 2 THEN
	vexcesohoras := 'lunes'; 
        ELSIF NEW.dia_semana = 3 THEN
	vexcesohoras := 'martes';
        ELSIF NEW.dia_semana = 4 THEN
	vexcesohoras := 'miercoles';
        ELSIF NEW.dia_semana = 5 THEN
	vexcesohoras := 'jueves';
        ELSIF NEW.dia_semana = 6 THEN
	vexcesohoras := 'viernes';
        ELSE 
	vexcesohoras := 'sabado';
	END IF;   
	IF NEW.tipo_horario='D' THEN
      	SELECT paralelo_de FROM "ITE".grupos WHERE periodo=NEW.periodo and materia=NEW.materia AND grupo=NEW.grupo INTO vparalelo;
	END IF;	
	IF vparalelo IS NULL THEN
		SELECT count(*) from "ITE".horarios where periodo=NEW.periodo AND rfc=NEW.rfc AND (NEW.rfc is not null or NEW.rfc<>'') and dia_semana=NEW.dia_semana 
		and ( hora_inicial=NEW.hora_inicial  or ( hora_inicial < NEW.hora_inicial and NEW.hora_inicial<hora_final )  
		or ( hora_inicial < NEW.hora_final and NEW.hora_final<hora_final )  
		or ( NEW.hora_inicial<hora_inicial and hora_inicial<NEW.hora_final ) 
		or ( hora_inicial > NEW.hora_inicial and hora_final<NEW.hora_final )                
      		and (vigencia_inicio=NEW.vigencia_inicio OR NEW.vigencia_inicio IS NULL)) INTO vcount;
		IF vcount > 0 THEN
			RAISE EXCEPTION 'Error esta persona ya tiene ocupada la hora indicada el día %', vexcesohoras;
		END IF;
		IF NEW.tipo_horario='D' THEN
			select count(*) from "ITE".grupos where paralelo_de=CONCAT(NEW.materia,NEW.grupo) and periodo = NEW.periodo INTO vcount1;
			 select count(*) from "ITE".horarios where periodo=NEW.periodo and aula=NEW.aula and aula<>'no' 
			 and aula in (select a.aula from aulas a where permite_cruce='N') 
			 and dia_semana=NEW.dia_semana         
				and ( hora_inicial=NEW.hora_inicial  or                                         
					( (hora_inicial < NEW.hora_inicial) and (NEW.hora_inicial<hora_final) )  or    
					( (hora_inicial < NEW.hora_final) and (NEW.hora_final<hora_final) )  or                                        
					( (NEW.hora_inicial<hora_inicial) and (hora_inicial<NEW.hora_final)) or                                        
					( (hora_inicial > NEW.hora_inicial) and (hora_final<NEW.hora_final))                                        
				) into vcount2;
			IF (vcount1 = 0 and vcount2 > 1) THEN      
				RAISE EXCEPTION 'Error, el aula indicada ya está ocupada en este horario el día %', vexcesohoras;
			END IF;
		END IF;
		RETURN NEW;
	ELSE
		RETURN NEW;
	END IF;
END
$$;
 $   DROP FUNCTION "ITE".alta_horario();
       ITE       	   amaterasu    false    6                       1255    16423 4   calificaciones(character varying, character varying)    FUNCTION     "  CREATE FUNCTION "ITE".calificaciones(periodo_checar character varying, control character varying, OUT mater "ITE"."T_materia", OUT nombre character varying, OUT cal smallint, OUT tipo character, OUT descripcion character varying, OUT credit smallint) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
DECLARE 
reg RECORD;
BEGIN
	FOR reg IN SELECT HA.materia,nombre_completo_materia, calificacion,HA.tipo_evaluacion, 
descripcion_evaluacion,creditos_materia
FROM 
historia_alumno HA, alumnos A, materias_carreras MC, materias M,tipos_evaluacion TE
WHERE 
HA.no_de_control=control AND HA.no_de_control=A.no_de_control
AND A.carrera=MC.carrera
AND A.reticula=MC.reticula
AND MC.materia=M.materia
AND HA.materia=MC.materia
AND HA.tipo_evaluacion=TE.tipo_evaluacion
AND A.plan_de_estudios=TE.plan_de_estudios
AND HA.periodo=periodo_checar LOOP
mater:=reg.materia;
nombre:=reg.nombre_completo_materia;
cal:=reg.calificacion;
tipo:=reg.tipo_evaluacion;
descripcion:=reg.descripcion_evaluacion;
credit:=reg.creditos_materia;
RETURN NEXT;
END LOOP;
RETURN;
END
$$;
 �   DROP FUNCTION "ITE".calificaciones(periodo_checar character varying, control character varying, OUT mater "ITE"."T_materia", OUT nombre character varying, OUT cal smallint, OUT tipo character, OUT descripcion character varying, OUT credit smallint);
       ITE       	   amaterasu    false    6    746                       1255    16424    cmaterias(character varying)    FUNCTION       CREATE FUNCTION "ITE".cmaterias(control character varying, OUT cve_mat character varying, OUT nmat character varying) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
DECLARE 
reg RECORD;
BEGIN
	FOR reg IN SELECT M.materia,nombre_completo_materia
FROM 
	alumnos A, materias_carreras MC, materias M
WHERE 
A.no_de_control=control
AND A.carrera=MC.carrera
AND A.reticula=MC.reticula
AND MC.materia=M.materia
ORDER BY nombre_completo_materia
LOOP
cve_mat:=reg.materia;
nmat:=reg.nombre_completo_materia;
RETURN NEXT;
END LOOP;
RETURN;
END
$$;
 u   DROP FUNCTION "ITE".cmaterias(control character varying, OUT cve_mat character varying, OUT nmat character varying);
       ITE       	   amaterasu    false    6                       1255    16425 b   cruce_horario(character varying, character varying, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION "ITE".cruce_horario(peri character varying, mat character varying, gpo character varying, doc character varying, dia integer, OUT cruce integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
hora_inicio time without time zone;
hora_fin time without time zone;
BEGIN
select hora_inicial from horarios where periodo = peri 
and materia = mat and grupo=gpo and dia_semana = dia into hora_inicio;
select hora_final from horarios where periodo = peri 
and materia = mat and grupo=gpo and dia_semana = dia into hora_fin;
select count(*) from horarios where periodo = peri    
and rfc = doc and (rfc is not null or rfc<>'') and dia_semana = dia
and (hora_inicial=hora_inicio  
or ((hora_inicial < hora_inicio) and (hora_inicio < hora_final))  
or ((hora_inicial < hora_fin) and (hora_fin < hora_final) ) 
or ((hora_inicio < hora_inicial) and (hora_inicial < hora_fin)) 
or ((hora_inicial > hora_inicio) and (hora_final < hora_fin))) into cruce;
END
$$;
 �   DROP FUNCTION "ITE".cruce_horario(peri character varying, mat character varying, gpo character varying, doc character varying, dia integer, OUT cruce integer);
       ITE       	   amaterasu    false    6                       1255    16426 8   evl_omitir_mat_alu(character varying, character varying)    FUNCTION     �  CREATE FUNCTION "ITE".evl_omitir_mat_alu(peri character varying, control character varying) RETURNS TABLE(materia "ITE"."T_materia", grupo character)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY SELECT DISTINCT(SM.materia),SM.grupo 
	from "ITE".seleccion_materias SM, "ITE".alumnos A,
	"ITE".materias_carreras MC,"ITE".materias M 
	WHERE SM.no_de_control=control and SM.periodo=peri 
	and SM.no_de_control=A.no_de_control 
	AND A.carrera=MC.carrera AND A.reticula=MC.reticula 
	AND SM.materia=MC.materia AND M.materia=SM.materia 
	AND M.nombre_abreviado_materia NOT LIKE 'RESIDENCIA%'
	AND M.materia NOT IN 
	(SELECT EA.materia FROM "ITE".evaluacion_alumnos EA 
	 WHERE EA.no_de_control=control AND EA.periodo=peri);
END
$$;
 [   DROP FUNCTION "ITE".evl_omitir_mat_alu(peri character varying, control character varying);
       ITE       	   amaterasu    false    6    746                       1255    16427 -   horario(character varying, character varying)    FUNCTION     �  CREATE FUNCTION "ITE".horario(control character varying, periodo_checar character varying, OUT mater character varying, OUT gpo character varying, OUT docente character varying, OUT nombre character varying, OUT credit smallint) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
DECLARE 
reg RECORD;
BEGIN
	FOR reg IN SELECT SM.materia,SM.grupo,apellidos_empleado,nombre_empleado,
	nombre_completo_materia,creditos_materia
FROM 
seleccion_materias SM, alumnos A, materias_carreras MC, materias M, grupos G, personal P
WHERE 
SM.no_de_control=control AND SM.no_de_control=A.no_de_control
AND SM.periodo=periodo_checar
AND A.carrera=MC.carrera
AND A.reticula=MC.reticula
AND MC.materia=M.materia
AND SM.materia=MC.materia
AND SM.periodo=G.periodo
AND SM.materia=G.materia
AND SM.grupo=G.grupo
AND G.rfc=P.rfc
 LOOP
mater:=reg.materia;
gpo:=reg.grupo;
docente:=CONCAT(reg.apellidos_empleado,' ',reg.nombre_empleado);
nombre:=reg.nombre_completo_materia;
credit:=reg.creditos_materia;
RETURN NEXT;
END LOOP;
RETURN;
END
$$;
 �   DROP FUNCTION "ITE".horario(control character varying, periodo_checar character varying, OUT mater character varying, OUT gpo character varying, OUT docente character varying, OUT nombre character varying, OUT credit smallint);
       ITE       	   amaterasu    false    6                       1255    16428 #   pac_actas_faltan(character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pac_actas_faltan(peri character varying) RETURNS TABLE(materia "ITE"."T_materia", grupo character, apellidos_empleado character, nombre_empleado character, nombre_abreviado_materia character varying)
    LANGUAGE plpgsql
    AS $$

BEGIN
	  

    RETURN QUERY SELECT DISTINCT(G.materia),G.grupo, P.apellidos_empleado,P.nombre_empleado,M.nombre_abreviado_materia 
FROM "ITE".grupos G, "ITE".horarios H, "ITE".personal P, "ITE".materias M
WHERE G.periodo=peri 
AND G.materia=H.materia AND G.grupo=H.grupo
AND H.periodo=G.periodo AND H.rfc=P.rfc
AND G.materia=M.materia
AND G.entrego=false
ORDER BY apellidos_empleado,nombre_empleado, nombre_abreviado_materia; 
	
	
END

$$;
 >   DROP FUNCTION "ITE".pac_actas_faltan(peri character varying);
       ITE       	   amaterasu    false    746    6                       1255    16429 -   pac_calcula_totales_alumno(character varying)    FUNCTION     G  CREATE FUNCTION "ITE".pac_calcula_totales_alumno(control character varying) RETURNS TABLE(no_de_control "ITE"."T_no_de_control", creditos_totales smallint, clave_oficial character, creditos_aprobados bigint, creditos_aprobados2 bigint, promedio numeric, periodo_final text)
    LANGUAGE plpgsql
    AS $$

BEGIN
	
    RETURN QUERY SELECT A.no_de_control, C.creditos_totales, C.clave_oficial, sum(MC.creditos_materia) as creditos_aprobados,
sum(MC.creditos_materia) as creditos_aprobados2, avg(HA.calificacion)::numeric(10,2) as promedio, max(HA.periodo) as periodo_final  
   from "ITE".historia_alumno HA, "ITE".alumnos A, "ITE".materias_carreras MC, "ITE".carreras C, "ITE".materias M   
  where HA.no_de_control = control   
    and HA.calificacion >= 60   
    and HA.no_de_control = A.no_de_control   
   and A.carrera = C.carrera and A.reticula = C.reticula   
   and HA.materia = M.materia   
   and A.carrera = MC.carrera and A.reticula = MC.reticula and HA.materia = MC.materia   
   and M.tipo_materia <> 4   
  group by A.no_de_control, C.creditos_totales, C.clave_oficial;

END

$$;
 K   DROP FUNCTION "ITE".pac_calcula_totales_alumno(control character varying);
       ITE       	   amaterasu    false    749    6                       1255    16430 ?   pac_calificacion_semestre(character varying, character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pac_calificacion_semestre(control character varying, peri character varying) RETURNS TABLE(materia "ITE"."T_materia", grupo character, nombre_abreviado_materia character varying, creditos_materia smallint, calificacion "ITE"."T_calificacion")
    LANGUAGE plpgsql
    AS $$

BEGIN
	
    RETURN QUERY SELECT DISTINCT(SM.materia),SM.grupo,M.nombre_abreviado_materia, MC.creditos_materia,SM.calificacion
FROM "ITE".seleccion_materias SM, "ITE".materias M, "ITE".materias_carreras MC, "ITE".alumnos A
WHERE A.no_de_control=control 
AND A.no_de_control=SM.no_de_control
AND SM.materia=M.materia
AND MC.materia=M.materia
AND MC.carrera=A.carrera
AND MC.reticula=A.reticula
AND SM.periodo=peri;

END

$$;
 b   DROP FUNCTION "ITE".pac_calificacion_semestre(control character varying, peri character varying);
       ITE       	   amaterasu    false    716    6    746                       1255    16431 8   pac_calificaciones(character varying, character varying)    FUNCTION     7  CREATE FUNCTION "ITE".pac_calificaciones(control character varying, peri character varying) RETURNS TABLE(tipo_materia smallint, clave character, nombre_completo_materia character varying, nombre_abreviado_materia character varying, periodo "ITE"."T_periodo", no_de_control "ITE"."T_no_de_control", materia "ITE"."T_materia", grupo character, calificacion "ITE"."T_calificacion", tipo_evaluacion character, fecha_calificacion timestamp without time zone, plan_de_estudios character, estatus_materia character, nopresento character, creditos_materia smallint, descripcion_corta_evaluacion character varying, identificacion_corta character)
    LANGUAGE plpgsql
    AS $$
BEGIN
	CREATE TEMPORARY TABLE histo AS
	SELECT historia_alumno.periodo, historia_alumno.no_de_control, historia_alumno.materia, historia_alumno.grupo, historia_alumno.calificacion, historia_alumno.tipo_evaluacion, historia_alumno.fecha_calificacion, historia_alumno.plan_de_estudios, historia_alumno.estatus_materia, historia_alumno.nopresento,historia_alumno.usuario, historia_alumno.fecha_actualizacion, historia_alumno.periodo_acredita_materia 
	FROM "ITE".historia_alumno WHERE historia_alumno.no_de_control=control;
 
	RETURN QUERY
	SELECT DISTINCT(M.tipo_materia), MC.clave_oficial_materia as clave, M.nombre_completo_materia, M.nombre_abreviado_materia, H.periodo, H.no_de_control, H.materia, H.grupo, H.calificacion, H.tipo_evaluacion, H.fecha_calificacion as fecha_calificacion, H.plan_de_estudios, H.estatus_materia, H.nopresento, MC.creditos_materia, TE.descripcion_corta_evaluacion, PE.identificacion_corta 
 	FROM histo H, "ITE".materias M, "ITE".materias_carreras MC, "ITE".tipos_evaluacion TE, "ITE".alumnos A, "ITE".periodos_escolares PE 
 where H.no_de_control=control 
 and H.materia=M.materia 
 and H.no_de_control=A.no_de_control 
 and A.carrera=MC.carrera and A.reticula=MC.reticula and H.materia=MC.materia 
 and H.tipo_evaluacion=TE.tipo_evaluacion 
 and A.plan_de_estudios=TE.plan_de_estudios 
 and H.periodo=PE.periodo 
 and H.periodo=peri
 ORDER BY periodo, fecha_calificacion;

	DROP TABLE histo;

END
$$;
 [   DROP FUNCTION "ITE".pac_calificaciones(control character varying, peri character varying);
       ITE       	   amaterasu    false    746    6    752    749    716                       1255    16432 &   pac_certificado_cal(character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pac_certificado_cal(control character varying) RETURNS TABLE(nombre_completo_materia character varying, periodo "ITE"."T_periodo", no_de_control "ITE"."T_no_de_control", materia "ITE"."T_materia", grupo character, calificacion "ITE"."T_calificacion", tipo_evaluacion character, fecha_calificacion timestamp without time zone, plan_de_estudios character, estatus_materia character, nopresento character, periodo_acrdita_materia "ITE"."T_periodo", creditos_materia smallint, orden_certificado smallint)
    LANGUAGE plpgsql
    AS $$
BEGIN
	CREATE TEMPORARY TABLE histo AS
	SELECT historia_alumno.periodo, historia_alumno.no_de_control, historia_alumno.materia, historia_alumno.grupo, historia_alumno.calificacion, historia_alumno.tipo_evaluacion, historia_alumno.fecha_calificacion, historia_alumno.plan_de_estudios, historia_alumno.estatus_materia, historia_alumno.nopresento,historia_alumno.usuario, historia_alumno.fecha_actualizacion, historia_alumno.periodo_acredita_materia 
	FROM "ITE".historia_alumno WHERE historia_alumno.no_de_control=control and historia_alumno.calificacion>=60;
 
	RETURN QUERY
	SELECT DISTINCT(M.nombre_completo_materia),H.periodo, H.no_de_control, M.materia, H.grupo, H.calificacion, H.tipo_evaluacion, H.fecha_calificacion as fecha_calificacion, H.plan_de_estudios, H.estatus_materia, H.nopresento, H.periodo_acredita_materia ,MC.creditos_materia, MC.orden_certificado
 	FROM histo H, "ITE".materias M, "ITE".materias_carreras MC, "ITE".alumnos A
 where H.no_de_control=A.no_de_control 
 and A.carrera=MC.carrera and A.reticula=MC.reticula and H.materia=MC.materia 
 and H.materia=M.materia
 and MC.creditos_materia>0
 ORDER BY M.nombre_completo_materia, MC.orden_certificado, M.materia;

	DROP TABLE histo;

END
$$;
 D   DROP FUNCTION "ITE".pac_certificado_cal(control character varying);
       ITE       	   amaterasu    false    749    746    716    6    752    752                       1255    16433 "   pac_constancias(character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pac_constancias(control character varying) RETURNS TABLE(periodo "ITE"."T_periodo", materia "ITE"."T_materia", n_materia character varying, n_materia_r character varying, calificacion "ITE"."T_calificacion", tipo_evaluacion character, creditos integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
carre character varying;
reti smallint;
rec record;

BEGIN
	SELECT carrera FROM "ITE".alumnos WHERE no_de_control=control into carre;
	SELECT reticula FROM "ITE".alumnos WHERE no_de_control=control into reti;

	CREATE TEMP TABLE IF NOT EXISTS materias_alumno AS
	select h.periodo, h.materia, m.nombre_completo_materia as n_materia, m.nombre_abreviado_materia as n_materia_r, h.calificacion, h.tipo_evaluacion, 0 as creditos, 0 as orden_certificado
    FROM "ITE".historia_alumno h
	LEFT JOIN "ITE".materias m
	ON (h.materia =m.materia)
    WHERE h.no_de_control=control and h.calificacion!=0;
	
    FOR rec IN SELECT mc.materia,mc.creditos_materia,mc.orden_certificado FROM "ITE".materias_carreras mc WHERE mc.carrera = carre and mc.reticula = reti	
    LOOP
        UPDATE materias_alumno
        SET creditos = rec.creditos_materia, orden_certificado = rec.orden_certificado
        WHERE materias_alumno.materia=rec.materia;
    END LOOP;

    RETURN QUERY SELECT ma.periodo, ma.materia, ma.n_materia, ma.n_materia_r, ma.calificacion, ma.tipo_evaluacion, ma.creditos
	FROM materias_alumno ma
    ORDER by periodo;

	DROP TABLE materias_alumno; 
END

$$;
 @   DROP FUNCTION "ITE".pac_constancias(control character varying);
       ITE       	   amaterasu    false    716    6    752    746                       1255    16434 )   pac_constancias_kardex(character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pac_constancias_kardex(control character varying) RETURNS TABLE(periodo "ITE"."T_periodo", materia "ITE"."T_materia", n_materia character varying, n_materia_r character varying, calificacion "ITE"."T_calificacion", tipo_evaluacion character, creditos integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
carre character varying;
reti smallint;
rec record;

BEGIN
	SELECT carrera FROM "ITE".alumnos WHERE no_de_control=control into carre;
	SELECT reticula FROM "ITE".alumnos WHERE no_de_control=control into reti;

	CREATE TEMP TABLE IF NOT EXISTS materias_alumno AS
	select h.periodo, h.materia, m.nombre_completo_materia as n_materia, m.nombre_abreviado_materia as n_materia_r, h.calificacion, h.tipo_evaluacion, 0 as creditos, 0 as orden_certificado
    FROM "ITE".historia_alumno h
	LEFT JOIN "ITE".materias m
	ON (h.materia =m.materia)
    WHERE h.no_de_control=control;
	
    FOR rec IN SELECT mc.materia,mc.creditos_materia,mc.orden_certificado FROM "ITE".materias_carreras mc WHERE mc.carrera = carre and mc.reticula = reti	
    LOOP
        UPDATE materias_alumno
        SET creditos = rec.creditos_materia, orden_certificado = rec.orden_certificado
        WHERE materias_alumno.materia=rec.materia;
    END LOOP;

    RETURN QUERY SELECT ma.periodo, ma.materia, ma.n_materia, ma.n_materia_r, ma.calificacion, ma.tipo_evaluacion, ma.creditos
	FROM materias_alumno ma
    ORDER by periodo;

	DROP TABLE materias_alumno; 
END

$$;
 G   DROP FUNCTION "ITE".pac_constancias_kardex(control character varying);
       ITE       	   amaterasu    false    716    746    6    752                       1255    16435 6   pac_cresidencias("ITE"."T_periodo", character varying)    FUNCTION       CREATE FUNCTION "ITE".pac_cresidencias(per "ITE"."T_periodo", quien character varying, OUT cantidad integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
select count(*) from "ITE".seleccion_materias, "ITE".materias, "ITE".grupos
	WHERE nombre_abreviado_materia LIKE 'RESIDENCIA%' 
	AND materias.materia=grupos.materia
	AND grupos.periodo=per
	AND seleccion_materias.periodo=grupos.periodo
	AND seleccion_materias.materia=grupos.materia
	AND seleccion_materias.grupo=grupos.grupo
	AND grupos.rfc=quien into cantidad;
END
$$;
 l   DROP FUNCTION "ITE".pac_cresidencias(per "ITE"."T_periodo", quien character varying, OUT cantidad integer);
       ITE       	   amaterasu    false    752    6                       1255    16436 9   pac_dataresidencias(character varying, character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pac_dataresidencias(peri character varying, quien character varying) RETURNS TABLE(no_de_control "ITE"."T_no_de_control", apellido_paterno "ITE"."T_apellidos_persona", apellido_materno "ITE"."T_apellidos_persona", nombre_alumno character varying, plan_de_estudios character, calificacion "ITE"."T_calificacion", materia "ITE"."T_materia", grupo character)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
    -- Obtener informacion de residencias
	CREATE TEMP TABLE IF NOT EXISTS info_grupos AS 
	SELECT seleccion_materias.no_de_control, alumnos.apellido_paterno, alumnos.apellido_materno, alumnos.nombre_alumno,
    alumnos.plan_de_estudios, seleccion_materias.calificacion, seleccion_materias.materia, seleccion_materias.grupo FROM
    "ITE".seleccion_materias, "ITE".materias, "ITE".grupos, "ITE".alumnos
	WHERE nombre_abreviado_materia LIKE 'RESIDENCIA%' 
	AND materias.materia=grupos.materia
	AND grupos.periodo=peri
	AND seleccion_materias.periodo=grupos.periodo
	AND seleccion_materias.materia=grupos.materia
	AND seleccion_materias.grupo=grupos.grupo
	AND grupos.rfc=quien
	AND seleccion_materias.no_de_control=alumnos.no_de_control
	ORDER BY apellido_paterno,apellido_materno,nombre_alumno;

    RETURN QUERY SELECT info_grupos.no_de_control, info_grupos.apellido_paterno, info_grupos.apellido_materno, info_grupos.nombre_alumno, info_grupos.plan_de_estudios, info_grupos.calificacion, info_grupos.materia,info_grupos.grupo 
    FROM info_grupos;

	DROP TABLE info_grupos;
	
	
END
$$;
 Z   DROP FUNCTION "ITE".pac_dataresidencias(peri character varying, quien character varying);
       ITE       	   amaterasu    false    716    746    713    713    749    6                       1255    16437 0   pac_edades(character varying, character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pac_edades(peri character varying, genero character varying) RETURNS TABLE(no_de_control "ITE"."T_no_de_control", edad double precision, semestre smallint)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY SELECT distinct(SM.no_de_control), date_part('year',current_date)-date_part('year',fecha_nacimiento) as edad, 
A.semestre FROM "ITE".alumnos A, "ITE".seleccion_materias SM WHERE SM.periodo=peri and sexo=genero 
and SM.no_de_control=A.no_de_control;
END
$$;
 R   DROP FUNCTION "ITE".pac_edades(peri character varying, genero character varying);
       ITE       	   amaterasu    false    6    749                       1255    16438 M   pac_edades_carrera(character varying, character varying, character, smallint)    FUNCTION     0  CREATE FUNCTION "ITE".pac_edades_carrera(peri character varying, genero character varying, carr character, reti smallint) RETURNS TABLE(no_de_control "ITE"."T_no_de_control", edad double precision, semestre smallint)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY SELECT distinct(SM.no_de_control), date_part('year',current_date)-date_part('year',fecha_nacimiento) as edad, 
A.semestre FROM "ITE".alumnos A, "ITE".seleccion_materias SM WHERE SM.periodo=peri and sexo=genero and carrera=carr and reticula=reti 
and SM.no_de_control=A.no_de_control;
END
$$;
 y   DROP FUNCTION "ITE".pac_edades_carrera(peri character varying, genero character varying, carr character, reti smallint);
       ITE       	   amaterasu    false    749    6                       1255    16439 W   pac_edades_estado(character varying, character varying, character, smallint, character)    FUNCTION     Z  CREATE FUNCTION "ITE".pac_edades_estado(peri character varying, genero character varying, carr character, reti smallint, edo character) RETURNS TABLE(no_de_control "ITE"."T_no_de_control", edad double precision, semestre smallint)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY SELECT distinct(SM.no_de_control), date_part('year',current_date)-date_part('year',fecha_nacimiento) as edad, 
A.semestre FROM "ITE".alumnos A, "ITE".seleccion_materias SM WHERE SM.periodo=peri and sexo=genero and carrera=carr and reticula=reti and entidad_procedencia=edo 
and SM.no_de_control=A.no_de_control;
END
$$;
 �   DROP FUNCTION "ITE".pac_edades_estado(peri character varying, genero character varying, carr character, reti smallint, edo character);
       ITE       	   amaterasu    false    6    749                       1255    16440 J   pac_gruposmateria(character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pac_gruposmateria(peri character varying, control character varying, mater character varying) RETURNS TABLE(grupo character, capacidad_grupo smallint, alumnos_inscritos smallint, rfc character, nombre_abreviado_materia character varying, paralelo_de character)
    LANGUAGE plpgsql
    AS $$
DECLARE
carre character varying;
reti smallint;
especiales smallint;
seleccionadas smallint;
ofertadas smallint;
diferencia smallint;

BEGIN
	SELECT carrera FROM "ITE".alumnos WHERE no_de_control=control into carre;
	SELECT reticula FROM "ITE".alumnos WHERE no_de_control=control into reti;
	
    -- Obtener materias en especial acreditadas
	CREATE TEMP TABLE IF NOT EXISTS info_grupos AS 
	SELECT G.grupo, G.capacidad_grupo, G.alumnos_inscritos, G.rfc, M.nombre_abreviado_materia, G.paralelo_de 
    FROM "ITE".grupos G, "ITE".materias M 
    WHERE G.periodo=peri AND G.materia=mater AND M.materia=mater AND exclusivo_carrera=carre AND exclusivo_reticula=reti
    UNION
    SELECT G.grupo, G.capacidad_grupo, G.alumnos_inscritos, G.rfc, M.nombre_abreviado_materia, G.paralelo_de 
    FROM "ITE".grupos G, "ITE".materias M 
    WHERE G.periodo=peri AND G.materia=mater AND M.materia=mater AND G.exclusivo='no';  
  

    RETURN QUERY SELECT info_grupos.grupo, info_grupos.capacidad_grupo, info_grupos.alumnos_inscritos, info_grupos.rfc, info_grupos.nombre_abreviado_materia, info_grupos.paralelo_de 
    FROM info_grupos;

	DROP TABLE info_grupos;
	
	
END
$$;
 s   DROP FUNCTION "ITE".pac_gruposmateria(peri character varying, control character varying, mater character varying);
       ITE       	   amaterasu    false    6                       1255    16441 .   pac_historia_escolar_alumno(character varying)    FUNCTION       CREATE FUNCTION "ITE".pac_historia_escolar_alumno(control character varying) RETURNS TABLE(tipo_materia smallint, clave character, nombre_completo_materia character varying, nombre_abreviado_materia character varying, periodo "ITE"."T_periodo", no_de_control "ITE"."T_no_de_control", materia "ITE"."T_materia", grupo character, calificacion "ITE"."T_calificacion", tipo_evaluacion character, fecha_calificacion timestamp without time zone, plan_de_estudios character, estatus_materia character, nopresento character, creditos_materia smallint, descripcion_corta_evaluacion character varying, identificacion_corta character)
    LANGUAGE plpgsql
    AS $$
BEGIN
	CREATE TEMPORARY TABLE histo AS
	SELECT historia_alumno.periodo, historia_alumno.no_de_control, historia_alumno.materia, historia_alumno.grupo, historia_alumno.calificacion, historia_alumno.tipo_evaluacion, historia_alumno.fecha_calificacion, historia_alumno.plan_de_estudios, historia_alumno.estatus_materia, historia_alumno.nopresento,historia_alumno.usuario, historia_alumno.fecha_actualizacion, historia_alumno.periodo_acredita_materia 
	FROM "ITE".historia_alumno WHERE historia_alumno.no_de_control=control;
 
	RETURN QUERY
	SELECT DISTINCT(M.tipo_materia), MC.clave_oficial_materia as clave, M.nombre_completo_materia, M.nombre_abreviado_materia, H.periodo, H.no_de_control, H.materia, H.grupo, H.calificacion, H.tipo_evaluacion, H.fecha_calificacion as fecha_calificacion, H.plan_de_estudios, H.estatus_materia, H.nopresento, MC.creditos_materia, TE.descripcion_corta_evaluacion, PE.identificacion_corta 
 	FROM histo H, "ITE".materias M, "ITE".materias_carreras MC, "ITE".tipos_evaluacion TE, "ITE".alumnos A, "ITE".periodos_escolares PE 
 where H.no_de_control=control 
 and H.materia=M.materia 
 and H.no_de_control=A.no_de_control 
 and A.carrera=MC.carrera and A.reticula=MC.reticula and H.materia=MC.materia 
 and H.tipo_evaluacion=TE.tipo_evaluacion 
 and A.plan_de_estudios=TE.plan_de_estudios 
 and H.periodo=PE.periodo 
 ORDER BY periodo, fecha_calificacion;

	DROP TABLE histo;

END
$$;
 L   DROP FUNCTION "ITE".pac_historia_escolar_alumno(control character varying);
       ITE       	   amaterasu    false    6    716    746    749    752                        1255    16442 1   pac_horario(character varying, character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pac_horario(control character varying, peri character varying) RETURNS TABLE(mat character varying, nmateria character varying, gpo character, ndocente character varying, creditos smallint)
    LANGUAGE plpgsql
    AS $$
DECLARE
carre character varying;
reti smallint;
nmateria character varying;
nrfc character varying;
nombre_doc character varying;
credi smallint;
rec record;

BEGIN
	SELECT carrera FROM alumnos WHERE no_de_control=control into carre;
	SELECT reticula FROM alumnos WHERE no_de_control=control into reti;
	
    -- Se crea la tabla del horario
	CREATE TEMPORARY TABLE horario(
    mat character varying, 
    nmateria character varying, 
    gpo character(3), 
    ndocente character varying,
    creditos smallint
    );

   --Se leen los datos
    FOR rec IN SELECT materia, grupo FROM seleccion_materias WHERE periodo=peri AND no_de_control=control 
    LOOP
        --Obtener nombre materia
        SELECT materias.nombre_completo_materia FROM materias,materias_carreras WHERE materias_carreras.materia=materias.materia AND materias_carreras.carrera=carre 
        AND materias_carreras.reticula=reti AND materias_carreras.materia=rec.materia INTO nmateria;
        --Obtener nombre docente
        SELECT grupos.rfc FROM grupos WHERE grupos.periodo=peri AND grupos.materia=rec.materia AND grupos.grupo=rec.grupo INTO nrfc;
        IF nrfc IS NULL THEN
            SELECT CONCAT('PENDIENTE',' ','POR ASIGNAR') INTO nombre_doc;
        ELSE
            SELECT CONCAT(personal.apellidos_empleado,' ',personal.nombre_empleado) FROM personal WHERE rfc=nrfc INTO nombre_doc;
        END IF;
        --Creditos
        SELECT materias_carreras.creditos_materia FROM materias_carreras WHERE materias_carreras.materia=rec.materia 
        AND materias_carreras.carrera=carre AND materias_carreras.reticula=reti INTO credi;
        --Almacaner
        INSERT INTO horario(mat,nmateria,gpo,ndocente,creditos) VALUES (rec.materia, nmateria, rec.grupo, nombre_doc, credi);
    END LOOP;
    RETURN QUERY SELECT horario.mat, horario.nmateria, horario.gpo, horario.ndocente, horario.creditos FROM horario;
        

	DROP TABLE horario;		
	
	
END

$$;
 T   DROP FUNCTION "ITE".pac_horario(control character varying, peri character varying);
       ITE       	   amaterasu    false    6            !           1255    16443 +   pac_materias_calificadas(character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pac_materias_calificadas(peri character varying) RETURNS TABLE(materia "ITE"."T_materia", grupo character, apellidos_empleado character, nombre_empleado character, nombre_abreviado_materia character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	  

    RETURN QUERY SELECT DISTINCT(SM.materia),SM.grupo, P.apellidos_empleado,P.nombre_empleado,M.nombre_abreviado_materia 
FROM "ITE".seleccion_materias SM, "ITE".horarios H, "ITE".personal P, "ITE".materias M
WHERE SM.periodo=peri and SM.calificacion IS NOT NULL
AND SM.materia=H.materia AND SM.grupo=H.grupo
AND SM.materia=M.materia
AND H.periodo=SM.periodo AND H.rfc=P.rfc
ORDER BY apellidos_empleado,nombre_empleado, nombre_abreviado_materia; 
	
	
END
$$;
 F   DROP FUNCTION "ITE".pac_materias_calificadas(peri character varying);
       ITE       	   amaterasu    false    6    746            "           1255    16444 &   pac_materias_faltan(character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pac_materias_faltan(peri character varying) RETURNS TABLE(materia "ITE"."T_materia", grupo character, apellidos_empleado character, nombre_empleado character, nombre_abreviado_materia character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	  

    RETURN QUERY SELECT DISTINCT(SM.materia),SM.grupo, P.apellidos_empleado,P.nombre_empleado,M.nombre_abreviado_materia 
FROM "ITE".seleccion_materias SM, "ITE".horarios H, "ITE".personal P, "ITE".materias M
WHERE SM.periodo=peri and SM.calificacion IS NULL
AND SM.materia=H.materia AND SM.grupo=H.grupo
AND SM.materia=M.materia
AND H.periodo=SM.periodo AND H.rfc=P.rfc
ORDER BY apellidos_empleado,nombre_empleado, nombre_abreviado_materia; 
	
	
END
$$;
 A   DROP FUNCTION "ITE".pac_materias_faltan(peri character varying);
       ITE       	   amaterasu    false    6    746            �            1259    16445    periodos_escolares    TABLE     �  CREATE TABLE "ITE".periodos_escolares (
    periodo "ITE"."T_periodo" NOT NULL,
    identificacion_larga character(30) NOT NULL,
    identificacion_corta character(12),
    fecha_inicio date,
    fecha_termino date,
    inicio_vacacional_ss date,
    fin_vacacional_ss date,
    inicio_especial date,
    fin_especial date,
    cierre_horarios character(1),
    cierre_seleccion character(1),
    inicio_sele_alumnos date,
    fin_sele_alumnos date,
    inicio_vacacional date,
    termino_vacacional date,
    inicio_cal_docentes date,
    fin_cal_docentes date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    ccarrera smallint
);
 %   DROP TABLE "ITE".periodos_escolares;
       ITE         heap 	   amaterasu    false    752    6            #           1255    16451    pac_periodo_actual()    FUNCTION     y  CREATE FUNCTION "ITE".pac_periodo_actual() RETURNS SETOF "ITE".periodos_escolares
    LANGUAGE plpgsql
    AS $$
DECLARE
	mes smallint;
	dia smallint;
	anio int;
	perio character(5);
BEGIN
	SELECT date_part('month',now()) into mes; 
	SELECT date_part('day',  now()) into dia;
	SELECT date_part('year', now()) into anio;
	IF mes BETWEEN 2 and 5 THEN
 		SELECT concat(anio,'1') into perio;
	--inicio de agosto-diciembre en el mes de agosto	
	ELSIF (mes=7 or(mes=8 and dia<=15)) THEN -- ESTA ES LA LINEA ORIGINAL: @mes=7 or (@mes=8 and @dia <=3) 
 		SELECT concat(anio,'2') into perio; 
 	ELSE
 		IF mes between 8 and 12 THEN -- ESTA ES LA LINEA ORIGINAL: @mes between 8 and 12 
 			IF mes=12 and dia>=22 THEN --dia de diciembre en que inicia el periodo Enero-Junio
 				SELECT concat(anio+1,'1') into perio; -- tecmina
 			ELSE
 				SELECT concat(anio,'3') into perio; 
			END IF;
 		ELSE 
 			IF mes=1 THEN
			--dia para determinar inicio de periodo1 del mes 01
 				IF dia <=26 THEN
 					SELECT concat(anio-1,'3') into perio;
 				ELSE 
 					SELECT concat(anio,'1') into perio;
				END IF;
 			ELSE
 			--dia para determinar inicio de verano del mes 06
 				IF dia < 27 THEN
 					SELECT concat(anio,'1') into perio;
 				ELSE 
 					SELECT concat(anio,'2') into perio;
				END IF;
			END IF;
		END IF;
	END IF;
	RETURN QUERY SELECT * FROM periodos_escolares WHERE periodo=perio; 
	RETURN;
END;
$$;
 *   DROP FUNCTION "ITE".pac_periodo_actual();
       ITE       	   amaterasu    false    203    6            $           1255    16452     pac_poblacion(character varying)    FUNCTION     `  CREATE FUNCTION "ITE".pac_poblacion(peri character varying) RETURNS TABLE(carrera character varying, reticula smallint, ncarrera character varying, cantidad integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
cantidad int;
rec record;
BEGIN
    
    CREATE TEMPORARY TABLE poblacion(
        carrera character varying, 
        reticula smallint, 
        ncarrera character varying, 
        cantidad int
    );
 
    FOR rec IN
        SELECT carreras.carrera, carreras.reticula, carreras.nombre_carrera FROM carreras
    LOOP
        SELECT COUNT(DISTINCT(SM.no_de_control)) FROM seleccion_materias SM, alumnos A
        WHERE SM.no_de_control=A.no_de_control AND SM.periodo=peri AND A.carrera=rec.carrera
        AND A.reticula=rec.reticula INTO cantidad;
        IF cantidad>0 THEN
            INSERT INTO poblacion(carrera,reticula,ncarrera,cantidad) 
VALUES(rec.carrera, rec.reticula, rec.nombre_carrera, cantidad);

        END IF;
    END LOOP;
 RETURN QUERY select poblacion.carrera, poblacion.reticula, poblacion.ncarrera, poblacion.cantidad FROM poblacion ORDER BY ncarrera ASC;
 DROP TABLE poblacion; 
END

$$;
 ;   DROP FUNCTION "ITE".pac_poblacion(peri character varying);
       ITE       	   amaterasu    false    6            %           1255    16453 %   pac_reticulaalumno(character varying)    FUNCTION       CREATE FUNCTION "ITE".pac_reticulaalumno(control character varying) RETURNS TABLE(materia "ITE"."T_materia", nombre_abreviado_materia character varying, creditos_materia smallint, semestre_reticula smallint, renglon smallint, calificacion "ITE"."T_calificacion", tipo_evaluacion character, tipocur text)
    LANGUAGE plpgsql
    AS $$
DECLARE
carre character varying;
reti smallint;
espe  character varying;
BEGIN
 SELECT carrera FROM alumnos WHERE no_de_control=control into carre;
 SELECT reticula FROM alumnos WHERE no_de_control=control into reti;
 SELECT especialidad FROM alumnos WHERE no_de_control=control into espe;

 CREATE TEMP TABLE IF NOT EXISTS histoalumno AS 
 select historia_alumno.periodo, historia_alumno.materia, historia_alumno.calificacion,
 historia_alumno.tipo_evaluacion, historia_alumno.plan_de_estudios,
 historia_alumno.estatus_materia 
 from historia_alumno 
 where no_de_control=control;
 CREATE TEMP TABLE IF NOT EXISTS hist1 AS 
 select histoalumno.materia, histoalumno.calificacion, histoalumno.tipo_evaluacion, 'AC' as tipocur 
  from histoalumno 
 where histoalumno.calificacion >=60;
 CREATE TEMP TABLE IF NOT EXISTS esperepro AS 
 select histoalumno.materia, histoalumno.calificacion, histoalumno.tipo_evaluacion, 'ER' as tipocur
 from histoalumno 
 where (histoalumno.calificacion < 70 and histoalumno.tipo_evaluacion in ('EE', 'CE')) 
 and histoalumno.materia not in (select hist1.materia from hist1);
 CREATE TEMP TABLE IF NOT EXISTS didacta AS 
 select count(histoalumno.materia) as contador, histoalumno.materia 
 from histoalumno 
 where histoalumno.calificacion <70 group by histoalumno.materia;
 -- Materias cursadas en Segunda Oportunidad y no Acreditadas 
 CREATE TEMP TABLE IF NOT EXISTS hist2 AS 
  select histoalumno.materia, histoalumno.calificacion, histoalumno.tipo_evaluacion, 'AE' as tipocur 
  from histoalumno 
  where (histoalumno.calificacion < 70 and histoalumno.tipo_evaluacion in ('O2', 'R2', 'RO', 'RP', 'R1')) --Agregado Ricardo Castro
  and histoalumno.materia not in (select hist1.materia from hist1) 
  and histoalumno.materia not in (select esperepro.materia from esperepro) or histoalumno.materia in 
 (select histoalumno.materia from histoalumno, didacta 
  where histoalumno.tipo_evaluacion='EA' and histoalumno.materia=didacta.materia 
  and contador>=2) and histoalumno.materia not in (select hist1.materia from hist1);
 CREATE TEMP TABLE IF NOT EXISTS hist3 AS 
 -- Materias cursadas y no Acreditados (En primera o Ex. Especial Autodidacta) y que no tienen segundas 
  select histoalumno.materia, histoalumno.calificacion, histoalumno.tipo_evaluacion, 'CR' as tipocur 
 from histoalumno 
  where (histoalumno.calificacion < 70 and histoalumno.tipo_evaluacion in ('O1', 'R1', 'E1', 'EA', 'OO', 'OC', '1', '2', 'E2', 'OS')) --Agregado Ricardo Castro
  and histoalumno.materia not in (select hist1.materia from hist1) 
  and histoalumno.materia not in (select hist2.materia from hist2) 
  and histoalumno.materia not in (select esperepro.materia from esperepro) -- Agregado por Licette Rueda 
  union 
  -- Materias a Examen Especial Pendientes 
  select hist2.materia, hist2.calificacion, hist2.tipo_evaluacion, hist2.tipocur 
  from hist2 
  union 
 -- Materias en Especiales Reprobados 
  select esperepro.materia, esperepro.calificacion, esperepro.tipo_evaluacion, esperepro.tipocur 
  from esperepro;
 CREATE TEMP TABLE IF NOT EXISTS mathis AS 
 select hist1.materia, hist1.calificacion, hist1.tipo_evaluacion, hist1.tipocur 
 from hist1 
  union 
  select hist3.materia, hist3.calificacion, hist3.tipo_evaluacion, hist3.tipocur 
 from hist3;
 
 CREATE TEMP TABLE IF NOT EXISTS reticalu1 AS
 select MC.materia, M.nombre_abreviado_materia, MC.creditos_materia, 
 MC.semestre_reticula, MC.renglon, MC.especialidad 
  from materias_carreras MC, materias M 
 where MC.carrera=carre and MC.reticula=reti
  and MC.materia=M.materia;
 
 CREATE TEMP TABLE IF NOT EXISTS reticalu AS
 select reticalu1.materia, reticalu1.nombre_abreviado_materia, reticalu1.creditos_materia, 
 reticalu1.semestre_reticula, reticalu1.renglon, mathis.calificacion, mathis.tipo_evaluacion, mathis.tipocur, 
 reticalu1.especialidad, '00' as cur 
  from reticalu1
 LEFT JOIN mathis
 ON (mathis.materia =reticalu1.materia);
 
 update reticalu set tipocur='NA' where reticalu.tipocur is NULL
 and reticalu.semestre_reticula > 9;
 IF espe IS NULL THEN
  CREATE TEMP TABLE IF NOT EXISTS reticula AS
  select reticalu.materia, reticalu.nombre_abreviado_materia, reticalu.creditos_materia, 
  reticalu.semestre_reticula, reticalu.renglon, reticalu.calificacion,
  reticalu.tipo_evaluacion, reticalu.tipocur
   from reticalu 
   where reticalu.especialidad is NULL 
  order by reticalu.materia, reticalu.tipo_evaluacion;
 ELSE
  CREATE TEMP TABLE IF NOT EXISTS reticula2 AS
  select reticalu.materia, reticalu.nombre_abreviado_materia, reticalu.creditos_materia, reticalu.semestre_reticula, reticalu.renglon, reticalu.calificacion,
  reticalu.tipo_evaluacion, reticalu.tipocur
   from reticalu 
   where reticalu.especialidad is NULL 
   union 
   select reticalu.materia, reticalu.nombre_abreviado_materia, reticalu.creditos_materia, reticalu.semestre_reticula, reticalu.renglon, reticalu.calificacion,
  reticalu.tipo_evaluacion, reticalu.tipocur 
   from reticalu 
   where reticalu.especialidad in (espe, '');
 END IF;
 IF espe IS NULL THEN
  RETURN QUERY select reticula.materia, reticula.nombre_abreviado_materia, reticula.creditos_materia, reticula.semestre_reticula, reticula.renglon, reticula.calificacion,
  reticula.tipo_evaluacion, reticula.tipocur 
  from reticula 
  order by materia, tipocur;
 ELSE
  RETURN QUERY select reticula2.materia, reticula2.nombre_abreviado_materia, reticula2.creditos_materia, reticula2.semestre_reticula, reticula2.renglon, reticula2.calificacion,
  reticula2.tipo_evaluacion, reticula2.tipocur
  from reticula2 
  order by materia, tipocur;
 END IF;
 DROP TABLE histoalumno;
 DROP TABLE hist1;  
 DROP TABLE esperepro;
 DROP TABLE didacta;
 DROP TABLE hist2;
 DROP TABLE hist3;
 DROP TABLE mathis;
 DROP TABLE reticalu1;
 DROP TABLE reticalu;
 DROP TABLE reticula2; 
END

$$;
 C   DROP FUNCTION "ITE".pac_reticulaalumno(control character varying);
       ITE       	   amaterasu    false    716    746    6            &           1255    16454 ;   pac_verifica_especial(character varying, character varying)    FUNCTION     u
  CREATE FUNCTION "ITE".pac_verifica_especial(control character varying, peri character varying) RETURNS TABLE(adeudo smallint, seleccionadas smallint, pendientes smallint, ofertados smallint)
    LANGUAGE plpgsql
    AS $$
DECLARE
carre character varying;
reti smallint;
especiales smallint;
seleccionadas smallint;
ofertadas smallint;
diferencia smallint;


BEGIN
	SELECT carrera FROM alumnos WHERE no_de_control=control into carre;
	SELECT reticula FROM alumnos WHERE no_de_control=control into reti;
	
    -- Obtener materias en especial acreditadas
	CREATE TEMP TABLE IF NOT EXISTS especiales_acreditadas AS 
	select historia_alumno.materia
	from historia_alumno 
	where historia_alumno.no_de_control=control and historia_alumno.tipo_evaluacion='CE' and calificacion>=70;

    -- Obtengo las materias en especial
	CREATE TEMP TABLE IF NOT EXISTS adeudo_especial AS 
	select historia_alumno.materia
 	from historia_alumno 
	where historia_alumno.no_de_control=control and historia_alumno.tipo_evaluacion IN ('RO','RP','R1','R2') and historia_alumno.calificacion<70 
    AND historia_alumno.materia NOT IN (SELECT materia FROM especiales_acreditadas);

    -- Obtengo las materias en especial que ya fueron seleccionadas
	CREATE TEMP TABLE IF NOT EXISTS materias_seleccionadas AS 
	select seleccion_materias.materia
	from seleccion_materias
	where seleccion_materias.no_de_control = control AND seleccion_materias.periodo=peri AND seleccion_materias.tipo_evaluacion IN ('RO','RP','R1','R2') AND seleccion_materias.calificacion < 70 
    AND seleccion_materias.materia NOT IN (SELECT materia FROM adeudo_especial);

    CREATE TEMP TABLE IF NOT EXISTS materias_ofertadas AS 
	select distinct(grupos.materia)
	from grupos
	where grupos.periodo = peri AND grupos.exclusivo_carrera = carre AND grupos.exclusivo_reticula = reti 
    AND grupos.materia IN (SELECT materia FROM adeudo_especial);

    CREATE TEMPORARY TABLE resultados(adeudo smallint, seleccionadas smallint, pendientes smallint, ofertados smallint);

    SELECT COUNT(*) FROM adeudo_especial INTO especiales;
    SELECT COUNT(*) FROM materias_seleccionadas INTO seleccionadas;
    SELECT COUNT(*) FROM materias_ofertadas INTO ofertadas;
    diferencia := especiales - seleccionadas;
	
    INSERT INTO resultados(adeudo,seleccionadas,pendientes,ofertados) VALUES (especiales,seleccionadas, diferencia, ofertadas);

    RETURN QUERY SELECT resultados.adeudo,resultados.seleccionadas,resultados.pendientes,resultados.ofertados FROM resultados;

	DROP TABLE especiales_acreditadas;
	DROP TABLE adeudo_especial;		
	DROP TABLE materias_seleccionadas;
	DROP TABLE materias_ofertadas;
    DROP TABLE resultados;
	
END

$$;
 ^   DROP FUNCTION "ITE".pac_verifica_especial(control character varying, peri character varying);
       ITE       	   amaterasu    false    6            '           1255    16455 9   pac_verifica_repite(character varying, character varying)    FUNCTION     d  CREATE FUNCTION "ITE".pac_verifica_repite(control character varying, peri character varying) RETURNS TABLE(adeudo smallint, seleccionadas smallint, pendientes smallint, ofertados smallint)
    LANGUAGE plpgsql
    AS $$
DECLARE
carre character varying;
reti smallint;
repite smallint;
seleccionadas smallint;
ofertadas smallint;
diferencia smallint;


BEGIN
	SELECT carrera FROM alumnos WHERE no_de_control=control into carre;
	SELECT reticula FROM alumnos WHERE no_de_control=control into reti;
	
    -- Obtener materias en repetición acreditadas
	CREATE TEMP TABLE IF NOT EXISTS repites_acreditadas AS 
	select historia_alumno.materia
	from historia_alumno 
	where historia_alumno.no_de_control=control and historia_alumno.tipo_evaluacion IN('CE','RO','RP','R1','R2') and calificacion>=70;

    -- Obtengo las materias en especial
	CREATE TEMP TABLE IF NOT EXISTS especiales AS 
	select historia_alumno.materia
 	from historia_alumno 
	where historia_alumno.no_de_control=control and historia_alumno.tipo_evaluacion IN ('RO','RP','R1','R2') and historia_alumno.calificacion<70 
    AND historia_alumno.materia NOT IN (SELECT materia FROM repites_acreditadas);

    -- Unir informacion
	CREATE TEMP TABLE IF NOT EXISTS union_descartados AS 
	select repites_acreditadas.materia from repites_acreditadas
 	union
    select especiales.materia from especiales;

    -- Obtengo las materias en repeticion
    CREATE TEMP TABLE IF NOT EXISTS adeudo_repite AS 
	select historia_alumno.materia
	from historia_alumno
	where historia_alumno.no_de_control=control and historia_alumno.calificacion < 70 
    and historia_alumno.tipo_evaluacion IN ('OC','OO','1','2') AND historia_alumno.materia NOT IN (SELECT materia FROM union_descartados);

    -- Obtengo las materias ya fueron seleccionadas
	CREATE TEMP TABLE IF NOT EXISTS materias_seleccionadas AS 
	select seleccion_materias.materia
	from seleccion_materias
	where seleccion_materias.no_de_control = control AND seleccion_materias.periodo=peri  
    AND seleccion_materias.materia IN (SELECT materia FROM adeudo_repite);

    CREATE TEMP TABLE IF NOT EXISTS materias_ofertadas AS 
	select distinct(grupos.materia)
	from grupos
	where grupos.periodo = peri AND grupos.exclusivo_carrera = carre AND grupos.exclusivo_reticula = reti 
    AND grupos.materia IN (SELECT materia FROM adeudo_repite);

    CREATE TEMPORARY TABLE resultados(adeudo smallint, seleccionadas smallint, pendientes smallint, ofertados smallint);

    SELECT COUNT(*) FROM adeudo_repite INTO repite;
    SELECT COUNT(*) FROM materias_seleccionadas INTO seleccionadas;
    SELECT COUNT(*) FROM materias_ofertadas INTO ofertadas;
    diferencia := repite - seleccionadas;
	
    INSERT INTO resultados(adeudo,seleccionadas,pendientes,ofertados) VALUES (repite, seleccionadas, diferencia, ofertadas);

    RETURN QUERY SELECT resultados.adeudo,resultados.seleccionadas,resultados.pendientes,resultados.ofertados FROM resultados;

	DROP TABLE repites_acreditadas;
	DROP TABLE especiales;		
    DROP TABLE union_descartados;
    DROP TABLE adeudo_repite;
	DROP TABLE materias_seleccionadas;
	DROP TABLE materias_ofertadas;
    DROP TABLE resultados;
	
END

$$;
 \   DROP FUNCTION "ITE".pac_verifica_repite(control character varying, peri character varying);
       ITE       	   amaterasu    false    6            (           1255    16456 >   pap_agrega_calif_a_histo("ITE"."T_periodo", character varying)    FUNCTION       CREATE FUNCTION "ITE".pap_agrega_calif_a_histo(peri "ITE"."T_periodo", usuar character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$
DECLARE
fecha_actual timestamp without time zone;
fecha_cali timestamp without time zone;
rec record;
contador smallint := 0;
existencia smallint;
nveces smallint := 0;
tipo char(2);
acred char(1);
per_acred character varying;
BEGIN
	SELECT current_timestamp into fecha_actual;
   
    IF substring(peri,5,1)='1' THEN 
     SELECT to_timestamp(CONCAT(substring(peri,1,4),'/06/01'),'YYYY/MM/DD HH24:MI:SS') INTO fecha_cali;
    ELSIF substring(peri,5,1)='2' THEN 
     SELECT to_timestamp(CONCAT(substring(peri,1,4),'/08/01'),'YYYY/MM/DD HH24:MI:SS') INTO fecha_cali; 
    ELSE 
     SELECT to_timestamp(CONCAT(substring(peri,1,4),'/12/01'),'YYYY/MM/DD HH24:MI:SS') INTO fecha_cali; 
    END IF;
 
    -- Determinar si ya existe historial academico del periodo
    SELECT COUNT(*) FROM "ITE".historia_alumno WHERE historia_alumno.periodo=peri AND historia_alumno.tipo_evaluacion NOT IN ('EE','EA','RU','RC','AC') INTO existencia;

    IF existencia > 0 THEN  --Si existe, por lo que se verifica que no se vaya a repetir la materia
        CREATE TEMP TABLE IF NOT EXISTS historia_periodo AS 
        select HA.periodo, HA.no_de_control, HA.materia, HA.calificacion, HA.tipo_evaluacion, HA.fecha_calificacion, HA.plan_de_estudios
        from "ITE".historia_alumno HA
        where HA.periodo=peri and HA.tipo_evaluacion not in ('EE', 'EA', 'RU', 'RC', 'AC');
	
        FOR rec IN SELECT SM.periodo, SM.no_de_control, SM.materia, SM.grupo, SM.calificacion, SM.tipo_evaluacion, A.plan_de_estudios, SM.nopresento 
        from "ITE".seleccion_materias SM, "ITE".alumnos A 
        where SM.periodo=peri AND SM.tipo_evaluacion is not NULL AND SM.no_de_control=A.no_de_control
        LOOP     
            SELECT COUNT(*) FROM historia_periodo HP WHERE HP.periodo=rec.periodo and HP.no_de_control=rec.no_de_control and HP.materia=rec.materia 
            and HP.calificacion=rec.calificacion and HP.tipo_evaluacion=rec.tipo_evaluacion and HP.fecha_calificacion=fecha_cali 
            and HP.plan_de_estudios=rec.plan_de_estudios INTO contador;
            IF contador=0 THEN  --Como la materia no esta repetida, se puede analizar para determinar como se almacena
                IF substring(rec.tipo_evaluacion,1,1)='R' THEN
                    SELECT COUNT(*) FROM "ITE".historia_alumno WHERE no_de_control=rec.no_de_control AND materia=rec.materia INTO nveces; 
                    IF nveces > 2 THEN
                        IF rec.calificacion >=70 THEN
                            SELECT 'A' INTO acred;
                            SELECT 'CE' INTO tipo;
                            SELECT peri INTO per_acred;
                        ELSE
                            SELECT 'N' INTO acred;
                            SELECT 'CE' INTO tipo;
                            SELECT null INTO per_acred;
                        END IF;
                    ELSE
                        IF rec.calificacion >=70 THEN
                            SELECT 'A' INTO acred;
                            SELECT rec.tipo_evaluacion INTO tipo;
                            SELECT peri INTO per_acred;
                        ELSE
                            SELECT 'P' INTO acred;
                            SELECT rec.tipo_evaluacion INTO tipo;
                            SELECT null INTO per_acred;
                        END IF;
                    END IF;
                ELSE
                    IF rec.calificacion >=70 THEN
                        SELECT 'A' INTO acred;
                        SELECT rec.tipo_evaluacion INTO tipo;
                        SELECT peri INTO per_acred;
                    ELSE
                        SELECT 'P' INTO acred;
                        SELECT rec.tipo_evaluacion INTO tipo;
                        SELECT null INTO per_acred;
                   END IF;
                END IF;
                INSERT INTO "ITE".historia_alumno(periodo,no_de_control,materia,grupo,calificacion,tipo_evaluacion,fecha_calificacion,
                plan_de_estudios,estatus_materia,nopresento,usuario,fecha_actualizacion,periodo_acredita_materia,created_at,updated_at) VALUES       
                (rec.periodo,rec.no_de_control,rec.materia,rec.grupo,rec.calificacion,tipo,fecha_cali,rec.plan_de_estudios,acred,null,usuar,
                fecha_actual,per_acred,fecha_cali,null); 
            END IF;   
        END LOOP;
        DROP TABLE historia_periodo;
    ELSE 
        FOR rec IN SELECT SM.periodo, SM.no_de_control, SM.materia, SM.grupo, SM.calificacion, SM.tipo_evaluacion, A.plan_de_estudios, SM.nopresento 
        from "ITE".seleccion_materias SM, "ITE".alumnos A 
        where SM.periodo=peri AND SM.tipo_evaluacion is not NULL AND SM.no_de_control=A.no_de_control
        LOOP     
            IF substring(rec.tipo_evaluacion,1,1)='R' THEN
                SELECT COUNT(*) FROM "ITE".historia_alumno WHERE no_de_control=rec.no_de_control AND materia=rec.materia INTO nveces; 
                IF nveces > 2 THEN
                    IF rec.calificacion >=70 THEN
                        SELECT 'A' INTO acred;
                        SELECT 'CE' INTO tipo;
                        SELECT peri INTO per_acred;
                    ELSE
                        SELECT 'N' INTO acred;
                        SELECT 'CE' INTO tipo;
                        SELECT null INTO per_acred;
                    END IF;
                ELSE
                   IF rec.calificacion >=70 THEN
                        SELECT 'A' INTO acred;
                        SELECT rec.tipo_evaluacion INTO tipo;
                        SELECT peri INTO per_acred;
                   ELSE
                        SELECT 'P' INTO acred;
                        SELECT rec.tipo_evaluacion INTO tipo;
                        SELECT null INTO per_acred;
                   END IF;
                END IF;
            ELSE
                IF rec.calificacion >=70 THEN
                    SELECT 'A' INTO acred;
                    SELECT rec.tipo_evaluacion INTO tipo;
                    SELECT peri INTO per_acred;
                ELSE
                    SELECT 'P' INTO acred;
                    SELECT rec.tipo_evaluacion INTO tipo;
                    SELECT null INTO per_acred;
                END IF;
            END IF;
            INSERT INTO "ITE".historia_alumno(periodo,no_de_control,materia,grupo,calificacion,tipo_evaluacion,fecha_calificacion,
            plan_de_estudios,estatus_materia,nopresento,usuario,fecha_actualizacion,periodo_acredita_materia,created_at,updated_at) VALUES       
            (rec.periodo,rec.no_de_control,rec.materia,rec.grupo,rec.calificacion,tipo,fecha_cali,rec.plan_de_estudios,acred,null,usuar,
            fecha_actual,per_acred,fecha_cali,null);            
        END LOOP;
    END IF;
    RETURN 1 as fin; 
END
$$;
 _   DROP FUNCTION "ITE".pap_agrega_calif_a_histo(peri "ITE"."T_periodo", usuar character varying);
       ITE       	   amaterasu    false    6    752            )           1255    16457 >   pap_avisos_reinscripcion(character varying, character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pap_avisos_reinscripcion(peri character varying, per_aviso character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
-- Inicializo variables
DECLARE
    rec record;
	semestre integer:=0; 
    creda integer:=0; 
    credc integer:=0; 
    credt integer:=0; 
    matc integer:=0; 
    matr integer:=0; 
    indice float:=0.00; 
    escolar char(1); 
    biblioteca char(1); 
    financieros char(1); 
    baja char(1):='N'; 
    motivo_baja character varying; 
    mata integer:=0; 
    egresar char(1):='N'; 
    encuesto char(1);          
    vobo char(1):='N'; 
    regular char(1):='S'; 
    credauto integer:=0; 
    promedio numeric(5,2):=0.00; 
    prom_acum numeric(5,2):=0.00;
    carga_max integer:=0; 
    carga_min integer:=0; 
    credcarr integer:=0; 
    valor integer:=0; 
    adeuda_esp char(1):='N'; 
    estatus char(3); 
    msgi character varying; 
    especiales_cursados integer:=0; 
    en_especial integer:=0;
    semini integer:=0;
    anioini integer:=0; 
    perini integer:=0;
    perrev integer:=0;
	cuando timestamp without time zone;
BEGIN	
--Alumnos del periodo en cuestion
    FOR rec IN SELECT DISTINCT SM.no_de_control FROM "ITE".seleccion_materias SM WHERE SM.periodo=peri
        LOOP
            IF EXISTS (SELECT 1 FROM "ITE".evaluacion_alumnos EA WHERE EA.periodo=peri AND EA.no_de_control=rec.no_de_control) THEN
                encuesto:='S';
            ELSE
                encuesto:='N';
            END IF;
            SELECT AH.indice_reprobacion_acumulado,creditos_aprobados,creditos_cursados,materias_cursadas,materias_reprobadas,promedio_aritmetico,promedio_aritmetico_acumulado,
                CASE WHEN AH.promedio_aritmetico BETWEEN 80.0 and 100 THEN creditos_cursados + 8
                WHEN promedio_aritmetico BETWEEN 70.0 and 79.999 THEN creditos_cursados
                WHEN promedio_aritmetico BETWEEN 60.0 and 69.999 THEN creditos_cursados - 4
                WHEN promedio_aritmetico BETWEEN 50.0 and 59.999 THEN creditos_cursados - 8
                ELSE creditos_cursados - 10 END
            INTO indice,creda,credc,mata,matr,promedio,prom_acum,credauto FROM "ITE".acumulado_historico AH WHERE AH.no_de_control=rec.no_de_control AND AH.periodo=peri;
            SELECT SUM(AH.creditos_aprobados) INTO credt FROM "ITE".acumulado_historico AH WHERE AH.no_de_control=rec.no_de_control;
             -- Adeudo con Servicios Escolares
			 /*
             IF EXISTS (SELECT 1 FROM "ITE".adeudos AD WHERE AD.periodo=peri AND AD.no_de_control=rec.no_de_control AND AD.tipo='E') THEN
                escolar:='S';
             ELSE
                escolar:='N';
             END IF;

             -- Adeudo con Centro de Información (Biblioteca)
             IF EXISTS (SELECT 1 FROM "ITE".adeudos AD WHERE AD.periodo=peri AND AD.no_de_control=rec.no_de_control AND AD.tipo='B') THEN
                biblioteca:='S';
             ELSE
                biblioteca:='N';
             END IF;
             
             -- Adeudo con Recursos Financieros
             IF EXISTS (SELECT 1 FROM "ITE".adeudos AD WHERE AD.periodo=peri AND AD.no_de_control=rec.no_de_control AND AD.tipo='F') THEN
                financieros:='S';
             ELSE
                financieros:='N';
             END IF;
             */
			 escolar:='N';
			 biblioteca:='N';
			 financieros:='N';
             vobo:='N'; -- Inicializa la variable que define el vo.bo. del director para avance
			 
             -- Selecciono los creditos totales, carga máxima y carga mínima de la carrera del alumno
             SELECT C.creditos_totales, C.carga_maxima, C.carga_minima INTO credcarr,carga_max,carga_min FROM "ITE".carreras C, "ITE".alumnos A 
             WHERE C.carrera=A.carrera and C.reticula=A.reticula AND A.no_de_control=rec.no_de_control;
             
             -- Se definen los créditos autorizados
             IF credauto < carga_min THEN
                credauto:=carga_min;
             ELSIF credauto > carga_max THEN
                credauto:=carga_max;
             END IF;
			 
             -- Se calcula semestre del alumno
             IF SUBSTRING(peri,5,1) = '3' THEN        
                 semini:=2;        
             ELSE        
                 semini:=1;
             END IF;
            SELECT SUBSTRING(A.periodo_ingreso_it,1,4)::INTEGER,SUBSTRING(A.periodo_ingreso_it,5,1)::INTEGER, A.periodos_revalidacion        
            INTO anioini,perini,perrev FROM "ITE".alumnos A WHERE A.no_de_control = rec.no_de_control;
            semestre:= 2 * (SUBSTRING(peri,1,4)::INTEGER - anioini);        
            IF perini=3 THEN
                semestre:= semestre + (semini - perini + 2 + perrev);
            ELSE 
                semestre:= semestre + (semini - perini + 1 + perrev);
            END IF;
            IF semestre < 0 THEN
                semestre:= 0;
            END IF;
			--REPROBACION DE MAS DE 50% DE CREDITOS PARA NUEVO INGRESO EN PRIMER SEMESTRE
            IF semestre=1 AND ((mata - matr) < 3) THEN
                baja:='S';
                motivo_baja:='REPROBACION DE MAS DE 3 MATERIAS PARA NUEVO INGRESO EN PRIMER SEMESTRE';
                estatus:='BD2';
                egresar:='N';
            ELSIF semestre>12 THEN
                baja:='S';
                motivo_baja:='EXCEDE MAS DE 12 SEMESTRES PERMITIDOS';
                estatus:='BD4';
				egresar:='N';
			ELSE
				baja:='N';
				motivo_baja:='';
			    estatus:='ACT';
				egresar:='N';
            END IF;
			IF credt >=credcarr THEN
                egresar:='S';
			END IF;
            --Si es regular
            IF EXISTS (SELECT 1 from "ITE".historia_alumno HA WHERE HA.no_de_control = rec.no_de_control AND HA.periodo <= peri AND HA.calificacion < 70 
              AND HA.materia NOT IN (SELECT HA.materia FROM "ITE".historia_alumno HA WHERE HA.calificacion >= 70 
              AND HA.no_de_control = rec.no_de_control AND periodo <= peri)) THEN
                regular:= 'N';
            ELSE
                regular:='S';
            END IF;
            SELECT COUNT(*) INTO especiales_cursados FROM "ITE".historia_alumno WHERE historia_alumno.no_de_control=rec.no_de_control AND historia_alumno.tipo_evaluacion='CE';
            SELECT COUNT(*) INTO en_especial FROM "ITE".historia_alumno HA WHERE HA.no_de_control=rec.no_de_control AND HA.tipo_evaluacion IN ('RO', 'RP') AND HA.materia NOT IN (
                SELECT HA.materia FROM "ITE".historia_alumno HA WHERE HA.no_de_control=rec.no_de_control AND HA.tipo_evaluacion='CE' AND HA.calificacion >=70) AND HA.calificacion < 70;
            IF (especiales_cursados + en_especial) > 5 THEN
                baja:='S';
                motivo_baja:='EXCEDE DEL MAXIMO NUMERO DE CURSOS ESPECIALES PERMITIDOS';
                adeuda_esp:='S';
                estatus:='BD7';
                egresar:='N';
            END IF;
            IF en_especial >=1 THEN
                credauto:=carga_max;
            END IF;
			SELECT now() AT TIME ZONE current_setting('timezone') INTO cuando;
            INSERT INTO "ITE".avisos_reinscripcion (periodo, no_de_control, autoriza_escolar,recibo_pago,fecha_recibo,cuenta_pago,fecha_hora_seleccion,lugar_seleccion,fecha_hora_pago,adeuda_escolar, adeuda_biblioteca, adeuda_financieros, otro_mensaje,baja, motivo_aviso_baja, 
 egresa, encuesto, vobo_adelanta_sel, regular, indice_reprobacion, creditos_autorizados, estatus_reinscripcion,semestre, promedio, adeudo_especial,promedio_acumulado,proareas,created_at,updated_at) 
            VALUES
            (per_aviso, rec.no_de_control, 'N',null,null,null,null,null,null,escolar, biblioteca, financieros,null, baja, motivo_baja, egresar, encuesto, vobo, regular, indice, credauto, null,semestre, promedio, adeuda_esp,prom_acum,null,cuando,null);
            UPDATE "ITE".alumnos SET estatus_alumno=estatus WHERE alumnos.no_de_control=rec.no_de_control; 
        END LOOP;
END;
$$;
 c   DROP FUNCTION "ITE".pap_avisos_reinscripcion(peri character varying, per_aviso character varying);
       ITE       	   amaterasu    false    6            *           1255    16460 %   pap_curso_especial(character varying)    FUNCTION     s  CREATE FUNCTION "ITE".pap_curso_especial(peri character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
-- Inicializo variables
DECLARE
    rec record;
	cantidad integer:=0; 
BEGIN	
    -- Obtener materias en especial 
	FOR rec IN SELECT SM.no_de_control,SM.materia, SM.calificacion FROM "ITE".seleccion_materias SM, "ITE".alumnos A WHERE SM.periodo=peri AND
        SM.no_de_control=A.no_de_control AND (A.plan_de_estudios='3' OR A.plan_de_estudios='4') AND SM.repeticion='S'
        LOOP
             SELECT COUNT(*) INTO cantidad FROM "ITE".historia_alumno HA WHERE HA.no_de_control=rec.no_de_control AND HA.materia=rec.materia AND HA.calificacion=0;
             IF cantidad=3 AND rec.calificacion=0 THEN
                UPDATE "ITE".alumnos SET estatus_alumno='BDR' WHERE alumnos.no_de_control=rec.no_de_control;
                INSERT INTO "ITE".baja_cespeciales(periodo, no_de_control, materia) VALUES(peri, rec.no_de_control, rec.materia);
             ELSIF cantidad=2 AND rec.calificacion >=70 THEN
                UPDATE "ITE".seleccion_materias SM SET tipo_evaluacion='CE' WHERE SM.periodo=peri AND SM.no_de_control=rec.no_de_control AND SM.materia=rec.materia;
			    UPDATE "ITE".historia_alumno HA SET tipo_evaluacion='CE' WHERE HA.periodo=peri and HA.no_de_control=rec.no_de_control AND HA.materia=rec.materia;
             END IF;
             
        END LOOP;
END;

$$;
 @   DROP FUNCTION "ITE".pap_curso_especial(peri character varying);
       ITE       	   amaterasu    false    6            +           1255    16461 &   pap_promedio_alumno(character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pap_promedio_alumno(peri character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec record;
    conteo integer:=0;
BEGIN	
--Alumnos del periodo en cuestion
    FOR rec IN SELECT DISTINCT(historia_alumno.no_de_control) FROM "ITE".historia_alumno WHERE historia_alumno.periodo=peri
        LOOP
            PERFORM "ITE".pap_promedios_alumno(rec.no_de_control,peri);
            conteo:=conteo+1;
        END LOOP;
RETURN conteo; 
END;
$$;
 A   DROP FUNCTION "ITE".pap_promedio_alumno(peri character varying);
       ITE       	   amaterasu    false    6            ,           1255    16462 @   pap_promedios_alumno("ITE"."T_no_de_control", character varying)    FUNCTION     {&  CREATE FUNCTION "ITE".pap_promedios_alumno(control "ITE"."T_no_de_control", peri character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$
-- Inicializo variables
DECLARE
    historia record;
	materias_cursadas integer:=0; 
    materias_aprobadas integer:=0; 
    materias_reprobadas integer:=0; 
    materias_a_especial integer:=0; 
    materias_especial_reprobado integer:=0; 
    creditos_cursados integer:=0; 
    creditos_aprobados integer:=0; 
    creditos_reprobados integer:=0; 
    suma_calificacion integer:=0; 
    suma_calificacion_ponderada integer:=0; 
    indice numeric(5,2):=0.00; 
    creditos_promedio integer:=0; 
    materias_promedio integer:=0; 
    promedio_ponderado numeric(5,2):=0.00; 
    promedio_aritmetico numeric(5,2):=0.00;          
    creditos_aprobados_a integer:=0; 
    creditos_cursados_a integer:=0; 
    suma_calificacion_a integer:=0; 
    suma_calificacion_ponderada_a integer:=0; 
    suma_calificacion_certificado integer:=0; 
    creditos_reprobados_a integer:=0; 
    materias_promedio_certificado integer:=0; 
    indice_a numeric(5,2):=0.00; 
    creditos_promedio_a integer:=0; 
    materias_promedio_a integer:=0; 
    promedio_ponderado_a numeric(5,2):=0.00; 
    promedio_aritmetico_a numeric(5,2):=0.00; 
    promedio_certificado numeric(5,2):=0.00;
    estatus_periodo char(1);
BEGIN	
--Alumnos del periodo en cuestion
    
        --Historial academico
            CREATE TEMP TABLE IF NOT EXISTS histo AS SELECT HA.periodo, HA.no_de_control, HA.materia, HA.calificacion, HA.tipo_evaluacion, HA.plan_de_estudios, 
            HA.estatus_materia, HA.nopresento, HA.periodo_acredita_materia FROM "ITE".historia_alumno HA WHERE HA.periodo <= peri and no_de_control = control;
        --Analizar historia
            FOR historia IN SELECT H.periodo, H.no_de_control, H.materia, MC.creditos_materia, H.calificacion, H.tipo_evaluacion, A.plan_de_estudios, H.estatus_materia, 
            C.creditos_totales, H.periodo_acredita_materia                       
            FROM histo H, "ITE".materias_carreras MC, "ITE".alumnos A, "ITE".materias M, "ITE".carreras C       
            WHERE H.no_de_control = control AND H.no_de_control = A.no_de_control AND H.materia = M.materia AND M.tipo_materia in (1,2,3) AND H.materia = MC.materia AND A.carrera = MC.carrera 
            AND A.reticula = MC.reticula AND A.carrera = C.carrera and A.reticula = C.reticula
                LOOP
                    IF historia.periodo=peri THEN
                    	IF historia.tipo_evaluacion not in ('RU', 'RC', 'EE', 'EA') THEN -- Materias cursadas 
                        	materias_cursadas:= materias_cursadas + 1; 
                            creditos_cursados:= creditos_cursados + historia.creditos_materia;
                        END IF;
                        IF historia.calificacion >= 70 OR (historia.calificacion >= 60 AND historia.tipo_evaluacion in ('RC','RU')) THEN    
                            creditos_aprobados:= creditos_aprobados + historia.creditos_materia;     -- Materia Aprobada          
                        ELSE             
                            materias_reprobadas:= materias_reprobadas + 1;
                            creditos_reprobados:= creditos_reprobados + historia.creditos_materia;  --Materia Reprobada 
                            IF historia.tipo_evaluacion = 'EE' THEN
                            	materias_especial_reprobado:= materias_especial_reprobado + 1;   -- Especial Reprobado 
                            ELSIF historia.tipo_evaluacion IN ('O2', 'R2') THEN
                                materias_a_especial = materias_a_especial + 1;    -- Materia a Especial
                            END IF;
                        END IF;
                        IF historia.tipo_evaluacion != 'RU' THEN   -- Para todas las materias que no son de Equivalencia             
                            suma_calificacion:= suma_calificacion + historia.calificacion;
                            materias_promedio:= materias_promedio + 1; 
                            suma_calificacion_ponderada:= suma_calificacion_ponderada + (historia.calificacion * historia.creditos_materia);
                            creditos_promedio:= creditos_promedio + historia.creditos_materia; 
                        END IF;
                    END IF;
                    -- Inicia analisis para acumulados 
                    IF historia.tipo_evaluacion != 'RU' THEN    -- Elimina Materias en Equivalencia  
                        IF historia.tipo_evaluacion not in ('EE','EA','RC') THEN 
                            creditos_cursados_a:= creditos_cursados_a + historia.creditos_materia;
                        END IF;
                        IF (historia.calificacion >= 70) OR (historia.calificacion < 70 AND ( (historia.estatus_materia = 'R') OR (historia.periodo_acredita_materia > historia.periodo))) THEN
                            suma_calificacion_a:= suma_calificacion_a + historia.calificacion;
                            materias_promedio_a:= materias_promedio_a + 1; 
                            suma_calificacion_ponderada_a:= suma_calificacion_ponderada_a + (historia.calificacion * historia.creditos_materia);
                            creditos_promedio_a:= creditos_promedio_a + historia.creditos_materia; 
                            IF historia.calificacion < 70 THEN 
                               creditos_reprobados_a:= creditos_reprobados_a + historia.creditos_materia;
                            END IF;
                        END IF; 
                        IF historia.calificacion >= 70 THEN
                            suma_calificacion_certificado:= suma_calificacion_certificado + historia.calificacion;
                            materias_promedio_certificado:= materias_promedio_certificado + 1;
                            creditos_aprobados_a:= creditos_aprobados_a + historia.creditos_materia;
                        END IF; 
                    END IF; 
                    -- Fin analisis para acumulados 
                    -- Inician Calculos para el periodo
                    IF creditos_promedio > 0 THEN -- Curso Materias en el Periodo, Obtiene Promedio, Aritmético y Ponderado 
                        promedio_ponderado:= suma_calificacion_ponderada / creditos_promedio;
                        promedio_aritmetico:= suma_calificacion / materias_promedio;
                        IF creditos_reprobados > 0 THEN  -- Si es afirmativo, calcula indice de reprobación por periodo 
                        	indice:=  creditos_reprobados / creditos_promedio;
                        ELSE 
                            indice:= 0.00; 
                        END IF; 
                    ELSE 
                        promedio_ponderado:= 0.00;
                        promedio_aritmetico:= 0.00;
                        IF materias_especial_reprobado > 0 THEN
                           estatus_periodo:= 'X'; 
                        ELSIF materias_a_especial >= 2 THEN
                           estatus_periodo:= 'T';
                        ELSIF creditos_reprobados > 0 THEN
                           estatus_periodo:= 'I';
                        ELSE 
                           estatus_periodo:= 'R';
                        END IF;
                    END IF;
                    -- Finalizan Calculos para el periodo  
                    -- Inician Calculos para acumulados
                    IF creditos_promedio_a > 0 THEN -- Curso Materias, Obtiene Promedio, Aritmético, Ponderado, de Certificado e Indice de reprobación
                        promedio_ponderado_a:= suma_calificacion_ponderada_a / creditos_promedio_a; 
                        promedio_aritmetico_a:= suma_calificacion_a / materias_promedio_a;         
                        IF materias_promedio_certificado > 0 THEN
                        	promedio_certificado:= suma_calificacion_certificado / materias_promedio_certificado;
                        ELSE 
                            promedio_certificado:= 0.00; 
                        END IF;
                    	IF creditos_reprobados_a > 0 THEN  -- Si es afirmativo, calcula indice de reprobación
                        	indice_a:= creditos_reprobados_a / creditos_promedio_a;
                        ELSE 
                            indice_a:= 0.00; 
                        END IF;
                    ELSE 
                        promedio_ponderado_a:= 0.00; 
                        promedio_aritmetico_a:= 0.00; 
                        indice_a:= 0.00; 
                        promedio_certificado:= 0.00; 
                    END IF; 
                END LOOP;
                INSERT INTO "ITE".acumulado_historico(periodo,no_de_control,estatus_periodo_alumno,creditos_cursados,
														  creditos_aprobados,promedio_ponderado,promedio_ponderado_acumulado,
														  promedio_aritmetico,promedio_aritmetico_acumulado,promedio_certificado,
														  materias_cursadas, materias_reprobadas, materias_a_examen_especial, 
														  materias_especial_reprobadas,indice_reprobacion_semestre,creditos_autorizados,
														  indice_reprobacion_acumulado) 
                VALUES(peri, control, estatus_periodo, creditos_cursados, creditos_aprobados, 
						   promedio_ponderado, promedio_ponderado_a, promedio_aritmetico,promedio_aritmetico_a, 
						   promedio_certificado, materias_cursadas, materias_reprobadas, materias_a_especial, 
						   materias_especial_reprobado, indice, 0, indice_a); 
                UPDATE "ITE".alumnos SET promedio_aritmetico_acumulado = promedio_aritmetico_a, creditos_aprobados = creditos_aprobados_a, 
					creditos_cursados = creditos_cursados_a, promedio_final_alcanzado = promedio_certificado 
				WHERE no_de_control = control; 
               DROP TABLE histo;
RETURN 1 AS fin; 
END;
$$;
 c   DROP FUNCTION "ITE".pap_promedios_alumno(control "ITE"."T_no_de_control", peri character varying);
       ITE       	   amaterasu    false    6    749            -           1255    16465 &   pap_semestre_alumno(character varying)    FUNCTION     �  CREATE FUNCTION "ITE".pap_semestre_alumno(peri character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
-- Inicializo variables
DECLARE
    rec record;
	semestr integer:=0; 
    semini integer:=0;
    anioini integer:=0; 
    perini integer:=0;
    perrev integer:=0;
	cuando timestamp without time zone;
BEGIN	
--Alumnos del periodo en cuestion
    FOR rec IN SELECT DISTINCT SM.no_de_control FROM "ITE".seleccion_materias SM WHERE SM.periodo=peri
        LOOP
             -- Se calcula semestre del alumno
             IF SUBSTRING(peri,5,1) = '3' THEN        
                 semini:=2;        
             ELSE        
                 semini:=1;
             END IF;
            SELECT SUBSTRING(A.periodo_ingreso_it,1,4)::INTEGER,SUBSTRING(A.periodo_ingreso_it,5,1)::INTEGER, A.periodos_revalidacion        
            INTO anioini,perini,perrev FROM "ITE".alumnos A WHERE A.no_de_control = rec.no_de_control;
            semestr:= 2 * (SUBSTRING(peri,1,4)::INTEGER - anioini);        
            IF perini=3 THEN
                semestr:= semestr + (semini - perini + 2 + perrev);
            ELSE 
                semestr:= semestr + (semini - perini + 1 + perrev);
            END IF;
            IF semestr < 0 THEN
                semestr:= 0;
            END IF;
            --Se le indica ahora que irá al próximo semestre
            semestr:= semestr + 1;
            UPDATE "ITE".alumnos SET semestre = semestr where no_de_control = rec.no_de_control;
        END LOOP;
END;

$$;
 A   DROP FUNCTION "ITE".pap_semestre_alumno(peri character varying);
       ITE       	   amaterasu    false    6            �            1259    16466    actividades_apoyo    TABLE        CREATE TABLE "ITE".actividades_apoyo (
    actividad character varying(4),
    descripcion_actividad character varying(150)
);
 $   DROP TABLE "ITE".actividades_apoyo;
       ITE         heap 	   amaterasu    false    6            �            1259    16469    acumulado_historico    TABLE       CREATE TABLE "ITE".acumulado_historico (
    periodo "ITE"."T_periodo" NOT NULL,
    no_de_control "ITE"."T_no_de_control" NOT NULL,
    estatus_periodo_alumno character(1),
    creditos_cursados "ITE"."T_creditos",
    creditos_aprobados "ITE"."T_creditos",
    promedio_ponderado "ITE"."T_promedio",
    promedio_ponderado_acumulado "ITE"."T_promedio",
    promedio_aritmetico "ITE"."T_promedio",
    promedio_aritmetico_acumulado "ITE"."T_promedio",
    promedio_certificado "ITE"."T_promedio",
    materias_cursadas integer,
    materias_reprobadas integer,
    materias_a_examen_especial integer,
    materias_especial_reprobadas integer,
    indice_reprobacion_semestre numeric(8,6),
    creditos_autorizados "ITE"."T_creditos",
    indice_reprobacion_acumulado numeric(8,6)
);
 &   DROP TABLE "ITE".acumulado_historico;
       ITE         heap 	   amaterasu    false    725    725    755    755    755    755    755    725    6    752    749            �            1259    16475    alumnos    TABLE     �  CREATE TABLE "ITE".alumnos (
    no_de_control "ITE"."T_no_de_control" NOT NULL,
    carrera "ITE"."T_carrera",
    reticula "ITE"."T_reticula",
    especialidad "ITE"."T_especialidad",
    nivel_escolar "char",
    semestre smallint,
    estatus_alumno character(3) DEFAULT 'ACT'::bpchar,
    plan_de_estudios character(1) NOT NULL,
    apellido_paterno "ITE"."T_apellidos_persona",
    apellido_materno "ITE"."T_apellidos_persona",
    nombre_alumno character varying(255) NOT NULL,
    curp_alumno "ITE"."T_curp",
    fecha_nacimiento "ITE"."T_fecha",
    sexo "ITE"."T_sexo",
    estado_civil "ITE"."T_estado_civil",
    tipo_ingreso numeric(1,0) NOT NULL,
    periodo_ingreso_it "ITE"."T_periodo" NOT NULL,
    ultimo_periodo_inscrito "ITE"."T_periodo",
    promedio_periodo_anterior "ITE"."T_promedio",
    promedio_aritmetico_acumulado "ITE"."T_promedio",
    creditos_aprobados "ITE"."T_creditos",
    creditos_cursados "ITE"."T_creditos",
    promedio_final_alcanzado "ITE"."T_promedio",
    escuela_procedencia character varying(50),
    entidad_procedencia "ITE"."T_lugar_nac",
    ciudad_procedencia "ITE"."T_ciudad",
    correo_electronico character varying(60),
    periodos_revalidacion smallint,
    becado_por character varying(100),
    nip integer,
    usuario character(30),
    fecha_actualizacion date,
    fecha_titulacion "ITE"."T_fecha",
    opcion_titulacion character varying(4),
    periodo_titulacion "ITE"."T_periodo",
    registro_patronal character varying(10),
    digito_registro_patronal character varying(1),
    nss character varying(20),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE "ITE".alumnos;
       ITE         heap 	   amaterasu    false    713    6    752    737    722    743    755    725    725    755    755    752    752    734    761    737    728    713    731    758    719    749            �           0    0    TABLE alumnos    ACL     1   GRANT SELECT ON TABLE "ITE".alumnos TO monedit4;
          ITE       	   amaterasu    false    206            �            1259    16482    alumnos_generales    TABLE     ~  CREATE TABLE "ITE".alumnos_generales (
    no_de_control "ITE"."T_no_de_control" NOT NULL,
    domicilio_calle character varying(60),
    domicilio_colonia character varying(40),
    codigo_postal character varying(5),
    telefono character varying(30),
    facebook character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 $   DROP TABLE "ITE".alumnos_generales;
       ITE         heap 	   amaterasu    false    749    6            �            1259    16488    apoyo_docencia    TABLE     �   CREATE TABLE "ITE".apoyo_docencia (
    periodo "ITE"."T_periodo",
    rfc character varying(13),
    actividad character varying(4),
    consecutivo smallint,
    especifica_actividad character varying(110)
);
 !   DROP TABLE "ITE".apoyo_docencia;
       ITE         heap 	   amaterasu    false    6    752            �            1259    16494    aulas    TABLE     �   CREATE TABLE "ITE".aulas (
    aula character varying(6) NOT NULL,
    ubicacion character varying(10),
    capacidad smallint,
    obaervaciones character varying(100),
    permite_cruce character(1),
    estatus character(1)
);
    DROP TABLE "ITE".aulas;
       ITE         heap 	   amaterasu    false    6            �            1259    16497    avisos_reinscripcion    TABLE     I  CREATE TABLE "ITE".avisos_reinscripcion (
    periodo "ITE"."T_periodo" NOT NULL,
    no_de_control "ITE"."T_no_de_control" NOT NULL,
    autoriza_escolar character(1),
    recibo_pago character(10),
    fecha_recibo date,
    cuenta_pago character varying(250),
    fecha_hora_seleccion timestamp without time zone,
    lugar_seleccion character varying(250),
    fecha_hora_pago date,
    lugar_pago character varying(250),
    adeuda_escolar character(1),
    adeuda_biblioteca character(1),
    adeuda_financieros character(1),
    otro_mensaje character varying(250),
    baja character(1),
    motivo_aviso_baja character varying(250),
    egresa character(1),
    encuesto character(1),
    vobo_adelanta_sel character(1),
    regular character(1),
    indice_reprobacion real,
    creditos_autorizados integer,
    estatus_reinscripcion character(1),
    semestre integer,
    promedio integer,
    adeudo_especial character(1),
    promedio_acumulado "ITE"."T_promedio",
    proareas character(1),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 '   DROP TABLE "ITE".avisos_reinscripcion;
       ITE         heap 	   amaterasu    false    6    749    752    755            �           0    0    TABLE avisos_reinscripcion    ACL     >   GRANT SELECT ON TABLE "ITE".avisos_reinscripcion TO monedit4;
          ITE       	   amaterasu    false    210            �            1259    16503    baja_cespeciales    TABLE     �   CREATE TABLE "ITE".baja_cespeciales (
    periodo "ITE"."T_periodo",
    no_de_control "ITE"."T_no_de_control",
    materia "ITE"."T_materia",
    id integer NOT NULL
);
 #   DROP TABLE "ITE".baja_cespeciales;
       ITE         heap 	   amaterasu    false    746    752    749    6            �            1259    16509    baja_cespeciales_id_seq    SEQUENCE     �   CREATE SEQUENCE "ITE".baja_cespeciales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE "ITE".baja_cespeciales_id_seq;
       ITE       	   amaterasu    false    6    211            �           0    0    baja_cespeciales_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE "ITE".baja_cespeciales_id_seq OWNED BY "ITE".baja_cespeciales.id;
          ITE       	   amaterasu    false    212            �            1259    16511    carreras    TABLE     �  CREATE TABLE "ITE".carreras (
    carrera "ITE"."T_carrera" NOT NULL,
    reticula "ITE"."T_reticula" NOT NULL,
    nivel_escolar character(1) NOT NULL,
    clave_oficial character(20) NOT NULL,
    nombre_carrera character varying(80) NOT NULL,
    nombre_reducido character varying(30) NOT NULL,
    siglas character varying(10) NOT NULL,
    carga_maxima smallint NOT NULL,
    carga_minima smallint NOT NULL,
    creditos_totales smallint,
    modalidad character(1),
    nreal character varying(100),
    ofertar boolean,
    abrev character(7),
    nombre_ofertar character varying(200),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE "ITE".carreras;
       ITE         heap 	   amaterasu    false    719    6    758            �           0    0    TABLE carreras    ACL     2   GRANT SELECT ON TABLE "ITE".carreras TO monedit4;
          ITE       	   amaterasu    false    213            �            1259    16517    entidades_federativas    TABLE     �   CREATE TABLE "ITE".entidades_federativas (
    entidad_federativa smallint,
    nombre_entidad character varying(50),
    clave_entidad character(2)
);
 (   DROP TABLE "ITE".entidades_federativas;
       ITE         heap 	   amaterasu    false    6            �            1259    16520    especialidades    TABLE     E  CREATE TABLE "ITE".especialidades (
    especialidad "ITE"."T_especialidad" NOT NULL,
    carrera "ITE"."T_carrera" NOT NULL,
    reticula "ITE"."T_reticula" NOT NULL,
    nombre_especialidad character varying(100) NOT NULL,
    creditos_optativos smallint,
    creditos_especialidad smallint NOT NULL,
    activa boolean
);
 !   DROP TABLE "ITE".especialidades;
       ITE         heap 	   amaterasu    false    758    731    6    719            �            1259    16526    estatus_alumno    TABLE     r   CREATE TABLE "ITE".estatus_alumno (
    estatus character(3) NOT NULL,
    descripcion character(100) NOT NULL
);
 !   DROP TABLE "ITE".estatus_alumno;
       ITE         heap 	   amaterasu    false    6            �           0    0    TABLE estatus_alumno    ACL     8   GRANT SELECT ON TABLE "ITE".estatus_alumno TO monedit4;
          ITE       	   amaterasu    false    216            �            1259    16529    evaluacion_alumnos    TABLE     	  CREATE TABLE "ITE".evaluacion_alumnos (
    periodo "ITE"."T_periodo" NOT NULL,
    no_de_control "ITE"."T_no_de_control" NOT NULL,
    materia "ITE"."T_materia" NOT NULL,
    grupo character(3),
    rfc character varying(13),
    clave_area character(6),
    encuesta character(1),
    respuestas character varying(50),
    resp_abierta character varying(255),
    usuario character varying(30),
    consecutivo integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 %   DROP TABLE "ITE".evaluacion_alumnos;
       ITE         heap 	   amaterasu    false    746    752    749    6            �            1259    16535    failed_jobs    TABLE     �   CREATE TABLE "ITE".failed_jobs (
    id bigint NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE "ITE".failed_jobs;
       ITE         heap 	   amaterasu    false    6            �            1259    16542    failed_jobs_id_seq    SEQUENCE     z   CREATE SEQUENCE "ITE".failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE "ITE".failed_jobs_id_seq;
       ITE       	   amaterasu    false    6    218            �           0    0    failed_jobs_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE "ITE".failed_jobs_id_seq OWNED BY "ITE".failed_jobs.id;
          ITE       	   amaterasu    false    219            �            1259    16544    fechas_carreras    TABLE       CREATE TABLE "ITE".fechas_carreras (
    carrera "ITE"."T_carrera",
    fecha_inscripcion date,
    fecha_inicio time without time zone,
    fecha_fin time without time zone,
    intervalo smallint,
    personas smallint,
    periodo "ITE"."T_periodo",
    puntero smallint
);
 "   DROP TABLE "ITE".fechas_carreras;
       ITE         heap 	   amaterasu    false    6    719    752            �            1259    16550    folios_constancias    TABLE       CREATE TABLE "ITE".folios_constancias (
    id integer NOT NULL,
    folio integer,
    periodo "ITE"."T_periodo",
    control "ITE"."T_no_de_control",
    tipo character(2),
    fecha timestamp without time zone,
    anio character(4),
    quien character(30)
);
 %   DROP TABLE "ITE".folios_constancias;
       ITE         heap 	   amaterasu    false    749    752    6            �            1259    16556    folios_constancias_id_seq    SEQUENCE     �   CREATE SEQUENCE "ITE".folios_constancias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE "ITE".folios_constancias_id_seq;
       ITE       	   amaterasu    false    221    6            �           0    0    folios_constancias_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE "ITE".folios_constancias_id_seq OWNED BY "ITE".folios_constancias.id;
          ITE       	   amaterasu    false    222            �            1259    16558    generar_listas_temporales    TABLE     [  CREATE TABLE "ITE".generar_listas_temporales (
    no_de_control "ITE"."T_no_de_control" NOT NULL,
    apellido_paterno character varying(100),
    apellido_materno character varying(100),
    nombre_alumno character varying(100),
    semestre smallint,
    fecha_hora_seleccion timestamp without time zone,
    promedio_ponderado numeric(7,3)
);
 ,   DROP TABLE "ITE".generar_listas_temporales;
       ITE         heap 	   amaterasu    false    6    749            �            1259    16564    grupos    TABLE     N  CREATE TABLE "ITE".grupos (
    periodo "ITE"."T_periodo" NOT NULL,
    materia "ITE"."T_materia" NOT NULL,
    grupo character(3) NOT NULL,
    estatus_grupo character(1),
    capacidad_grupo smallint NOT NULL,
    alumnos_inscritos smallint,
    folio_acta "ITE"."T_folio_acta",
    paralelo_de character(10),
    exclusivo_carrera "ITE"."T_carrera",
    exclusivo_reticula "ITE"."T_reticula",
    rfc character(13),
    tipo_personal character(1),
    exclusivo character(2),
    entrego boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE "ITE".grupos;
       ITE         heap 	   amaterasu    false    758    752    719    740    746    6            �            1259    16570    historia_alumno    TABLE     �  CREATE TABLE "ITE".historia_alumno (
    periodo "ITE"."T_periodo" NOT NULL,
    no_de_control "ITE"."T_no_de_control" NOT NULL,
    materia "ITE"."T_materia" NOT NULL,
    grupo character(3),
    calificacion "ITE"."T_calificacion",
    tipo_evaluacion character(2) NOT NULL,
    fecha_calificacion timestamp without time zone,
    plan_de_estudios character(1),
    estatus_materia character(1),
    nopresento character(1),
    usuario character(30),
    fecha_actualizacion timestamp without time zone,
    periodo_acredita_materia "ITE"."T_periodo",
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 "   DROP TABLE "ITE".historia_alumno;
       ITE         heap 	   amaterasu    false    746    752    749    716    752    6            �            1259    16576    horario_administrativo    TABLE     �   CREATE TABLE "ITE".horario_administrativo (
    periodo "ITE"."T_periodo",
    rfc character varying(13),
    consecutivo_admvo smallint,
    descripcion_horario integer,
    fcaptura date
);
 )   DROP TABLE "ITE".horario_administrativo;
       ITE         heap 	   amaterasu    false    6    752            �            1259    16582    horario_observaciones    TABLE     �   CREATE TABLE "ITE".horario_observaciones (
    periodo "ITE"."T_periodo",
    rfc character varying(13),
    observaciones character varying(400),
    depto character varying(6),
    cuando timestamp without time zone
);
 (   DROP TABLE "ITE".horario_observaciones;
       ITE         heap 	   amaterasu    false    752    6            �            1259    16588    horarios    TABLE     P  CREATE TABLE "ITE".horarios (
    periodo "ITE"."T_periodo" NOT NULL,
    rfc character(13),
    tipo_horario character(1) NOT NULL,
    dia_semana smallint NOT NULL,
    hora_inicial time without time zone NOT NULL,
    hora_final time without time zone,
    materia "ITE"."T_materia",
    grupo character(3),
    aula character(6),
    actividad character(10),
    consecutivo smallint,
    vigencia_inicio date,
    vigencia_fin date,
    consecutivo_admvo smallint,
    tipo_personal character(1),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE "ITE".horarios;
       ITE         heap 	   amaterasu    false    6    752    746            �            1259    16594    idiomas    TABLE     t   CREATE TABLE "ITE".idiomas (
    id integer NOT NULL,
    idiomas character(100),
    abrev character varying(5)
);
    DROP TABLE "ITE".idiomas;
       ITE         heap 	   amaterasu    false    6            �            1259    16597    idiomas_id_seq    SEQUENCE     �   CREATE SEQUENCE "ITE".idiomas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE "ITE".idiomas_id_seq;
       ITE       	   amaterasu    false    229    6            �           0    0    idiomas_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE "ITE".idiomas_id_seq OWNED BY "ITE".idiomas.id;
          ITE       	   amaterasu    false    230            �            1259    16599    idiomas_liberacion    TABLE     �   CREATE TABLE "ITE".idiomas_liberacion (
    periodo "ITE"."T_periodo",
    control "ITE"."T_no_de_control" NOT NULL,
    calif "ITE"."T_calificacion",
    liberacion date,
    idioma integer NOT NULL,
    opcion character(1) NOT NULL
);
 %   DROP TABLE "ITE".idiomas_liberacion;
       ITE         heap 	   amaterasu    false    716    749    6    752            �            1259    16605    jefes    TABLE       CREATE TABLE "ITE".jefes (
    clave_area character(6) NOT NULL,
    descripcion_area character varying(200),
    jefe_area character varying(70),
    rfc character varying(13),
    correo character varying(200),
    ext character varying(4),
    correo2 character varying(200)
);
    DROP TABLE "ITE".jefes;
       ITE         heap 	   amaterasu    false    6            �           0    0    TABLE jefes    ACL     /   GRANT SELECT ON TABLE "ITE".jefes TO monedit4;
          ITE       	   amaterasu    false    232            �            1259    16611    materias    TABLE     �  CREATE TABLE "ITE".materias (
    materia "ITE"."T_materia" NOT NULL,
    nivel_escolar character(1),
    tipo_materia smallint,
    clave_area character(6),
    nombre_completo_materia character varying(100) NOT NULL,
    nombre_abreviado_materia character varying(40) NOT NULL,
    caracterizacion text,
    generales text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE "ITE".materias;
       ITE         heap 	   amaterasu    false    746    6            �            1259    16617    materias_carreras    TABLE     =  CREATE TABLE "ITE".materias_carreras (
    carrera "ITE"."T_carrera" NOT NULL,
    reticula "ITE"."T_reticula" NOT NULL,
    materia "ITE"."T_materia" NOT NULL,
    creditos_materia smallint,
    horas_teoricas smallint NOT NULL,
    horas_practicas smallint NOT NULL,
    orden_certificado smallint,
    semestre_reticula smallint NOT NULL,
    creditos_prerrequisito smallint,
    especialidad "ITE"."T_especialidad",
    clave_oficial_materia character(10),
    renglon smallint,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 $   DROP TABLE "ITE".materias_carreras;
       ITE         heap 	   amaterasu    false    758    719    6    731    746            �            1259    16623 
   migrations    TABLE     �   CREATE TABLE "ITE".migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);
    DROP TABLE "ITE".migrations;
       ITE         heap 	   amaterasu    false    6            �            1259    16626    migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE "ITE".migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE "ITE".migrations_id_seq;
       ITE       	   amaterasu    false    235    6            �           0    0    migrations_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE "ITE".migrations_id_seq OWNED BY "ITE".migrations.id;
          ITE       	   amaterasu    false    236            �            1259    16628    nivel_de_estudios    TABLE     �   CREATE TABLE "ITE".nivel_de_estudios (
    nivel_estudios character(1) NOT NULL,
    descripcion_nivel_estudios character varying(100)
);
 $   DROP TABLE "ITE".nivel_de_estudios;
       ITE         heap 	   amaterasu    false    6            �            1259    16631    nivel_escolar    TABLE     j   CREATE TABLE "ITE".nivel_escolar (
    nivel_escolar character(1),
    descripcion_nivel character(50)
);
     DROP TABLE "ITE".nivel_escolar;
       ITE         heap 	   amaterasu    false    6            �            1259    16634    organigrama    TABLE     �   CREATE TABLE "ITE".organigrama (
    clave_area character(6) NOT NULL,
    descripcion_area character varying(200),
    area_depende character(6),
    siglas character(5)
);
    DROP TABLE "ITE".organigrama;
       ITE         heap 	   amaterasu    false    6            �            1259    16637    password_resets    TABLE     �   CREATE TABLE "ITE".password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);
 "   DROP TABLE "ITE".password_resets;
       ITE         heap 	   amaterasu    false    6            �            1259    16643    permisos_carreras    TABLE     �   CREATE TABLE "ITE".permisos_carreras (
    carrera "ITE"."T_carrera",
    reticula "ITE"."T_reticula",
    nombre_carrera character varying(150),
    nombre_reducido character varying(100),
    email character varying(150)
);
 $   DROP TABLE "ITE".permisos_carreras;
       ITE         heap 	   amaterasu    false    758    6    719            �            1259    16649    personal    TABLE     �  CREATE TABLE "ITE".personal (
    rfc character(13) NOT NULL,
    clave_area character(6),
    curp_empleado character(18),
    no_tarjeta integer,
    apellidos_empleado character(200),
    nombre_empleado character(100),
    nombramiento character(1) NOT NULL,
    ingreso_rama character(6),
    inicio_gobierno character(6),
    inicio_sep character(6),
    inicio_plantel character(6),
    domicilio_empleado character varying(150),
    colonia_empleado character varying(100),
    codigo_postal_empleado integer,
    telefono_empleado character varying(30),
    sexo_empleado character(1),
    estado_civil character(1),
    nivel_estudios character(1),
    grado_maximo_estudios character(1),
    estudios character varying(250),
    cedula_profesional character(15),
    status_empleado character(2),
    correo_electronico character varying(150),
    correo_institucion character varying(150),
    institucion_expide_titulo character varying(250),
    institucion_expide_cedula character varying(250),
    inactivo_rc character(1),
    documento_obtenido character varying(100),
    documento_obtenido_fecha date,
    documento_obtenido_institucion character varying(100),
    apellido_paterno character varying(100),
    apellido_materno character varying(100),
    tit_abreviado character varying(10),
    cedula_maestria character(15),
    cedula_doctorado character(15),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
    DROP TABLE "ITE".personal;
       ITE         heap 	   amaterasu    false    6            �            1259    16655    planes_de_estudio    TABLE     }   CREATE TABLE "ITE".planes_de_estudio (
    plan_de_estudio character(1) NOT NULL,
    descripcion character(100) NOT NULL
);
 $   DROP TABLE "ITE".planes_de_estudio;
       ITE         heap 	   amaterasu    false    6            �            1259    16658 	   preguntas    TABLE       CREATE TABLE "ITE".preguntas (
    encuesta character varying(1) NOT NULL,
    aspecto character varying(1) NOT NULL,
    no_pregunta integer NOT NULL,
    pregunta character varying(300),
    respuestas character varying(150),
    resp_val integer,
    consecutivo integer NOT NULL
);
    DROP TABLE "ITE".preguntas;
       ITE         heap 	   amaterasu    false    6            �            1259    16661    puestos    TABLE     h   CREATE TABLE "ITE".puestos (
    clave_puesto integer,
    descripcion_puesto character varying(200)
);
    DROP TABLE "ITE".puestos;
       ITE         heap 	   amaterasu    false    6            �            1259    16664    requisitos_materia    TABLE     �   CREATE TABLE "ITE".requisitos_materia (
    carrera "ITE"."T_carrera" NOT NULL,
    reticula "ITE"."T_reticula" NOT NULL,
    materia "ITE"."T_materia" NOT NULL,
    materia_relacion "ITE"."T_materia" NOT NULL,
    tipo_requisito "char"
);
 %   DROP TABLE "ITE".requisitos_materia;
       ITE         heap 	   amaterasu    false    746    758    719    6    746            �            1259    16670 	   role_user    TABLE     �   CREATE TABLE "ITE".role_user (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE "ITE".role_user;
       ITE         heap 	   amaterasu    false    6            �            1259    16673    role_user_id_seq    SEQUENCE     x   CREATE SEQUENCE "ITE".role_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE "ITE".role_user_id_seq;
       ITE       	   amaterasu    false    247    6            �           0    0    role_user_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE "ITE".role_user_id_seq OWNED BY "ITE".role_user.id;
          ITE       	   amaterasu    false    248            �            1259    16675    roles    TABLE     �   CREATE TABLE "ITE".roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE "ITE".roles;
       ITE         heap 	   amaterasu    false    6            �            1259    16681    roles_id_seq    SEQUENCE     t   CREATE SEQUENCE "ITE".roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE "ITE".roles_id_seq;
       ITE       	   amaterasu    false    6    249            �           0    0    roles_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE "ITE".roles_id_seq OWNED BY "ITE".roles.id;
          ITE       	   amaterasu    false    250            �            1259    16683    seleccion_materias    TABLE       CREATE TABLE "ITE".seleccion_materias (
    periodo "ITE"."T_periodo" NOT NULL,
    no_de_control "ITE"."T_no_de_control" NOT NULL,
    materia "ITE"."T_materia" NOT NULL,
    grupo character(3) NOT NULL,
    calificacion "ITE"."T_calificacion",
    tipo_evaluacion character(2),
    repeticion character(1),
    nopresento character(1),
    status_seleccion character(1),
    fecha_hora_seleccion timestamp without time zone,
    global character(1),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 %   DROP TABLE "ITE".seleccion_materias;
       ITE         heap 	   amaterasu    false    716    746    752    749    6            �           0    0    TABLE seleccion_materias    ACL     <   GRANT SELECT ON TABLE "ITE".seleccion_materias TO monedit4;
          ITE       	   amaterasu    false    251            �            1259    16689    seleccion_materias_log    TABLE     c  CREATE TABLE "ITE".seleccion_materias_log (
    periodo "ITE"."T_periodo" NOT NULL,
    no_de_control "ITE"."T_no_de_control" NOT NULL,
    materia "ITE"."T_materia" NOT NULL,
    grupo character varying(3) NOT NULL,
    movimiento character(1) NOT NULL,
    cuando timestamp without time zone NOT NULL,
    responsable character varying(150) NOT NULL
);
 )   DROP TABLE "ITE".seleccion_materias_log;
       ITE         heap 	   amaterasu    false    749    746    6    752            �            1259    16695    tipo_materia    TABLE     _   CREATE TABLE "ITE".tipo_materia (
    tipo_materia smallint,
    nombre_tipo character(120)
);
    DROP TABLE "ITE".tipo_materia;
       ITE         heap 	   amaterasu    false    6            �            1259    16698    tipos_evaluacion    TABLE     `  CREATE TABLE "ITE".tipos_evaluacion (
    plan_de_estudios character(1) NOT NULL,
    tipo_evaluacion character(2) NOT NULL,
    descripcion_evaluacion character varying(80),
    descripcion_corta_evaluacion character varying(10),
    calif_minima_aprobatoria smallint,
    usocurso character(1),
    nosegundas character(1),
    prioridad smallint
);
 #   DROP TABLE "ITE".tipos_evaluacion;
       ITE         heap 	   amaterasu    false    6            �            1259    16701    users    TABLE     w  CREATE TABLE "ITE".users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE "ITE".users;
       ITE         heap 	   amaterasu    false    6                        1259    16707    users_id_seq    SEQUENCE     t   CREATE SEQUENCE "ITE".users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE "ITE".users_id_seq;
       ITE       	   amaterasu    false    6    255            �           0    0    users_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE "ITE".users_id_seq OWNED BY "ITE".users.id;
          ITE       	   amaterasu    false    256            F           2604    16709    baja_cespeciales id    DEFAULT     x   ALTER TABLE ONLY "ITE".baja_cespeciales ALTER COLUMN id SET DEFAULT nextval('"ITE".baja_cespeciales_id_seq'::regclass);
 A   ALTER TABLE "ITE".baja_cespeciales ALTER COLUMN id DROP DEFAULT;
       ITE       	   amaterasu    false    212    211            H           2604    16710    failed_jobs id    DEFAULT     n   ALTER TABLE ONLY "ITE".failed_jobs ALTER COLUMN id SET DEFAULT nextval('"ITE".failed_jobs_id_seq'::regclass);
 <   ALTER TABLE "ITE".failed_jobs ALTER COLUMN id DROP DEFAULT;
       ITE       	   amaterasu    false    219    218            I           2604    16711    folios_constancias id    DEFAULT     |   ALTER TABLE ONLY "ITE".folios_constancias ALTER COLUMN id SET DEFAULT nextval('"ITE".folios_constancias_id_seq'::regclass);
 C   ALTER TABLE "ITE".folios_constancias ALTER COLUMN id DROP DEFAULT;
       ITE       	   amaterasu    false    222    221            J           2604    16712 
   idiomas id    DEFAULT     f   ALTER TABLE ONLY "ITE".idiomas ALTER COLUMN id SET DEFAULT nextval('"ITE".idiomas_id_seq'::regclass);
 8   ALTER TABLE "ITE".idiomas ALTER COLUMN id DROP DEFAULT;
       ITE       	   amaterasu    false    230    229            K           2604    16713    migrations id    DEFAULT     l   ALTER TABLE ONLY "ITE".migrations ALTER COLUMN id SET DEFAULT nextval('"ITE".migrations_id_seq'::regclass);
 ;   ALTER TABLE "ITE".migrations ALTER COLUMN id DROP DEFAULT;
       ITE       	   amaterasu    false    236    235            L           2604    16714    role_user id    DEFAULT     j   ALTER TABLE ONLY "ITE".role_user ALTER COLUMN id SET DEFAULT nextval('"ITE".role_user_id_seq'::regclass);
 :   ALTER TABLE "ITE".role_user ALTER COLUMN id DROP DEFAULT;
       ITE       	   amaterasu    false    248    247            M           2604    16715    roles id    DEFAULT     b   ALTER TABLE ONLY "ITE".roles ALTER COLUMN id SET DEFAULT nextval('"ITE".roles_id_seq'::regclass);
 6   ALTER TABLE "ITE".roles ALTER COLUMN id DROP DEFAULT;
       ITE       	   amaterasu    false    250    249            N           2604    16716    users id    DEFAULT     b   ALTER TABLE ONLY "ITE".users ALTER COLUMN id SET DEFAULT nextval('"ITE".users_id_seq'::regclass);
 6   ALTER TABLE "ITE".users ALTER COLUMN id DROP DEFAULT;
       ITE       	   amaterasu    false    256    255            N          0    16466    actividades_apoyo 
   TABLE DATA           L   COPY "ITE".actividades_apoyo (actividad, descripcion_actividad) FROM stdin;
    ITE       	   amaterasu    false    204   N�      O          0    16469    acumulado_historico 
   TABLE DATA           �  COPY "ITE".acumulado_historico (periodo, no_de_control, estatus_periodo_alumno, creditos_cursados, creditos_aprobados, promedio_ponderado, promedio_ponderado_acumulado, promedio_aritmetico, promedio_aritmetico_acumulado, promedio_certificado, materias_cursadas, materias_reprobadas, materias_a_examen_especial, materias_especial_reprobadas, indice_reprobacion_semestre, creditos_autorizados, indice_reprobacion_acumulado) FROM stdin;
    ITE       	   amaterasu    false    205   k�      P          0    16475    alumnos 
   TABLE DATA           �  COPY "ITE".alumnos (no_de_control, carrera, reticula, especialidad, nivel_escolar, semestre, estatus_alumno, plan_de_estudios, apellido_paterno, apellido_materno, nombre_alumno, curp_alumno, fecha_nacimiento, sexo, estado_civil, tipo_ingreso, periodo_ingreso_it, ultimo_periodo_inscrito, promedio_periodo_anterior, promedio_aritmetico_acumulado, creditos_aprobados, creditos_cursados, promedio_final_alcanzado, escuela_procedencia, entidad_procedencia, ciudad_procedencia, correo_electronico, periodos_revalidacion, becado_por, nip, usuario, fecha_actualizacion, fecha_titulacion, opcion_titulacion, periodo_titulacion, registro_patronal, digito_registro_patronal, nss, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    206   ��      Q          0    16482    alumnos_generales 
   TABLE DATA           �   COPY "ITE".alumnos_generales (no_de_control, domicilio_calle, domicilio_colonia, codigo_postal, telefono, facebook, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    207   ��      R          0    16488    apoyo_docencia 
   TABLE DATA           c   COPY "ITE".apoyo_docencia (periodo, rfc, actividad, consecutivo, especifica_actividad) FROM stdin;
    ITE       	   amaterasu    false    208         S          0    16494    aulas 
   TABLE DATA           a   COPY "ITE".aulas (aula, ubicacion, capacidad, obaervaciones, permite_cruce, estatus) FROM stdin;
    ITE       	   amaterasu    false    209   ߙ      T          0    16497    avisos_reinscripcion 
   TABLE DATA           �  COPY "ITE".avisos_reinscripcion (periodo, no_de_control, autoriza_escolar, recibo_pago, fecha_recibo, cuenta_pago, fecha_hora_seleccion, lugar_seleccion, fecha_hora_pago, lugar_pago, adeuda_escolar, adeuda_biblioteca, adeuda_financieros, otro_mensaje, baja, motivo_aviso_baja, egresa, encuesto, vobo_adelanta_sel, regular, indice_reprobacion, creditos_autorizados, estatus_reinscripcion, semestre, promedio, adeudo_especial, promedio_acumulado, proareas, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    210   ��      U          0    16503    baja_cespeciales 
   TABLE DATA           N   COPY "ITE".baja_cespeciales (periodo, no_de_control, materia, id) FROM stdin;
    ITE       	   amaterasu    false    211   �      W          0    16511    carreras 
   TABLE DATA           �   COPY "ITE".carreras (carrera, reticula, nivel_escolar, clave_oficial, nombre_carrera, nombre_reducido, siglas, carga_maxima, carga_minima, creditos_totales, modalidad, nreal, ofertar, abrev, nombre_ofertar, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    213   6�      X          0    16517    entidades_federativas 
   TABLE DATA           a   COPY "ITE".entidades_federativas (entidad_federativa, nombre_entidad, clave_entidad) FROM stdin;
    ITE       	   amaterasu    false    214   S�      Y          0    16520    especialidades 
   TABLE DATA           �   COPY "ITE".especialidades (especialidad, carrera, reticula, nombre_especialidad, creditos_optativos, creditos_especialidad, activa) FROM stdin;
    ITE       	   amaterasu    false    215   p�      Z          0    16526    estatus_alumno 
   TABLE DATA           =   COPY "ITE".estatus_alumno (estatus, descripcion) FROM stdin;
    ITE       	   amaterasu    false    216   ��      [          0    16529    evaluacion_alumnos 
   TABLE DATA           �   COPY "ITE".evaluacion_alumnos (periodo, no_de_control, materia, grupo, rfc, clave_area, encuesta, respuestas, resp_abierta, usuario, consecutivo, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    217   ��      \          0    16535    failed_jobs 
   TABLE DATA           Z   COPY "ITE".failed_jobs (id, connection, queue, payload, exception, failed_at) FROM stdin;
    ITE       	   amaterasu    false    218   ǚ      ^          0    16544    fechas_carreras 
   TABLE DATA           �   COPY "ITE".fechas_carreras (carrera, fecha_inscripcion, fecha_inicio, fecha_fin, intervalo, personas, periodo, puntero) FROM stdin;
    ITE       	   amaterasu    false    220   �      _          0    16550    folios_constancias 
   TABLE DATA           b   COPY "ITE".folios_constancias (id, folio, periodo, control, tipo, fecha, anio, quien) FROM stdin;
    ITE       	   amaterasu    false    221   �      a          0    16558    generar_listas_temporales 
   TABLE DATA           �   COPY "ITE".generar_listas_temporales (no_de_control, apellido_paterno, apellido_materno, nombre_alumno, semestre, fecha_hora_seleccion, promedio_ponderado) FROM stdin;
    ITE       	   amaterasu    false    223   �      b          0    16564    grupos 
   TABLE DATA           �   COPY "ITE".grupos (periodo, materia, grupo, estatus_grupo, capacidad_grupo, alumnos_inscritos, folio_acta, paralelo_de, exclusivo_carrera, exclusivo_reticula, rfc, tipo_personal, exclusivo, entrego, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    224   ;�      c          0    16570    historia_alumno 
   TABLE DATA             COPY "ITE".historia_alumno (periodo, no_de_control, materia, grupo, calificacion, tipo_evaluacion, fecha_calificacion, plan_de_estudios, estatus_materia, nopresento, usuario, fecha_actualizacion, periodo_acredita_materia, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    225   X�      d          0    16576    horario_administrativo 
   TABLE DATA           o   COPY "ITE".horario_administrativo (periodo, rfc, consecutivo_admvo, descripcion_horario, fcaptura) FROM stdin;
    ITE       	   amaterasu    false    226   u�      e          0    16582    horario_observaciones 
   TABLE DATA           Z   COPY "ITE".horario_observaciones (periodo, rfc, observaciones, depto, cuando) FROM stdin;
    ITE       	   amaterasu    false    227   ��      f          0    16588    horarios 
   TABLE DATA           �   COPY "ITE".horarios (periodo, rfc, tipo_horario, dia_semana, hora_inicial, hora_final, materia, grupo, aula, actividad, consecutivo, vigencia_inicio, vigencia_fin, consecutivo_admvo, tipo_personal, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    228   ��      g          0    16594    idiomas 
   TABLE DATA           4   COPY "ITE".idiomas (id, idiomas, abrev) FROM stdin;
    ITE       	   amaterasu    false    229   ̛      i          0    16599    idiomas_liberacion 
   TABLE DATA           `   COPY "ITE".idiomas_liberacion (periodo, control, calif, liberacion, idioma, opcion) FROM stdin;
    ITE       	   amaterasu    false    231   �      j          0    16605    jefes 
   TABLE DATA           b   COPY "ITE".jefes (clave_area, descripcion_area, jefe_area, rfc, correo, ext, correo2) FROM stdin;
    ITE       	   amaterasu    false    232   �      k          0    16611    materias 
   TABLE DATA           �   COPY "ITE".materias (materia, nivel_escolar, tipo_materia, clave_area, nombre_completo_materia, nombre_abreviado_materia, caracterizacion, generales, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    233   #�      l          0    16617    materias_carreras 
   TABLE DATA           �   COPY "ITE".materias_carreras (carrera, reticula, materia, creditos_materia, horas_teoricas, horas_practicas, orden_certificado, semestre_reticula, creditos_prerrequisito, especialidad, clave_oficial_materia, renglon, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    234   @�      m          0    16623 
   migrations 
   TABLE DATA           9   COPY "ITE".migrations (id, migration, batch) FROM stdin;
    ITE       	   amaterasu    false    235   ]�      o          0    16628    nivel_de_estudios 
   TABLE DATA           V   COPY "ITE".nivel_de_estudios (nivel_estudios, descripcion_nivel_estudios) FROM stdin;
    ITE       	   amaterasu    false    237   z�      p          0    16631    nivel_escolar 
   TABLE DATA           H   COPY "ITE".nivel_escolar (nivel_escolar, descripcion_nivel) FROM stdin;
    ITE       	   amaterasu    false    238   ��      q          0    16634    organigrama 
   TABLE DATA           X   COPY "ITE".organigrama (clave_area, descripcion_area, area_depende, siglas) FROM stdin;
    ITE       	   amaterasu    false    239   ��      r          0    16637    password_resets 
   TABLE DATA           B   COPY "ITE".password_resets (email, token, created_at) FROM stdin;
    ITE       	   amaterasu    false    240   ќ      M          0    16445    periodos_escolares 
   TABLE DATA             COPY "ITE".periodos_escolares (periodo, identificacion_larga, identificacion_corta, fecha_inicio, fecha_termino, inicio_vacacional_ss, fin_vacacional_ss, inicio_especial, fin_especial, cierre_horarios, cierre_seleccion, inicio_sele_alumnos, fin_sele_alumnos, inicio_vacacional, termino_vacacional, inicio_cal_docentes, fin_cal_docentes, created_at, updated_at, ccarrera) FROM stdin;
    ITE       	   amaterasu    false    203   �      s          0    16643    permisos_carreras 
   TABLE DATA           e   COPY "ITE".permisos_carreras (carrera, reticula, nombre_carrera, nombre_reducido, email) FROM stdin;
    ITE       	   amaterasu    false    241   �      t          0    16649    personal 
   TABLE DATA           �  COPY "ITE".personal (rfc, clave_area, curp_empleado, no_tarjeta, apellidos_empleado, nombre_empleado, nombramiento, ingreso_rama, inicio_gobierno, inicio_sep, inicio_plantel, domicilio_empleado, colonia_empleado, codigo_postal_empleado, telefono_empleado, sexo_empleado, estado_civil, nivel_estudios, grado_maximo_estudios, estudios, cedula_profesional, status_empleado, correo_electronico, correo_institucion, institucion_expide_titulo, institucion_expide_cedula, inactivo_rc, documento_obtenido, documento_obtenido_fecha, documento_obtenido_institucion, apellido_paterno, apellido_materno, tit_abreviado, cedula_maestria, cedula_doctorado, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    242   (�      u          0    16655    planes_de_estudio 
   TABLE DATA           H   COPY "ITE".planes_de_estudio (plan_de_estudio, descripcion) FROM stdin;
    ITE       	   amaterasu    false    243   E�      v          0    16658 	   preguntas 
   TABLE DATA           o   COPY "ITE".preguntas (encuesta, aspecto, no_pregunta, pregunta, respuestas, resp_val, consecutivo) FROM stdin;
    ITE       	   amaterasu    false    244   b�      w          0    16661    puestos 
   TABLE DATA           B   COPY "ITE".puestos (clave_puesto, descripcion_puesto) FROM stdin;
    ITE       	   amaterasu    false    245   �      x          0    16664    requisitos_materia 
   TABLE DATA           i   COPY "ITE".requisitos_materia (carrera, reticula, materia, materia_relacion, tipo_requisito) FROM stdin;
    ITE       	   amaterasu    false    246   ��      y          0    16670 	   role_user 
   TABLE DATA           P   COPY "ITE".role_user (id, role_id, user_id, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    247   ��      {          0    16675    roles 
   TABLE DATA           M   COPY "ITE".roles (id, name, description, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    249   ֝      }          0    16683    seleccion_materias 
   TABLE DATA           �   COPY "ITE".seleccion_materias (periodo, no_de_control, materia, grupo, calificacion, tipo_evaluacion, repeticion, nopresento, status_seleccion, fecha_hora_seleccion, global, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    251   �      ~          0    16689    seleccion_materias_log 
   TABLE DATA           x   COPY "ITE".seleccion_materias_log (periodo, no_de_control, materia, grupo, movimiento, cuando, responsable) FROM stdin;
    ITE       	   amaterasu    false    252   �                0    16695    tipo_materia 
   TABLE DATA           @   COPY "ITE".tipo_materia (tipo_materia, nombre_tipo) FROM stdin;
    ITE       	   amaterasu    false    253   -�      �          0    16698    tipos_evaluacion 
   TABLE DATA           �   COPY "ITE".tipos_evaluacion (plan_de_estudios, tipo_evaluacion, descripcion_evaluacion, descripcion_corta_evaluacion, calif_minima_aprobatoria, usocurso, nosegundas, prioridad) FROM stdin;
    ITE       	   amaterasu    false    254   J�      �          0    16701    users 
   TABLE DATA           t   COPY "ITE".users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
    ITE       	   amaterasu    false    255   g�      �           0    0    baja_cespeciales_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('"ITE".baja_cespeciales_id_seq', 54, true);
          ITE       	   amaterasu    false    212            �           0    0    failed_jobs_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('"ITE".failed_jobs_id_seq', 1, false);
          ITE       	   amaterasu    false    219            �           0    0    folios_constancias_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('"ITE".folios_constancias_id_seq', 382, true);
          ITE       	   amaterasu    false    222            �           0    0    idiomas_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('"ITE".idiomas_id_seq', 1, false);
          ITE       	   amaterasu    false    230            �           0    0    migrations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('"ITE".migrations_id_seq', 15, true);
          ITE       	   amaterasu    false    236            �           0    0    role_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('"ITE".role_user_id_seq', 6288, true);
          ITE       	   amaterasu    false    248            �           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('"ITE".roles_id_seq', 21, true);
          ITE       	   amaterasu    false    250            �           0    0    users_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('"ITE".users_id_seq', 6364, true);
          ITE       	   amaterasu    false    256            Z           2606    16718    aulas aulas_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY "ITE".aulas
    ADD CONSTRAINT aulas_pkey PRIMARY KEY (aula);
 9   ALTER TABLE ONLY "ITE".aulas DROP CONSTRAINT aulas_pkey;
       ITE         	   amaterasu    false    209            ^           2606    16720 &   baja_cespeciales baja_cespeciales_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY "ITE".baja_cespeciales
    ADD CONSTRAINT baja_cespeciales_pkey PRIMARY KEY (id);
 O   ALTER TABLE ONLY "ITE".baja_cespeciales DROP CONSTRAINT baja_cespeciales_pkey;
       ITE         	   amaterasu    false    211            e           2606    16722 "   estatus_alumno estatus_alumno_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY "ITE".estatus_alumno
    ADD CONSTRAINT estatus_alumno_pkey PRIMARY KEY (estatus);
 K   ALTER TABLE ONLY "ITE".estatus_alumno DROP CONSTRAINT estatus_alumno_pkey;
       ITE         	   amaterasu    false    216            h           2606    16724 *   evaluacion_alumnos evaluacion_alumnos_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY "ITE".evaluacion_alumnos
    ADD CONSTRAINT evaluacion_alumnos_pkey PRIMARY KEY (periodo, no_de_control, materia, consecutivo);
 S   ALTER TABLE ONLY "ITE".evaluacion_alumnos DROP CONSTRAINT evaluacion_alumnos_pkey;
       ITE         	   amaterasu    false    217    217    217    217            k           2606    16726    failed_jobs failed_jobs_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY "ITE".failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY "ITE".failed_jobs DROP CONSTRAINT failed_jobs_pkey;
       ITE         	   amaterasu    false    218            �           2606    16728 *   idiomas_liberacion idiomas_liberacion_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY "ITE".idiomas_liberacion
    ADD CONSTRAINT idiomas_liberacion_pkey PRIMARY KEY (control);
 S   ALTER TABLE ONLY "ITE".idiomas_liberacion DROP CONSTRAINT idiomas_liberacion_pkey;
       ITE         	   amaterasu    false    231            {           2606    16730    idiomas idiomas_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY "ITE".idiomas
    ADD CONSTRAINT idiomas_pkey PRIMARY KEY (id);
 =   ALTER TABLE ONLY "ITE".idiomas DROP CONSTRAINT idiomas_pkey;
       ITE         	   amaterasu    false    229            �           2606    16732    migrations migrations_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY "ITE".migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 C   ALTER TABLE ONLY "ITE".migrations DROP CONSTRAINT migrations_pkey;
       ITE         	   amaterasu    false    235            �           2606    16734    preguntas preguntas_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY "ITE".preguntas
    ADD CONSTRAINT preguntas_pkey PRIMARY KEY (encuesta, no_pregunta, consecutivo);
 A   ALTER TABLE ONLY "ITE".preguntas DROP CONSTRAINT preguntas_pkey;
       ITE         	   amaterasu    false    244    244    244            �           2606    16736    role_user role_user_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY "ITE".role_user
    ADD CONSTRAINT role_user_pkey PRIMARY KEY (id);
 A   ALTER TABLE ONLY "ITE".role_user DROP CONSTRAINT role_user_pkey;
       ITE         	   amaterasu    false    247            �           2606    16738    roles roles_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY "ITE".roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 9   ALTER TABLE ONLY "ITE".roles DROP CONSTRAINT roles_pkey;
       ITE         	   amaterasu    false    249            �           2606    16740    users users_email_unique 
   CONSTRAINT     S   ALTER TABLE ONLY "ITE".users
    ADD CONSTRAINT users_email_unique UNIQUE (email);
 A   ALTER TABLE ONLY "ITE".users DROP CONSTRAINT users_email_unique;
       ITE         	   amaterasu    false    255            �           2606    16742    users users_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY "ITE".users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 9   ALTER TABLE ONLY "ITE".users DROP CONSTRAINT users_pkey;
       ITE         	   amaterasu    false    255            ~           1259    16743 
   KEY_idioma    INDEX     L   CREATE INDEX "KEY_idioma" ON "ITE".idiomas_liberacion USING btree (idioma);
    DROP INDEX "ITE"."KEY_idioma";
       ITE         	   amaterasu    false    231            V           1259    16744    PK_apoyo_docencia    INDEX     t   CREATE UNIQUE INDEX "PK_apoyo_docencia" ON "ITE".apoyo_docencia USING btree (periodo, rfc, actividad, consecutivo);
 &   DROP INDEX "ITE"."PK_apoyo_docencia";
       ITE         	   amaterasu    false    208    208    208    208            v           1259    16745    PK_horario_admin    INDEX     �   CREATE UNIQUE INDEX "PK_horario_admin" ON "ITE".horario_administrativo USING btree (periodo, rfc, consecutivo_admvo, fcaptura);
 %   DROP INDEX "ITE"."PK_horario_admin";
       ITE         	   amaterasu    false    226    226    226    226                       1259    16746    PK_idiomas_lib    INDEX     X   CREATE UNIQUE INDEX "PK_idiomas_lib" ON "ITE".idiomas_liberacion USING btree (control);
 #   DROP INDEX "ITE"."PK_idiomas_lib";
       ITE         	   amaterasu    false    231            W           1259    16747    fki_AD_periodos    INDEX     N   CREATE INDEX "fki_AD_periodos" ON "ITE".apoyo_docencia USING btree (periodo);
 $   DROP INDEX "ITE"."fki_AD_periodos";
       ITE         	   amaterasu    false    208            X           1259    16748    fki_AP_activ_apoyo    INDEX     S   CREATE INDEX "fki_AP_activ_apoyo" ON "ITE".apoyo_docencia USING btree (actividad);
 '   DROP INDEX "ITE"."fki_AP_activ_apoyo";
       ITE         	   amaterasu    false    208            [           1259    16749    fki_AV_alumnos    INDEX     Y   CREATE INDEX "fki_AV_alumnos" ON "ITE".avisos_reinscripcion USING btree (no_de_control);
 #   DROP INDEX "ITE"."fki_AV_alumnos";
       ITE         	   amaterasu    false    210            Q           1259    16750    fki_A_carreras    INDEX     P   CREATE INDEX "fki_A_carreras" ON "ITE".alumnos USING btree (carrera, reticula);
 #   DROP INDEX "ITE"."fki_A_carreras";
       ITE         	   amaterasu    false    206    206            R           1259    16751    fki_A_estatus    INDEX     L   CREATE INDEX "fki_A_estatus" ON "ITE".alumnos USING btree (estatus_alumno);
 "   DROP INDEX "ITE"."fki_A_estatus";
       ITE         	   amaterasu    false    206            S           1259    16752    fki_A_plan_estudio    INDEX     S   CREATE INDEX "fki_A_plan_estudio" ON "ITE".alumnos USING btree (plan_de_estudios);
 '   DROP INDEX "ITE"."fki_A_plan_estudio";
       ITE         	   amaterasu    false    206            b           1259    16753    fki_ESP_carreras    INDEX     Y   CREATE INDEX "fki_ESP_carreras" ON "ITE".especialidades USING btree (carrera, reticula);
 %   DROP INDEX "ITE"."fki_ESP_carreras";
       ITE         	   amaterasu    false    215    215            l           1259    16754    fki_FC_alumnos    INDEX     Q   CREATE INDEX "fki_FC_alumnos" ON "ITE".folios_constancias USING btree (control);
 #   DROP INDEX "ITE"."fki_FC_alumnos";
       ITE         	   amaterasu    false    221            m           1259    16755    fki_FC_periodo    INDEX     Q   CREATE INDEX "fki_FC_periodo" ON "ITE".folios_constancias USING btree (periodo);
 #   DROP INDEX "ITE"."fki_FC_periodo";
       ITE         	   amaterasu    false    221            o           1259    16756    fki_G_carreras    INDEX     c   CREATE INDEX "fki_G_carreras" ON "ITE".grupos USING btree (exclusivo_carrera, exclusivo_reticula);
 #   DROP INDEX "ITE"."fki_G_carreras";
       ITE         	   amaterasu    false    224    224            p           1259    16757    fki_G_materias    INDEX     E   CREATE INDEX "fki_G_materias" ON "ITE".grupos USING btree (materia);
 #   DROP INDEX "ITE"."fki_G_materias";
       ITE         	   amaterasu    false    224            q           1259    16758    fki_G_periodos    INDEX     E   CREATE INDEX "fki_G_periodos" ON "ITE".grupos USING btree (periodo);
 #   DROP INDEX "ITE"."fki_G_periodos";
       ITE         	   amaterasu    false    224            s           1259    16759    fki_HA_alumnos    INDEX     T   CREATE INDEX "fki_HA_alumnos" ON "ITE".historia_alumno USING btree (no_de_control);
 #   DROP INDEX "ITE"."fki_HA_alumnos";
       ITE         	   amaterasu    false    225            w           1259    16760    fki_HA_periodos    INDEX     V   CREATE INDEX "fki_HA_periodos" ON "ITE".horario_administrativo USING btree (periodo);
 $   DROP INDEX "ITE"."fki_HA_periodos";
       ITE         	   amaterasu    false    226            t           1259    16761    fki_HA_tipos_ev    INDEX     i   CREATE INDEX "fki_HA_tipos_ev" ON "ITE".historia_alumno USING btree (tipo_evaluacion, plan_de_estudios);
 $   DROP INDEX "ITE"."fki_HA_tipos_ev";
       ITE         	   amaterasu    false    225    225            x           1259    16762    fki_HO_periodos    INDEX     U   CREATE INDEX "fki_HO_periodos" ON "ITE".horario_observaciones USING btree (periodo);
 $   DROP INDEX "ITE"."fki_HO_periodos";
       ITE         	   amaterasu    false    227            �           1259    16763    fki_MC_carreras    INDEX     [   CREATE INDEX "fki_MC_carreras" ON "ITE".materias_carreras USING btree (carrera, reticula);
 $   DROP INDEX "ITE"."fki_MC_carreras";
       ITE         	   amaterasu    false    234    234            �           1259    16764    fki_MC_materias    INDEX     Q   CREATE INDEX "fki_MC_materias" ON "ITE".materias_carreras USING btree (materia);
 $   DROP INDEX "ITE"."fki_MC_materias";
       ITE         	   amaterasu    false    234            �           1259    16765    fki_M_nivel_es    INDEX     M   CREATE INDEX "fki_M_nivel_es" ON "ITE".materias USING btree (nivel_escolar);
 #   DROP INDEX "ITE"."fki_M_nivel_es";
       ITE         	   amaterasu    false    233            �           1259    16766    fki_M_organigrama    INDEX     M   CREATE INDEX "fki_M_organigrama" ON "ITE".materias USING btree (clave_area);
 &   DROP INDEX "ITE"."fki_M_organigrama";
       ITE         	   amaterasu    false    233            �           1259    16767    fki_M_tipo_materia    INDEX     P   CREATE INDEX "fki_M_tipo_materia" ON "ITE".materias USING btree (tipo_materia);
 '   DROP INDEX "ITE"."fki_M_tipo_materia";
       ITE         	   amaterasu    false    233            �           1259    16768    fki_PC_carreras    INDEX     [   CREATE INDEX "fki_PC_carreras" ON "ITE".permisos_carreras USING btree (carrera, reticula);
 $   DROP INDEX "ITE"."fki_PC_carreras";
       ITE         	   amaterasu    false    241    241            �           1259    16769    fki_P_nivel_estudios    INDEX     T   CREATE INDEX "fki_P_nivel_estudios" ON "ITE".personal USING btree (nivel_estudios);
 )   DROP INDEX "ITE"."fki_P_nivel_estudios";
       ITE         	   amaterasu    false    242            �           1259    16770    fki_REQ_carreras    INDEX     ]   CREATE INDEX "fki_REQ_carreras" ON "ITE".requisitos_materia USING btree (carrera, reticula);
 %   DROP INDEX "ITE"."fki_REQ_carreras";
       ITE         	   amaterasu    false    246    246            �           1259    16771    fki_REQ_materias    INDEX     S   CREATE INDEX "fki_REQ_materias" ON "ITE".requisitos_materia USING btree (materia);
 %   DROP INDEX "ITE"."fki_REQ_materias";
       ITE         	   amaterasu    false    246            �           1259    16772    fki_SM_alumnos    INDEX     W   CREATE INDEX "fki_SM_alumnos" ON "ITE".seleccion_materias USING btree (no_de_control);
 #   DROP INDEX "ITE"."fki_SM_alumnos";
       ITE         	   amaterasu    false    251            �           1259    16773    fki_SM_periodos    INDEX     R   CREATE INDEX "fki_SM_periodos" ON "ITE".seleccion_materias USING btree (periodo);
 $   DROP INDEX "ITE"."fki_SM_periodos";
       ITE         	   amaterasu    false    251            �           1259    16774    fki_TE_planes_estudio    INDEX     _   CREATE INDEX "fki_TE_planes_estudio" ON "ITE".tipos_evaluacion USING btree (plan_de_estudios);
 *   DROP INDEX "ITE"."fki_TE_planes_estudio";
       ITE         	   amaterasu    false    254            �           1259    16775    password_resets_email_index    INDEX     W   CREATE INDEX password_resets_email_index ON "ITE".password_resets USING btree (email);
 .   DROP INDEX "ITE".password_resets_email_index;
       ITE         	   amaterasu    false    240            P           1259    16776    pk_actividades_apoyo    INDEX     ]   CREATE UNIQUE INDEX pk_actividades_apoyo ON "ITE".actividades_apoyo USING btree (actividad);
 '   DROP INDEX "ITE".pk_actividades_apoyo;
       ITE         	   amaterasu    false    204            T           1259    16777 
   pk_alumnos    INDEX     M   CREATE UNIQUE INDEX pk_alumnos ON "ITE".alumnos USING btree (no_de_control);
    DROP INDEX "ITE".pk_alumnos;
       ITE         	   amaterasu    false    206            U           1259    16778    pk_alumnos_generales    INDEX     a   CREATE UNIQUE INDEX pk_alumnos_generales ON "ITE".alumnos_generales USING btree (no_de_control);
 '   DROP INDEX "ITE".pk_alumnos_generales;
       ITE         	   amaterasu    false    207            \           1259    16779    pk_avisos_reinscripcion    INDEX     p   CREATE UNIQUE INDEX pk_avisos_reinscripcion ON "ITE".avisos_reinscripcion USING btree (periodo, no_de_control);
 *   DROP INDEX "ITE".pk_avisos_reinscripcion;
       ITE         	   amaterasu    false    210    210            _           1259    16780    pk_baja_especiales    INDEX     p   CREATE UNIQUE INDEX pk_baja_especiales ON "ITE".baja_cespeciales USING btree (periodo, no_de_control, materia);
 %   DROP INDEX "ITE".pk_baja_especiales;
       ITE         	   amaterasu    false    211    211    211            `           1259    16781    pk_carreras    INDEX     S   CREATE UNIQUE INDEX pk_carreras ON "ITE".carreras USING btree (carrera, reticula);
    DROP INDEX "ITE".pk_carreras;
       ITE         	   amaterasu    false    213    213            a           1259    16782    pk_entidades_federativas    INDEX     n   CREATE UNIQUE INDEX pk_entidades_federativas ON "ITE".entidades_federativas USING btree (entidad_federativa);
 +   DROP INDEX "ITE".pk_entidades_federativas;
       ITE         	   amaterasu    false    214            c           1259    16783    pk_especialidades    INDEX     Z   CREATE UNIQUE INDEX pk_especialidades ON "ITE".especialidades USING btree (especialidad);
 $   DROP INDEX "ITE".pk_especialidades;
       ITE         	   amaterasu    false    215            f           1259    16784 
   pk_estatus    INDEX     N   CREATE UNIQUE INDEX pk_estatus ON "ITE".estatus_alumno USING btree (estatus);
    DROP INDEX "ITE".pk_estatus;
       ITE         	   amaterasu    false    216            i           1259    16785    pk_evaluacion_alumnos    INDEX     �   CREATE UNIQUE INDEX pk_evaluacion_alumnos ON "ITE".evaluacion_alumnos USING btree (periodo, no_de_control, materia, consecutivo);
 (   DROP INDEX "ITE".pk_evaluacion_alumnos;
       ITE         	   amaterasu    false    217    217    217    217            n           1259    16786    pk_folios_const    INDEX     g   CREATE UNIQUE INDEX pk_folios_const ON "ITE".folios_constancias USING btree (folio, periodo, control);
 "   DROP INDEX "ITE".pk_folios_const;
       ITE         	   amaterasu    false    221    221    221            r           1259    16787 	   pk_grupos    INDEX     U   CREATE UNIQUE INDEX pk_grupos ON "ITE".grupos USING btree (periodo, materia, grupo);
    DROP INDEX "ITE".pk_grupos;
       ITE         	   amaterasu    false    224    224    224            u           1259    16788    pk_historia_alumno    INDEX     �   CREATE UNIQUE INDEX pk_historia_alumno ON "ITE".historia_alumno USING btree (periodo, no_de_control, materia, fecha_calificacion);
 %   DROP INDEX "ITE".pk_historia_alumno;
       ITE         	   amaterasu    false    225    225    225    225            y           1259    16789    pk_horario_obs    INDEX     m   CREATE UNIQUE INDEX pk_horario_obs ON "ITE".horario_observaciones USING btree (periodo, rfc, observaciones);
 !   DROP INDEX "ITE".pk_horario_obs;
       ITE         	   amaterasu    false    227    227    227            |           1259    16790 
   pk_idiomas    INDEX     B   CREATE UNIQUE INDEX pk_idiomas ON "ITE".idiomas USING btree (id);
    DROP INDEX "ITE".pk_idiomas;
       ITE         	   amaterasu    false    229            }           1259    16791    pk_idiomas2    INDEX     S   CREATE UNIQUE INDEX pk_idiomas2 ON "ITE".idiomas USING btree (id, idiomas, abrev);
    DROP INDEX "ITE".pk_idiomas2;
       ITE         	   amaterasu    false    229    229    229            �           1259    16792    pk_jefes    INDEX     F   CREATE UNIQUE INDEX pk_jefes ON "ITE".jefes USING btree (clave_area);
    DROP INDEX "ITE".pk_jefes;
       ITE         	   amaterasu    false    232            �           1259    16793    pk_materias    INDEX     I   CREATE UNIQUE INDEX pk_materias ON "ITE".materias USING btree (materia);
    DROP INDEX "ITE".pk_materias;
       ITE         	   amaterasu    false    233            �           1259    16794    pk_materias_carreras    INDEX     |   CREATE UNIQUE INDEX pk_materias_carreras ON "ITE".materias_carreras USING btree (carrera, reticula, materia, especialidad);
 '   DROP INDEX "ITE".pk_materias_carreras;
       ITE         	   amaterasu    false    234    234    234    234            �           1259    16795    pk_nivel_escolar    INDEX     Y   CREATE UNIQUE INDEX pk_nivel_escolar ON "ITE".nivel_escolar USING btree (nivel_escolar);
 #   DROP INDEX "ITE".pk_nivel_escolar;
       ITE         	   amaterasu    false    238            �           1259    16796    pk_nivel_estudios    INDEX     _   CREATE UNIQUE INDEX pk_nivel_estudios ON "ITE".nivel_de_estudios USING btree (nivel_estudios);
 $   DROP INDEX "ITE".pk_nivel_estudios;
       ITE         	   amaterasu    false    237            �           1259    16797    pk_organigrama    INDEX     R   CREATE UNIQUE INDEX pk_organigrama ON "ITE".organigrama USING btree (clave_area);
 !   DROP INDEX "ITE".pk_organigrama;
       ITE         	   amaterasu    false    239            O           1259    16798    pk_periodos_escolares    INDEX     ]   CREATE UNIQUE INDEX pk_periodos_escolares ON "ITE".periodos_escolares USING btree (periodo);
 (   DROP INDEX "ITE".pk_periodos_escolares;
       ITE         	   amaterasu    false    203            �           1259    16799    pk_personal    INDEX     T   CREATE UNIQUE INDEX pk_personal ON "ITE".personal USING btree (correo_institucion);
    DROP INDEX "ITE".pk_personal;
       ITE         	   amaterasu    false    242            �           1259    16800    pk_plan_estudios    INDEX     _   CREATE UNIQUE INDEX pk_plan_estudios ON "ITE".planes_de_estudio USING btree (plan_de_estudio);
 #   DROP INDEX "ITE".pk_plan_estudios;
       ITE         	   amaterasu    false    243            �           1259    16801    pk_preguntas    INDEX     o   CREATE UNIQUE INDEX pk_preguntas ON "ITE".preguntas USING btree (encuesta, aspecto, no_pregunta, consecutivo);
    DROP INDEX "ITE".pk_preguntas;
       ITE         	   amaterasu    false    244    244    244    244            �           1259    16802 
   pk_puestos    INDEX     L   CREATE UNIQUE INDEX pk_puestos ON "ITE".puestos USING btree (clave_puesto);
    DROP INDEX "ITE".pk_puestos;
       ITE         	   amaterasu    false    245            �           1259    16803    pk_requisitos_materia    INDEX     �   CREATE UNIQUE INDEX pk_requisitos_materia ON "ITE".requisitos_materia USING btree (carrera, reticula, materia, materia_relacion);
 (   DROP INDEX "ITE".pk_requisitos_materia;
       ITE         	   amaterasu    false    246    246    246    246            �           1259    16804    pk_seleccion_materias    INDEX     |   CREATE UNIQUE INDEX pk_seleccion_materias ON "ITE".seleccion_materias USING btree (periodo, no_de_control, materia, grupo);
 (   DROP INDEX "ITE".pk_seleccion_materias;
       ITE         	   amaterasu    false    251    251    251    251            �           1259    16805    pk_tipo_materia    INDEX     V   CREATE UNIQUE INDEX pk_tipo_materia ON "ITE".tipo_materia USING btree (tipo_materia);
 "   DROP INDEX "ITE".pk_tipo_materia;
       ITE         	   amaterasu    false    253            �           1259    16806    pk_tipos_evaluacion    INDEX     s   CREATE UNIQUE INDEX pk_tipos_evaluacion ON "ITE".tipos_evaluacion USING btree (plan_de_estudios, tipo_evaluacion);
 &   DROP INDEX "ITE".pk_tipos_evaluacion;
       ITE         	   amaterasu    false    254    254            �           2620    16807    horarios trig_horario    TRIGGER     p   CREATE TRIGGER trig_horario BEFORE INSERT ON "ITE".horarios FOR EACH ROW EXECUTE FUNCTION "ITE".alta_horario();
 -   DROP TRIGGER trig_horario ON "ITE".horarios;
       ITE       	   amaterasu    false    228    259            �           2606    16808    apoyo_docencia AD_periodos    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".apoyo_docencia
    ADD CONSTRAINT "AD_periodos" FOREIGN KEY (periodo) REFERENCES "ITE".periodos_escolares(periodo) NOT VALID;
 E   ALTER TABLE ONLY "ITE".apoyo_docencia DROP CONSTRAINT "AD_periodos";
       ITE       	   amaterasu    false    208    3151    203            �           2606    16813    alumnos_generales AG_alumnos    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".alumnos_generales
    ADD CONSTRAINT "AG_alumnos" FOREIGN KEY (no_de_control) REFERENCES "ITE".alumnos(no_de_control) NOT VALID;
 G   ALTER TABLE ONLY "ITE".alumnos_generales DROP CONSTRAINT "AG_alumnos";
       ITE       	   amaterasu    false    207    3156    206            �           2606    16818    apoyo_docencia AP_activ_apoyo    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".apoyo_docencia
    ADD CONSTRAINT "AP_activ_apoyo" FOREIGN KEY (actividad) REFERENCES "ITE".actividades_apoyo(actividad) NOT VALID;
 H   ALTER TABLE ONLY "ITE".apoyo_docencia DROP CONSTRAINT "AP_activ_apoyo";
       ITE       	   amaterasu    false    3152    208    204            �           2606    16823    avisos_reinscripcion AV_alumnos    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".avisos_reinscripcion
    ADD CONSTRAINT "AV_alumnos" FOREIGN KEY (no_de_control) REFERENCES "ITE".alumnos(no_de_control) NOT VALID;
 J   ALTER TABLE ONLY "ITE".avisos_reinscripcion DROP CONSTRAINT "AV_alumnos";
       ITE       	   amaterasu    false    210    206    3156            �           2606    16828    alumnos A_carreras    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".alumnos
    ADD CONSTRAINT "A_carreras" FOREIGN KEY (carrera, reticula) REFERENCES "ITE".carreras(carrera, reticula) NOT VALID;
 =   ALTER TABLE ONLY "ITE".alumnos DROP CONSTRAINT "A_carreras";
       ITE       	   amaterasu    false    213    3168    206    206    213            �           2606    16833    alumnos A_estatus    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".alumnos
    ADD CONSTRAINT "A_estatus" FOREIGN KEY (estatus_alumno) REFERENCES "ITE".estatus_alumno(estatus) NOT VALID;
 <   ALTER TABLE ONLY "ITE".alumnos DROP CONSTRAINT "A_estatus";
       ITE       	   amaterasu    false    3173    206    216            �           2606    16838    alumnos A_plan_estudio    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".alumnos
    ADD CONSTRAINT "A_plan_estudio" FOREIGN KEY (plan_de_estudios) REFERENCES "ITE".planes_de_estudio(plan_de_estudio) NOT VALID;
 A   ALTER TABLE ONLY "ITE".alumnos DROP CONSTRAINT "A_plan_estudio";
       ITE       	   amaterasu    false    243    206    3219            �           2606    16843    especialidades ESP_carreras    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".especialidades
    ADD CONSTRAINT "ESP_carreras" FOREIGN KEY (carrera, reticula) REFERENCES "ITE".carreras(carrera, reticula) NOT VALID;
 F   ALTER TABLE ONLY "ITE".especialidades DROP CONSTRAINT "ESP_carreras";
       ITE       	   amaterasu    false    213    215    215    3168    213            �           2606    16848    folios_constancias FC_alumnos    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".folios_constancias
    ADD CONSTRAINT "FC_alumnos" FOREIGN KEY (control) REFERENCES "ITE".alumnos(no_de_control) NOT VALID;
 H   ALTER TABLE ONLY "ITE".folios_constancias DROP CONSTRAINT "FC_alumnos";
       ITE       	   amaterasu    false    221    206    3156            �           2606    16853    folios_constancias FC_periodo    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".folios_constancias
    ADD CONSTRAINT "FC_periodo" FOREIGN KEY (periodo) REFERENCES "ITE".periodos_escolares(periodo) NOT VALID;
 H   ALTER TABLE ONLY "ITE".folios_constancias DROP CONSTRAINT "FC_periodo";
       ITE       	   amaterasu    false    203    3151    221            �           2606    16858    grupos G_carreras    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".grupos
    ADD CONSTRAINT "G_carreras" FOREIGN KEY (exclusivo_carrera, exclusivo_reticula) REFERENCES "ITE".carreras(carrera, reticula) NOT VALID;
 <   ALTER TABLE ONLY "ITE".grupos DROP CONSTRAINT "G_carreras";
       ITE       	   amaterasu    false    213    213    3168    224    224            �           2606    16863    grupos G_materias    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".grupos
    ADD CONSTRAINT "G_materias" FOREIGN KEY (materia) REFERENCES "ITE".materias(materia) ON UPDATE CASCADE NOT VALID;
 <   ALTER TABLE ONLY "ITE".grupos DROP CONSTRAINT "G_materias";
       ITE       	   amaterasu    false    224    233    3206            �           2606    16868    grupos G_periodos    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".grupos
    ADD CONSTRAINT "G_periodos" FOREIGN KEY (periodo) REFERENCES "ITE".periodos_escolares(periodo) NOT VALID;
 <   ALTER TABLE ONLY "ITE".grupos DROP CONSTRAINT "G_periodos";
       ITE       	   amaterasu    false    3151    224    203            �           2606    16873    historia_alumno HA_alumnos    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".historia_alumno
    ADD CONSTRAINT "HA_alumnos" FOREIGN KEY (no_de_control) REFERENCES "ITE".alumnos(no_de_control) NOT VALID;
 E   ALTER TABLE ONLY "ITE".historia_alumno DROP CONSTRAINT "HA_alumnos";
       ITE       	   amaterasu    false    206    225    3156            �           2606    16878 "   horario_administrativo HA_periodos    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".horario_administrativo
    ADD CONSTRAINT "HA_periodos" FOREIGN KEY (periodo) REFERENCES "ITE".periodos_escolares(periodo) NOT VALID;
 M   ALTER TABLE ONLY "ITE".horario_administrativo DROP CONSTRAINT "HA_periodos";
       ITE       	   amaterasu    false    226    203    3151            �           2606    16883    historia_alumno HA_tipos_ev    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".historia_alumno
    ADD CONSTRAINT "HA_tipos_ev" FOREIGN KEY (tipo_evaluacion, plan_de_estudios) REFERENCES "ITE".tipos_evaluacion(tipo_evaluacion, plan_de_estudios) NOT VALID;
 F   ALTER TABLE ONLY "ITE".historia_alumno DROP CONSTRAINT "HA_tipos_ev";
       ITE       	   amaterasu    false    3236    225    225    254    254            �           2606    16888 !   horario_observaciones HO_periodos    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".horario_observaciones
    ADD CONSTRAINT "HO_periodos" FOREIGN KEY (periodo) REFERENCES "ITE".periodos_escolares(periodo) NOT VALID;
 L   ALTER TABLE ONLY "ITE".horario_observaciones DROP CONSTRAINT "HO_periodos";
       ITE       	   amaterasu    false    203    227    3151            �           2606    16893    idiomas_liberacion IL_idiomas    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".idiomas_liberacion
    ADD CONSTRAINT "IL_idiomas" FOREIGN KEY (idioma) REFERENCES "ITE".idiomas(id) NOT VALID;
 H   ALTER TABLE ONLY "ITE".idiomas_liberacion DROP CONSTRAINT "IL_idiomas";
       ITE       	   amaterasu    false    229    231    3195            �           2606    16898    jefes JEF_org    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".jefes
    ADD CONSTRAINT "JEF_org" FOREIGN KEY (clave_area) REFERENCES "ITE".organigrama(clave_area) NOT VALID;
 8   ALTER TABLE ONLY "ITE".jefes DROP CONSTRAINT "JEF_org";
       ITE       	   amaterasu    false    239    232    3214            �           2606    16903    materias_carreras MC_carreras    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".materias_carreras
    ADD CONSTRAINT "MC_carreras" FOREIGN KEY (carrera, reticula) REFERENCES "ITE".carreras(carrera, reticula) NOT VALID;
 H   ALTER TABLE ONLY "ITE".materias_carreras DROP CONSTRAINT "MC_carreras";
       ITE       	   amaterasu    false    213    234    234    213    3168            �           2606    16908    materias_carreras MC_materias    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".materias_carreras
    ADD CONSTRAINT "MC_materias" FOREIGN KEY (materia) REFERENCES "ITE".materias(materia) ON UPDATE CASCADE NOT VALID;
 H   ALTER TABLE ONLY "ITE".materias_carreras DROP CONSTRAINT "MC_materias";
       ITE       	   amaterasu    false    3206    234    233            �           2606    16913    materias M_nivel_es    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".materias
    ADD CONSTRAINT "M_nivel_es" FOREIGN KEY (nivel_escolar) REFERENCES "ITE".nivel_escolar(nivel_escolar) NOT VALID;
 >   ALTER TABLE ONLY "ITE".materias DROP CONSTRAINT "M_nivel_es";
       ITE       	   amaterasu    false    233    238    3213            �           2606    16918    materias M_organigrama    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".materias
    ADD CONSTRAINT "M_organigrama" FOREIGN KEY (clave_area) REFERENCES "ITE".organigrama(clave_area) NOT VALID;
 A   ALTER TABLE ONLY "ITE".materias DROP CONSTRAINT "M_organigrama";
       ITE       	   amaterasu    false    3214    233    239            �           2606    16923    materias M_tipo_materia    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".materias
    ADD CONSTRAINT "M_tipo_materia" FOREIGN KEY (tipo_materia) REFERENCES "ITE".tipo_materia(tipo_materia) NOT VALID;
 B   ALTER TABLE ONLY "ITE".materias DROP CONSTRAINT "M_tipo_materia";
       ITE       	   amaterasu    false    253    233    3234            �           2606    16928    permisos_carreras PC_carreras    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".permisos_carreras
    ADD CONSTRAINT "PC_carreras" FOREIGN KEY (carrera, reticula) REFERENCES "ITE".carreras(carrera, reticula) NOT VALID;
 H   ALTER TABLE ONLY "ITE".permisos_carreras DROP CONSTRAINT "PC_carreras";
       ITE       	   amaterasu    false    213    241    213    241    3168            �           2606    16933    personal P_nivel_estudios    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".personal
    ADD CONSTRAINT "P_nivel_estudios" FOREIGN KEY (nivel_estudios) REFERENCES "ITE".nivel_de_estudios(nivel_estudios) NOT VALID;
 D   ALTER TABLE ONLY "ITE".personal DROP CONSTRAINT "P_nivel_estudios";
       ITE       	   amaterasu    false    237    3212    242            �           2606    16938    requisitos_materia REQ_carreras    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".requisitos_materia
    ADD CONSTRAINT "REQ_carreras" FOREIGN KEY (carrera, reticula) REFERENCES "ITE".carreras(carrera, reticula) NOT VALID;
 J   ALTER TABLE ONLY "ITE".requisitos_materia DROP CONSTRAINT "REQ_carreras";
       ITE       	   amaterasu    false    246    246    3168    213    213            �           2606    16943    requisitos_materia REQ_materias    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".requisitos_materia
    ADD CONSTRAINT "REQ_materias" FOREIGN KEY (materia) REFERENCES "ITE".materias(materia) NOT VALID;
 J   ALTER TABLE ONLY "ITE".requisitos_materia DROP CONSTRAINT "REQ_materias";
       ITE       	   amaterasu    false    233    3206    246            �           2606    16948    seleccion_materias SM_alumnos    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".seleccion_materias
    ADD CONSTRAINT "SM_alumnos" FOREIGN KEY (no_de_control) REFERENCES "ITE".alumnos(no_de_control) NOT VALID;
 H   ALTER TABLE ONLY "ITE".seleccion_materias DROP CONSTRAINT "SM_alumnos";
       ITE       	   amaterasu    false    3156    206    251            �           2606    16953    seleccion_materias SM_periodos    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".seleccion_materias
    ADD CONSTRAINT "SM_periodos" FOREIGN KEY (periodo) REFERENCES "ITE".periodos_escolares(periodo) NOT VALID;
 I   ALTER TABLE ONLY "ITE".seleccion_materias DROP CONSTRAINT "SM_periodos";
       ITE       	   amaterasu    false    3151    203    251            �           2606    16958 "   tipos_evaluacion TE_planes_estudio    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".tipos_evaluacion
    ADD CONSTRAINT "TE_planes_estudio" FOREIGN KEY (plan_de_estudios) REFERENCES "ITE".planes_de_estudio(plan_de_estudio) NOT VALID;
 M   ALTER TABLE ONLY "ITE".tipos_evaluacion DROP CONSTRAINT "TE_planes_estudio";
       ITE       	   amaterasu    false    243    254    3219            �           2606    16963 #   role_user role_user_role_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".role_user
    ADD CONSTRAINT role_user_role_id_foreign FOREIGN KEY (role_id) REFERENCES "ITE".roles(id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY "ITE".role_user DROP CONSTRAINT role_user_role_id_foreign;
       ITE       	   amaterasu    false    3230    249    247            �           2606    16968 #   role_user role_user_user_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY "ITE".role_user
    ADD CONSTRAINT role_user_user_id_foreign FOREIGN KEY (user_id) REFERENCES "ITE".users(id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY "ITE".role_user DROP CONSTRAINT role_user_user_id_foreign;
       ITE       	   amaterasu    false    247    255    3240            N      x������ � �      O      x������ � �      P      x������ � �      Q      x������ � �      R      x������ � �      S      x������ � �      T      x������ � �      U      x������ � �      W      x������ � �      X      x������ � �      Y      x������ � �      Z      x������ � �      [      x������ � �      \      x������ � �      ^      x������ � �      _      x������ � �      a      x������ � �      b      x������ � �      c      x������ � �      d      x������ � �      e      x������ � �      f      x������ � �      g      x������ � �      i      x������ � �      j      x������ � �      k      x������ � �      l      x������ � �      m      x������ � �      o      x������ � �      p      x������ � �      q      x������ � �      r      x������ � �      M      x������ � �      s      x������ � �      t      x������ � �      u      x������ � �      v      x������ � �      w      x������ � �      x      x������ � �      y      x������ � �      {      x������ � �      }      x������ � �      ~      x������ � �            x������ � �      �      x������ � �      �      x������ � �     