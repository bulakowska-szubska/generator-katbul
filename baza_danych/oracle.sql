--utworzenie tabel i sekwencji
CREATE TABLE STATUS_WYKONANIA (
    NAZWA_PROCESU   VARCHAR2(100),
    DATA_STARTU     TIMESTAMP,
    DATA_KONCA      TIMESTAMP
);

CREATE TABLE KURSY_WALUT (
    DATA_DANYCH DATE,
    WALUTA VARCHAR2(100),
    KOD VARCHAR2(3),
    KURS NUMBER
);  

CREATE TABLE TMP_DATA_DANYCH (
    friday DATE,
    saturday DATE,
    sunday DATE
);

CREATE SEQUENCE klienci_seq
  MINVALUE 1
  MAXVALUE 999999999
  START WITH 1
  INCREMENT BY 1
  NOCACHE;

CREATE TABLE KLIENCI (
    ID_KLIENTA NUMBER DEFAULT klienci_seq.nextval,
    NAZWA_FIRMY VARCHAR2(200),
    DATA_ZALOZENIA DATE,
    WOJEWODZCTWO VARCHAR2(100),
    MIASTO VARCHAR2(100),
    ADRES VARCHAR2(200),
    STATUS VARCHAR(50),
    CONSTRAINT klienci_pk PRIMARY KEY (id_klienta),
    CONSTRAINT klienci_ch CHECK (STATUS IN ('Active','Inactive'))
);

CREATE SEQUENCE umowy_seq
  MINVALUE 1
  MAXVALUE 999999999
  START WITH 1
  INCREMENT BY 1
  NOCACHE;

CREATE TABLE UMOWY (
    ID_UMOWY NUMBER DEFAULT umowy_seq.nextval,
    ID_KLIENTA NUMBER,
    DATA_UMOWY DATE,
    MIESIAC VARCHAR2(2),
    ROK VARCHAR2(4),
    KWOTA NUMBER,
    WALUTA VARCHAR2(3),
    CONSTRAINT umowy_pk PRIMARY KEY (ID_UMOWY),
    CONSTRAINT umowy_fk FOREIGN KEY (id_klienta)
    REFERENCES klienci (id_klienta)
);

CREATE SEQUENCE wplaty_seq
  MINVALUE 1
  MAXVALUE 999999999
  START WITH 1
  INCREMENT BY 1
  NOCACHE;

CREATE TABLE WPLATY (
    ID_WPLATY NUMBER DEFAULT wplaty_seq.nextval,
    ID_KLIENTA NUMBER,
    DATA_WPLATY DATE,
    KWOTA NUMBER,
    WALUTA VARCHAR2(3),
    CONSTRAINT wplaty_pk PRIMARY KEY (ID_WPLATY),
    CONSTRAINT wplaty_fk FOREIGN KEY (id_klienta)
    REFERENCES klienci (id_klienta)
);

CREATE TABLE UMOWY_PLN
(   ID_UMOWY NUMBER, 
	ID_KLIENTA NUMBER, 
	NAZWA_FIRMY VARCHAR2(200 BYTE), 
	MIESIAC VARCHAR2(2 BYTE), 
	ROK VARCHAR2(4 BYTE), 
	KWOTA NUMBER, 
	WALUTA VARCHAR2(3 BYTE), 
	DATA_UMOWY DATE, 
	KWOTA_PLN NUMBER, 
	KWOTA_PLN_PRZED NUMBER, 
	D_UM NUMBER, 
	D_ZAL NUMBER,
    CONSTRAINT umowy_pln_pk PRIMARY KEY (ID_UMOWY),
    CONSTRAINT umowy_pln_fk FOREIGN KEY (id_klienta)
    REFERENCES klienci (id_klienta)
);

CREATE TABLE WPLATY_PLN
   (ID_WPLATY NUMBER, 
	ID_KLIENTA NUMBER, 
	KWOTA NUMBER, 
	WALUTA VARCHAR2(3 BYTE), 
	DATA_WPLATY DATE, 
	KWOTA_PLN NUMBER,
    CONSTRAINT WPLATY_PLN_pk PRIMARY KEY (ID_WPLATY),
    CONSTRAINT WPLATY_PLN_fk FOREIGN KEY (id_klienta)
    REFERENCES klienci (id_klienta)
);

