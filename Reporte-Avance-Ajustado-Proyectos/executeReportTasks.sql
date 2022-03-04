/**
2022-02-09. Andrés Del Río
Este script permite crear una función que ejecuta varias tareas para actualizar las tablas
que contienen los avances de proyectos, ajustados por costos planificados.
La función es usada en un workflow SE Suite que se ejecuta todos los días, como alternativa
al agendamiento de un job en el pgadmin de Softexpert.
**/

create or replace function executeReportTasks()
returns int
language plpgsql
as
$$
declare
records integer;
begin

		--En reemplazo de las Acciones 1 y 2 del procedimiento enviado a SE
		truncate table CUSTPROJPLANDATA RESTART IDENTITY;

		--Acción 4
		select saveProjHistData(nmidtask) from prtask
		where cdtask = cdbasetask;

		--Acción 7
		select saveProjTodayData();

        SELECT count(*)
        INTO records
        FROM CUSTPROJPLANDATA;
        
        RETURN records;

end;
$$;



