CREATE DATABASE LINK dblinkFilia 
CONNECT TO RBD1_ST20 IDENTIFIED BY start123 
USING 'baza11b';

CREATE OR REPLACE SYNONYM kursanciFilia FOR kursanci@dblinkFilia;
CREATE OR REPLACE SYNONYM wykladowcyFilia FOR wykladowcy@dblinkFilia;
CREATE OR REPLACE SYNONYM rodzajeFilia FOR rodzaje@dblinkFilia;
CREATE OR REPLACE SYNONYM kursyFilia FOR kursy@dblinkFilia;