CREATE TABLE SUMA_WPLAT
    (ID_KLIENTA NUMBER, 
	SUMA_WPLAT_PLN NUMBER,
    CONSTRAINT SUMA_WPLAT_pk PRIMARY KEY (ID_KLIENTA),
    CONSTRAINT SUMA_WPLAT_fk FOREIGN KEY (id_klienta)
    REFERENCES klienci (id_klienta)
);


CREATE SEQUENCE odsetki_seq
  MINVALUE 1
  MAXVALUE 999999999
  START WITH 1
  INCREMENT BY 1
  NOCACHE;

CREATE TABLE ODSETKI
   (ID_ODSETKI NUMBER DEFAULT odsetki_seq.nextval,
    ID_UMOWY NUMBER, 
	ID_KLIENTA NUMBER, 
	NAZWA_FIRMY VARCHAR2(200 BYTE), 
	KWOTA NUMBER, 
	WALUTA VARCHAR2(3 BYTE), 
	DATA_UMOWY DATE, 
	KWOTA_PLN NUMBER, 
	DATA_WYMAGALNOSCI DATE, 
	DATA_DANYCH DATE, 
	LICZBA_DNI NUMBER, 
	KWOTA_ODSETEK NUMBER,
    CONSTRAINT ODSETKI_pk PRIMARY KEY (ID_ODSETKI),
    CONSTRAINT ODSETKI_fk FOREIGN KEY (id_klienta)
    REFERENCES klienci (id_klienta)
);

CREATE TABLE SALDO_KLIENTA
   (ID_KLIENTA NUMBER, 
	NAZWA_FIRMY VARCHAR2(200 BYTE), 
	DATA_ZALOZENIA DATE, 
	WOJEWODZCTWO VARCHAR2(100 BYTE), 
	MIASTO VARCHAR2(100 BYTE), 
	ADRES VARCHAR2(200 BYTE), 
	KWOTA_ODSETEK NUMBER, 
	SUMA_WPLAT_PLN NUMBER, 
	SALDO_KLIENTA NUMBER,
    CONSTRAINT SALDO_KLIENTA_pk PRIMARY KEY (ID_KLIENTA),
    CONSTRAINT SALDO_KLIENTA_fk FOREIGN KEY (id_klienta)
    REFERENCES klienci (id_klienta)
);

CREATE TABLE ZALEGLE_UMOWY
   (	
    ID_KLIENTA NUMBER, 
	STYCZEN18 NUMBER, 
	LUTY18 NUMBER, 
	MARZEC18 NUMBER, 
	KWIECIEN18 NUMBER, 
	MAJ18 NUMBER, 
	CZERWIEC18 NUMBER, 
	LIPIEC18 NUMBER, 
	SIERPIEN18 NUMBER, 
	WRZESIEN18 NUMBER, 
	PAZDZIERNIK18 NUMBER, 
	LISTOPAD18 NUMBER, 
	GRUDZIEN18 NUMBER, 
	STYCZEN19 NUMBER, 
	LUTY19 NUMBER, 
	MARZEC19 NUMBER, 
	KWIECIEN19 NUMBER, 
	MAJ19 NUMBER, 
	CZERWIEC19 NUMBER, 
	LIPIEC19 NUMBER, 
	SIERPIEN19 NUMBER, 
	WRZESIEN19 NUMBER, 
	PAZDZIERNIK19 NUMBER, 
	LISTOPAD19 NUMBER, 
	GRUDZIEN19 NUMBER, 
	STYCZEN20 NUMBER, 
	LUTY20 NUMBER, 
	MARZEC20 NUMBER, 
	KWIECIEN20 NUMBER, 
	MAJ20 NUMBER, 
	CZERWIEC20 NUMBER, 
	LIPIEC20 NUMBER, 
	SIERPIEN20 NUMBER, 
	WRZESIEN20 NUMBER, 
	PAZDZIERNIK20 NUMBER, 
	LISTOPAD20 NUMBER, 
	GRUDZIEN20 NUMBER, 
	STYCZEN21 NUMBER, 
	LUTY21 NUMBER, 
	MARZEC21 NUMBER, 
	KWIECIEN21 NUMBER, 
	MAJ21 NUMBER, 
	CZERWIEC21 NUMBER, 
	LIPIEC21 NUMBER, 
	SIERPIEN21 NUMBER,
    CONSTRAINT ZALEGLE_UMOWY_pk PRIMARY KEY (ID_KLIENTA),
    CONSTRAINT ZALEGLE_UMOWY_fk FOREIGN KEY (id_klienta)
    REFERENCES klienci (id_klienta)
);

