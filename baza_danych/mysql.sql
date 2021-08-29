CREATE TABLE STATUS_WYKONANIA (
    NAZWA_PROCESU VARCHAR(100),
    DATA_STARTU DATETIME(6),
    DATA_KONCA DATETIME(6)
);
CREATE TABLE KURSY_WALUT (
    DATA_DANYCH DATETIME,
    WALUTA VARCHAR(100),
    KOD VARCHAR(3),
    KURS DOUBLE
);
CREATE TABLE TMP_DATA_DANYCH (
    friday DATETIME,
    saturday DATETIME,
    sunday DATETIME
);
CREATE TABLE KLIENCI (
    ID_KLIENTA DOUBLE NOT NULL AUTO_INCREMENT,
    NAZWA_FIRMY VARCHAR(200),
    DATA_ZALOZENIA DATETIME,
    WOJEWODZCTWO VARCHAR(100),
    MIASTO VARCHAR(100),
    ADRES VARCHAR(200),
    STATUS VARCHAR(50),
    CONSTRAINT klienci_pk PRIMARY KEY (id_klienta),
    CONSTRAINT klienci_ch CHECK (STATUS IN ('Active', 'Inactive'))
);
CREATE TABLE UMOWY (
    ID_UMOWY DOUBLE NOT NULL AUTO_INCREMENT,
    ID_KLIENTA DOUBLE,
    DATA_UMOWY DATETIME,
    MIESIAC VARCHAR(2),
    ROK VARCHAR(4),
    KWOTA DOUBLE,
    WALUTA VARCHAR(3),
    CONSTRAINT umowy_pk PRIMARY KEY (ID_UMOWY),
    CONSTRAINT umowy_fk FOREIGN KEY (id_klienta) REFERENCES klienci (id_klienta)
);
CREATE TABLE WPLATY (
    ID_WPLATY DOUBLE NOT NULL AUTO_INCREMENT,
    ID_KLIENTA DOUBLE,
    DATA_WPLATY DATETIME,
    KWOTA DOUBLE,
    WALUTA VARCHAR(3),
    CONSTRAINT wplaty_pk PRIMARY KEY (ID_WPLATY),
    CONSTRAINT wplaty_fk FOREIGN KEY (id_klienta) REFERENCES klienci (id_klienta)
);
CREATE TABLE UMOWY_PLN (
    ID_UMOWY DOUBLE,
    ID_KLIENTA DOUBLE,
    NAZWA_FIRMY VARCHAR(200),
    MIESIAC VARCHAR(2),
    ROK VARCHAR(4),
    KWOTA DOUBLE,
    WALUTA VARCHAR(3),
    DATA_UMOWY DATETIME,
    KWOTA_PLN DOUBLE,
    KWOTA_PLN_PRZED DOUBLE,
    D_UM DOUBLE,
    D_ZAL DOUBLE,
    CONSTRAINT umowy_pln_pk PRIMARY KEY (ID_UMOWY),
    CONSTRAINT umowy_pln_fk FOREIGN KEY (id_klienta) REFERENCES klienci (id_klienta)
);
CREATE TABLE WPLATY_PLN (
    ID_WPLATY DOUBLE,
    ID_KLIENTA DOUBLE,
    KWOTA DOUBLE,
    WALUTA VARCHAR(3),
    DATA_WPLATY DATETIME,
    KWOTA_PLN DOUBLE,
    CONSTRAINT WPLATY_PLN_pk PRIMARY KEY (ID_WPLATY),
    CONSTRAINT WPLATY_PLN_fk FOREIGN KEY (id_klienta) REFERENCES klienci (id_klienta)
);
CREATE TABLE SUMA_WPLAT (
    ID_KLIENTA DOUBLE,
    SUMA_WPLAT_PLN DOUBLE,
    CONSTRAINT SUMA_WPLAT_pk PRIMARY KEY (ID_KLIENTA),
    CONSTRAINT SUMA_WPLAT_fk FOREIGN KEY (id_klienta) REFERENCES klienci (id_klienta)
);
CREATE TABLE ODSETKI (
    ID_ODSETKI DOUBLE NOT NULL AUTO_INCREMENT,
    ID_UMOWY DOUBLE,
    ID_KLIENTA DOUBLE,
    NAZWA_FIRMY VARCHAR(200),
    KWOTA DOUBLE,
    WALUTA VARCHAR(3),
    DATA_UMOWY DATETIME,
    KWOTA_PLN DOUBLE,
    DATA_WYMAGALNOSCI DATETIME,
    DATA_DANYCH DATETIME,
    LICZBA_DNI DOUBLE,
    KWOTA_ODSETEK DOUBLE,
    CONSTRAINT ODSETKI_pk PRIMARY KEY (ID_ODSETKI),
    CONSTRAINT ODSETKI_fk FOREIGN KEY (id_klienta) REFERENCES klienci (id_klienta)
);
CREATE TABLE SALDO_KLIENTA (
    ID_KLIENTA DOUBLE,
    NAZWA_FIRMY VARCHAR(200),
    DATA_ZALOZENIA DATETIME,
    WOJEWODZCTWO VARCHAR(100),
    MIASTO VARCHAR(100),
    ADRES VARCHAR(200),
    KWOTA_ODSETEK DOUBLE,
    SUMA_WPLAT_PLN DOUBLE,
    SALDO_KLIENTA DOUBLE,
    CONSTRAINT SALDO_KLIENTA_pk PRIMARY KEY (ID_KLIENTA),
    CONSTRAINT SALDO_KLIENTA_fk FOREIGN KEY (id_klienta) REFERENCES klienci (id_klienta)
);
CREATE TABLE ZALEGLE_UMOWY (
    ID_KLIENTA DOUBLE,
    STYCZEN18 DOUBLE,
    LUTY18 DOUBLE,
    MARZEC18 DOUBLE,
    KWIECIEN18 DOUBLE,
    MAJ18 DOUBLE,
    CZERWIEC18 DOUBLE,
    LIPIEC18 DOUBLE,
    SIERPIEN18 DOUBLE,
    WRZESIEN18 DOUBLE,
    PAZDZIERNIK18 DOUBLE,
    LISTOPAD18 DOUBLE,
    GRUDZIEN18 DOUBLE,
    STYCZEN19 DOUBLE,
    LUTY19 DOUBLE,
    MARZEC19 DOUBLE,
    KWIECIEN19 DOUBLE,
    MAJ19 DOUBLE,
    CZERWIEC19 DOUBLE,
    LIPIEC19 DOUBLE,
    SIERPIEN19 DOUBLE,
    WRZESIEN19 DOUBLE,
    PAZDZIERNIK19 DOUBLE,
    LISTOPAD19 DOUBLE,
    GRUDZIEN19 DOUBLE,
    STYCZEN20 DOUBLE,
    LUTY20 DOUBLE,
    MARZEC20 DOUBLE,
    KWIECIEN20 DOUBLE,
    MAJ20 DOUBLE,
    CZERWIEC20 DOUBLE,
    LIPIEC20 DOUBLE,
    SIERPIEN20 DOUBLE,
    WRZESIEN20 DOUBLE,
    PAZDZIERNIK20 DOUBLE,
    LISTOPAD20 DOUBLE,
    GRUDZIEN20 DOUBLE,
    STYCZEN21 DOUBLE,
    LUTY21 DOUBLE,
    MARZEC21 DOUBLE,
    KWIECIEN21 DOUBLE,
    MAJ21 DOUBLE,
    CZERWIEC21 DOUBLE,
    LIPIEC21 DOUBLE,
    SIERPIEN21 DOUBLE,
    CONSTRAINT ZALEGLE_UMOWY_pk PRIMARY KEY (ID_KLIENTA),
    CONSTRAINT ZALEGLE_UMOWY_fk FOREIGN KEY (id_klienta) REFERENCES klienci (id_klienta)
);
DROP PROCEDURE IF EXISTS loguj_start;
DELIMITER / / CREATE PROCEDURE loguj_start(in p_nazwa_procesu VARCHAR(4000)) BEGIN
INSERT INTO status_wykonania (nazwa_procesu, data_startu, data_konca)
VALUES (p_nazwa_procesu, NOW(), null);
COMMIT;
END;
/ / DELIMITER;
DROP PROCEDURE IF EXISTS loguj_start;
DELIMITER / / CREATE PROCEDURE loguj_start(in p_nazwa_procesu VARCHAR(4000)) BEGIN
INSERT INTO status_wykonania (nazwa_procesu, data_startu, data_konca)
VALUES (p_nazwa_procesu, NOW(), null);
COMMIT;
END;
/ / DELIMITER;
DROP PROCEDURE IF EXISTS loguj_stop;
DELIMITER / / CREATE PROCEDURE loguj_stop(in p_nazwa_procesu VARCHAR(4000)) BEGIN
UPDATE status_wykonania
SET data_konca = NOW()
WHERE nazwa_procesu = p_nazwa_procesu;
COMMIT;
END;
/ / DELIMITER;
DELIMITER / / CREATE PROCEDURE laduj_umowy_pln() BEGIN
INSERT INTO UMOWY_PLN WITH najnowsza_umowa as (
        SELECT u.id_umowy,
            u.data_umowy,
            ROW_NUMBER() OVER (
                PARTITION BY u.id_klienta,
                u.miesiac,
                u.rok
                ORDER BY u.data_umowy desc
            ) as liczba
        FROM umowy u
    ),
    data_zalozenia as (
        SELECT u.id_umowy,
            kl.id_klienta,
            CAST(
                DATE_FORMAT(kl.data_zalozenia, '%Y%m') AS UNSIGNED
            ) as d_zal,
            CASE
                WHEN u.miesiac = '1' THEN CAST(CONCAT(u.rok, '01') AS UNSIGNED)
                WHEN u.miesiac = '2' THEN CAST(CONCAT(u.rok, '02') AS UNSIGNED)
                WHEN u.miesiac = '3' THEN CAST(CONCAT(u.rok, '03') AS UNSIGNED)
                WHEN u.miesiac = '4' THEN CAST(CONCAT(u.rok, '04') AS UNSIGNED)
                WHEN u.miesiac = '5' THEN CAST(CONCAT(u.rok, '05') AS UNSIGNED)
                WHEN u.miesiac = '6' THEN CAST(CONCAT(u.rok, '06') AS UNSIGNED)
                WHEN u.miesiac = '7' THEN CAST(CONCAT(u.rok, '07') AS UNSIGNED)
                WHEN u.miesiac = '8' THEN CAST(CONCAT(u.rok, '08') AS UNSIGNED)
                WHEN u.miesiac = '9' THEN CAST(CONCAT(u.rok, '09') AS UNSIGNED)
                WHEN u.miesiac = '10' THEN CAST(CONCAT(u.rok, u.miesiac) AS UNSIGNED)
                WHEN u.miesiac = '11' THEN CAST(CONCAT(u.rok, u.miesiac) AS UNSIGNED)
                WHEN u.miesiac = '12' THEN CAST(CONCAT(u.rok, u.miesiac) AS UNSIGNED)
            END AS d_um
        FROM umowy u
            LEFT JOIN klienci kl on kl.id_klienta = u.id_klienta
    )
