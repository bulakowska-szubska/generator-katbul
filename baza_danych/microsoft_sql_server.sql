CREATE TABLE STATUS_WYKONANIA (
    NAZWA_PROCESU VARCHAR(100),
    DATA_STARTU DATETIME2(6),
    DATA_KONCA DATETIME2(6)
);
CREATE TABLE KURSY_WALUT (
    DATA_DANYCH DATETIME,
    WALUTA VARCHAR(100),
    KOD VARCHAR(3),
    KURS FLOAT
);
CREATE TABLE TMP_DATA_DANYCH (
    friday DATETIME,
    saturday DATETIME,
    sunday DATETIME
);
CREATE SEQUENCE klienci_seq MINVALUE 1 MAXVALUE 999999999 START WITH 1 INCREMENT BY 1;
CREATE TABLE KLIENCI (
    ID_KLIENTA FLOAT DEFAULT NEXT VALUE FOR klienci_seq,
    NAZWA_FIRMY VARCHAR(200),
    DATA_ZALOZENIA DATETIME,
    WOJEWODZCTWO VARCHAR(100),
    MIASTO VARCHAR(100),
    ADRES VARCHAR(200),
    STATUS VARCHAR(50),
    CONSTRAINT klienci_pk PRIMARY KEY (id_klienta),
    CONSTRAINT klienci_ch CHECK (STATUS IN ('Active', 'Inactive'))
);
CREATE SEQUENCE umowy_seq MINVALUE 1 MAXVALUE 999999999 START WITH 1 INCREMENT BY 1;
CREATE TABLE UMOWY (
    ID_UMOWY FLOAT DEFAULT NEXT VALUE FOR umowy_seq,
    ID_KLIENTA FLOAT,
    DATA_UMOWY DATETIME,
    MIESIAC VARCHAR(2),
    ROK VARCHAR(4),
    KWOTA FLOAT,
    WALUTA VARCHAR(3),
    CONSTRAINT umowy_pk PRIMARY KEY (ID_UMOWY),
    CONSTRAINT umowy_fk FOREIGN KEY (id_klienta) REFERENCES dbo.KLIENCI (id_klienta)
);
CREATE SEQUENCE wplaty_seq MINVALUE 1 MAXVALUE 999999999 START WITH 1 INCREMENT BY 1;
CREATE TABLE WPLATY (
    ID_WPLATY FLOAT DEFAULT NEXT VALUE FOR wplaty_seq,
    ID_KLIENTA FLOAT,
    DATA_WPLATY DATETIME,
    KWOTA FLOAT,
    WALUTA VARCHAR(3),
    CONSTRAINT wplaty_pk PRIMARY KEY (ID_WPLATY),
    CONSTRAINT wplaty_fk FOREIGN KEY (id_klienta) REFERENCES dbo.KLIENCI (id_klienta)
);
CREATE TABLE UMOWY_PLN (
    ID_UMOWY FLOAT,
    ID_KLIENTA FLOAT,
    NAZWA_FIRMY VARCHAR(200),
    MIESIAC VARCHAR(2),
    ROK VARCHAR(4),
    KWOTA FLOAT,
    WALUTA VARCHAR(3),
    DATA_UMOWY DATETIME,
    KWOTA_PLN FLOAT,
    KWOTA_PLN_PRZED FLOAT,
    D_UM FLOAT,
    D_ZAL FLOAT,
    CONSTRAINT umowy_pln_pk PRIMARY KEY (ID_UMOWY),
    CONSTRAINT umowy_pln_fk FOREIGN KEY (id_klienta) REFERENCES dbo.klienci (id_klienta)
);
CREATE TABLE WPLATY_PLN (
    ID_WPLATY FLOAT,
    ID_KLIENTA FLOAT,
    KWOTA FLOAT,
    WALUTA VARCHAR(3),
    DATA_WPLATY DATETIME,
    KWOTA_PLN FLOAT,
    CONSTRAINT WPLATY_PLN_pk PRIMARY KEY (ID_WPLATY),
    CONSTRAINT WPLATY_PLN_fk FOREIGN KEY (id_klienta) REFERENCES dbo.klienci (id_klienta)
);
CREATE TABLE SUMA_WPLAT (
    ID_KLIENTA FLOAT,
    SUMA_WPLAT_PLN FLOAT,
    CONSTRAINT SUMA_WPLAT_pk PRIMARY KEY (ID_KLIENTA),
    CONSTRAINT SUMA_WPLAT_fk FOREIGN KEY (id_klienta) REFERENCES dbo.klienci (id_klienta)
);
CREATE SEQUENCE odsetki_seq MINVALUE 1 MAXVALUE 999999999 START WITH 1 INCREMENT BY 1;
CREATE TABLE ODSETKI (
    ID_UMOWY FLOAT,
    ID_KLIENTA FLOAT,
    NAZWA_FIRMY VARCHAR(200),
    KWOTA FLOAT,
    WALUTA VARCHAR(3),
    DATA_UMOWY DATETIME,
    KWOTA_PLN FLOAT,
    DATA_WYMAGALNOSCI DATETIME,
    DATA_DANYCH DATETIME,
    LICZBA_DNI FLOAT,
    KWOTA_ODSETEK FLOAT,
    CONSTRAINT ODSETKI_fk FOREIGN KEY (id_klienta) REFERENCES dbo.klienci (id_klienta)
);
CREATE TABLE SALDO_KLIENTA (
    ID_KLIENTA FLOAT,
    NAZWA_FIRMY VARCHAR(200),
    DATA_ZALOZENIA DATETIME,
    WOJEWODZCTWO VARCHAR(100),
    MIASTO VARCHAR(100),
    ADRES VARCHAR(200),
    KWOTA_ODSETEK FLOAT,
    SUMA_WPLAT_PLN FLOAT,
    SALDO_KLIENTA FLOAT,
    CONSTRAINT SALDO_KLIENTA_pk PRIMARY KEY (ID_KLIENTA),
    CONSTRAINT SALDO_KLIENTA_fk FOREIGN KEY (id_klienta) REFERENCES dbo.klienci (id_klienta)
);
CREATE TABLE ZALEGLE_UMOWY (
    ID_KLIENTA FLOAT,
    STYCZEN18 FLOAT,
    LUTY18 FLOAT,
    MARZEC18 FLOAT,
    KWIECIEN18 FLOAT,
    MAJ18 FLOAT,
    CZERWIEC18 FLOAT,
    LIPIEC18 FLOAT,
    SIERPIEN18 FLOAT,
    WRZESIEN18 FLOAT,
    PAZDZIERNIK18 FLOAT,
    LISTOPAD18 FLOAT,
    GRUDZIEN18 FLOAT,
    STYCZEN19 FLOAT,
    LUTY19 FLOAT,
    MARZEC19 FLOAT,
    KWIECIEN19 FLOAT,
    MAJ19 FLOAT,
    CZERWIEC19 FLOAT,
    LIPIEC19 FLOAT,
    SIERPIEN19 FLOAT,
    WRZESIEN19 FLOAT,
    PAZDZIERNIK19 FLOAT,
    LISTOPAD19 FLOAT,
    GRUDZIEN19 FLOAT,
    STYCZEN20 FLOAT,
    LUTY20 FLOAT,
    MARZEC20 FLOAT,
    KWIECIEN20 FLOAT,
    MAJ20 FLOAT,
    CZERWIEC20 FLOAT,
    LIPIEC20 FLOAT,
    SIERPIEN20 FLOAT,
    WRZESIEN20 FLOAT,
    PAZDZIERNIK20 FLOAT,
    LISTOPAD20 FLOAT,
    GRUDZIEN20 FLOAT,
    STYCZEN21 FLOAT,
    LUTY21 FLOAT,
    MARZEC21 FLOAT,
    KWIECIEN21 FLOAT,
    MAJ21 FLOAT,
    CZERWIEC21 FLOAT,
    LIPIEC21 FLOAT,
    SIERPIEN21 FLOAT,
    CONSTRAINT ZALEGLE_UMOWY_pk PRIMARY KEY (ID_KLIENTA),
    CONSTRAINT ZALEGLE_UMOWY_fk FOREIGN KEY (id_klienta) REFERENCES dbo.klienci (id_klienta)
);
IF OBJECT_ID('loguj_start', 'P') IS NOT NULL DROP PROCEDURE loguj_start;
GO CREATE PROCEDURE loguj_start(@p_nazwa_procesu VARCHAR) AS BEGIN
SET NOCOUNT ON;
INSERT INTO status_wykonania (nazwa_procesu, data_startu, data_konca)
VALUES (@p_nazwa_procesu, GETDATE(), null);
COMMIT;
END;
IF OBJECT_ID('loguj_stop', 'P') IS NOT NULL DROP PROCEDURE loguj_stop;
GO CREATE PROCEDURE loguj_stop(@p_nazwa_procesu VARCHAR) AS BEGIN
SET NOCOUNT ON;
UPDATE status_wykonania
SET data_konca = GETDATE()
WHERE nazwa_procesu = @p_nazwa_procesu;
COMMIT;
END;
CREATE PROCEDURE insert_tmp_data_danych_rok (@data_danych DATETIME) AS BEGIN
SET NOCOUNT ON;
INSERT INTO TMP_DATA_DANYCH (friday, saturday, sunday) --all fridays
    with dts as (
        with recursive cte_connect_by as (
            select 1 as level
            union all
            select level + 1 as level
            from cte_connect_by
            where level <= 366 -1
        )
        select @data_danych + rownum -1 as dt
    )