CREATE OR REPLACE PROCEDURE loguj_start(p_nazwa_procesu in VARCHAR) IS
BEGIN
INSERT INTO status_wykonania (nazwa_procesu, data_startu, data_konca) 
VALUES (p_nazwa_procesu,CURRENT_TIMESTAMP,null);
COMMIT;
END;

CREATE OR REPLACE PROCEDURE loguj_stop(p_nazwa_procesu in VARCHAR) IS
BEGIN
UPDATE status_wykonania SET data_konca = CURRENT_TIMESTAMP
    WHERE nazwa_procesu = p_nazwa_procesu;
    COMMIT;
END;

CREATE PROCEDURE insert_tmp_data_danych_rok (data_danych IN DATE) IS
BEGIN
INSERT INTO TMP_DATA_DANYCH (friday, saturday, sunday)
--all fridays
  with dts as (
  select data_danych+rownum-1 as dt from dual
  connect by level <= 366
) 
  select dt     as friday, 
         dt+1   as saturday, 
         dt+2   as sunday 
  from dts
  where  to_char(dt, 'fmday', 'NLS_DATE_LANGUAGE=AMERICAN') = 'friday';
END;

--BEGIN
--insert_tmp_data_danych_rok(TO_DATE('2018-01-01','YYYY-MM-DD'));
----powielic dla 18,19,20,21 :)
--END;

CREATE OR REPLACE PROCEDURE laduj_dane_kursy_walut (p_data_danych IN DATE, p_data_danych_ostatnia IN DATE) IS
BEGIN
INSERT INTO KURSY_WALUT
with saturday as (
SELECT k.* 
from TMP_DATA_DANYCH k where k.friday >= p_data_danych AND k.friday <= p_data_danych_ostatnia
)
SELECT  s.saturday,
        k.WALUTA,
        k.KOD,
        k.KURS
FROM saturday s
left join kursy_walut k on k.data_danych = s.friday;
COMMIT;

INSERT INTO KURSY_WALUT
with sunday as (
SELECT k.* 
from TMP_DATA_DANYCH k
where k.friday >= p_data_danych AND k.friday <= p_data_danych_ostatnia
)
SELECT  s.sunday,
        k.WALUTA,
        k.KOD,
        k.KURS
FROM sunday s
left join kursy_walut k on k.data_danych = s.friday;
COMMIT;
END;

--BEGIN
--laduj_dane_kursy_walut(TO_DATE('2018/01/01','YYYY/MM/DD'), TO_DATE('2021/08/24','YYYY/MM/DD'));
--END;