SELECT um.ID_UMOWY,
    kl.id_klienta,
    kl.nazwa_firmy,
    u.MIESIAC,
    u.ROK,
    u.KWOTA,
    u.WALUTA,
    um.data_umowy,
    CASE
        WHEN u.waluta = 'PLN' THEN IFNULL(u.kwota, 0)
        ELSE IFNULL(ROUND(u.kwota * k.kurs, 2), 0)
    end as kwota_pln,
    CASE
        WHEN u.waluta = 'PLN' THEN IFNULL(u.kwota, 0)
        ELSE IFNULL(ROUND(u.kwota * k.kurs, 2), 0)
    end as kwota_pln_przed,
    dz.d_um,
    dz.d_zal
FROM najnowsza_umowa um
    LEFT JOIN UMOWY u ON um.id_umowy = u.ID_UMOWY
    LEFT JOIN kursy_walut k on u.WALUTA = k.kod
    AND DATE(u.data_umowy) = k.data_danych
    LEFT JOIN klienci kl on kl.id_klienta = u.id_klienta
    LEFT JOIN data_zalozenia dz on um.id_umowy = dz.id_umowy
    and dz.id_klienta = kl.id_klienta
WHERE um.liczba = 1
    AND dz.d_um >= dz.d_zal;
END / / DELIMITER;
DELIMITER / / CREATE PROCEDURE laduj_wplaty_pln() BEGIN
INSERT INTO WPLATY_PLN
SELECT w.id_wplaty,
    w.id_klienta,
    w.kwota,
    w.waluta,
    w.data_wplaty,
    CASE
        WHEN w.waluta = 'PLN' THEN IFNULL(w.kwota, 0)
        ELSE IFNULL(ROUND(w.kwota * k.kurs, 2), 0)
    end as kwota_pln