select dt as friday,
    dt + 1 as saturday,
    dt + 2 as sunday
from dts
where to_char(dt, 'fmday', 'NLS_DATE_LANGUAGE=AMERICAN') = 'friday';
END;
--BEGIN
-- SQLINES DEMO *** nych_rok(TO_DATE('2018-01-01','YYYY-MM-DD'));
-- SQLINES DEMO *** 19,20,21 :)
--END;
IF OBJECT_ID('laduj_dane_kursy_walut', 'P') IS NOT NULL DROP PROCEDURE laduj_dane_kursy_walut;
GO CREATE PROCEDURE laduj_dane_kursy_walut (
        @p_data_danych DATETIME,
        @p_data_danych_ostatnia DATETIME
    ) AS BEGIN
SET NOCOUNT ON;
INSERT INTO KURSY_WALUT with saturday as (
        SELECT k.*
        from TMP_DATA_DANYCH k
        where k.friday >= @p_data_danych
            AND k.friday <= @p_data_danych_ostatnia
    )
SELECT s.saturday,
    k.WALUTA,
    k.KOD,
    k.KURS
FROM saturday s
    left join kursy_walut k on k.data_danych = s.friday;
COMMIT;
INSERT INTO KURSY_WALUT with sunday as (
        SELECT k.*
        from TMP_DATA_DANYCH k
        where k.friday >= @p_data_danych
            AND k.friday <= @p_data_danych_ostatnia
    )