CREATE OR REPLACE PROCEDURE laduj_umowy_pln IS
BEGIN
INSERT INTO UMOWY_PLN
WITH najnowsza_umowa as 
(   SELECT    u.id_umowy, u.data_umowy,
            ROW_NUMBER() OVER (PARTITION BY u.id_klienta, u.miesiac, u.rok ORDER BY u.data_umowy desc) as liczba
    FROM umowy u),
        data_zalozenia as (
    SELECT    u.id_umowy, kl.id_klienta,
        TO_NUMBER(TO_CHAR(kl.data_zalozenia,'YYYYMM')) as d_zal,
        CASE
            WHEN u.miesiac = '1' THEN TO_NUMBER(CONCAT(u.rok,'01'))
            WHEN u.miesiac = '2' THEN TO_NUMBER(CONCAT(u.rok,'02'))
            WHEN u.miesiac = '3' THEN TO_NUMBER(CONCAT(u.rok,'03'))
            WHEN u.miesiac = '4' THEN TO_NUMBER(CONCAT(u.rok,'04'))
            WHEN u.miesiac = '5' THEN TO_NUMBER(CONCAT(u.rok,'05'))
            WHEN u.miesiac = '6' THEN TO_NUMBER(CONCAT(u.rok,'06'))
            WHEN u.miesiac = '7' THEN TO_NUMBER(CONCAT(u.rok,'07'))
            WHEN u.miesiac = '8' THEN TO_NUMBER(CONCAT(u.rok,'08'))
            WHEN u.miesiac = '9' THEN TO_NUMBER(CONCAT(u.rok,'09'))
            WHEN u.miesiac = '10' THEN TO_NUMBER(CONCAT(u.rok, u.miesiac))
            WHEN u.miesiac = '11' THEN TO_NUMBER(CONCAT(u.rok, u.miesiac))
            WHEN u.miesiac = '12' THEN TO_NUMBER(CONCAT(u.rok, u.miesiac))
        END AS d_um
FROM umowy u
LEFT JOIN klienci kl on kl.id_klienta = u.id_klienta
)
SELECT
    um.ID_UMOWY,
    kl.id_klienta,
    kl.nazwa_firmy,
    u.MIESIAC,
    u.ROK,
    u.KWOTA,
    u.WALUTA,
    um.data_umowy,
    CASE
        WHEN u.waluta = 'PLN' THEN NVL(u.kwota,0)
        ELSE NVL(ROUND(u.kwota * k.kurs,2),0) 
    end as kwota_pln,
    CASE
        WHEN u.waluta = 'PLN' THEN NVL(u.kwota,0)
        ELSE NVL(ROUND(u.kwota * k.kurs,2),0) 
    end as kwota_pln_przed,
    dz.d_um,
    dz.d_zal
FROM najnowsza_umowa um
LEFT JOIN UMOWY u ON um.id_umowy = u.ID_UMOWY
LEFT JOIN kursy_walut k on u.WALUTA = k.kod AND u.data_umowy = k.data_danych
LEFT JOIN klienci kl on kl.id_klienta = u.id_klienta
LEFT JOIN data_zalozenia dz on um.id_umowy = dz.id_umowy and dz.id_klienta = kl.id_klienta
WHERE um.liczba = 1  AND dz.d_um >= dz.d_zal 
;
END;

CREATE PROCEDURE laduj_wplaty_pln IS
BEGIN
INSERT INTO WPLATY_PLN
SELECT 
    w.id_wplaty, 
    w.id_klienta, 
    w.kwota, 
    w.waluta,
    w.data_wplaty,
     CASE
        WHEN w.waluta = 'PLN' THEN NVL(w.kwota,0)
        ELSE NVL(ROUND(w.kwota * k.kurs,2),0)
    end as kwota_pln
from wplaty w
left join kursy_walut k on w.data_wplaty = k.data_danych and w.waluta = k.kod;
END;


CREATE PROCEDURE laduj_suma_wplat_pln IS
BEGIN
INSERT INTO SUMA_WPLAT
SELECT 
    k.id_klienta,
    NVL(SUM(w.KWOTA_PLN),0) as suma_wplat_pln
FROM klienci k
LEFT JOIN WPLATY_PLN w on w.id_klienta = k.id_klienta
GROUP BY k.id_klienta;
END;


CREATE OR REPLACE PROCEDURE laduj_rozliczenie_wplat is
BEGIN

DECLARE 
v_RESZTA NUMBER;
v_KWOTA NUMBER;
V_SUMA_WPLAT NUMBER;