from wplaty w
    left join kursy_walut k on DATE(w.data_wplaty) = k.data_danych
    and w.waluta = k.kod;
END;
/ / DELIMITER;
DELIMITER / / CREATE PROCEDURE laduj_suma_wplat_pln() BEGIN
INSERT INTO SUMA_WPLAT
SELECT k.id_klienta,
    IFNULL(SUM(w.KWOTA_PLN), 0) as suma_wplat_pln
FROM klienci k
    LEFT JOIN WPLATY_PLN w on w.id_klienta = k.id_klienta
GROUP BY k.id_klienta;
END;
/ / DELIMITER;
DELIMITER / / CREATE PROCEDURE laduj_rozliczenie_wplat() BEGIN
DECLARE NOT_FOUND INT DEFAULT 0;
DECLARE v_RESZTA DOUBLE;
DECLARE v_KWOTA DOUBLE;
DECLARE V_SUMA_WPLAT DOUBLE;
DECLARE id_umowy DOUBLE;
DECLARE id_klienta DOUBLE;
DECLARE kwota_pln DOUBLE;
DECLARE CONTINUE HANDLER FOR NOT FOUND
SET NOT_FOUND = 1;
BEGIN
DECLARE k CURSOR FOR
SELECT u.id_umowy,
    u.id_klienta,
    u.kwota_pln
