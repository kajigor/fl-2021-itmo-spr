На больших объемах данных Seq p q стал работать быстрее в 2 раза на строке, 
состоящей из букв "a" с regexp = a*a и в 163 раза на строке состоящей из 5000 подстрок badabac
со сложным regexp (b|c(a|b)**)

benchmarking Match regular/a*a, 5000 times
time                 4.292 s    (3.546 s .. 4.859 s)
0.997 R²   (NaN R² .. 1.000 R²)
mean                 4.316 s    (4.202 s .. 4.448 s)
std dev              155.3 ms   (480.3 μs .. 190.0 ms)
variance introduced by outliers: 19% (moderately inflated)

benchmarking Match regular/b|c(a|b)*, 5000 times
time                 18.01 ms   (17.72 ms .. 18.38 ms)
0.998 R²   (0.997 R² .. 0.999 R²)
mean                 17.77 ms   (17.41 ms .. 17.96 ms)
std dev              666.4 μs   (447.7 μs .. 1.068 ms)
variance introduced by outliers: 13% (moderately inflated)

benchmarking Match optimized/a*a, 5000 times
time                 2.091 s    (1.858 s .. 2.524 s)
0.995 R²   (0.989 R² .. 1.000 R²)
mean                 1.928 s    (1.869 s .. 2.002 s)
std dev              85.45 ms   (22.10 ms .. 113.0 ms)
variance introduced by outliers: 19% (moderately inflated)

benchmarking Match optimized/b|c(a|b)*, 5000 times
time                 110.2 μs   (106.7 μs .. 112.9 μs)
0.995 R²   (0.993 R² .. 0.997 R²)
mean                 111.7 μs   (109.4 μs .л. 114.0 μs)
std dev              7.917 μs   (6.655 μs .. 10.56 μs)
variance introduced by outliers: 68% (severely inflated)
