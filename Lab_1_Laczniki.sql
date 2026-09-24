 -- Zadanie 3 tworzynie link do baza11b
CREATE DATABASE LINK dblinkFilia
  CONNECT TO RBD1_ST20
  IDENTIFIED BY start123
  USING 'baza11b';
 
 
-- Zadanie 4
SELECT * FROM kursanci@dblinkFilia;
 
 
-- Zadanie 5
CREATE OR REPLACE SYNONYM kursanciSiedziba   FOR kursanci;
CREATE OR REPLACE SYNONYM kursySiedziba      FOR kursy;
CREATE OR REPLACE SYNONYM rodzajeSiedziba    FOR rodzaje;
CREATE OR REPLACE SYNONYM wykladowcySiedziba FOR wykladowcy;
 
CREATE OR REPLACE SYNONYM kursanciFilia      FOR kursanci@dblinkFilia;
CREATE OR REPLACE SYNONYM kursyFilia         FOR kursy@dblinkFilia;
CREATE OR REPLACE SYNONYM rodzajeFilia       FOR rodzaje@dblinkFilia;
CREATE OR REPLACE SYNONYM wykladowcyFilia    FOR wykladowcy@dblinkFilia;
 
 
-- Zadanie 6
CREATE OR REPLACE VIEW kursanciAll AS
SELECT imie, nazwisko FROM kursanciSiedziba
UNION
SELECT imie, nazwisko FROM kursanciFilia;
 
CREATE OR REPLACE VIEW wykladowcyAll AS
SELECT imie, nazwisko FROM wykladowcySiedziba
UNION
SELECT imie, nazwisko FROM wykladowcyFilia;
 
 
-- Zadanie 7

CREATE OR REPLACE VIEW kursyAll AS
SELECT k.kurs_id, r.nazwa AS nazwa_kursu, w.imie, w.nazwisko,
       COUNT(u.kursant_id) AS ilosc_uczestnikow,
       r.cena, r.godz, w.stawka
FROM kursySiedziba k
JOIN rodzajeSiedziba r    ON r.rodzaj_id = k.rodzaj_id
JOIN wykladowcySiedziba w ON w.wykladowca_id = k.wykladowca_id
LEFT JOIN umowy u         ON u.kurs_id = k.kurs_id
GROUP BY k.kurs_id, r.nazwa, w.imie, w.nazwisko, r.cena, r.godz, w.stawka
UNION ALL
SELECT k.kurs_id, r.nazwa, w.imie, w.nazwisko,
       COUNT(u.kursant_id),
       r.cena, r.godz, w.stawka
FROM kursyFilia k
JOIN rodzajeFilia r    ON r.rodzaj_id = k.rodzaj_id
JOIN wykladowcyFilia w ON w.wykladowca_id = k.wykladowca_id
LEFT JOIN umowy u      ON u.kurs_id = k.kurs_id
GROUP BY k.kurs_id, r.nazwa, w.imie, w.nazwisko, r.cena, r.godz, w.stawka;
 
SELECT * FROM kursyAll;
 
 
-- Zadanie 8

SELECT SUM(ilosc_uczestnikow * cena) AS przychod
FROM kursyAll;
 
 
-- Zadanie 9

SELECT SUM(godz * stawka) AS koszty
FROM kursyAll;
 
 
-- Zadanie 10
SELECT kurs_id, nazwa_kursu,
       ilosc_uczestnikow * cena - godz * stawka AS zysk
FROM kursyAll
ORDER BY kurs_id;
 
 
-- Zadanie 11
SELECT SUM(ilosc_uczestnikow * cena - godz * stawka) AS laczny_zysk
FROM kursyAll;
 
