**Regexpr criterion benchmark:**

**No optimization:**

benchmarking no optimization/a*a
time                 729.2 ms   (NaN s .. 854.1 ms)
                     0.985 R²   (0.960 R² .. 1.000 R²)
mean                 718.2 ms   (651.6 ms .. 759.1 ms)
std dev              67.92 ms   (36.80 ms .. 94.46 ms)
variance introduced by outliers: 22% (moderately inflated)
                             
benchmarking no optimization/(a|a)*
time                 531.2 ms   (336.7 ms .. 957.0 ms)
                     0.928 R²   (0.889 R² .. 1.000 R²)
mean                 397.1 ms   (359.3 ms .. 470.2 ms)
std dev              72.41 ms   (355.2 μs .. 86.88 ms)
variance introduced by outliers: 47% (moderately inflated)
                             
benchmarking no optimization/b|c(a|b)*
time                 182.6 μs   (180.7 μs .. 186.3 μs)
                     0.988 R²   (0.976 R² .. 0.996 R²)
mean                 193.1 μs   (186.2 μs .. 205.2 μs)
std dev              28.72 μs   (20.21 μs .. 39.80 μs)
variance introduced by outliers: 90% (severely inflated)
                             
benchmarking no optimization/b|c(a|b)*
time                 471.0 μs   (452.3 μs .. 488.3 μs)
                     0.987 R²   (0.978 R² .. 0.994 R²)
mean                 461.6 μs   (448.4 μs .. 483.7 μs)
std dev              53.13 μs   (34.30 μs .. 75.31 μs)
variance introduced by outliers: 82% (severely inflated)
                             
benchmarking no optimization/b|c(a|b)*
time                 22.24 ms   (21.55 ms .. 22.91 ms)
                     0.997 R²   (0.995 R² .. 1.000 R²)
mean                 22.06 ms   (21.85 ms .. 22.39 ms)
std dev              601.1 μs   (381.6 μs .. 816.3 μs)
                             
**Optimization:**
                             
benchmarking smart constructors/a*a
time                 133.9 μs   (132.1 μs .. 135.4 μs)
                     0.999 R²   (0.999 R² .. 0.999 R²)
mean                 134.1 μs   (132.9 μs .. 135.2 μs)
std dev              3.770 μs   (3.295 μs .. 4.321 μs)
variance introduced by outliers: 24% (moderately inflated)
                             
benchmarking smart constructors/(a|a)*
time                 83.01 μs   (80.71 μs .. 85.24 μs)
                     0.995 R²   (0.993 R² .. 0.998 R²)
mean                 83.34 μs   (81.97 μs .. 86.10 μs)
std dev              6.538 μs   (4.022 μs .. 11.44 μs)
variance introduced by outliers: 74% (severely inflated)
                             
benchmarking smart constructors/b|c(a|b)*
time                 12.41 μs   (12.28 μs .. 12.58 μs)
                     0.997 R²   (0.995 R² .. 0.999 R²)
mean                 13.02 μs   (12.75 μs .. 13.50 μs)
std dev              1.142 μs   (819.6 ns .. 1.759 μs)
variance introduced by outliers: 82% (severely inflated)
                             
benchmarking smart constructors/b|c(a|b)*
time                 12.06 μs   (11.79 μs .. 12.54 μs)
                     0.996 R²   (0.992 R² .. 1.000 R²)
mean                 12.06 μs   (11.96 μs .. 12.22 μs)
std dev              424.8 ns   (263.4 ns .. 793.5 ns)
variance introduced by outliers: 42% (moderately inflated)
                             
benchmarking smart constructors/b|c(a|b)*
time                 63.71 μs   (62.40 μs .. 65.11 μs)
                     0.997 R²   (0.996 R² .. 0.998 R²)
mean                 63.86 μs   (62.96 μs .. 64.80 μs)
std dev              2.994 μs   (2.498 μs .. 3.621 μs)
variance introduced by outliers: 51% (severely inflated)