SELECT s.sunday,
    k.WALUTA,
    k.KOD,
    k.KURS
FROM sunday s
    left join kursy_walut k on k.data_danych = s.friday;
COMMIT;
END;
--BEGIN
-- SQLINES DEMO *** alut(TO_DATE('2018/01/01','YYYY/MM/DD'), TO_DATE('2021/08/24','YYYY/MM/DD'));
--END;
CREATE PROCEDURE laduj_umowy_pln AS BEGIN
SET NOCOUNT ON;
INSERT INTO UMOWY_PLN
SELECT um.ID_UMOWY,
    kl.id_klienta,
    kl.nazwa_firmy,
    u.MIESIAC,
    u.ROK,
    u.KWOTA,
    u.WALUTA,
    um.data_umowy,
    CASE
        WHEN u.waluta = 'PLN' THEN ISNULL(u.kwota, 0)
        ELSE ISNULL(ROUND(u.kwota * k.kurs, 2), 0)
    end as kwota_pln,
    CASE
        WHEN u.waluta = 'PLN' THEN ISNULL(u.kwota, 0)
        ELSE ISNULL(ROUND(u.kwota * k.kurs, 2), 0)
    end as kwota_pln_przed,
    dz.d_um,
    dz.d_zal
FROM (
        SELECT u.id_umowy,
            u.data_umowy,
            ROW_NUMBER() OVER (
                PARTITION BY u.id_klienta,
                u.miesiac,
                u.rok
                ORDER BY u.data_umowy desc
            ) as liczba
        FROM umowy u
    ) um
    LEFT JOIN UMOWY u ON um.id_umowy = u.ID_UMOWY
    LEFT JOIN kursy_walut k on u.WALUTA = k.kod
    AND u.data_umowy = k.data_danych
    LEFT JOIN klienci kl on kl.id_klienta = u.id_klienta
    LEFT JOIN (
        SELECT u.id_umowy,
            kl.id_klienta,
            CAST(format(kl.data_zalozenia, 'yyyyMM') AS INT) as d_zal,
            CASE
                WHEN u.miesiac = '1' THEN CAST(CONCAT(u.rok, '01') AS INT)
                WHEN u.miesiac = '2' THEN CAST(CONCAT(u.rok, '02') AS INT)
                WHEN u.miesiac = '3' THEN CAST(CONCAT(u.rok, '03') AS INT)
                WHEN u.miesiac = '4' THEN CAST(CONCAT(u.rok, '04') AS INT)
                WHEN u.miesiac = '5' THEN CAST(CONCAT(u.rok, '05') AS INT)
                WHEN u.miesiac = '6' THEN CAST(CONCAT(u.rok, '06') AS INT)
                WHEN u.miesiac = '7' THEN CAST(CONCAT(u.rok, '07') AS INT)
                WHEN u.miesiac = '8' THEN CAST(CONCAT(u.rok, '08') AS INT)
                WHEN u.miesiac = '9' THEN CAST(CONCAT(u.rok, '09') AS INT)
                WHEN u.miesiac = '10' THEN CAST(CONCAT(u.rok, u.miesiac) AS INT)
                WHEN u.miesiac = '11' THEN CAST(CONCAT(u.rok, u.miesiac) AS INT)
                WHEN u.miesiac = '12' THEN CAST(CONCAT(u.rok, u.miesiac) AS INT)
            END AS d_um
        FROM umowy u
            LEFT JOIN klienci kl on kl.id_klienta = u.id_klienta
    ) dz on um.id_umowy = dz.id_umowy
    and dz.id_klienta = kl.id_klienta
