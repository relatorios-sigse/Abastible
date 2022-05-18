SELECT
/**
 * Creación:
 * 18-05-2022. Andrés Del Río. Devuelve los porcentajes de avance planificados, reprogramdos y reales, de todos los proyectos, 
 * ajustados por costos, de acuerdo a cálculo realizado por cliente.
 * Versión: 2.1.6.215
 * Ambiente: https://abastible.softexpert.com/
 * Formulario: FORM-AVAN-AJUS - Formulario Avance Ajustados de Proyectos
 * Query: datadeldia
 * 
 * Modificaciones:
 * DD-MM-AAAA. Autor. Descripción.
 */
		DISTINCT
        DATPLAN.CD_PROYECTO cd_project,
        DATPLAN.ID_PROYECTO id_project,
        DATPLAN.PROYECTO title,
        CURRENT_DATE record_date,
        DATPLAN.PORC_PLAN_PROY_AJUS plan_progress,
        DATPLAN.PORC_REPR_PROY_AJUS repl_progress,
        DATREAL.PORC_REAL_PROY_AJUS actual_progress  
    FROM
        (SELECT
            TBL4.CD_PROYECTO,
            TBL4.ID_PROYECTO,
            TBL4.PROYECTO,
            TBL4.CLC_INGENIERIA,
            TBL4.INGENIERIA,
            TBL4.CLC_EJECUCION,
            TBL4.EJECUCION,
            TBL4.PERMISOS,
            TBL4.PEM,
            TBL4.CIERRE,
            TBL4.SUMATORIA_FASES,
            TBL4.PORC_PLAN_CLC_INGENIERIA,
            TBL4.PORC_PLAN_INGENIERIA,
            TBL4.PORC_PLAN_CLC_EJECUCION,
            TBL4.PORC_PLAN_EJECUCION,
            TBL4.PORC_PLAN_PERMISOS,
            TBL4.PORC_PLAN_PEM,
            TBL4.PORC_PLAN_CIERRE,
            TBL4.PORC_REPR_CLC_INGENIERIA,
            TBL4.PORC_REPR_INGENIERIA,
            TBL4.PORC_REPR_CLC_EJECUCION,
            TBL4.PORC_REPR_EJECUCION,
            TBL4.PORC_REPR_PERMISOS,
            TBL4.PORC_REPR_PEM,
            TBL4.PORC_REPR_CIERRE,
            ROUND((TBL4.CLC_INGENIERIA / TBL4.SUMATORIA_FASES) * 100,
            2) PORC_PESO_CLC_INGENIERIA,
            ROUND((TBL4.INGENIERIA / TBL4.SUMATORIA_FASES) * 100,
            2) PORC_PESO_INGENIERIA,
            ROUND((TBL4.CLC_EJECUCION / TBL4.SUMATORIA_FASES) * 100,
            2) PORC_PESO_CLC_EJECUCION,
            ROUND((TBL4.EJECUCION / TBL4.SUMATORIA_FASES) * 100,
            2) PORC_PESO_EJECUCION,
            ROUND((TBL4.PERMISOS / TBL4.SUMATORIA_FASES) * 100,
            2) PORC_PESO_PERMISOS,
            ROUND((TBL4.PEM / TBL4.SUMATORIA_FASES) * 100,
            2) PORC_PESO_PEM,
            ROUND((TBL4.CIERRE / TBL4.SUMATORIA_FASES) * 100,
            2) PORC_PESO_CIERRE,
            ROUND(     ((TBL4.PORC_PLAN_CLC_INGENIERIA) * (TBL4.CLC_INGENIERIA / TBL4.SUMATORIA_FASES)) +     ((TBL4.PORC_PLAN_INGENIERIA) * (TBL4.INGENIERIA / TBL4.SUMATORIA_FASES)) +     ((TBL4.PORC_PLAN_CLC_EJECUCION) * (TBL4.CLC_EJECUCION / TBL4.SUMATORIA_FASES)) +         ((TBL4.PORC_PLAN_EJECUCION) * (TBL4.EJECUCION / TBL4.SUMATORIA_FASES)) +      ((TBL4.PORC_PLAN_PERMISOS) * (TBL4.PERMISOS / TBL4.SUMATORIA_FASES)) +     ((TBL4.PORC_PLAN_PEM) * (TBL4.PEM / TBL4.SUMATORIA_FASES)) +         ((TBL4.PORC_PLAN_CIERRE) * (TBL4.CIERRE / TBL4.SUMATORIA_FASES))      ) PORC_PLAN_PROY_AJUS,
            ROUND(     ((TBL4.PORC_REPR_CLC_INGENIERIA) * (TBL4.CLC_INGENIERIA / TBL4.SUMATORIA_FASES)) +     ((TBL4.PORC_REPR_INGENIERIA) * (TBL4.INGENIERIA / TBL4.SUMATORIA_FASES)) +     ((TBL4.PORC_REPR_CLC_EJECUCION) * (TBL4.CLC_EJECUCION / TBL4.SUMATORIA_FASES)) +         ((TBL4.PORC_REPR_EJECUCION) * (TBL4.EJECUCION / TBL4.SUMATORIA_FASES)) +      ((TBL4.PORC_REPR_PERMISOS) * (TBL4.PERMISOS / TBL4.SUMATORIA_FASES)) +     ((TBL4.PORC_REPR_PEM) * (TBL4.PEM / TBL4.SUMATORIA_FASES)) +         ((TBL4.PORC_REPR_CIERRE) * (TBL4.CIERRE / TBL4.SUMATORIA_FASES))     )      PORC_REPR_PROY_AJUS           
        FROM
            (SELECT
                TBL3.CD_PROYECTO,
                TBL3.ID_PROYECTO,
                TBL3.PROYECTO,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.02' THEN TBL3.COSTO                      
                    ELSE 0                  
                END) CLC_INGENIERIA,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.01' THEN TBL3.COSTO                      
                    ELSE 0                  
                END) INGENIERIA,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.04' THEN TBL3.COSTO                      
                    ELSE 0                  
                END) CLC_EJECUCION,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.03' THEN TBL3.COSTO                      
                    ELSE 0                  
                END) EJECUCION,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.07' THEN TBL3.COSTO                      
                    ELSE 0                  
                END) PERMISOS,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.08' THEN TBL3.COSTO                      
                    ELSE 0                  
                END) PEM,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.09' THEN TBL3.COSTO                      
                    ELSE 0                  
                END) CIERRE,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.02' THEN TBL3.PORC_PLAN_ATI                      
                    ELSE 0                  
                END) PORC_PLAN_CLC_INGENIERIA,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.01' THEN TBL3.PORC_PLAN_ATI                      
                    ELSE 0                  
                END) PORC_PLAN_INGENIERIA,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.04' THEN TBL3.PORC_PLAN_ATI                      
                    ELSE 0                  
                END) PORC_PLAN_CLC_EJECUCION,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.03' THEN TBL3.PORC_PLAN_ATI                      
                    ELSE 0                  
                END) PORC_PLAN_EJECUCION,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.07' THEN TBL3.PORC_PLAN_ATI                      
                    ELSE 0                  
                END) PORC_PLAN_PERMISOS,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.08' THEN TBL3.PORC_PLAN_ATI                      
                    ELSE 0                  
                END) PORC_PLAN_PEM,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.09' THEN TBL3.PORC_PLAN_ATI                      
                    ELSE 0                  
                END) PORC_PLAN_CIERRE,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.02' THEN TBL3.PORC_REPR_ATI                      
                    ELSE 0                  
                END) PORC_REPR_CLC_INGENIERIA,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.01' THEN TBL3.PORC_REPR_ATI                      
                    ELSE 0                  
                END) PORC_REPR_INGENIERIA,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.04' THEN TBL3.PORC_REPR_ATI                      
                    ELSE 0                  
                END) PORC_REPR_CLC_EJECUCION,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.03' THEN TBL3.PORC_REPR_ATI                      
                    ELSE 0                  
                END) PORC_REPR_EJECUCION,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.07' THEN TBL3.PORC_REPR_ATI                      
                    ELSE 0                  
                END) PORC_REPR_PERMISOS,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.08' THEN TBL3.PORC_REPR_ATI                      
                    ELSE 0                  
                END) PORC_REPR_PEM,
                SUM(CASE                      
                    WHEN TBL3.TIPOCOSTO = 'ABA.001.09' THEN TBL3.PORC_REPR_ATI                      
                    ELSE 0                  
                END) PORC_REPR_CIERRE,
                SUM(TBL3.COSTO) SUMATORIA_FASES                 
            FROM
                (SELECT
                    C.NMCOST,
                    CASE                           
                        WHEN C.MNREPLTOTCOST IS NOT NULL THEN COALESCE(C.MNREPLTOTCOST,
                        0)                          
                        ELSE COALESCE(C.MNPLANTOTCOST,
                        0)                      
                    END COSTO,
                    CT.IDCOSTTYPE TIPOCOSTO,
                    TBL2.*                  
                FROM
                    PRTASK AB                  
                LEFT JOIN
                    PRTASK ATI                          
                        ON ATI.CDBASETASK = AB.CDTASK                  
                LEFT JOIN
                    (
                        SELECT
                            DISTINCT TBL.CD_PROYECTO,
                            TBL.ID_PROYECTO,
                            TBL.PROYECTO,
                            TBL.CD_TAREA,
                            TBL.ID_TAREA,
                            TBL.TAREA,
                            ROUND(SUM(TBL.DURACION_PLAN_HASTA) OVER(PARTITION                          
                        BY
                            TBL.CD_PROYECTO,
                            TBL.CD_TAREA),
                            2) TOTAL_PLAN_A_HOY,
                            ROUND(SUM(TBL.DURACION_REPR_HASTA) OVER(PARTITION                          
                        BY
                            TBL.CD_PROYECTO,
                            TBL.CD_TAREA),
                            2) TOTAL_REPR_A_HOY,
                            ROUND(SUM(TBL.PLANDUR) OVER(PARTITION                          
                        BY
                            TBL.CD_PROYECTO,
                            TBL.CD_TAREA),
                            2) TOTAL_PLAN_GANTT,
                            ROUND(SUM(TBL.REPRDUR) OVER(PARTITION                          
                        BY
                            TBL.CD_PROYECTO,
                            TBL.CD_TAREA),
                            2) TOTAL_REPR_GANTT,
                            CASE                                  
                                WHEN SUM(TBL.PLANDUR) OVER(PARTITION                              
                            BY
                                TBL.CD_PROYECTO,
                                TBL.CD_TAREA) = 0 THEN 0                                  
                                ELSE ROUND(SUM(TBL.DURACION_PLAN_HASTA) OVER(PARTITION                              
                            BY
                                TBL.CD_PROYECTO,
                                TBL.CD_TAREA) / SUM(TBL.PLANDUR) OVER(PARTITION                              
                            BY
                                TBL.CD_PROYECTO,
                                TBL.CD_TAREA),
                                2)*100                              
                            END PORC_PLAN_ATI,
                            CASE                                  
                                WHEN SUM(TBL.REPRDUR) OVER(PARTITION                              
                            BY
                                TBL.CD_PROYECTO,
                                TBL.CD_TAREA) = 0 THEN 0                                  
                                ELSE ROUND(SUM(TBL.DURACION_REPR_HASTA) OVER(PARTITION                              
                            BY
                                TBL.CD_PROYECTO,
                                TBL.CD_TAREA) / SUM(TBL.REPRDUR) OVER(PARTITION                              
                            BY
                                TBL.CD_PROYECTO,
                                TBL.CD_TAREA),
                                2)*100                              
                            END PORC_REPR_ATI                          
                        FROM
                            (SELECT
                                N2.CDBASETASK,
                                N2.CDTASK,
                                N2.NMWBS,
                                N2.NMTASK,
                                N2.CDTASKOWNER,
                                N2.NRTASKINDEX,
                                N2.NRTASKLEVEL,
                                N2.QTPLANDUR PLANDUR,
                                N2.QTREPLDUR REPRDUR,
                                N1.CDTASK CD_TAREA,
                                N1.NMWBS ID_TAREA,
                                N1.NMTASK TAREA,
                                CASE                                       
                                    WHEN N2.DTPLANST < CURRENT_DATE                                      
                                    AND N2.DTPLANEND < CURRENT_DATE THEN N2.QTPLANDUR                                      
                                    WHEN N2.DTPLANST > CURRENT_DATE                                      
                                    AND N2.DTPLANEND > CURRENT_DATE THEN 0                                      
                                    WHEN N2.DTPLANST < CURRENT_DATE                                      
                                    AND N2.DTPLANEND > CURRENT_DATE THEN  (select
                                        count(*)                                      
                                    from
                                        GNCALENDARWORKDAY                                           
                                    where
                                        dtday >= N2.DTPLANST                                              
                                        and dtday <= CURRENT_DATE                                              
                                        and cdcalendar = P.CDCALENDAR)                                   
                                END DURACION_PLAN_HASTA,
                                CASE                                       
                                    WHEN N2.DTREPLST < CURRENT_DATE                                      
                                    AND N2.DTREPLEND < CURRENT_DATE THEN N2.QTREPLDUR                                      
                                    WHEN N2.DTREPLST > CURRENT_DATE                                      
                                    AND N2.DTREPLEND > CURRENT_DATE THEN 0                                      
                                    WHEN N2.DTREPLST < CURRENT_DATE                                      
                                    AND N2.DTREPLEND > CURRENT_DATE THEN   (select
                                        count(*)                                      
                                    from
                                        GNCALENDARWORKDAY                                           
                                    where
                                        dtday >= N2.DTREPLST                                              
                                        and dtday <= CURRENT_DATE                                              
                                        and cdcalendar = P.CDCALENDAR)                                   
                                END DURACION_REPR_HASTA,
                                P.CDTASK CD_PROYECTO,
                                P.NMIDTASK ID_PROYECTO,
                                P.NMTASK PROYECTO                              
                            FROM
                                PRTASK N1                              
                            LEFT JOIN
                                PRTASK N2                                      
                                    ON N2.CDBASETASK = N1.CDBASETASK                               
                            LEFT JOIN
                                PRTASK P                                      
                                    ON P.CDTASK = N1.CDBASETASK                              
                            WHERE
                                N2.NMWBS LIKE CONCAT(N1.NMWBS, '%')                                  
                                AND N2.CDTASK NOT IN (
                                    SELECT
                                        COALESCE(CDTASKOWNER,
                                        0)                                      
                                    FROM
                                        PRTASK                                      
                                    WHERE
                                        CDBASETASK = N1.CDBASETASK                                 
                                )  /** N1.NMWBS IS NULL cuando se quiere consultar avances del proyecto **/                              
                            ) TBL                          
                        ) TBL2                              
                            ON TBL2.CD_PROYECTO = AB.CDBASETASK                              
                            AND TBL2.CD_TAREA = ATI.CDTASK                      
                    LEFT JOIN
                        PRTASKCOST C                              
                            ON C.CDTASK = ATI.CDTASK                      
                    LEFT JOIN
                        PRCOSTTYPE CT                              
                            ON C.CDCOSTTYPE = CT.CDCOSTTYPE                      
                    WHERE
                        CT.IDCOSTTYPE IN (
                            'ABA.001.01','ABA.001.02','ABA.001.03','ABA.001.04','ABA.001.07','ABA.001.08','ABA.001.09'                         
                        )                     
                    ) TBL3                  
                GROUP BY
                    TBL3.CD_PROYECTO,
                    TBL3.ID_PROYECTO,
                    TBL3.PROYECTO ) TBL4) DATPLAN              
            LEFT JOIN
                (
                    SELECT
                        TEMP2.CDTASK,
                        TEMP2.NMIDTASK,
                        TEMP2.NMTASK,
                        TEMP2.ATTPR_CODIGO_PROYECTO_SAP,
                        TEMP2.ATTPR_OFICINAS_PLANTAS,
                        TEMP2.ATTPR_GERENCIA_SPONSOR,
                        TEMP2.PPTO_TOTAL_ESTIMADO,
                        TEMP2.ATTIN_REAL_EJ_PERIODOS_ANT_SAP,
                        TEMP2.ATTIN_PRESUPUESTO_APROBADO_ANO_SAP,
                        ROUND(COALESCE(TEMP2.ATTIN_REAL_EJ_PERIODOS_ANT_SAP,
                        0) + COALESCE(TEMP2.ATTIN_PRESUPUESTO_APROBADO_ANO_SAP,
                        0),
                        2) PPTO_APROBADO_TOTAL,
                        TEMP2.CLC_INGENIERIA,
                        TEMP2.INGENIERIA,
                        TEMP2.CLC_EJECUCION,
                        TEMP2.EJECUCION,
                        TEMP2.PERMISOS,
                        TEMP2.PEM,
                        TEMP2.CIERRE,
                        TEMP2.SUMATORIA_FASES,
                        TEMP2.PORC_REAL_CLC_INGENIERIA,
                        TEMP2.PORC_REAL_INGENIERIA,
                        TEMP2.PORC_REAL_CLC_EJECUCION,
                        TEMP2.PORC_REAL_EJECUCION,
                        TEMP2.PORC_REAL_PERMISOS,
                        TEMP2.PORC_REAL_PEM,
                        TEMP2.PORC_REAL_CIERRE,
                        ROUND((TEMP2.CLC_INGENIERIA / TEMP2.SUMATORIA_FASES) * 100,
                        2) PORC_PESO_CLC_INGENIERIA,
                        ROUND((TEMP2.INGENIERIA / TEMP2.SUMATORIA_FASES) * 100,
                        2) PORC_PESO_INGENIERIA,
                        ROUND((TEMP2.CLC_EJECUCION / TEMP2.SUMATORIA_FASES) * 100,
                        2) PORC_PESO_CLC_EJECUCION,
                        ROUND((TEMP2.EJECUCION / TEMP2.SUMATORIA_FASES) * 100,
                        2) PORC_PESO_EJECUCION,
                        ROUND((TEMP2.PERMISOS / TEMP2.SUMATORIA_FASES) * 100,
                        2) PORC_PESO_PERMISOS,
                        ROUND((TEMP2.PEM / TEMP2.SUMATORIA_FASES) * 100,
                        2) PORC_PESO_PEM,
                        ROUND((TEMP2.CIERRE / TEMP2.SUMATORIA_FASES) * 100,
                        2) PORC_PESO_CIERRE,
                        TEMP2.PORC_REAL_PROY,
                        ROUND(     (TEMP2.PORC_REAL_CLC_INGENIERIA * (TEMP2.CLC_INGENIERIA / TEMP2.SUMATORIA_FASES)) +     (TEMP2.PORC_REAL_INGENIERIA * (TEMP2.INGENIERIA / TEMP2.SUMATORIA_FASES)) +     (TEMP2.PORC_REAL_CLC_EJECUCION * (TEMP2.CLC_EJECUCION / TEMP2.SUMATORIA_FASES)) +        (TEMP2.PORC_REAL_EJECUCION * (TEMP2.EJECUCION / TEMP2.SUMATORIA_FASES)) +      (TEMP2.PORC_REAL_PERMISOS * (TEMP2.PERMISOS / TEMP2.SUMATORIA_FASES)) +     (TEMP2.PORC_REAL_PEM * (TEMP2.PEM / TEMP2.SUMATORIA_FASES)) +        (TEMP2.PORC_REAL_CIERRE * (TEMP2.CIERRE / TEMP2.SUMATORIA_FASES))      ) PORC_REAL_PROY_AJUS,
                        1 AS CANTIDAD                      
                    FROM
                        (SELECT
                            TEMP1.CDTASK,
                            TEMP1.NMIDTASK,
                            TEMP1.NMTASK,
                            TEMP1.ATTPR_CODIGO_PROYECTO_SAP,
                            TEMP1.ATTPR_OFICINAS_PLANTAS,
                            TEMP1.ATTPR_GERENCIA_SPONSOR,
                            TEMP1.PPTO_TOTAL_ESTIMADO,
                            TEMP1.ATTIN_REAL_EJ_PERIODOS_ANT_SAP,
                            TEMP1.ATTIN_PRESUPUESTO_APROBADO_ANO_SAP,
                            TEMP1.PORC_REAL_PROY,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.02' THEN TEMP1.COSTO                                  
                                ELSE 0                              
                            END) CLC_INGENIERIA,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.01' THEN TEMP1.COSTO                                  
                                ELSE 0                              
                            END) INGENIERIA,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.04' THEN TEMP1.COSTO                                  
                                ELSE 0                              
                            END) CLC_EJECUCION,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.03' THEN TEMP1.COSTO                                  
                                ELSE 0                              
                            END) EJECUCION,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.07' THEN TEMP1.COSTO                                  
                                ELSE 0                              
                            END) PERMISOS,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.08' THEN TEMP1.COSTO                                  
                                ELSE 0                              
                            END) PEM,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.09' THEN TEMP1.COSTO                                  
                                ELSE 0                              
                            END) CIERRE,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.02' THEN TEMP1.PORC_REAL_ATI                                  
                                ELSE 0                              
                            END) PORC_REAL_CLC_INGENIERIA,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.01' THEN TEMP1.PORC_REAL_ATI                                  
                                ELSE 0                              
                            END) PORC_REAL_INGENIERIA,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.04' THEN TEMP1.PORC_REAL_ATI                                  
                                ELSE 0                              
                            END) PORC_REAL_CLC_EJECUCION,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.03' THEN TEMP1.PORC_REAL_ATI                                  
                                ELSE 0                              
                            END) PORC_REAL_EJECUCION,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.07' THEN TEMP1.PORC_REAL_ATI                                  
                                ELSE 0                              
                            END) PORC_REAL_PERMISOS,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.08' THEN TEMP1.PORC_REAL_ATI                                  
                                ELSE 0                              
                            END) PORC_REAL_PEM,
                            SUM(CASE                                  
                                WHEN TEMP1.TIPOCOSTO = 'ABA.001.09' THEN TEMP1.PORC_REAL_ATI                                  
                                ELSE 0                              
                            END) PORC_REAL_CIERRE,
                            SUM(TEMP1.COSTO) SUMATORIA_FASES                           
                        FROM
                            (SELECT
                                AB.CDTASK,
                                AB.NMIDTASK,
                                AB.NMTASK,
                                ATI.NMIDTASK IDACT,
                                ATI.NMTASK ACT,
                                COALESCE(ATI.QTACTPERC,
                                0) AS PORC_REAL_ATI,
                                CT.IDCOSTTYPE TIPOCOSTO,
                                CASE                                               
                                    WHEN C.MNREPLTOTCOST IS NOT NULL THEN COALESCE(C.MNREPLTOTCOST,
                                    0)                                              
                                    ELSE COALESCE(C.MNPLANTOTCOST,
                                    0)                                          
                                END COSTO,
                                CASE                                              
                                    WHEN R.MNREPLTOTREV IS NOT NULL THEN COALESCE(R.MNREPLTOTREV,
                                    0)                                              
                                    ELSE COALESCE(R.MNPLANTOTALREV,
                                    0)                                          
                                END PPTO_TOTAL_ESTIMADO,
                                (SELECT
                                    VLVALUE                                           
                                FROM
                                    PRTASKREVATTRIB ATT                                           
                                WHERE
                                    ATT.CDATTRIBUTE=18                                                   
                                    AND AB.CDTASK=ATT.CDTASK                                                   
                                    AND R.NRREVENUE=ATT.NRREVENUE) AS ATTIN_REAL_EJ_PERIODOS_ANT_SAP,
                                (SELECT
                                    VLVALUE                                           
                                FROM
                                    PRTASKREVATTRIB ATT                                           
                                WHERE
                                    ATT.CDATTRIBUTE=17                                                   
                                    AND AB.CDTASK=ATT.CDTASK                                                   
                                    AND R.NRREVENUE=ATT.NRREVENUE) AS ATTIN_PRESUPUESTO_APROBADO_ANO_SAP,
                                ( SELECT
                                    COALESCE(TRLAN.NMTRANSLATION,
                                    ADATV.NMATTRIBUTE) AS NMATTRIBUTE                                           
                                FROM
                                    ADATTRIBVALUE ADATV                                           
                                INNER JOIN
                                    PRTASKATTRIB ATT                                                           
                                        ON (
                                            ATT.CDATTRIBUTE=ADATV.CDATTRIBUTE                                                                   
                                            AND ATT.CDVALUE=ADATV.CDVALUE                                                          
                                        )                                           
                                LEFT JOIN
                                    GNTRANSLATIONLANGUAGE TRLAN                                                           
                                        ON (
                                            ADATV.CDTRANSLATION=TRLAN.CDTRANSLATION                                                                   
                                            AND TRLAN.FGLANGUAGE=3                                                          
                                        )                                           
                                WHERE
                                    AB.CDTASK=ATT.CDTASK                                                   
                                    AND ATT.CDATTRIBUTE=6) AS ATTPR_CODIGO_PROYECTO_SAP ,
                                ( SELECT
                                    COALESCE(TRLAN.NMTRANSLATION,
                                    ADATV.NMATTRIBUTE) AS NMATTRIBUTE                                           
                                FROM
                                    ADATTRIBVALUE ADATV                                           
                                INNER JOIN
                                    PRTASKATTRIB ATT                                                           
                                        ON (
                                            ATT.CDATTRIBUTE=ADATV.CDATTRIBUTE                                                                   
                                            AND ATT.CDVALUE=ADATV.CDVALUE                                                          
                                        )                                           
                                LEFT JOIN
                                    GNTRANSLATIONLANGUAGE TRLAN                                                           
                                        ON (
                                            ADATV.CDTRANSLATION=TRLAN.CDTRANSLATION                                                                   
                                            AND TRLAN.FGLANGUAGE=3                                                          
                                        )                                           
                                WHERE
                                    AB.CDTASK=ATT.CDTASK                                                   
                                    AND ATT.CDATTRIBUTE=2) AS ATTPR_OFICINAS_PLANTAS ,
                                ( SELECT
                                    COALESCE(TRLAN.NMTRANSLATION,
                                    ADATV.NMATTRIBUTE) AS NMATTRIBUTE                                           
                                FROM
                                    ADATTRIBVALUE ADATV                                           
                                INNER JOIN
                                    PRTASKATTRIB ATT                                                           
                                        ON (
                                            ATT.CDATTRIBUTE=ADATV.CDATTRIBUTE                                                                   
                                            AND ATT.CDVALUE=ADATV.CDVALUE                                                          
                                        )                                           
                                LEFT JOIN
                                    GNTRANSLATIONLANGUAGE TRLAN                                                           
                                        ON (
                                            ADATV.CDTRANSLATION=TRLAN.CDTRANSLATION                                                                   
                                            AND TRLAN.FGLANGUAGE=3                                                          
                                        )                                           
                                WHERE
                                    AB.CDTASK=ATT.CDTASK                                                   
                                    AND ATT.CDATTRIBUTE=3) AS ATTPR_GERENCIA_SPONSOR ,
                                COALESCE(AB.QTACTPERC,
                                0) AS PORC_REAL_PROY                               
                            FROM
                                PRTASK AB                              
                            LEFT JOIN
                                PRTASK ATI                                      
                                    ON ATI.CDBASETASK = AB.CDTASK                              
                            LEFT JOIN
                                PRTASKREVENUE R                                      
                                    ON AB.CDTASK = R.CDTASK                              
                            LEFT JOIN
                                PRTASKCOST C                                      
                                    ON C.CDTASK = ATI.CDTASK                              
                            LEFT JOIN
                                PRCOSTTYPE CT                                      
                                    ON C.CDCOSTTYPE = CT.CDCOSTTYPE                              
                            LEFT JOIN
                                PRREVENUETYPE RT                                      
                                    ON R.CDREVENUETYPE = RT.CDREVENUETYPE                              
                            WHERE
                                AB.CDTASK = AB.CDBASETASK                                  
                                AND RT.IDREVENUETYPE = 'ABA.001'                                  
                                AND (
                                    CT.IDCOSTTYPE IN (
                                        'ABA.001.01','ABA.001.02','ABA.001.03','ABA.001.04','ABA.001.07','ABA.001.08','ABA.001.09'                                     
                                    )                                 
                                )                                  
                                AND AB.FGTASKTYPE = 1                              
                            ) TEMP1                          
                        GROUP BY
                            TEMP1.CDTASK,
                            TEMP1.NMIDTASK,
                            TEMP1.NMTASK,
                            TEMP1.ATTPR_CODIGO_PROYECTO_SAP,
                            TEMP1.ATTPR_OFICINAS_PLANTAS,
                            TEMP1.ATTPR_GERENCIA_SPONSOR,
                            TEMP1.PPTO_TOTAL_ESTIMADO,
                            TEMP1.ATTIN_REAL_EJ_PERIODOS_ANT_SAP,
                            TEMP1.ATTIN_PRESUPUESTO_APROBADO_ANO_SAP,
                            TEMP1.PORC_REAL_PROY ) TEMP2) DATREAL                                  
                                ON DATREAL.CDTASK = DATPLAN.CD_PROYECTO