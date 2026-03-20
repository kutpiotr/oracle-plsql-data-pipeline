# Oracle PL/SQL Data Pipeline

##  Cel projektu

Projekt przedstawia implementację prostego pipeline'u ETL w bazie danych Oracle z wykorzystaniem PL/SQL.

Celem projektu jest przetwarzanie surowych danych sprzedażowych, ich walidacja, oczyszczanie oraz przygotowanie do analizy poprzez zapis do tabeli docelowej.

Projekt pokazuje:

* programowanie w Oracle PL/SQL,
* projektowanie schematu bazy danych,
* przetwarzanie danych (ETL),
* walidację danych,
* logowanie błędów i przebiegu procesu,
* przygotowanie środowiska pod testowanie i automatyzację.

---

##  Architektura rozwiązania

Pipeline składa się z kilku warstw przetwarzania danych:

RAW → STAGING → CLEAN
↓
ERROR LOG

### Opis warstw:

* RAW (`raw_sales`)
  Surowe dane wejściowe (np. z API lub pliku CSV).
  Dane mogą być niepoprawne lub niekompletne.

* STAGING (`stg_sales`)
  Warstwa pośrednia, w której dane są przygotowywane do walidacji.
  Każdy rekord posiada status:

  * NEW
  * VALID
  * INVALID

* CLEAN (`clean_sales`)
  Tabela docelowa zawierająca tylko poprawne dane.

* ERROR LOG (`etl_error_log`)
  Tabela przechowująca błędne rekordy wraz z opisem błędu.

* ETL LOG (`etl_log`)
  Log przebiegu procesu ETL (start, koniec, status, liczba rekordów).

---

##  Model danych

Projekt zawiera następujące główne tabele:

* raw_sales — dane wejściowe
* stg_sales — dane pośrednie
* clean_sales — dane docelowe
* etl_log — log procesu ETL
* etl_error_log — log błędów

Dodatkowo:

* sekwencje (SEQUENCE) do generowania ID
* triggery (TRIGGER) do automatycznego nadawania kluczy głównych



---

## ▶ Uruchomienie projektu

Projekt można uruchomić w Oracle SQL Developer.

### Krok 1 — połączenie z bazą

Utwórz połączenie do bazy Oracle (np. pipeline_user).

### Krok 2 — uruchomienie skryptów

Najprostszy sposób:

@sql/run_all.sql

Lub ręcznie:

@sql/tables.sql
@sql/sequences.sql
@sql/triggers.sql
@sql/inserts.sql

---

##  Dane testowe

Projekt zawiera przykładowe dane w tabeli raw_sales, które obejmują:

###  Poprawne rekordy

* kompletne dane sprzedażowe

###  Błędne rekordy

* brak nazwy produktu
* brak ilości
* cena ujemna
* ilość równa 0
* brak daty sprzedaży

###  Przypadki graniczne

* duplikaty
* wartości skrajne

---

##  Logika przetwarzania (ETL)

Pipeline będzie realizował następujące kroki:

1. Załadunek danych z raw_sales do stg_sales
2. Walidacja danych
3. Oznaczenie rekordów jako VALID lub INVALID
4. Zapis błędów do etl_error_log
5. Przeniesienie poprawnych danych do clean_sales
6. Logowanie procesu w etl_log

---

##  Reguły walidacji

Rekord uznawany jest za poprawny, jeśli:

* product_name IS NOT NULL
* quantity IS NOT NULL AND quantity > 0
* price IS NOT NULL AND price > 0
* sale_date IS NOT NULL

---

##  Status projektu

Zrealizowane etapy:

* ✔ Projekt koncepcji i architektury
* ✔ Model danych
* ✔ Implementacja tabel
* ✔ Sekwencje i triggery
* ✔ Dane testowe
* ✔ Projekt logiki ETL

W kolejnych etapach:

* implementacja pakietu PL/SQL (etl_pkg)
* testy
* automatyzacja (scheduler)
* dokumentacja i diagramy

---

##  Technologie

* Oracle Database
* PL/SQL
* SQL
* Oracle SQL Developer
