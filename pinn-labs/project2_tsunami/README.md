# Projekt 2: Symulacja Tsunami nad zmienną topografią (PINN)

## Opis

PINN rozwiązujący równania płytkiej wody (Shallow Water Equations) 2D w celu symulacji propagacji fali tsunami nad dnem o zmiennej głębokości (wyspa w kształcie litery L).

## Zmiany w oryginalnym notebooku

### 1. Poprawa Fizyki (Równania Płytkiej Wody)

W oryginalnym kodzie brakowało członów uwzględniających nachylenie dna. Zostały one dodane do funkcji `residual_loss`:
- Obliczanie gradientów topografii: `dz/dx` i `dz/dy`.
- Uwzględnienie ich w bilansie pędu: `(u_x - dzdx) * u_x` oraz `(u_y - dzdy) * u_y`.

### 2. Stabilizacja Numeryczna (Bicubic + Gravity)

- **Interpolacja**: Zmieniono tryb próbkowania topografii (`F.grid_sample`) na `'bicubic'`. Zapobiega to powstawaniu nieciągłości (ostrych kantów) w gradientach dna, które powodowały błędy w treningu.
- **Grawitacja**: Zmniejszono stałą grawitacji `GRAVITY = 1.0` (zamiast 9.81), co ułatwia sieci neuronowej uczenie się dynamiki fali (skalowanie bezwymiarowe).

### 3. Uproszczenie Sieci Neuronowej

Zauważono, że zbyt głęboka sieć miała trudności z nauczeniem się prostego kształtu początkowego (Initial Condition).
- **Warstwy**: Zredukowano z 10 do **4 warstw**.
- **Neurony**: Zredukowano do 64 na warstwę.
- **Fourier Features**: Zmniejszono skalę (`scale=1.0`), aby sieć lepiej odwzorowywała gładkie kształty (niskie częstotliwości) zamiast szumu.

### 4. Topografia (Wygładzona L-kształtna wyspa)

Wygenerowano nową mapę topografii (`topography.png`) za pomocą skryptu `generate_topography_final.py`. Zastosowano **rozmycie Gaussa (sigma=5)**, aby zapewnić różniczkowalność kształtu wyspy.

### 5. Wizualizacja (Global Dynamic Scaling)

Dodano mechanizm "Global Dynamic Scaling" do generowania animacji GIF. Skrypt najpierw oblicza wartości min/max dla całej symulacji, a następnie używa stałej skali kolorów (`vmin`, `vmax`), co eliminuje efekt "migotania" kolorów w animacji.

## Uruchomienie

1. Wygeneruj topografię:
   ```bash
   python project2_tsunami/generate_topography_final.py
   ```
2. Uruchom notebook:
   ```bash
   jupyter notebook project2_tsunami/PINN_tsunami_2d_solution.ipynb
   ```

Wynik: Plik `tsunami_wave12.gif` przedstawiający propagację i odbicie fali.