WHERE um.liczba = 1
    AND dz.d_um >= dz.d_zal;
END;
IF OBJECT_ID('laduj_umowy_pln', 'P') IS NOT NULL DROP PROCEDURE laduj_umowy_pln;
GO CREATE PROCEDURE laduj_wplaty_pln AS BEGIN
SET NOCOUNT ON;
INSERT INTO WPLATY_PLN
SELECT w.id_wplaty,
    w.id_klienta,
    w.kwota,
    w.waluta,
    w.data_wplaty,
    CASE
        WHEN w.waluta = 'PLN' THEN ISNULL(w.kwota, 0)
        ELSE ISNULL(ROUND(w.kwota * k.kurs, 2), 0)
    end as kwota_pln
from wplaty w
    left join kursy_walut k on w.data_wplaty = k.data_danych
    and w.waluta = k.kod;
END;
CREATE PROCEDURE laduj_suma_wplat_pln AS BEGIN
SET NOCOUNT ON;
INSERT INTO SUMA_WPLAT
SELECT k.id_klienta,
    ISNULL(SUM(w.KWOTA_PLN), 0) as suma_wplat_pln
FROM klienci k
    LEFT JOIN WPLATY_PLN w on w.id_klienta = k.id_klienta
GROUP BY k.id_klienta;
END;
IF OBJECT_ID('laduj_rozliczenie_wplat', 'P') IS NOT NULL DROP PROCEDURE laduj_rozliczenie_wplat;
GO CREATE PROCEDURE laduj_rozliczenie_wplat as BEGIN
SET NOCOUNT ON;
DECLARE @v_RESZTA FLOAT;
DECLARE @v_KWOTA FLOAT;
DECLARE @V_SUMA_WPLAT FLOAT;
DECLARE @V_id_umowy FLOAT;
DECLARE @V_id_klienta FLOAT;
DECLARE @V_kwota_pln FLOAT;
BEGIN
DECLARE k CURSOR FOR
SELECT u.id_umowy,
    u.id_klienta,
    u.kwota_pln
from umowy_pln u
order by u.id_klienta,
    u.data_umowy;