from umowy_pln u
order by u.id_klienta,
    u.data_umowy;
OPEN k;
FETCH k INTO id_umowy,
id_klienta,
kwota_pln;
WHILE NOT_FOUND = 0 DO -- SQLINES LICENSE FOR EVALUATION USE ONLY
SELECT d.SUMA_WPLAT_PLN INTO V_SUMA_WPLAT
FROM suma_wplat d
WHERE id_klienta = d.id_klienta;
IF V_SUMA_WPLAT >= KWOTA_PLN THEN
SET V_RESZTA = V_SUMA_WPLAT - KWOTA_PLN;
SET V_KWOTA = 0;
ELSEIF V_SUMA_WPLAT < 0 THEN
SET V_RESZTA = V_SUMA_WPLAT - KWOTA_PLN;
SET V_KWOTA = KWOTA_PLN;
ELSE
SET V_RESZTA = V_SUMA_WPLAT - KWOTA_PLN;
SET V_KWOTA = KWOTA_PLN - V_SUMA_WPLAT;
END IF;
UPDATE umowy_pln u
SET u.kwota_pln = V_KWOTA
WHERE u.id_umowy = id_umowy;
UPDATE suma_wplat s
SET s.SUMA_WPLAT_PLN = V_RESZTA
WHERE s.id_klienta = id_klienta;
FETCH k INTO id_umowy,
id_umowy,
kwota_pln;
END WHILE;
CLOSE k;
END;
END;
/ / DELIMITER;
DELIMITER / / CREATE PROCEDURE laduj_odsetki() BEGIN
INSERT INTO ODSETKI WITH odsetki as (
        select u.ID_UMOWY,
            u.ID_KLIENTA,
            ADDDATE(u.DATA_UMOWY, 14) as data_wymagalnosci,
            date(sysdate()) as data_danych,
            CASE
                WHEN datediff(sysdate(), ADDDATE(u.DATA_UMOWY, 14)) > 0 THEN datediff(sysdate(), ADDDATE(u.DATA_UMOWY, 14))
                ELSE 0
            END AS liczba_dni
        from umowy_pln u
    )
