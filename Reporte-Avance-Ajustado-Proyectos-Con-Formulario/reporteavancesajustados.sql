SELECT
/**
 * Creación:
 * 18-05-2022. Andrés Del Río. Devuelve los porcentajes de avance planificados, reprogramdos y reales, DEL DÍA, de todos los proyectos, 
 * ajustados por costos, de acuerdo a cálculo realizado por cliente.
 * Versión: 2.1.6.215
 * Ambiente: https://abastible.softexpert.com/
 * Panel de Análisis: REPOHISTAVAN - Reporte Histórico de Avances de Proyectos [Formulario]
 * 
 * Modificaciones:
 * DD-MM-AAAA. Autor. Descripción.
 */
        1 AS cantidad,
        tmp.*           
    FROM
        (SELECT
            WFP.idprocess,
            AB.codiproy,
            AB.idenproy,
            AB.tituproy,
            FORMPPAL.fechregi,
            CAST(AB.porcplan AS NUMERIC),
            CAST(AB.porcrepro AS NUMERIC),
            CAST(AB.porcreal AS NUMERIC)                       
        FROM
            WFPROCESS WFP     
        JOIN
            GNASSOCFORMREG REG                                                                                                           
                ON WFP.CDASSOCREG = REG.CDASSOC                                                           
        JOIN
            DYNrepoavanhist FORMPPAL   
		 		ON REG.OIDENTITYREG = FORMPPAL.OID
        JOIN
            DYNhistavanreal AB 
                ON AB.OIDABCR3D2BF88GGAF = FORMPPAL.OID) tmp   
    ORDER BY
        tmp.fechregi,
        idenproy	             