OPEN k;
FETCH k INTO @V_id_umowy,
@V_id_klienta,
@V_kwota_pln;
WHILE @@FETCH_STATUS = 0 BEGIN
SELECT @V_SUMA_WPLAT = d.SUMA_WPLAT_PLN
FROM suma_wplat d
WHERE @V_id_klienta = d.id_klienta;
IF @V_SUMA_WPLAT >= @V_kwota_pln BEGIN
SET @V_RESZTA = @V_SUMA_WPLAT - @V_kwota_pln;
SET @V_KWOTA = 0;
END
ELSE IF @V_SUMA_WPLAT < 0 BEGIN
SET @V_RESZTA = @V_SUMA_WPLAT - @V_kwota_pln;
SET @V_KWOTA = @V_kwota_pln;
END
ELSE BEGIN
SET @V_RESZTA = @V_SUMA_WPLAT - @V_kwota_pln;
SET @V_KWOTA = @V_kwota_pln - @V_SUMA_WPLAT;
END
UPDATE umowy_pln
SET kwota_pln = @v_KWOTA
WHERE id_umowy = @V_id_umowy;
UPDATE suma_wplat
SET SUMA_WPLAT_PLN = @v_RESZTA
WHERE id_klienta = @V_id_klienta;
FETCH k INTO @V_id_umowy,
@V_id_klienta,
@V_kwota_pln;
END;
CLOSE k;
DEALLOCATE k;
END;
END;
IF OBJECT_ID('laduj_odsetki', 'P') IS NOT NULL DROP PROCEDURE laduj_odsetki;
GO CREATE PROCEDURE laduj_odsetki AS BEGIN
SET NOCOUNT ON;
INSERT INTO ODSETKI
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
    ROUND((o.liczba_dni / 365.0 * 0.05 * u.kwota_pln), 2) as kwota_odsetek
from (
        select u.ID_UMOWY,
            u.ID_KLIENTA,
            u.DATA_UMOWY + 14 as data_wymagalnosci,
            convert(datetime, convert(date, getdate())) as data_danych,
            CASE
                WHEN DATEDIFF(day, getdate(), (u.DATA_UMOWY + 14)) > 0 THEN DATEDIFF(day, getdate(),(u.DATA_UMOWY + 14))
                ELSE 0
            END AS liczba_dni
        from umowy_pln u
    ) o
    left join umowy_pln u on u.id_umowy = o.id_umowy
    and u.id_klienta = o.id_klienta;
END;
CREATE PROCEDURE laduj_zalegle_umowy AS BEGIN
SET NOCOUNT ON;
INSERT INTO ZALEGLE_UMOWY
select k.id_klienta,
    ISNULL(t2.styczen18, 0) as styczen18,
    ISNULL(t2.luty18, 0) as luty18,
    ISNULL(t2.marzec18, 0) as marzec18,
    ISNULL(t2.kwiecien18, 0) as kwiecien18,
    ISNULL(t2.maj18, 0) as maj18,
    ISNULL(t2.czerwiec18, 0) as czerwiec18,
    ISNULL(t2.lipiec18, 0) as lipiec18,
    ISNULL(t2.sierpien18, 0) as sierpien18,
    ISNULL(t2.wrzesien18, 0) as wrzesien18,
    ISNULL(t2.pazdziernik18, 0) as pazdziernik18,
    ISNULL(t2.listopad18, 0) as listopad18,
    ISNULL(t2.grudzien18, 0) as grudzien18,
    ISNULL(t2.styczen19, 0) as styczen19,
    ISNULL(t2.luty19, 0) as luty19,
    ISNULL(t2.marzec19, 0) as marzec19,
    ISNULL(t2.kwiecien19, 0) as kwiecien19,
    ISNULL(t2.maj19, 0) as maj19,
    ISNULL(t2.czerwiec19, 0) as czerwiec19,
    ISNULL(t2.lipiec19, 0) as lipiec19,
    ISNULL(t2.sierpien19, 0) as sierpien19,
    ISNULL(t2.wrzesien19, 0) as wrzesien19,
    ISNULL(t2.pazdziernik19, 0) as pazdziernik19,
    ISNULL(t2.listopad19, 0) as listopad19,
    ISNULL(t2.grudzien19, 0) as grudzien19,
    ISNULL(t2.styczen20, 0) as styczen20,
    ISNULL(t2.luty20, 0) as luty20,
    ISNULL(t2.marzec20, 0) as marzec20,
    ISNULL(t2.kwiecien20, 0) as kwiecien20,
    ISNULL(t2.maj20, 0) as maj20,
    ISNULL(t2.czerwiec20, 0) as czerwiec20,
    ISNULL(t2.lipiec20, 0) as lipiec20,
    ISNULL(t2.sierpien20, 0) as sierpien20,
    ISNULL(t2.wrzesien20, 0) as wrzesien20,
    ISNULL(t2.pazdziernik20, 0) as pazdziernik20,
    ISNULL(t2.listopad20, 0) as listopad20,
    ISNULL(t2.grudzien20, 0) as grudzien20,
    ISNULL(t2.styczen21, 0) as styczen21,
    ISNULL(t2.luty21, 0) as luty21,
    ISNULL(t2.marzec21, 0) as marzec21,
    ISNULL(t2.kwiecien21, 0) as kwiecien21,
    ISNULL(t2.maj21, 0) as maj21,
    ISNULL(t2.czerwiec21, 0) as czerwiec21,
    ISNULL(t2.lipiec21, 0) as lipiec21,
    ISNULL(t2.sierpien21, 0) as sierpien21