BEGIN
FOR k IN (SELECT  
            u.id_umowy,
            u.id_klienta, 
            u.kwota_pln
        from   umowy_pln u
        order by u.id_klienta, u.data_umowy)
    LOOP
        SELECT  d.SUMA_WPLAT_PLN INTO V_SUMA_WPLAT
        FROM suma_wplat d
        WHERE k.id_klienta = d.id_klienta;

        IF V_SUMA_WPLAT >= k.KWOTA_PLN THEN
        V_RESZTA := V_SUMA_WPLAT - k.KWOTA_PLN;
        V_KWOTA := 0;
        ELSIF V_SUMA_WPLAT < 0 THEN
            V_RESZTA := V_SUMA_WPLAT - k.KWOTA_PLN;
            V_KWOTA := k.KWOTA_PLN;
        ELSE 
            V_RESZTA := V_SUMA_WPLAT - k.KWOTA_PLN;
            V_KWOTA := k.KWOTA_PLN - V_SUMA_WPLAT;
        END IF;

        UPDATE umowy_pln u
        SET u.kwota_pln = V_KWOTA
        WHERE u.id_umowy = k.id_umowy;

        UPDATE suma_wplat s
        SET s.SUMA_WPLAT_PLN = V_RESZTA
        WHERE s.id_klienta = k.id_klienta;

    END LOOP;
    END;
END;


CREATE OR REPLACE PROCEDURE laduj_odsetki IS
BEGIN
INSERT INTO ODSETKI
WITH odsetki as (
select 
    u.ID_UMOWY,
    u.ID_KLIENTA,
    u.DATA_UMOWY + 14 as data_wymagalnosci,
    trunc(sysdate) as data_danych,
    CASE 
        WHEN trunc(sysdate) - (u.DATA_UMOWY + 14) >0 THEN trunc(sysdate) - (u.DATA_UMOWY + 14)
        ELSE 0
    END AS liczba_dni
from umowy_pln u
)
select 
    odsetki_seq.nextval,
    u.ID_UMOWY,
    u.ID_KLIENTA,
    u.NAZWA_FIRMY,
    u.KWOTA,
    u.WALUTA,
    u.DATA_UMOWY,
    u.KWOTA_PLN,
    o.data_wymagalnosci,
    o.data_danych,
    o.liczba_dni,
    ROUND((o.liczba_dni /365 * 0.05 * u.kwota_pln),2) as kwota_odsetek
from odsetki o
left join umowy_pln u on u.id_umowy = o.id_umowy and u.id_klienta = o.id_klienta;
END;

