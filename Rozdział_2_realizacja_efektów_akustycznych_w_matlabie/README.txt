Funckje w folderze dedykowanym dla rozdziału drugiego mojej pracy zawiera funkcję realizujące 
efekty akustyczne. 
Każda z funkcji zawiera plik dźwiękowy. Dla Sumatora jest są to Próbka_stereo/mono_test_sumowanie 
kanalow. Dla Pitch_Shiftera, Detune oraz chorusa jest to Sample_to_test_stereo natomiast dla pozostałych
jest to Sample_to_test. Wersja stereo od wersji zwykłej różni się ilością kanałów zastosowanych
dla danego efektu. Dla Detunu oraz Pitch Shiftera, a także chorusa lepiej użyć dźwięku stereofonicznego
w związku z ich działaniem na sygnał. 

Każda funkcja realizwana jest w podobny sposób. 

1. Deklaracja sygnału wejściowego
2. Realizacja cyfrowa w opraciu o zadaną zależność.
3. Zapis do pliku
4. Realizacja wykresów i funkcji.
5. Odsłuch sygnału wejściowego i sygnału poddanego obróce cyfrowej.

Wszystkie obrobione sygnału zostają zapisane w folderze Zapisane_pliki_koncowe
zgodnie z zależnością : NazwaFunkcji_efekt_koncowy
dla przykladu : chorus_efekt_koncowy.

Multi_efekt to program dla użytkownika realizujący efekty akustyczne. Użytkownik może wybrać
efekt który ma zostać zrealizowany i po wprowadzeniu parametrów zostaje zrealizowana
wybrana funkcja z wybranymi parametrami. 
Po wprowadzeniu parametrów następuje odsłuch sygnału wejściowego, następnie odsłuch sygnału
wyjściowego. Zostają również wyrysowane odpowiednie zależności przedstawiające zmiane sygnału,
a sygnał jak zostało to wspomniane powyżej zostaje zapisany do pliku. 

