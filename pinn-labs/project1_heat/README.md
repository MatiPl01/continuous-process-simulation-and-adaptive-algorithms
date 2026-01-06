# Projekt 1: Równanie ciepła z warunkiem początkowym z obrazu

## Opis

PINN rozwiązujący 2D równanie ciepła z warunkiem początkowym wczytanym z obrazu `initial_condition.png`.

## Zmiany w oryginalnym notebooku

### 1. Warunek początkowy z obrazu

Zamiast funkcji analitycznej (Gaussian), warunek początkowy wczytywany jest z pliku PNG i interpolowany na siatkę fizyczną za pomocą `torch.nn.functional.grid_sample()`.

### 2. Usunięte zależności Google Colab

- Zakomentowano: `from google.colab import files`
- Dodano: `import imageio.v3 as imageio`

### 3. Usunięte porównania z rozwiązaniem dokładnym

Kod porównujący wyniki PINN z funkcją `exact()` został usunięty - nie istnieje rozwiązanie analityczne dla dowolnych obrazów.

### 4. Dinamiczna skala kolorów w animacji

Funkcja `plot_color()` została rozszerzona o parametry `vmin`, `vmax`. Animacja najpierw oblicza wszystkie klatki, znajduje globalny zakres temperatur, a następnie używa stałej skali kolorów dla wszystkich ramek.

### 5. Generowanie GIF

Dodano komórkę generującą animację:

- 50 klatek dla czasu t ∈ [0, 0.1]
- Zapis do `output/heat_transfer.gif`

### 6. Parametry

- `EPOCHS = 10000` (zwiększone dla lepszej konwergencji przy trudniejszym kształcie)
- Zakres czasu: [0, 0.1] - skupienie na wczesnej fazie dyfuzji

## Uruchomienie

```bash
python generate_initial_condition.py  # wygenerowanie asymetrycznego warunku początkowego (L-shape)
jupyter notebook PINN_heat_transfer_2d_solution.ipynb  # uruchomienie notebooka
```

Wynik: `output/heat_transfer.gif`