select u.ID_UMOWY,
    u.ID_KLIENTA,
    u.NAZWA_FIRMY,
    u.KWOTA,
    u.WALUTA,
    u.DATA_UMOWY,
    u.KWOTA_PLN,
    o.data_wymagalnosci,
    o.data_danych,
    o.liczba_dni,
    ROUND((o.liczba_dni / 365 * 0.05 * u.kwota_pln), 2) as kwota_odsetek
from odsetki o
    left join umowy_pln u on u.id_umowy = o.id_umowy
    and u.id_klienta = o.id_klienta;
END;
/ / DELIMITER;
DELIMITER / / CREATE PROCEDURE laduj_zalegle_umowy() BEGIN
INSERT INTO ZALEGLE_UMOWY
select k.id_klienta,
    IFNULL(t2.styczen18, 0) as styczen18,
    IFNULL(t2.luty18, 0) as luty18,
    IFNULL(t2.marzec18, 0) as marzec18,
    IFNULL(t2.kwiecien18, 0) as kwiecien18,
    IFNULL(t2.maj18, 0) as maj18,
    IFNULL(t2.czerwiec18, 0) as czerwiec18,
    IFNULL(t2.lipiec18, 0) as lipiec18,
    IFNULL(t2.sierpien18, 0) as sierpien18,
    IFNULL(t2.wrzesien18, 0) as wrzesien18,
    IFNULL(t2.pazdziernik18, 0) as pazdziernik18,
    IFNULL(t2.listopad18, 0) as listopad18,
    IFNULL(t2.grudzien18, 0) as grudzien18,
    IFNULL(t2.styczen19, 0) as styczen19,
    IFNULL(t2.luty19, 0) as luty19,
    IFNULL(t2.marzec19, 0) as marzec19,
    IFNULL(t2.kwiecien19, 0) as kwiecien19,
    IFNULL(t2.maj19, 0) as maj19,
    IFNULL(t2.czerwiec19, 0) as czerwiec19,
    IFNULL(t2.lipiec19, 0) as lipiec19,
    IFNULL(t2.sierpien19, 0) as sierpien19,
    IFNULL(t2.wrzesien19, 0) as wrzesien19,
    IFNULL(t2.pazdziernik19, 0) as pazdziernik19,
    IFNULL(t2.listopad19, 0) as listopad19,
    IFNULL(t2.grudzien19, 0) as grudzien19,
    IFNULL(t2.styczen20, 0) as styczen20,
    IFNULL(t2.luty20, 0) as luty20,
    IFNULL(t2.marzec20, 0) as marzec20,
    IFNULL(t2.kwiecien20, 0) as kwiecien20,
    IFNULL(t2.maj20, 0) as maj20,
    IFNULL(t2.czerwiec20, 0) as czerwiec20,
    IFNULL(t2.lipiec20, 0) as lipiec20,
    IFNULL(t2.sierpien20, 0) as sierpien20,
    IFNULL(t2.wrzesien20, 0) as wrzesien20,
    IFNULL(t2.pazdziernik20, 0) as pazdziernik20,
    IFNULL(t2.listopad20, 0) as listopad20,
    IFNULL(t2.grudzien20, 0) as grudzien20,
    IFNULL(t2.styczen21, 0) as styczen21,
    IFNULL(t2.luty21, 0) as luty21,
    IFNULL(t2.marzec21, 0) as marzec21,
    IFNULL(t2.kwiecien21, 0) as kwiecien21,
    IFNULL(t2.maj21, 0) as maj21,
    IFNULL(t2.czerwiec21, 0) as czerwiec21,
    IFNULL(t2.lipiec21, 0) as lipiec21,
    IFNULL(t2.sierpien21, 0) as sierpien21
