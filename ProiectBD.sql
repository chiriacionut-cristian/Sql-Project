CREATE TABLE JUCATOR (
    jucator_id NUMBER(4) PRIMARY KEY,
    nume VARCHAR2(40),
    prenume VARCHAR2(40),
    data_nasterii DATE,
    nationalitate VARCHAR2(30),
    pozitie VARCHAR2(40),
    inaltime NUMBER(3),
    greutate NUMBER(3)
);
CREATE TABLE STADION (
    stadion_id NUMBER(4) PRIMARY KEY,
    nume_stadion VARCHAR2(40),
    capacitate NUMBER(6)
);
CREATE TABLE ECHIPA (
    echipa_id NUMBER(4) PRIMARY KEY,
    nume VARCHAR2(40),
    tara VARCHAR2(40),
    liga VARCHAR2(40),
    stadion_id NUMBER(4),
    CONSTRAINT FK_ECHIPA_STADION FOREIGN KEY (stadion_id) REFERENCES STADION(stadion_id)
);
CREATE TABLE CONTRACT (
    contract_id NUMBER(4) PRIMARY KEY,
    jucator_id NUMBER (4),
    echipa_id NUMBER (4),
    data_inceput DATE,
    data_sfarsit DATE,
    salariu NUMBER(7),
    CONSTRAINT FK_CONTRACT_JUCATOR FOREIGN KEY (jucator_id) REFERENCES JUCATOR(jucator_id),
    CONSTRAINT FK_CONTRACT_ECHIPA FOREIGN KEY (echipa_id) REFERENCES ECHIPA(echipa_id),
    CONSTRAINT UQ_JUCATOR_CONTRACT UNIQUE (jucator_id)
);
CREATE TABLE MECI (
    meci_id NUMBER(4) PRIMARY KEY,
    echipa_id NUMBER (4),
    adversara varchar2(40),
    data_meci DATE,
    competitie VARCHAR2(40),
    CONSTRAINT FK_MECI_ECHIPA FOREIGN KEY (echipa_id) REFERENCES ECHIPA(echipa_id)
);
CREATE TABLE STATISTICI_MECI (
    statistici_id NUMBER(4) PRIMARY KEY,
    jucator_id NUMBER(4),
    meci_id NUMBER(4),
    minute_jucate NUMBER(3),
    goluri NUMBER(2),
    assisturi NUMBER(2),
    cartonase_galbene NUMBER(2),
    cartonase_rosii NUMBER(2),
    CONSTRAINT FK_STATISTICI_JUCATOR FOREIGN KEY (jucator_id) REFERENCES JUCATOR(jucator_id),
    CONSTRAINT FK_STATISTICI_MECI FOREIGN KEY (meci_id) REFERENCES MECI(meci_id)
);
CREATE TABLE TROFEE_INDIVIDUALE (
    trofeu_individual_id NUMBER(4) PRIMARY KEY,
    jucator_id NUMBER(4),
    nume_trofeu VARCHAR2(40),
    an NUMBER(4),
    competitie VARCHAR2(40),
    categorie VARCHAR2(40),
    CONSTRAINT FK_TROFEE FOREIGN KEY (jucator_id) REFERENCES JUCATOR(jucator_id)
);
CREATE TABLE ACCIDENTARI (
    accidentare_id NUMBER(4) PRIMARY KEY,
    jucator_id NUMBER(4),
    data_inceput DATE,
    data_sfarsit DATE,
    tip_accidentare VARCHAR2(30),
    CONSTRAINT FK_ACCIDENTARI FOREIGN KEY (jucator_id) REFERENCES JUCATOR(jucator_id)
);
CREATE TABLE STATISTICI_SEZON (
    statistici_sezon_id NUMBER(4) PRIMARY KEY,
    jucator_id NUMBER(4),
    sezon_an NUMBER(4),
    meciuri_jucate NUMBER(3),
    goluri_total NUMBER(3),
    assist_total NUMBER(3),
    minute_total NUMBER(5),
    CONSTRAINT FK_STATISTICI_SEZON FOREIGN KEY (jucator_id) REFERENCES JUCATOR(jucator_id),
    CONSTRAINT UQ_JUCATOR_SEZON UNIQUE (jucator_id, sezon_an) 
);
CREATE TABLE TRANSFER (
    transfer_id NUMBER(4) PRIMARY KEY,
    jucator_id NUMBER(4),
    echipa_fosta varchar2(30),
    echipa_actuala varchar2(30),
    data_transfer DATE,
    suma_transfer NUMBER(7),
    CONSTRAINT FK_TRANSFER_JUCATOR FOREIGN KEY (jucator_id) REFERENCES JUCATOR(jucator_id)
);

