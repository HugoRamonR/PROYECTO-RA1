# Proyecto RA1: Análisis de Proyectos de Arquitectura

## Descripción del Proyecto

Este proyecto implementa un flujo completo de análisis y procesamiento de datos utilizando un dataset de proyectos de arquitectura. Se construyen dos pipelines ETL paralelos (Pandas y PySpark) que procesan, transforman y cargan los datos en un Data Warehouse basado en SQLite.

El dataset contiene 10,000 registros de proyectos de arquitectura con información sobre colaboradores, ciudades, fases, estados y métricas financieras.

---

## Estructura del Proyecto

| Carpeta | Contenido |
|---------|-----------|
| **data/** | Dataset original en formato CSV |
| **notebooks/** | Notebooks Jupyter con los pipelines ETL (Pandas y PySpark) |
| **warehouse/** | Bases de datos SQLite generadas y archivos DDL |
| **docs/** | Documentación del proyecto |

---

## Herramientas Utilizadas

| Herramienta | Uso |
|-------------|-----|
| Python | Lenguaje principal |
| Pandas | Procesamiento de datos (Flujo 1) |
| PySpark | Procesamiento distribuido (Flujo 2) |
| SQLite | Base de datos del Data Warehouse |
| Jupyter | Entorno de desarrollo interactivo |
| Docker | Contenerización |

---

## Fases del Proyecto

### Fase 1: Exploración y Limpieza (Pandas)

Análisis inicial del dataset identificando problemas de calidad como valores nulos en identificadores, formatos inconsistentes de fechas, variaciones en nombres de colaboradores, valores monetarios con diferentes formatos y ciudades con múltiples representaciones.

### Fase 2: Procesamiento con PySpark

Aplicación de transformaciones usando la API de Spark DataFrame, incluyendo normalización de colaboradores y ciudades, limpieza de valores monetarios, normalización de IVA, extracción de tipo de proyecto, categorización por tamaño, cálculo de métricas derivadas y asignación de IDs faltantes.

### Fase 3: ETL con Pandas

Pipeline completo de Extracción, Transformación y Carga usando Pandas.

### Fase 4: ETL con PySpark

Pipeline ETL equivalente implementado con PySpark.

### Fase 5: Modelo de Data Warehouse

Diseño de modelo dimensional en estrella con tablas de dimensiones y hechos.

### Fase 6: Docker

Contenerización del proyecto para ejecución reproducible.

---

## Proceso ETL

### Extracción

Se lee el archivo CSV original con 10,000 registros, realizando inferencia automática de tipos de datos y detección de valores nulos y anomalías.

**Columnas originales:** id_proyecto, nombre_proyecto, colaborador, fase, fecha_inicio, total_base, iva_porcentaje, total_con_iva, estado, ciudad.

### Transformación

| Problema Detectado | Solución Aplicada |
|--------------------|-------------------|
| IDs nulos | Asignación secuencial automática |
| Colaboradores inconsistentes | Normalización a formato título |
| Fechas en múltiples formatos | Parseo con múltiples patrones |
| Valores monetarios con símbolos | Limpieza y conversión a número decimal |
| IVA en diferentes formatos | Normalización a decimal |
| Ciudades inconsistentes | Mapeo a formato estándar |

**Columnas derivadas creadas:**

- **tipo_proyecto:** Extraído del nombre (Edificio, Residencial, Reforma, Oficina, Local)
- **tamano_proyecto:** Categorizado por importe (Pequeño, Mediano, Grande, Muy Grande)
- **importe_iva:** Calculado como diferencia entre total con IVA y base
- **año, mes, trimestre:** Extraídos de la fecha de inicio

### Carga

Los datos transformados se cargan en bases de datos SQLite siguiendo un modelo dimensional en estrella, generando dos warehouses independientes (uno por cada flujo).

---

## Modelo Dimensional

El Data Warehouse utiliza un **esquema en estrella** (Star Schema) compuesto por:

### Tabla de Hechos

**fact_proyectos** - Contiene los 10,000 registros de proyectos con todas las métricas financieras (total_base, iva_porcentaje, total_con_iva, importe_iva) y las claves foráneas a las dimensiones.

### Tablas de Dimensiones

| Dimensión | Descripción | Registros |
|-----------|-------------|-----------|
| dim_colaborador | Profesionales asignados a proyectos | 10 |
| dim_ciudad | Ubicaciones de los proyectos | 4 |
| dim_tipo_proyecto | Categorías de proyecto | 5 |
| dim_estado | Estado actual del proyecto | 4 |
| dim_fase | Fase en la que se encuentra | 4 |
| dim_fecha | Calendario con atributos temporales | 901 |

---

## Flujo del Proyecto

El dataset original se procesa en paralelo por dos flujos independientes:

**Flujo Pandas:** Realiza exploración, limpieza, transformaciones, construcción del modelo dimensional y carga en SQLite.

**Flujo PySpark:** Ejecuta carga distribuida, 8 transformaciones vectorizadas, agregaciones, construcción del modelo dimensional y carga en SQLite.

Ambos flujos generan su propia base de datos warehouse con la misma estructura dimensional.

---

## Métricas del Dataset

| Métrica | Valor |
|---------|-------|
| Registros procesados | 10,000 proyectos |
| Colaboradores únicos | 10 |
| Ciudades | 4 (Barcelona, Madrid, Valencia, Bilbao) |
| Tipos de proyecto | 5 (Edificio, Residencial, Reforma, Oficina, Local) |
| Estados | 4 (Finalizado, En curso, Pendiente, Cancelado) |
| Fases | 4 (Presupuesto, Planificación, Diseño, Obra) |

---

## Instrucciones de Ejecución

### Ejecución Local

1. Crear y activar un entorno virtual de Python
2. Instalar las dependencias del archivo requirements.txt
3. Abrir Jupyter Lab desde la carpeta notebooks
4. Ejecutar primero el notebook de Pandas y luego el de PySpark

### Ejecución con Docker

1. Construir la imagen con docker-compose build
2. Iniciar el contenedor con docker-compose up
3. Acceder a Jupyter en http://localhost:8888
4. Ejecutar los notebooks en orden

---

## Conclusiones

### Aspectos Técnicos

- **Calidad de datos:** El dataset presentaba múltiples problemas que requirieron limpieza exhaustiva en fechas, valores monetarios y nombres inconsistentes.

- **Pandas vs PySpark:** Ambas herramientas realizan las mismas transformaciones, pero PySpark ofrece mejor escalabilidad para datasets más grandes.

- **Modelo dimensional:** El esquema en estrella facilita las consultas analíticas y permite responder preguntas de negocio de forma eficiente.

- **Docker:** La contenerización garantiza reproducibilidad y facilita el despliegue del proyecto.

### Posibles Mejoras

- Implementar validaciones de datos más robustas
- Agregar visualizaciones con librerías gráficas
- Crear tests automatizados para el pipeline ETL
- Implementar logging y monitoreo
- Agregar más métricas derivadas para análisis avanzado

---

## Autor

Proyecto desarrollado como parte del curso de Data Engineering.

**Fecha de entrega:** Diciembre 2024
=======
# PROYECTO-RA1
>>>>>>> e0fa1529aa2056ec4211b7b9077614cf759c5a51
