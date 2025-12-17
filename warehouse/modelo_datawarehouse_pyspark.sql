-- ============================================================
-- MODELO DATAWAREHOUSE PYSPARK
-- Proyecto RA1: Analisis de Proyectos de Arquitectura
-- Base de datos: warehouse_pyspark.db
-- Generado automaticamente por 02_pyspark.ipynb
-- ============================================================

-- ============================================================
-- TABLAS DE DIMENSIONES
-- ============================================================

-- Dimension: Colaboradores
CREATE TABLE IF NOT EXISTS dim_colaborador (
    id_colaborador INTEGER PRIMARY KEY,
    colaborador TEXT NOT NULL
);

-- Dimension: Ciudades
CREATE TABLE IF NOT EXISTS dim_ciudad (
    id_ciudad INTEGER PRIMARY KEY,
    ciudad TEXT NOT NULL
);

-- Dimension: Tipo de Proyecto
CREATE TABLE IF NOT EXISTS dim_tipo_proyecto (
    id_tipo_proyecto INTEGER PRIMARY KEY,
    tipo_proyecto TEXT NOT NULL
);

-- Dimension: Estado
CREATE TABLE IF NOT EXISTS dim_estado (
    id_estado INTEGER PRIMARY KEY,
    estado TEXT NOT NULL
);

-- Dimension: Fase
CREATE TABLE IF NOT EXISTS dim_fase (
    id_fase INTEGER PRIMARY KEY,
    fase TEXT NOT NULL
);

-- Dimension: Tamano
CREATE TABLE IF NOT EXISTS dim_tamano (
    id_tamano INTEGER PRIMARY KEY,
    tamano TEXT NOT NULL
);

-- ============================================================
-- TABLA DE HECHOS
-- ============================================================

CREATE TABLE IF NOT EXISTS fact_proyectos (
    id_proyecto INTEGER PRIMARY KEY,
    nombre_proyecto TEXT,
    id_colaborador INTEGER,
    id_ciudad INTEGER,
    id_tipo_proyecto INTEGER,
    id_estado INTEGER,
    id_fase INTEGER,
    id_tamano INTEGER,
    total_base REAL,
    iva_porcentaje REAL,
    total_con_iva REAL,
    importe_iva REAL,
    FOREIGN KEY (id_colaborador) REFERENCES dim_colaborador(id_colaborador),
    FOREIGN KEY (id_ciudad) REFERENCES dim_ciudad(id_ciudad),
    FOREIGN KEY (id_tipo_proyecto) REFERENCES dim_tipo_proyecto(id_tipo_proyecto),
    FOREIGN KEY (id_estado) REFERENCES dim_estado(id_estado),
    FOREIGN KEY (id_fase) REFERENCES dim_fase(id_fase),
    FOREIGN KEY (id_tamano) REFERENCES dim_tamano(id_tamano)
);

-- ============================================================
-- INDICES PARA OPTIMIZACION
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_fact_colaborador ON fact_proyectos(id_colaborador);
CREATE INDEX IF NOT EXISTS idx_fact_ciudad ON fact_proyectos(id_ciudad);
CREATE INDEX IF NOT EXISTS idx_fact_tipo ON fact_proyectos(id_tipo_proyecto);
CREATE INDEX IF NOT EXISTS idx_fact_estado ON fact_proyectos(id_estado);
CREATE INDEX IF NOT EXISTS idx_fact_fase ON fact_proyectos(id_fase);
CREATE INDEX IF NOT EXISTS idx_fact_tamano ON fact_proyectos(id_tamano);