CREATE PROCEDURE laduj_zalegle_umowy IS
BEGIN
INSERT INTO ZALEGLE_UMOWY 
select  k.id_klienta,
        NVL(t2.styczen18,0) as styczen18, 
        NVL(t2.luty18,0) as luty18,
        NVL(t2.marzec18,0) as marzec18,
        NVL(t2.kwiecien18,0) as kwiecien18,
        NVL(t2.maj18,0) as maj18,
        NVL(t2.czerwiec18,0) as czerwiec18,
        NVL(t2.lipiec18,0) as lipiec18,
        NVL(t2.sierpien18,0) as sierpien18,
        NVL(t2.wrzesien18,0) as wrzesien18,
        NVL(t2.pazdziernik18,0) as pazdziernik18,
        NVL(t2.listopad18,0) as listopad18,
        NVL(t2.grudzien18,0) as grudzien18,
        NVL(t2.styczen19,0) as styczen19, 
        NVL(t2.luty19,0) as luty19,
        NVL(t2.marzec19,0) as marzec19,
        NVL(t2.kwiecien19,0) as kwiecien19,
        NVL(t2.maj19,0) as maj19,
        NVL(t2.czerwiec19,0) as czerwiec19,
        NVL(t2.lipiec19,0) as lipiec19,
        NVL(t2.sierpien19,0) as sierpien19,
        NVL(t2.wrzesien19,0) as wrzesien19,
        NVL(t2.pazdziernik19,0) as pazdziernik19,
        NVL(t2.listopad19,0) as listopad19,
        NVL(t2.grudzien19,0) as grudzien19,
        NVL(t2.styczen20,0) as styczen20, 
        NVL(t2.luty20,0) as luty20,
        NVL(t2.marzec20,0) as marzec20,
        NVL(t2.kwiecien20,0) as kwiecien20,
        NVL(t2.maj20,0) as maj20,
        NVL(t2.czerwiec20,0) as czerwiec20,
        NVL(t2.lipiec20,0) as lipiec20,
        NVL(t2.sierpien20,0) as sierpien20,
        NVL(t2.wrzesien20,0) as wrzesien20,
        NVL(t2.pazdziernik20,0) as pazdziernik20,
        NVL(t2.listopad20,0) as listopad20,
        NVL(t2.grudzien20,0) as grudzien20,
        NVL(t2.styczen21,0) as styczen21, 
        NVL(t2.luty21,0) as luty21,
        NVL(t2.marzec21,0) as marzec21,
        NVL(t2.kwiecien21,0) as kwiecien21,
        NVL(t2.maj21,0) as maj21,
        NVL(t2.czerwiec21,0) as czerwiec21,
        NVL(t2.lipiec21,0) as lipiec21,
        NVL(t2.sierpien21,0) as sierpien21
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
    from (select id_klienta,
                case when miesiac=1 and rok=2018 then 1  else 0 end as styczen18,
                case when miesiac=2 and rok=2018 then 1  else 0 end as luty18,
                case when miesiac=3 and rok=2018 then 1  else 0 end as marzec18,
                case when miesiac=4 and rok=2018 then 1  else 0 end as kwiecien18,
                case when miesiac=5 and rok=2018 then 1  else 0 end as maj18,
                case when miesiac=6 and rok=2018 then 1  else 0 end as czerwiec18,
                case when miesiac=7 and rok=2018 then 1  else 0 end as lipiec18,
                case when miesiac=8 and rok=2018 then 1  else 0 end as sierpien18,
                case when miesiac=9 and rok=2018 then 1  else 0 end as wrzesien18,
                case when miesiac=10 and rok=2018 then 1  else 0 end as pazdziernik18,
                case when miesiac=11 and rok=2018 then 1  else 0 end as listopad18,
                case when miesiac=12 and rok=2018 then 1  else 0 end as grudzien18,
                case when miesiac=1 and rok=2019 then 1  else 0 end as styczen19,
                case when miesiac=2 and rok=2019 then 1  else 0 end as luty19,
                case when miesiac=3 and rok=2019 then 1  else 0 end as marzec19,
                case when miesiac=4 and rok=2019 then 1  else 0 end as kwiecien19,
                case when miesiac=5 and rok=2019 then 1  else 0 end as maj19,
                case when miesiac=6 and rok=2019 then 1  else 0 end as czerwiec19,
                case when miesiac=7 and rok=2019 then 1  else 0 end as lipiec19,
                case when miesiac=8 and rok=2019 then 1  else 0 end as sierpien19,
                case when miesiac=9 and rok=2019 then 1  else 0 end as wrzesien19,
                case when miesiac=10 and rok=2019 then 1  else 0 end as pazdziernik19,
                case when miesiac=11 and rok=2019 then 1  else 0 end as listopad19,
                case when miesiac=12 and rok=2019 then 1  else 0 end as grudzien19,
                case when miesiac=1 and rok=2020 then 1  else 0 end as styczen20,
                case when miesiac=2 and rok=2020 then 1  else 0 end as luty20,
                case when miesiac=3 and rok=2020 then 1  else 0 end as marzec20,
                case when miesiac=4 and rok=2020 then 1  else 0 end as kwiecien20,
                case when miesiac=5 and rok=2020 then 1  else 0 end as maj20,
                case when miesiac=6 and rok=2020 then 1  else 0 end as czerwiec20,
                case when miesiac=7 and rok=2020 then 1  else 0 end as lipiec20,
                case when miesiac=8 and rok=2020 then 1  else 0 end as sierpien20,
                case when miesiac=9 and rok=2020 then 1  else 0 end as wrzesien20,
                case when miesiac=10 and rok=2020 then 1  else 0 end as pazdziernik20,
                case when miesiac=11 and rok=2020 then 1  else 0 end as listopad20,
                case when miesiac=12 and rok=2020 then 1  else 0 end as grudzien20,
                case when miesiac=1 and rok=2021 then 1  else 0 end as styczen21,
                case when miesiac=2 and rok=2021 then 1  else 0 end as luty21,
                case when miesiac=3 and rok=2021 then 1  else 0 end as marzec21,
                case when miesiac=4 and rok=2021 then 1  else 0 end as kwiecien21,
                case when miesiac=5 and rok=2021 then 1  else 0 end as maj21,
                case when miesiac=6 and rok=2021 then 1  else 0 end as czerwiec21,
                case when miesiac=7 and rok=2021 then 1  else 0 end as lipiec21,
                case when miesiac=8 and rok=2021 then 1  else 0 end as sierpien21
          from umowy_pln where id_klienta in (select id_klienta from klienci)) 
    group by id_klienta) t2 on (k.id_klienta = t2.id_klienta)
    where k.status = 'Active';
