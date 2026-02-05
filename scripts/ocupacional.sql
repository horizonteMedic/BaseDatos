CREATE TABLE n_orden_firma(
    id SERIAL PRIMARY KEY,
    n_orden INTEGER NOT NULL,
    profesional TEXT,
    doctor_asignado TEXT,
    doctor_extra TEXT,
    usuario_registro TEXT,
    fecha_registro DATE,
    usuario_actualizacion TEXT,
    fecha_actualizacion DATE,
    FOREIGN KEY (n_orden) REFERENCES n_orden_ocupacional(n_orden)
)