ALTER TABLE JUCATOR ADD CONSTRAINT chk_jucator_id_nn CHECK (jucator_id IS NOT NULL);
ALTER TABLE JUCATOR ADD CONSTRAINT chk_nume_nn CHECK (nume IS NOT NULL);
ALTER TABLE JUCATOR ADD CONSTRAINT chk_prenume_nn CHECK (prenume IS NOT NULL);
ALTER TABLE JUCATOR ADD CONSTRAINT chk_data_nasterii_nn CHECK (data_nasterii IS NOT NULL);
ALTER TABLE JUCATOR ADD CONSTRAINT chk_nationalitate_nn CHECK (nationalitate IS NOT NULL);
ALTER TABLE JUCATOR ADD CONSTRAINT chk_pozitie_nn CHECK (pozitie IS NOT NULL);
ALTER TABLE JUCATOR ADD CONSTRAINT chk_inaltime_nn CHECK (inaltime IS NOT NULL);
ALTER TABLE JUCATOR ADD CONSTRAINT chk_greutate_nn CHECK (greutate IS NOT NULL);

ALTER TABLE MECI ADD (comentator VARCHAR2(100) NOT NULL);

ALTER TABLE MECI DROP COLUMN comentator;

ALTER TABLE JUCATOR ADD CONSTRAINT ck_greutate CHECK (greutate BETWEEN 60 AND 120);
ALTER TABLE JUCATOR ADD CONSTRAINT ck_inaltime CHECK (inaltime BETWEEN 150 AND 230);

CREATE TABLE TABELA_ISTORIC_CONTRACTE (
    contract_id NUMBER(4) PRIMARY KEY,
    jucator_id NUMBER(4)NOT NULL,
    echipa_id NUMBER(4)NOT NULL,
    data_inceput DATE NOT NULL,
    data_sfarsit DATE NOT NULL,
    salariu NUMBER(7) NOT NULL,
    data_modificarii DATE DEFAULT SYSDATE,
    CONSTRAINT FK_ISTORIC_JUCATOR FOREIGN KEY (jucator_id) REFERENCES JUCATOR(jucator_id),
    CONSTRAINT FK_ISTORIC_ECHIPA FOREIGN KEY (echipa_id) REFERENCES ECHIPA(echipa_id)
);

DROP TABLE TABELA_ISTORIC_CONTRACTE;

--Inserare tabela JUCATOR
INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (1, 'Cristiano', 'Ronaldo', TO_DATE('1985-02-05', 'YYYY-MM-DD'), 'Portugalia', 'Atacant', 187, 83);

INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (2, 'Lionel', 'Messi', TO_DATE('1987-06-24', 'YYYY-MM-DD'), 'Argentina', 'Atacant', 170, 72);

INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (3, 'Neymar', 'Jr.', TO_DATE('1992-02-05', 'YYYY-MM-DD'), 'Brazilia', 'Atacant', 175, 68);

INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (4, 'Kylian', 'Mbappe', TO_DATE('1998-12-20', 'YYYY-MM-DD'), 'Franța', 'Atacant', 178, 73);

INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (5, 'Kevin', 'De Bruyne', TO_DATE('1991-06-28', 'YYYY-MM-DD'), 'Belgia', 'Mijlocaș', 181, 70);

INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (6, 'Mohamed', 'Salah', TO_DATE('1992-06-15', 'YYYY-MM-DD'), 'Egipt', 'Atacant', 175, 71);

INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (7, 'Robert', 'Lewandowski', TO_DATE('1988-08-21', 'YYYY-MM-DD'), 'Polonia', 'Atacant', 184, 79);

INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (8, 'Sergio', 'Ramos', TO_DATE('1986-03-30', 'YYYY-MM-DD'), 'Spania', 'Fundaș', 183, 82);

INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (9, 'Virgil', 'Van Dijk', TO_DATE('1991-07-08', 'YYYY-MM-DD'), 'Olanda', 'Fundaș', 193, 92);

INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (10, 'Eden', 'Hazard', TO_DATE('1991-01-07', 'YYYY-MM-DD'), 'Belgia', 'Mijlocaș', 175, 74);

INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (11, 'Luka', 'Modric', TO_DATE('1985-09-09', 'YYYY-MM-DD'), 'Croația', 'Mijlocaș', 172, 66);

INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (12, 'Karim', 'Benzema', TO_DATE('1987-12-19', 'YYYY-MM-DD'), 'Franța', 'Atacant', 185, 80);

--Inserare tabela ECHIPA
INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (1, 'Real Madrid', 'Spania', 'La Liga', 1);

INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (2, 'Barcelona', 'Spania', 'La Liga', 2);

INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (3, 'Paris Saint-Germain', 'Franța', 'Ligue 1', 3);

INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (4, 'Bayern Munchen', 'Germania', 'Bundesliga', 4);

INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (5, 'Liverpool', 'Anglia', 'Premier League', 5);

INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (6, 'Manchester City', 'Anglia', 'Premier League', 6);

INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (7, 'Juventus', 'Italia', 'Serie A', 7);

INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (8, 'Chelsea', 'Anglia', 'Premier League', 8);

INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (9, 'Inter Milan', 'Italia', 'Serie A', 9);

INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (10, 'Manchester United', 'Anglia', 'Premier League', 10);

INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (11, 'Tottenham Hotspur', 'Anglia', 'Premier League', 11);

INSERT INTO ECHIPA (echipa_id, nume, tara, liga, stadion_id) 
VALUES (12, 'Arsenal', 'Anglia', 'Premier League', 12);

--Inserare tabela STADION
INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (1, 'Santiago Bernabeu', 81044);

INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (2, 'Camp Nou', 99354);

INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (3, 'Parc des Princes', 48700);

INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (4, 'Allianz Arena', 75000);

INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (5, 'Anfield', 54074);

INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (6, 'Etihad Stadium', 55000);

INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (7, 'Allianz Stadium', 41350);

INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (8, 'Stamford Bridge', 40834);

INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (9, 'San Siro', 80000);

INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (10, 'Old Trafford', 74879);

INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (11, 'Tottenham Hotspur Stadium', 62062);

INSERT INTO STADION (stadion_id, nume_stadion, capacitate) 
VALUES (12, 'Emirates Stadium', 60361);