from klienci k
    left join (
        select id_klienta,
            sum(styczen18) as styczen18,
            sum(luty18) as luty18,
            sum(marzec18) as marzec18,
            sum(kwiecien18) as kwiecien18,
            sum(maj18) as maj18,
            sum(czerwiec18) as czerwiec18,
            sum(lipiec18) as lipiec18,
            sum(sierpien18) as sierpien18,
            sum(wrzesien18) as wrzesien18,
            sum(pazdziernik18) as pazdziernik18,
            sum(listopad18) as listopad18,
            sum(grudzien18) as grudzien18,
            sum(styczen19) as styczen19,
            sum(luty19) as luty19,
            sum(marzec19) as marzec19,
            sum(kwiecien19) as kwiecien19,
            sum(maj19) as maj19,
            sum(czerwiec19) as czerwiec19,
            sum(lipiec19) as lipiec19,
            sum(sierpien19) as sierpien19,
            sum(wrzesien19) as wrzesien19,
            sum(pazdziernik19) as pazdziernik19,
            sum(listopad19) as listopad19,
            sum(grudzien19) as grudzien19,
            sum(styczen20) as styczen20,
            sum(luty20) as luty20,
            sum(marzec20) as marzec20,
            sum(kwiecien20) as kwiecien20,
            sum(maj20) as maj20,
            sum(czerwiec20) as czerwiec20,
            sum(lipiec20) as lipiec20,
            sum(sierpien20) as sierpien20,
            sum(wrzesien20) as wrzesien20,
            sum(pazdziernik20) as pazdziernik20,
            sum(listopad20) as listopad20,
            sum(grudzien20) as grudzien20,
            sum(styczen21) as styczen21,
            sum(luty21) as luty21,
            sum(marzec21) as marzec21,
            sum(kwiecien21) as kwiecien21,
            sum(maj21) as maj21,
            sum(czerwiec21) as czerwiec21,
            sum(lipiec21) as lipiec21,
            sum(sierpien21) as sierpien21
        from (
                select id_klienta,
                    case
                        when miesiac = 1
                        and rok = 2018 then 1
                        else 0
                    end as styczen18,
                    case
                        when miesiac = 2
                        and rok = 2018 then 1
                        else 0
                    end as luty18,
                    case
                        when miesiac = 3
                        and rok = 2018 then 1
                        else 0
                    end as marzec18,
                    case
                        when miesiac = 4
                        and rok = 2018 then 1
                        else 0
                    end as kwiecien18,
                    case
                        when miesiac = 5
                        and rok = 2018 then 1
                        else 0
                    end as maj18,
                    case
                        when miesiac = 6
                        and rok = 2018 then 1
                        else 0
                    end as czerwiec18,
                    case
                        when miesiac = 7
                        and rok = 2018 then 1
                        else 0
                    end as lipiec18,
                    case
                        when miesiac = 8
                        and rok = 2018 then 1
                        else 0
                    end as sierpien18,
                    case
                        when miesiac = 9
                        and rok = 2018 then 1
                        else 0
                    end as wrzesien18,
                    case
                        when miesiac = 10
                        and rok = 2018 then 1
                        else 0
                    end as pazdziernik18,
                    case
                        when miesiac = 11
                        and rok = 2018 then 1
                        else 0
                    end as listopad18,
                    case
                        when miesiac = 12
                        and rok = 2018 then 1
                        else 0
                    end as grudzien18,
                    case
                        when miesiac = 1
                        and rok = 2019 then 1
                        else 0
                    end as styczen19,
                    case
                        when miesiac = 2
                        and rok = 2019 then 1
                        else 0
                    end as luty19,
                    case
                        when miesiac = 3
                        and rok = 2019 then 1
                        else 0
                    end as marzec19,
                    case
                        when miesiac = 4
                        and rok = 2019 then 1
                        else 0
                    end as kwiecien19,
                    case
                        when miesiac = 5
                        and rok = 2019 then 1
                        else 0
                    end as maj19,
                    case
                        when miesiac = 6
                        and rok = 2019 then 1
                        else 0
                    end as czerwiec19,
                    case
                        when miesiac = 7
                        and rok = 2019 then 1
                        else 0
                    end as lipiec19,
                    case
                        when miesiac = 8
                        and rok = 2019 then 1
                        else 0
                    end as sierpien19,
                    case
                        when miesiac = 9
                        and rok = 2019 then 1
                        else 0
                    end as wrzesien19,
                    case
                        when miesiac = 10
                        and rok = 2019 then 1
                        else 0
                    end as pazdziernik19,
                    case
                        when miesiac = 11
                        and rok = 2019 then 1
                        else 0
                    end as listopad19,
                    case
                        when miesiac = 12
                        and rok = 2019 then 1
                        else 0
                    end as grudzien19,
                    case
                        when miesiac = 1
                        and rok = 2020 then 1
                        else 0
                    end as styczen20,
                    case
                        when miesiac = 2
                        and rok = 2020 then 1
                        else 0
                    end as luty20,
                    case
                        when miesiac = 3
                        and rok = 2020 then 1
                        else 0
                    end as marzec20,
                    case
                        when miesiac = 4
                        and rok = 2020 then 1
                        else 0
                    end as kwiecien20,
                    case
                        when miesiac = 5
                        and rok = 2020 then 1
                        else 0
                    end as maj20,
                    case
                        when miesiac = 6
                        and rok = 2020 then 1
                        else 0
                    end as czerwiec20,
                    case
                        when miesiac = 7
                        and rok = 2020 then 1
                        else 0
                    end as lipiec20,
                    case
                        when miesiac = 8
                        and rok = 2020 then 1
                        else 0
                    end as sierpien20,
                    case
                        when miesiac = 9
                        and rok = 2020 then 1
                        else 0
                    end as wrzesien20,
                    case
                        when miesiac = 10
                        and rok = 2020 then 1
                        else 0
                    end as pazdziernik20,
                    case
                        when miesiac = 11
                        and rok = 2020 then 1
                        else 0
                    end as listopad20,
                    case
                        when miesiac = 12
                        and rok = 2020 then 1
                        else 0
                    end as grudzien20,
                    case
                        when miesiac = 1
                        and rok = 2021 then 1
                        else 0
                    end as styczen21,
                    case
                        when miesiac = 2
                        and rok = 2021 then 1
                        else 0
                    end as luty21,
                    case
                        when miesiac = 3
                        and rok = 2021 then 1
                        else 0
                    end as marzec21,
                    case
                        when miesiac = 4
                        and rok = 2021 then 1
                        else 0
                    end as kwiecien21,
                    case
                        when miesiac = 5
                        and rok = 2021 then 1
                        else 0
                    end as maj21,
                    case
                        when miesiac = 6
                        and rok = 2021 then 1
                        else 0
                    end as czerwiec21,
                    case
                        when miesiac = 7
                        and rok = 2021 then 1
                        else 0
                    end as lipiec21,
                    case
                        when miesiac = 8
                        and rok = 2021 then 1
                        else 0
                    end as sierpien21
                from umowy_pln
                where id_klienta in (
                        select id_klienta
                        from klienci
                    )
            ) s
        group by id_klienta
    ) t2 on (k.id_klienta = t2.id_klienta)