from klienci k
    left join (
        select f.id_klienta,
            sum(f.styczen18) as styczen18,
            sum(f.luty18) as luty18,
            sum(f.marzec18) as marzec18,
            sum(f.kwiecien18) as kwiecien18,
            sum(f.maj18) as maj18,
            sum(f.czerwiec18) as czerwiec18,
            sum(f.lipiec18) as lipiec18,
            sum(f.sierpien18) as sierpien18,
            sum(f.wrzesien18) as wrzesien18,
            sum(f.pazdziernik18) as pazdziernik18,
            sum(f.listopad18) as listopad18,
            sum(f.grudzien18) as grudzien18,
            sum(f.styczen19) as styczen19,
            sum(f.luty19) as luty19,
            sum(f.marzec19) as marzec19,
            sum(f.kwiecien19) as kwiecien19,
            sum(f.maj19) as maj19,
            sum(f.czerwiec19) as czerwiec19,
            sum(f.lipiec19) as lipiec19,
            sum(f.sierpien19) as sierpien19,
            sum(f.wrzesien19) as wrzesien19,
            sum(f.pazdziernik19) as pazdziernik19,
            sum(f.listopad19) as listopad19,
            sum(f.grudzien19) as grudzien19,
            sum(f.styczen20) as styczen20,
            sum(f.luty20) as luty20,
            sum(f.marzec20) as marzec20,
            sum(f.kwiecien20) as kwiecien20,
            sum(f.maj20) as maj20,
            sum(f.czerwiec20) as czerwiec20,
            sum(f.lipiec20) as lipiec20,
            sum(f.sierpien20) as sierpien20,
            sum(f.wrzesien20) as wrzesien20,
            sum(f.pazdziernik20) as pazdziernik20,
            sum(f.listopad20) as listopad20,
            sum(f.grudzien20) as grudzien20,
            sum(f.styczen21) as styczen21,
            sum(f.luty21) as luty21,
            sum(f.marzec21) as marzec21,
            sum(f.kwiecien21) as kwiecien21,
            sum(f.maj21) as maj21,
            sum(f.czerwiec21) as czerwiec21,
            sum(f.lipiec21) as lipiec21,
            sum(f.sierpien21) as sierpien21
        from (
                select u.id_klienta,
                    case
                        when u.miesiac = 1
                        and u.rok = 2018 then 1
                        else 0
                    end as styczen18,
                    case
                        when u.miesiac = 2
                        and u.rok = 2018 then 1
                        else 0
                    end as luty18,
                    case
                        when u.miesiac = 3
                        and u.rok = 2018 then 1
                        else 0
                    end as marzec18,
                    case
                        when u.miesiac = 4
                        and u.rok = 2018 then 1
                        else 0
                    end as kwiecien18,
                    case
                        when u.miesiac = 5
                        and u.rok = 2018 then 1
                        else 0
                    end as maj18,
                    case
                        when u.miesiac = 6
                        and u.rok = 2018 then 1
                        else 0
                    end as czerwiec18,
                    case
                        when u.miesiac = 7
                        and u.rok = 2018 then 1
                        else 0
                    end as lipiec18,
                    case
                        when u.miesiac = 8
                        and u.rok = 2018 then 1
                        else 0
                    end as sierpien18,
                    case
                        when u.miesiac = 9
                        and u.rok = 2018 then 1
                        else 0
                    end as wrzesien18,
                    case
                        when u.miesiac = 10
                        and u.rok = 2018 then 1
                        else 0
                    end as pazdziernik18,
                    case
                        when u.miesiac = 11
                        and u.rok = 2018 then 1
                        else 0
                    end as listopad18,
                    case
                        when u.miesiac = 12
                        and u.rok = 2018 then 1
                        else 0
                    end as grudzien18,
                    case
                        when u.miesiac = 1
                        and u.rok = 2019 then 1
                        else 0
                    end as styczen19,
                    case
                        when u.miesiac = 2
                        and u.rok = 2019 then 1
                        else 0
                    end as luty19,
                    case
                        when u.miesiac = 3
                        and u.rok = 2019 then 1
                        else 0
                    end as marzec19,
                    case
                        when u.miesiac = 4
                        and u.rok = 2019 then 1
                        else 0
                    end as kwiecien19,
                    case
                        when u.miesiac = 5
                        and u.rok = 2019 then 1
                        else 0
                    end as maj19,
                    case
                        when u.miesiac = 6
                        and u.rok = 2019 then 1
                        else 0
                    end as czerwiec19,
                    case
                        when u.miesiac = 7
                        and u.rok = 2019 then 1
                        else 0
                    end as lipiec19,
                    case
                        when u.miesiac = 8
                        and u.rok = 2019 then 1
                        else 0
                    end as sierpien19,
                    case
                        when u.miesiac = 9
                        and u.rok = 2019 then 1
                        else 0
                    end as wrzesien19,
                    case
                        when u.miesiac = 10
                        and u.rok = 2019 then 1
                        else 0
                    end as pazdziernik19,
                    case
                        when u.miesiac = 11
                        and u.rok = 2019 then 1
                        else 0
                    end as listopad19,
                    case
                        when u.miesiac = 12
                        and u.rok = 2019 then 1
                        else 0
                    end as grudzien19,
                    case
                        when u.miesiac = 1
                        and u.rok = 2020 then 1
                        else 0
                    end as styczen20,
                    case
                        when u.miesiac = 2
                        and u.rok = 2020 then 1
                        else 0
                    end as luty20,
                    case
                        when u.miesiac = 3
                        and u.rok = 2020 then 1
                        else 0
                    end as marzec20,
                    case
                        when u.miesiac = 4
                        and u.rok = 2020 then 1
                        else 0
                    end as kwiecien20,
                    case
                        when u.miesiac = 5
                        and u.rok = 2020 then 1
                        else 0
                    end as maj20,
                    case
                        when u.miesiac = 6
                        and u.rok = 2020 then 1
                        else 0
                    end as czerwiec20,
                    case
                        when u.miesiac = 7
                        and u.rok = 2020 then 1
                        else 0
                    end as lipiec20,
                    case
                        when u.miesiac = 8
                        and u.rok = 2020 then 1
                        else 0
                    end as sierpien20,
                    case
                        when u.miesiac = 9
                        and u.rok = 2020 then 1
                        else 0
                    end as wrzesien20,
                    case
                        when u.miesiac = 10
                        and u.rok = 2020 then 1
                        else 0
                    end as pazdziernik20,
                    case
                        when u.miesiac = 11
                        and u.rok = 2020 then 1
                        else 0
                    end as listopad20,
                    case
                        when u.miesiac = 12
                        and u.rok = 2020 then 1
                        else 0
                    end as grudzien20,
                    case
                        when u.miesiac = 1
                        and u.rok = 2021 then 1
                        else 0
                    end as styczen21,
                    case
                        when u.miesiac = 2
                        and u.rok = 2021 then 1
                        else 0
                    end as luty21,
                    case
                        when u.miesiac = 3
                        and u.rok = 2021 then 1
                        else 0
                    end as marzec21,
                    case
                        when u.miesiac = 4
                        and u.rok = 2021 then 1
                        else 0
                    end as kwiecien21,
                    case
                        when u.miesiac = 5
                        and u.rok = 2021 then 1
                        else 0
                    end as maj21,
                    case
                        when u.miesiac = 6
                        and u.rok = 2021 then 1
                        else 0
                    end as czerwiec21,
                    case
                        when u.miesiac = 7
                        and u.rok = 2021 then 1
                        else 0
                    end as lipiec21,
                    case
                        when u.miesiac = 8
                        and u.rok = 2021 then 1
                        else 0
                    end as sierpien21
                from umowy_pln u
                where u.id_klienta in (
                        select k.id_klienta
                        from klienci k
                    )
            ) f
        group by f.id_klienta
    ) t2 on (k.id_klienta = t2.id_klienta)