END;
    
CREATE PROCEDURE laduj_saldo_klienta IS
BEGIN
INSERT INTO SALDO_KLIENTA
WITH suma_odestek as (
SELECT  o.id_klienta,
        SUM(o.KWOTA_ODSETEK) as KWOTA_ODSETEK
FROM ODSETKI o
GROUP BY o.ID_KLIENTA
)
SELECT  k.id_klienta,
        k.nazwa_firmy,
        k.data_zalozenia,
        k.wojewodzctwo,
        k.miasto,
        k.adres,
        NVL(o.kwota_odsetek,0) as KWOTA_ODSETEK,
        NVL(s.SUMA_WPLAT_PLN,0) as SUMA_WPLAT_PLN,
        NVL(s.SUMA_WPLAT_PLN,0) - NVL(o.kwota_odsetek,0) AS SALDO_KLIENTA
FROM klienci k
LEFT JOIN suma_odestek o ON k.id_klienta = o.id_klienta
LEFT JOIN suma_wplat s ON k.id_klienta = s.id_klienta
WHERE k.status = 'Active';
END;

CREATE OR REPLACE PROCEDURE czysc_tabele is 
BEGIN
execute immediate 'TRUNCATE TABLE ODSETKI';
execute immediate 'TRUNCATE TABLE SALDO_KLIENTA';
execute immediate 'TRUNCATE TABLE SUMA_WPLAT';
execute immediate 'TRUNCATE TABLE UMOWY_PLN';
execute immediate 'TRUNCATE TABLE WPLATY_PLN';
execute immediate 'TRUNCATE TABLE ZALEGLE_UMOWY';
END;

BEGIN
--laduj_umowy_pln
loguj_start('laduj_umowy_pln');
laduj_umowy_pln();
loguj_stop('laduj_umowy_pln');
--laduj_wplaty_pln
loguj_start('laduj_wplaty_pln');
laduj_wplaty_pln();
loguj_stop('laduj_wplaty_pln');
--laduj_suma_wplat_pln
loguj_start('laduj_suma_wplat_pln');
laduj_suma_wplat_pln();
loguj_stop('laduj_suma_wplat_pln');
--laduj_rozliczenie_wplat
loguj_start('laduj_rozliczenie_wplat');
laduj_rozliczenie_wplat();
loguj_stop('laduj_rozliczenie_wplat');
--laduj_odsetki
loguj_start('laduj_odsetki');
laduj_odsetki();
loguj_stop('laduj_odsetki');
--laduj_zalegle_umowy
loguj_start('laduj_zalegle_umowy');
laduj_zalegle_umowy();
loguj_stop('laduj_zalegle_umowy');
--laduj_saldo_klienta
loguj_start('laduj_saldo_klienta');
laduj_saldo_klienta();
loguj_stop('laduj_saldo_klienta');
END;

BEGIN
czysc_tabele();
END;

--select data_danych, kod 
--from kursy_walut 
--group by data_danych, kod
--having count(data_danych) > 2;