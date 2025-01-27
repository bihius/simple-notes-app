# Projekt flutter

Projekt ten jest aplikacją mobilną napisaną w języku Dart przy użyciu frameworka Flutter. W aplikacji tej użytkownik może tworzyć notatki oraz je edytować. Notatki te są zapisywane w bazie sqlite. Do aplikacji użytkownik musi się autoryzować za pomocą danych, które są również zapisywane w bazie sqlite. Informacje o tym czy użytkownik jest zalogowany i na jakie konto, przechowywane są w shared preferences.

## Struktura projektu
Aplikacja składa się z 4 ekranów:
- `LoginScreen` - ekran logowania
- `RegisterScreen` - ekran rejestracji
- 'HomeScreen' - ekran główny, na którym użytkownik może przeglądać swoje notatki
- 'NoteScreen' - ekran, na którym użytkownik moze przejrzec notatke
- 'AddNoteScreen' - ekran, na którym użytkownik moze dodac, edytowac notatke

## Technologie
- Dart
- Flutter
- SQLite
- Shared Preferences

## Wyzwania
Na początku największym (urojonym) wyzwaniem było stworzenie całego layoutu na ekranie logowania. Okazalo się jednak, że stworzenie tego nie było wcale takie trudne. Trudności dopiero pojawiły się w szczegółach, lub raczej dopiero po ich zauważeniu - przycisk do odkrycia hasła zagwiastkowywał po kliknieciu pole loginu - z problemem tym borykałem się całkiem sporo czasu, ponieważ wymagałem od siebie najprostszego ale i najbardziej logicznego rozwiązania. Kolejnym problemem, drobnym lecz bardzo denerwującym, okazały się wartości w InitialValue. Uważam, że nie skorzystałbym z aplikacji, która automatycznie usuwa domyślną zawartość pól tekstowych po kliknięciu w nie, stąd też musiałem się zapoznać z mechanizmami controllera oraz focusnode aby to naprawić. 

Kolejnym problemem, ktory napotkalem dotyczyl obslugi bazy danych. Okazalo sie, ze potrzeba duzo czasu na zrozumienie jak dziala SQLite w flutterze, jakie sa jego ograniczenia oraz jakie sa najlepsze praktyki. Niestety, nie udalo mi sie zaimplementowac wszystkich funkcjonalnosci, ktore chcialem, ale jestem zadowolony z tego, co udalo mi sie osiagnac. Przede wszystkim brakuje korelacji miedzy notatkami a uzytkownikami, co uniemozliwia zapisywanie notatek dla konkretnego uzytkownika. 