--Inserare tabela CONTRACT
INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (1, 1, 1, TO_DATE('2021-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-01', 'YYYY-MM-DD'), 500000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (2, 2, 2, TO_DATE('2020-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-01', 'YYYY-MM-DD'), 400000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (3, 3, 3, TO_DATE('2022-01-15', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'), 350000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (4, 4, 3, TO_DATE('2021-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-01', 'YYYY-MM-DD'), 300000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (5, 5, 6, TO_DATE('2020-05-01', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'), 450000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (6, 6, 5, TO_DATE('2022-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), 600000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (7, 7, 4, TO_DATE('2021-09-01', 'YYYY-MM-DD'), TO_DATE('2024-09-01', 'YYYY-MM-DD'), 380000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (8, 8, 1, TO_DATE('2020-04-01', 'YYYY-MM-DD'), TO_DATE('2023-04-01', 'YYYY-MM-DD'), 420000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (9, 9, 5, TO_DATE('2022-11-01', 'YYYY-MM-DD'), TO_DATE('2025-11-01', 'YYYY-MM-DD'), 470000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (10, 10, 8, TO_DATE('2021-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-01', 'YYYY-MM-DD'), 390000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (11, 11, 1, TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2025-03-01', 'YYYY-MM-DD'), 550000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (12, 12, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2026-01-01', 'YYYY-MM-DD'), 620000);

INSERT INTO CONTRACT (contract_id, jucator_id, echipa_id, data_inceput, data_sfarsit, salariu)
VALUES (13, 13, 1, TO_DATE('2023-01-02', 'YYYY-MM-DD'), TO_DATE('2026-05-08', 'YYYY-MM-DD'), 350000);

--Inserare tabela TROFEE_INDIVIDUALE
INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (1, 1, 'Balonul de Aur', 2023, 'FIFA', 'Cel mai bun jucator');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (2, 2, 'Balonul de Aur', 2022, 'FIFA', 'Cel mai bun jucator');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (3, 3, 'Jucatorul UEFA al Anului', 2023, 'Champions League', 'Cel mai bun jucator');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (4, 4, 'Balonul de Aur', 2021, 'FIFA', 'Cel mai bun jucator');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (5, 5, 'Jucatorul UEFA al Anului', 2020, 'Europa League', 'Cel mai bun mijlocas');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (6, 6, 'Marcatorul competitiei', 2022, 'Conference League', 'Cel mai bun atacant');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (7, 7, 'Golden Boot', 2023, 'Premier League', 'Cel mai bun marcator');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (8, 8, 'Balonul de Aur', 2020, 'FIFA', 'Cel mai bun fundas');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (9, 9, 'Cel mai bun fundas', 2023, 'FIFA', 'Cel mai bun fundas');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (10, 10, 'Jucatorul Uefa al Anului', 2021, 'UEFA', 'Cel mai bun mijlocas');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (11, 11, 'Balonul de Aur', 2018, 'FIFA', 'Cel mai bun jucator');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (12, 12, 'Jucatorul Anului', 2021, 'FIFA', 'Cel mai bun atacant');

INSERT INTO TROFEE_INDIVIDUALE (trofeu_individual_id, jucator_id, nume_trofeu, an, competitie, categorie) 
VALUES (13, 13, 'Jucatorul Anului', 2024, 'FIFA', 'Cel mai bun jucator');

--Inserare tabela MECI
INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (1, 1, 'Barcelona', TO_DATE('2024-09-15', 'YYYY-MM-DD'), 'UEFA Champions League');

INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (2, 2, 'Cadiz', TO_DATE('2024-09-17', 'YYYY-MM-DD'), 'La Liga');

INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (3, 3, 'Lyon', TO_DATE('2024-09-20', 'YYYY-MM-DD'), 'Ligue 1');

INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (4, 4, 'Stuttgard', TO_DATE('2024-09-22', 'YYYY-MM-DD'), 'Bundesliga');

INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (5, 5, 'Juventus', TO_DATE('2024-09-25', 'YYYY-MM-DD'), 'Champions League');

INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (6, 6, 'Manchester United', TO_DATE('2024-09-28', 'YYYY-MM-DD'), 'Premier League');

INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (7, 7, 'Ac Milan', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'Serie A');

INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (8, 8, 'West Ham', TO_DATE('2024-10-03', 'YYYY-MM-DD'), 'Premier League');

INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (9, 9, 'AC Milan', TO_DATE('2024-10-05', 'YYYY-MM-DD'), 'Serie A');

INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (10, 10, 'Arsenal', TO_DATE('2024-10-08', 'YYYY-MM-DD'), 'Premier League');

INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (11, 11, 'Leicester', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'Premier League');

INSERT INTO MECI (meci_id, echipa_id, adversara, data_meci, competitie)
VALUES (12, 12, 'Chelsea', TO_DATE('2024-10-12', 'YYYY-MM-DD'), 'FA Cup');

--Inserare tabela STATISTICI_MECI
INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (1, 1, 1, 90, 2, 1, 0, 0);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (2, 2, 2, 90, 1, 0, 1, 0);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (3, 3, 3, 85, 1, 1, 0, 0);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (4, 4, 3, 90, 1, 2, 0, 0);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (5, 5, 6, 88, 0, 1, 1, 0);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (6, 6, 5, 90, 2, 0, 0, 0);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (7, 7, 7, 90, 1, 1, 0, 0);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (8, 8, 1, 85, 0, 0, 2, 0);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (9, 9, 5, 90, 1, 0, 1, 0);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (10, 10, 8, 89, 0, 2, 0, 0);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (11, 11, 1, 90, 0, 0, 0, 1);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (12, 12, 1, 90, 0, 1, 1, 0);

INSERT INTO STATISTICI_MECI (statistici_id, jucator_id, meci_id, minute_jucate, goluri, assisturi, cartonase_galbene, cartonase_rosii) 
VALUES (13, 13, 4, 60, 0, 1, 1, 0);
--Inserare tabela ACCIDENTARI
INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (1, 1, TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'Fractură genunchi');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (2, 2, TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-05-20', 'YYYY-MM-DD'), 'Leziune la mușchi');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (3, 3, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-07-10', 'YYYY-MM-DD'), 'Accidentare la glezna');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (4, 4, TO_DATE('2023-06-10', 'YYYY-MM-DD'), TO_DATE('2023-06-25', 'YYYY-MM-DD'), 'Leziune musculara');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (5, 5, TO_DATE('2023-04-15', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'Fractura de picior');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (6, 6, TO_DATE('2023-05-20', 'YYYY-MM-DD'), TO_DATE('2023-06-05', 'YYYY-MM-DD'), 'Accidentare la genunchi');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (7, 7, TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-10', 'YYYY-MM-DD'), 'Accidentare la sold');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (8, 8, TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-04-15', 'YYYY-MM-DD'), 'Entorsa');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (9, 9, TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 'Leziune musculara');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (10, 10, TO_DATE('2023-09-10', 'YYYY-MM-DD'), TO_DATE('2023-09-20', 'YYYY-MM-DD'), 'Fractura de clavicula');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (11, 11, TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'), 'Leziune la ligamente');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (12, 12, TO_DATE('2023-07-05', 'YYYY-MM-DD'), TO_DATE('2023-07-20', 'YYYY-MM-DD'), 'Leziune la genunchi');

INSERT INTO ACCIDENTARI (accidentare_id, jucator_id, data_inceput, data_sfarsit, tip_accidentare) 
VALUES (13, 13, TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-05-20', 'YYYY-MM-DD'), 'Leziune craniana');

--Inserare tabela TRANSFER
INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (1, 1, 'Real Madrid', 'Juventus', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 8000000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (2, 2, 'Juventus', 'Manchester United', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 6000000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (3, 3, 'Bayern Munchen', 'Paris Saint-Germain', TO_DATE('2023-08-10', 'YYYY-MM-DD'), 7500000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (4, 4, 'Chelsea', 'Manchester City', TO_DATE('2023-07-15', 'YYYY-MM-DD'), 8500000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (5, 5, 'AC Milan', 'Juventus', TO_DATE('2023-08-05', 'YYYY-MM-DD'), 7000000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (6, 6, 'Liverpool', 'FC Barcelona', TO_DATE('2023-06-20', 'YYYY-MM-DD'), 6500000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (7, 7, 'Bayer Leverkusen', 'Arsenal', TO_DATE('2023-07-25', 'YYYY-MM-DD'), 5500000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (8, 8, 'Paris Saint-Germain', 'Chelsea', TO_DATE('2023-09-01', 'YYYY-MM-DD'), 6800000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (9, 9, 'Real Madrid', 'AC Milan', TO_DATE('2023-06-30', 'YYYY-MM-DD'), 7500000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (10, 10, 'Tottenham', 'Manchester United', TO_DATE('2023-08-15', 'YYYY-MM-DD'), 7200000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (11, 11, 'Atletico Madrid', 'Bayern Munchen', TO_DATE('2023-09-05', 'YYYY-MM-DD'), 8500000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (12, 12, 'FC Barcelona', 'Paris Saint-Germain', TO_DATE('2023-07-10', 'YYYY-MM-DD'), 7000000);

INSERT INTO TRANSFER (transfer_id, jucator_id, echipa_fosta, echipa_actuala, data_transfer, suma_transfer)
VALUES (13, 13, 'FC Barcelona', 'FCSB', TO_DATE('2023-07-10', 'YYYY-MM-DD'), 2000000);

--Inserare tabela STATISTICI_SEZON
INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (1, 1, 2023, 38, 30, 12, 3420);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (2, 2, 2023, 36, 25, 15, 3240);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (3, 3, 2023, 34, 28, 10, 3060);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (4, 4, 2023, 37, 12, 20, 3330);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (5, 5, 2023, 38, 20, 18, 3420);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (6, 6, 2023, 35, 22, 14, 3150);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (7, 7, 2022, 34, 25, 8, 3000);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (8, 8, 2022, 36, 18, 22, 3240);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (9, 9, 2022, 33, 26, 9, 2970);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (10, 10, 2022, 38, 10, 30, 3420);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (11, 11, 2022, 35, 24, 12, 3150);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (12, 12, 2022, 37, 15, 25, 3330);

INSERT INTO STATISTICI_SEZON (statistici_sezon_id, jucator_id, sezon_an, meciuri_jucate, goluri_total, assist_total, minute_total)
VALUES (13, 13, 2022, 9, 3, 2, 3000);
--Inserare date student in tabela
INSERT INTO JUCATOR (jucator_id, nume, prenume, data_nasterii, nationalitate, pozitie, inaltime, greutate) 
VALUES (13, 'Chiriac', 'Ionut-Cristian', TO_DATE('2005-05-01', 'YYYY-MM-DD'), 'Romania', 'Portar', 188, 86);

ALTER TABLE JUCATOR RENAME COLUMN nume TO nume_temp;
ALTER TABLE JUCATOR RENAME COLUMN prenume TO nume;
ALTER TABLE JUCATOR RENAME COLUMN nume_temp TO prenume;

DROP TABLE MECI CASCADE CONSTRAINTS;
FLASHBACK TABLE MECI TO BEFORE DROP;

UPDATE STATISTICI_SEZON
SET meciuri_jucate = meciuri_jucate + 3, assist_total = assist_total + 4
WHERE jucator_id = (
    SELECT jucator_id
    FROM JUCATOR
    WHERE nume = 'Modric' AND prenume = 'Luka'
)
AND sezon_an = 2022;
--
SELECT 
    JUCATOR.nume,
    JUCATOR.prenume,
    STATISTICI_SEZON.sezon_an,
    STATISTICI_SEZON.meciuri_jucate,
    STATISTICI_SEZON.goluri_total,
    STATISTICI_SEZON.assist_total,
    STATISTICI_SEZON.minute_total
FROM 
    STATISTICI_SEZON
JOIN 
    JUCATOR
ON 
    STATISTICI_SEZON.jucator_id = JUCATOR.jucator_id;
--

SELECT 
    J.nume AS nume_jucator,
    J.prenume AS prenume_jucator,
    E.nume AS nume_echipa,
    SS.meciuri_jucate,
    SS.goluri_total,
    SS.assist_total,
    SS.minute_total
FROM 
    STATISTICI_SEZON SS
JOIN 
    JUCATOR J ON SS.jucator_id = J.jucator_id
JOIN 
    ECHIPA E ON SS.jucator_id = E.echipa_id
WHERE 
    SS.jucator_id IN (
        SELECT jucator_id 
        FROM TRANSFER 
        WHERE data_transfer BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') 
                                 AND TO_DATE('2023-12-30', 'YYYY-MM-DD')
    )
AND SS.sezon_an = 2023
AND SS.goluri_total < 30;
--
SELECT 
    J.nume AS nume_jucator,
    J.prenume AS prenume_jucator,
    TI.nume_trofeu,
    SS.goluri_total
FROM 
    TROFEE_INDIVIDUALE TI
JOIN 
    JUCATOR J ON TI.jucator_id = J.jucator_id
JOIN 
    STATISTICI_SEZON SS ON J.jucator_id = SS.jucator_id
WHERE 
    SS.sezon_an = 2022
AND 
    SS.goluri_total < 25;
--
DELETE FROM TROFEE_INDIVIDUALE
WHERE jucator_id IN (
    SELECT jucator_id
    FROM STATISTICI_SEZON
    WHERE sezon_an = 2022
    AND goluri_total < 25
);

SELECT 
    e.nume AS echipa,
    COUNT(c.jucator_id) AS numar_jucatori,
    AVG(c.salariu) AS salariu_mediu,
    MAX(c.salariu) AS salariu_maxim,
    MIN(c.salariu) AS salariu_minim
FROM 
    ECHIPA e
JOIN 
    CONTRACT c ON e.echipa_id = c.echipa_id
GROUP BY 
    e.echipa_id, e.nume
ORDER BY 
    e.nume;
-- 
SELECT e.nume AS echipa, COUNT(c.contract_id) AS numar_contracte,
       s.nume_stadion AS stadion, e.liga, e.tara
FROM ECHIPA e
JOIN CONTRACT c ON e.echipa_id = c.echipa_id
JOIN STADION s ON e.stadion_id = s.stadion_id
GROUP BY e.nume, s.nume_stadion, e.liga, e.tara
HAVING COUNT(c.contract_id) >= 2
ORDER BY e.nume;
--
SELECT jucator_id, nume, prenume, data_nasterii,
       TRUNC(MONTHS_BETWEEN(SYSDATE, data_nasterii) / 12) AS varsta
FROM JUCATOR;
--
SELECT S.sezon_an AS an_sezon,
       SUM(S.goluri_total) AS goluri_totale,
       COUNT(DISTINCT S.jucator_id) AS numar_jucatori
FROM STATISTICI_SEZON S
GROUP BY S.sezon_an
HAVING SUM(S.goluri_total) > 30;
--
SELECT E.nume AS echipa,
       CASE 
           WHEN SYSDATE > C.data_sfarsit THEN 'Expirate' 
           ELSE 'Valabile' 
       END AS status_contract,
COUNT(C.contract_id) AS numar_contracte
FROM ECHIPA E
JOIN CONTRACT C ON E.echipa_id = C.echipa_id
GROUP BY E.nume, 
         CASE 
             WHEN SYSDATE > C.data_sfarsit THEN 'Expirate' 
             ELSE 'Valabile' 
         END;
--
SELECT E.nume AS echipa,
       COUNT(CASE WHEN S.goluri > 0 THEN 1 END) AS jucatori_cu_goluri,
       COUNT(CASE WHEN S.goluri = 0 THEN 1 END) AS jucatori_fara_goluri
FROM ECHIPA E
JOIN MECI M ON E.echipa_id = M.echipa_id
JOIN STATISTICI_MECI S ON M.meci_id = S.meci_id
GROUP BY E.nume;
--
SELECT 
    J.nume AS nume_jucator,
    J.prenume AS prenume_jucator,
    C.salariu AS salariu,
    E.nume AS echipa,
    CASE 
        WHEN C.salariu < 400000 THEN 'mic'
        WHEN C.salariu BETWEEN 400000 AND 550000 THEN 'mediu'
        ELSE 'mare'
    END AS categorie_salariu
FROM JUCATOR J
JOIN CONTRACT C ON J.jucator_id = C.jucator_id
JOIN ECHIPA E ON C.echipa_id = E.echipa_id
ORDER BY J.nume DESC;
--
SELECT 
    J.nume AS nume_jucator,
    J.prenume AS prenume_jucator,
    A.data_inceput AS data_inceput_accident,
    A.data_sfarsit AS data_sfarsit_accident,
    A.tip_accidentare AS tip_accidentare,
    ROUND(A.data_sfarsit - A.data_inceput) AS durata_accidentare,
    CASE 
        WHEN (A.data_sfarsit - A.data_inceput) > 30 THEN 'Gravă'
        ELSE 'Ușoară'
    END AS clasificare_accidentare
FROM ACCIDENTARI A
JOIN JUCATOR J ON A.jucator_id = J.jucator_id;
--
UPDATE TRANSFER
SET echipa_fosta = NULL
WHERE transfer_id IN (3, 6, 12);

UPDATE TRANSFER
SET echipa_actuala = NULL
WHERE transfer_id IN (2, 5, 8);

SELECT 
    T.jucator_id,
    J.nume AS nume_jucator,
    J.prenume AS prenume_jucator,
    NVL(T.echipa_fosta, 'Fosta echipă necunoscută') AS echipa_fosta, 
    NVL(T.echipa_actuala, 'Echipă necunoscută') AS echipa_actuala,
    TO_CHAR(T.data_transfer, 'YYYY-MM-DD') AS data_transfer,
    NVL(T.suma_transfer, 0) AS suma_transfer,  -- Înlocuim NULL cu valoarea 0
    CASE
        WHEN NVL(T.suma_transfer, 0) > 7000000 THEN 'Transfer mare'
        ELSE 'Transfer mic'
    END AS tip_transfer
FROM TRANSFER T
JOIN JUCATOR J ON T.jucator_id = J.jucator_id;
--
SELECT 
    J.nume AS nume_jucator, 
    J.prenume AS prenume_jucator,
    TO_CHAR(J.data_nasterii, 'DD-MON-YYYY') AS data_nasterii_formata,
    TRUNC(MONTHS_BETWEEN(SYSDATE, J.data_nasterii) / 12) AS varsta,
    E.nume AS nume_echipa
FROM JUCATOR J
JOIN CONTRACT C ON J.jucator_id = C.jucator_id
JOIN ECHIPA E ON C.echipa_id = E.echipa_id
WHERE E.liga = 'La Liga'
AND TRUNC(MONTHS_BETWEEN(SYSDATE, J.data_nasterii) / 12) > 30
ORDER BY varsta;
--
SELECT 
    E.nume AS nume_echipa,
    TO_DATE('01-JUL-2020', 'DD-MON-YYYY') AS data_inceput_contract,
    COUNT(C.contract_id) AS numar_contracte
FROM ECHIPA E
JOIN CONTRACT C ON E.echipa_id = C.echipa_id
WHERE C.data_inceput > TO_DATE('01-JUL-2020', 'DD-MON-YYYY')
GROUP BY E.nume
HAVING COUNT(C.contract_id) >= 2
ORDER BY numar_contracte DESC;
--
SELECT 
    J.nume AS nume_jucator, 
    J.prenume AS prenume_jucator,
    TO_CHAR(J.data_nasterii, 'DD-MON-YYYY') AS data_nasterii_formata
FROM JUCATOR J
WHERE EXTRACT(YEAR FROM J.data_nasterii) BETWEEN 1987 AND 1990
ORDER BY J.nume DESC;
--
SELECT 
    J.nume AS nume_jucator, 
    J.prenume AS prenume_jucator,
    SS.sezon_an,
    SS.goluri_total
FROM JUCATOR J
JOIN STATISTICI_SEZON SS ON J.jucator_id = SS.jucator_id
WHERE (SS.sezon_an = 2022 AND SS.goluri_total > 10)
UNION
SELECT 
    J.nume AS nume_jucator, 
    J.prenume AS prenume_jucator,
    SS.sezon_an,
    SS.goluri_total
FROM JUCATOR J
JOIN STATISTICI_SEZON SS ON J.jucator_id = SS.jucator_id
WHERE (SS.sezon_an = 2023 AND SS.goluri_total > 5);
--
SELECT E.nume AS nume_echipa
FROM ECHIPA E
MINUS
SELECT E.nume AS nume_echipa
FROM ECHIPA E
JOIN CONTRACT C ON E.echipa_id = C.echipa_id;
--
SELECT 
    J.nume AS nume_jucator, 
    J.prenume AS prenume_jucator
FROM JUCATOR J
JOIN STATISTICI_SEZON SS ON J.jucator_id = SS.jucator_id
WHERE SS.minute_total < (
        SELECT AVG(minute_total) 
        FROM STATISTICI_SEZON);
-- 
CREATE SYNONYM ECHIPA_SINONIM FOR ECHIPA;
SELECT * FROM ECHIPA_SINONIM;
--
CREATE INDEX idx_jucator_nume_prenume ON JUCATOR (nume, prenume);
SELECT * 
FROM JUCATOR
WHERE nume = 'Ronaldo' AND prenume = 'Cristiano';



