where k.status = 'Active';
END;
CREATE PROCEDURE laduj_saldo_klienta AS BEGIN
SET NOCOUNT ON;
INSERT INTO SALDO_KLIENTA
SELECT k.id_klienta,
    k.nazwa_firmy,
    k.data_zalozenia,
    k.wojewodzctwo,
    k.miasto,
    k.adres,
    ISNULL(o.kwota_odsetek, 0) as KWOTA_ODSETEK,
    ISNULL(s.SUMA_WPLAT_PLN, 0) as SUMA_WPLAT_PLN,
    ISNULL(s.SUMA_WPLAT_PLN, 0) - ISNULL(o.kwota_odsetek, 0) AS SALDO_KLIENTA
FROM klienci k
    LEFT JOIN (
        SELECT o.id_klienta,
            SUM(o.KWOTA_ODSETEK) as KWOTA_ODSETEK
        FROM ODSETKI o
        GROUP BY o.ID_KLIENTA
    ) o ON k.id_klienta = o.id_klienta
    LEFT JOIN suma_wplat s ON k.id_klienta = s.id_klienta
WHERE k.status = 'Active';
END;
IF OBJECT_ID('czysc_tabele', 'P') IS NOT NULL DROP PROCEDURE czysc_tabele;
GO CREATE PROCEDURE czysc_tabele as BEGIN
SET NOCOUNT ON;
execute sp_executesql @'TRUNCATE TABLE ODSETKI';
execute sp_executesql @'TRUNCATE TABLE SALDO_KLIENTA';
execute sp_executesql @'TRUNCATE TABLE SUMA_WPLAT';
execute sp_executesql @'TRUNCATE TABLE UMOWY_PLN';
execute sp_executesql @'TRUNCATE TABLE WPLATY_PLN';
execute sp_executesql @'TRUNCATE TABLE ZALEGLE_UMOWY';
END;
BEGIN EXEC dbo.loguj_start @p_nazwa_procesu = 'laduj_umowy_pln';
EXEC dbo.laduj_umowy_pln;
EXEC dbo.loguj_stop @p_nazwa_procesu = 'laduj_umowy_pln';
EXEC dbo.loguj_start @p_nazwa_procesu = 'laduj_wplaty_pln';
EXEC dbo.laduj_wplaty_pln;
EXEC dbo.loguj_stop @p_nazwa_procesu = 'laduj_wplaty_pln';
EXEC dbo.loguj_start @p_nazwa_procesu = 'laduj_suma_wplat_pln';
EXEC dbo.laduj_suma_wplat_pln;
EXEC dbo.loguj_stop @p_nazwa_procesu = 'laduj_suma_wplat_pln';
EXEC dbo.loguj_start @p_nazwa_procesu = 'laduj_rozliczenie_wplat';
EXEC dbo.laduj_rozliczenie_wplat;
EXEC dbo.loguj_stop @p_nazwa_procesu = 'laduj_rozliczenie_wplat';
EXEC dbo.loguj_start @p_nazwa_procesu = 'laduj_odsetki';
EXEC dbo.laduj_odsetki;
EXEC dbo.loguj_stop @p_nazwa_procesu = 'laduj_odsetki';
EXEC dbo.loguj_start @p_nazwa_procesu = 'laduj_zalegle_umowy';
EXEC dbo.laduj_zalegle_umowy;
EXEC dbo.loguj_stop @p_nazwa_procesu = 'laduj_zalegle_umowy';
EXEC dbo.loguj_start @p_nazwa_procesu = 'laduj_saldo_klienta';
EXEC dbo.laduj_saldo_klienta;
EXEC dbo.loguj_stop @p_nazwa_procesu = 'laduj_saldo_klienta';
COMMIT;
END;
BEGIN czysc_tabele();
END;
-- SQLINES DEMO *** , kod
--from kursy_walut
-- SQLINES DEMO *** ch, kod
- - SQLINES DEMO * * * danych
) > 2;