where k.status = 'Active';
END;
/ / DELIMITER;
DELIMITER / / CREATE PROCEDURE laduj_saldo_klienta() BEGIN
INSERT INTO SALDO_KLIENTA WITH suma_odestek as (
        SELECT o.id_klienta,
            SUM(o.KWOTA_ODSETEK) as KWOTA_ODSETEK
        FROM ODSETKI o
        GROUP BY o.ID_KLIENTA
    )
SELECT k.id_klienta,
    k.nazwa_firmy,
    k.data_zalozenia,
    k.wojewodzctwo,
    k.miasto,
    k.adres,
    IFNULL(o.kwota_odsetek, 0) as KWOTA_ODSETEK,
    IFNULL(s.SUMA_WPLAT_PLN, 0) as SUMA_WPLAT_PLN,
    IFNULL(s.SUMA_WPLAT_PLN, 0) - IFNULL(o.kwota_odsetek, 0) AS SALDO_KLIENTA
FROM klienci k
    LEFT JOIN suma_odestek o ON k.id_klienta = o.id_klienta
    LEFT JOIN suma_wplat s ON k.id_klienta = s.id_klienta
WHERE k.status = 'Active';
END;
/ / DELIMITER;
DELIMITER / / CREATE PROCEDURE czysc_tabele() BEGIN TRUNCATE TABLE ODSETKI;
TRUNCATE TABLE SALDO_KLIENTA;
TRUNCATE TABLE SUMA_WPLAT;
TRUNCATE TABLE UMOWY_PLN;
TRUNCATE TABLE WPLATY_PLN;
TRUNCATE TABLE ZALEGLE_UMOWY;
END;
/ / DELIMITER;
CREATE PROCEDURE przelicz_proces() BEGIN
SET SQL_SAFE_UPDATES = 0;
CALL loguj_start('laduj_umowy_pln');
CALL laduj_umowy_pln();
CALL loguj_stop('laduj_umowy_pln');
CALL loguj_start('laduj_wplaty_pln');
CALL laduj_wplaty_pln();
CALL loguj_stop('laduj_wplaty_pln');
CALL loguj_start('laduj_suma_wplat_pln');
CALL laduj_suma_wplat_pln();
CALL loguj_stop('laduj_suma_wplat_pln');
CALL loguj_start('laduj_rozliczenie_wplat');
CALL laduj_rozliczenie_wplat();
CALL loguj_stop('laduj_rozliczenie_wplat');
CALL loguj_start('laduj_odsetki');
CALL laduj_odsetki();
CALL loguj_stop('laduj_odsetki');
CALL loguj_start('laduj_zalegle_umowy');
CALL laduj_zalegle_umowy();
CALL loguj_stop('laduj_zalegle_umowy');
CALL loguj_start('laduj_saldo_klienta');
CALL laduj_saldo_klienta();
CALL loguj_stop('laduj_saldo_klienta');
END