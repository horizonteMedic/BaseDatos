

CREATE OR REPLACE FUNCTION set_nomenclatura_interconsulta()
    RETURNS TRIGGER AS $$
DECLARE
    v_count INT;
BEGIN
    -- Contar cuántos ya existen con el mismo dato en común
    SELECT COUNT(*)
    INTO v_count
    FROM ficha_interconsulta
    WHERE n_orden = NEW.n_orden;

    -- Armar el valor de la columna
    IF v_count = 0 THEN
        NEW.nomenclatura := 'INTERCONSULTA';
    ELSE
        NEW.nomenclatura := 'INTERCONSULTA ' || (v_count + 1);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_set_nomenclatura_interconsulta
    BEFORE INSERT
    ON ficha_interconsulta
    FOR EACH ROW
EXECUTE PROCEDURE set_nomenclatura_interconsulta();