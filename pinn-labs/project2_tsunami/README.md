# Projekt 2: Symulacja tsunami z topografią dna z obrazu

## Opis

PINN rozwiązujący równania płytkiej wody (shallow water equations) z topografią dna morskiego wczytaną z obrazu `topography.png`.

## Zmiany w oryginalnym notebooku

### 1. Topografia dna z obrazu

Zamiast funkcji analitycznej, topografia dna (`floor(x,y)`) wczytywana jest z pliku PNG i interpolowana na siatkę fizyczną za pomocą `torch.nn.functional.grid_sample()`.

### 2. Usunięte zależności Google Colab

- Zakomentowano: `from google.colab import drive`
- Dodano: `import imageio.v3 as imageio`

### 3. Dodana funkcja warunku początkowego

Dodano `initial_condition(x,y)` - kopuła Gaussowska symulująca źródło fali tsunami.

### 4. Generowanie GIF

Dodano komórkę generującą animację:

- 50 klatek dla całego czasu symulacji
- Dinamiczna skala kolorów (globalne min/max)
- Zapis do `output/tsunami.gif`

### 5. Parametry

- `EPOCHS = 5000` (zredukowane z 150,000 dla szybszego testowania)
- Domena: [0, 2] × [0, 2] (kwadratowa)

## Uruchomienie

```bash
python generate_topography.py  # wygenerowanie topografii
jupyter notebook PINN_tsunami_2d.ipynb  # uruchomienie notebooka
```

Wynik: `output/tsunami.gif`
