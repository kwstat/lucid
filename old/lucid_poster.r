# lucid: An R package for pretty printing floating point numbers

Abstract

Real numbers can be efficiently stored in computer memory with the floating
point format, but printed floating point numbers can be difficult for people
to interpret, especially when the exponents are not all the same.  The R
package "lucid" is useful for formatting vectors and tables of floating-point
numbers in a human-friendly format.  Examples are given to illustrate the
benefits with variance components from mixed models.

Keywords: R, floating-point, tables

Abstract Number 319969 has been submitted.
Draft manuscript emailed 5.11.16


---

Try to connect to the theme.  Think about a prop like a big diamond or magnifying glass.  Have 50 ? copies of the poster printed on 8.5x11 paper or paper strips linking to vignette.

Presentations may be given on any topic of statistical interest; however, authors are encouraged to submit papers on the theme set by 2016 ASA President Jessica Utts, "The Extraordinary Power of Statistics." Additionally, abstracts with a primary focus on statistical applications are encouraged.

JSM registraiton: 123013
password: jsm2016

A six-foot table, an 8 x 4 foot display board, and push pins are provided.

# ----------------------------------------------------------------------------

The sequence of steps used by lucid() is:

1. Zap small numbers to zero.
2. Round using 3 significant digits.
3. Drop trailing zeros.
4. Align numbers at the decimal point.
5. Format as text.

One recommendation for improving the display of tables of numbers
is to round numbers to 2 [@wainer1997improving]
or 3 [@feinberg2011extracting] digits for the following reasons:

1. We cannot comprehend more than three digits very easily.
2. We seldom care about accuracy of more than three digits.
3. We can rarely justify more than three digits of accuracy statistically.

# ----------------------------------------------------------------------------

df1 <- data.frame(effect=c(113.5, -13.5, 4.5,  24.5, 6.927792e-14, -1.75, 16.5))
rownames(df1) <- c("(Intercept)","A","B","C","C1","C2","D")
print(df1)
lucid(df1)
round(df1,4)
signif(df1,4)

R> print(df1)
                   effect
(Intercept)  1.135000e+02
A           -1.350000e+01
B            4.500000e+00
C            2.450000e+01
C1           6.927792e-14
C2          -1.750000e+00
D            1.650000e+01

R> lucid(df1)
            effect
(Intercept) 114   
A           -13.5 
B             4.5 
C            24.5 
C1            0   
C2           -1.75
D            16.5 

# ----------------------------------------------------------------------------

# Compare lucid to round, signif

d4 <- cbind(default=format(antibiotic$penicillin),
            signif=format(signif(antibiotic$penicillin)),
            round=format(round(antibiotic$penicillin,3)),
            lucid=format(lucid(antibiotic$penicillin)))
as.data.frame(d4)

  default   signif    round     lucid  
  870.000   870.000   870.000   870    
    1.000     1.000     1.000     1    
    0.001     0.001     0.001     0.001
    0.005     0.005     0.005     0.005
  100.000   100.000   100.000   100    
  850.000   850.000   850.000   850    
  800.000   800.000   800.000   800    
    3.000     3.000     3.000     3    
  850.000   850.000   850.000   850    
    1.000     1.000     1.000     1    
   10.000    10.000    10.000    10    
    0.007     0.007     0.007     0.007
    0.030     0.030     0.030     0.03 
    1.000     1.000     1.000     1    
    0.001     0.001     0.001     0.001
    0.005     0.005     0.005     0.005

# ----------------------------------------------------------------------------

print(antibiotic)
lucid(antibiotic)

                       bacteria penicillin streptomycin neomycin stain
           Aerobacter aerogenes    870.000         1.00    1.600   neg
               Brucella abortus      1.000         2.00    0.020   neg
               Escherichia coli    100.000         0.40    0.100   neg
          Klebsiella pneumoniae    850.000         1.20    1.000   neg
     Mycobacterium tuberculosis    800.000         5.00    2.000   neg
               Proteus vulgaris      3.000         0.10    0.100   neg
         Pseudomonas aeruginosa    850.000         2.00    0.400   neg
             Salmonella typhosa      1.000         0.40    0.008   neg
      Salmonella schottmuelleri     10.000         0.80    0.090   neg
             Bacillis anthracis      0.001         0.01    0.007   pos
         Diplococcus pneumoniae      0.005        11.00   10.000   pos
           Staphylococcus albus      0.007         0.10    0.001   pos
          Staphylococcus aureus      0.030         0.03    0.001   pos
          Streptococcus fecalis      1.000         1.00    0.100   pos
      Streptococcus hemolyticus      0.001        14.00   10.000   pos
         Streptococcus viridans      0.005        10.00   40.000   pos

                       bacteria penicillin streptomycin neomycin stain
           Aerobacter aerogenes    870             1       1.6     neg
               Brucella abortus      1             2       0.02    neg
               Escherichia coli    100             0.4     0.1     neg
          Klebsiella pneumoniae    850             1.2     1       neg
     Mycobacterium tuberculosis    800             5       2       neg
               Proteus vulgaris      3             0.1     0.1     neg
         Pseudomonas aeruginosa    850             2       0.4     neg
             Salmonella typhosa      1             0.4     0.008   neg
      Salmonella schottmuelleri     10             0.8     0.09    neg
             Bacillis anthracis      0.001         0.01    0.007   pos
         Diplococcus pneumoniae      0.005        11      10       pos
           Staphylococcus albus      0.007         0.1     0.001   pos
          Staphylococcus aureus      0.03          0.03    0.001   pos
          Streptococcus fecalis      1             1       0.1     pos
      Streptococcus hemolyticus      0.001        14      10       pos
         Streptococcus viridans      0.005        10      40       pos


# ----------------------------------------------------------------------------

# Orange tree

require(dplyr)
require(broom)
require(lattice)
require(lucid)
xyplot(circumference ~ age, data=Orange, group=Tree,
       auto.key=list(columns=5), type=c('p','r'), main="Orange")
Orange %>% group_by(Tree) %>% do(tidy(lm(circumference ~ age, data=.)))
Orange %>% group_by(Tree) %>% do(tidy(lm(circumference ~ age, data=.))) %>% lucid


 Tree        term    estimate    std.error statistic      p.value
<ord>       <chr>       <dbl>        <dbl>     <dbl>        <dbl>
    3 (Intercept) 19.20353638  5.863410215  3.275148 2.207255e-02
    3         age  0.08111158  0.005628105 14.411881 2.901046e-05
    1 (Intercept) 24.43784664  6.543311039  3.734783 1.350409e-02
    1         age  0.08147716  0.006280721 12.972581 4.851902e-05
    5 (Intercept)  8.75834459  8.176436207  1.071169 3.330518e-01
    5         age  0.11102891  0.007848307 14.146861 3.177093e-05
    2 (Intercept) 19.96090337  9.352361105  2.134317 8.593318e-02
    2         age  0.12506176  0.008977041 13.931291 3.425041e-05
    4 (Intercept) 14.63762022 11.233762751  1.303002 2.493507e-01
    4         age  0.13517222  0.010782940 12.535748 5.733090e-05

 Tree        term estimate std.error statistic   p.value
<ord>       <chr>    <chr>     <chr>     <chr>     <chr>
    3 (Intercept)  19.2      5.86         3.28 0.0221   
    3         age   0.0811   0.00563     14.4  0.000029 
    1 (Intercept)  24.4      6.54         3.73 0.0135   
    1         age   0.0815   0.00628     13    0.0000485
    5 (Intercept)   8.76     8.18         1.07 0.333    
    5         age   0.111    0.00785     14.1  0.0000318
    2 (Intercept)  20        9.35         2.13 0.0859   
    2         age   0.125    0.00898     13.9  0.0000343
    4 (Intercept)  14.6     11.2          1.3  0.249    
    4         age   0.135    0.0108      12.5  0.0000573

# ----------------------------------------------------------------------------

df1 <- data.frame(effect=c(-13.5, 4.5,  24.5, 6.927792e-14, -1.75,
                    16.5, 113.5000))
rownames(df1) <- c("A","B","C","C1","C2","D","(Intercept)")
print(df1)
lucid(df1)

                   effect
(Intercept)  1.135000e+02
A           -1.350000e+01
B            4.500000e+00
C            2.450000e+01
C1           6.927792e-14
C2          -1.750000e+00
D            1.650000e+01

            effect
(Intercept) 114
A           -13.5 
B             4.5 
C            24.5 
C1            0   
C2           -1.75
D            16.5 


# ----------------------------------------------------------------------------

d1 <- structure(list(grp = c("new.gen", "one", "one.1", "one.2", "one.3",
"one.4", "one.5", "one.6", "one.7", "one.8", "one.9", "one.10",
"one.11", "one.12", "one.13", "Residual"), var1 = c("(Intercept)",
"r1:c3", "r1:c2", "r1:c1", "c8", "c6", "c4", "c3", "c2", "c1",
"r10", "r8", "r4", "r2", "r1", NA), var2 = c(NA_character_, NA_character_,
NA_character_, NA_character_, NA_character_, NA_character_, NA_character_,
NA_character_, NA_character_, NA_character_, NA_character_, NA_character_,
NA_character_, NA_character_, NA_character_, NA_character_),
    vcov = c(2869.44692139271, 5531.57239635089, 58225.767835444,
    128004.156092455, 6455.74953933247, 1399.72937329085, 1791.65071661348,
    2548.88470543732, 5941.79076230161, 0, 1132.95013713932,
    1355.22907294114, 2268.72957045473, 241.789424531994, 9199.9021721834,
    4412.1096176349), sdcor = c(53.5672187199663, 74.3745413185916,
    241.300161283502, 357.7766846686, 80.3476791160297, 37.4129572914365,
    42.3278952537623, 50.4864804223598, 77.0830121511972, 0,
    33.6593246684974, 36.8134360382339, 47.6311827530529, 15.5495795612613,
    95.9161205021523, 66.4237127661116)), .Names = c("grp", "var1",
    "var2", "vcov", "sdcor"), row.names = c(NA, -16L), class = "data.frame")

d2 <- structure(list(grp = c("new.gen", "one", "one.1", "one.2", "one.3",
"one.4", "one.5", "one.6", "one.7", "one.8", "one.9", "one.10",
"one.11", "one.12", "one.13", "Residual"), var1 = c("(Intercept)",
"r1:c3", "r1:c2", "r1:c1", "c8", "c6", "c4", "c3", "c2", "c1",
"r10", "r8", "r4", "r2", "r1", NA), var2 = c(NA_character_, NA_character_,
NA_character_, NA_character_, NA_character_, NA_character_, NA_character_,
NA_character_, NA_character_, NA_character_, NA_character_, NA_character_,
NA_character_, NA_character_, NA_character_, NA_character_),
    vcov = c(3228.41890564251, 7688.13916836557, 69747.5508913552,
    107427.043198654, 6787.00354507896, 1636.12771714548, 12268.4603217744,
    2686.30159414561, 7644.72994565782, 0.00122514315152732,
    1975.50482871438, 1241.42852423718, 2811.24084391436, 928.227473340838,
    10363.5849610346, 4126.83169047631), sdcor = c(56.8191772700249,
    87.6820344675326, 264.097616216722, 327.760649252856, 82.3832722406616,
    40.4490756031022, 110.763081944186, 51.8295436420735, 87.4341463368736,
    0.0350020449620779, 44.4466514904597, 35.23391156595, 53.02113582256,
    30.4668257838069, 101.801694293536, 64.2404210017051)), .Names = c("grp",
"var1", "var2", "vcov", "sdcor"), row.names = c(NA, -16L), class = "data.frame")
out <- cbind(d1[, c(2,4,5)], sep="   ",d2[,4:5])
names(out) <- c('term','vcov-bo','sdcor-bo','sep','vcov-ne','sdcor-ne')
print(out)
lucid(out, dig=4)

        term     var-boby  std-boby         var-neld     std-neld
 (Intercept)    2869.4469  53.56722     3.228419e+03  56.81917727
       r1:c3    5531.5724  74.37454     7.688139e+03  87.68203447
       r1:c2   58225.7678 241.30016     6.974755e+04 264.09761622
       r1:c1  128004.1561 357.77668     1.074270e+05 327.76064925
          c8    6455.7495  80.34768     6.787004e+03  82.38327224
          c6    1399.7294  37.41296     1.636128e+03  40.44907560
          c4    1791.6507  42.32790     1.226846e+04 110.76308194
          c3    2548.8847  50.48648     2.686302e+03  51.82954364
          c2    5941.7908  77.08301     7.644730e+03  87.43414634
          c1       0.0000   0.00000     1.225143e-03   0.03500204
         r10    1132.9501  33.65932     1.975505e+03  44.44665149
          r8    1355.2291  36.81344     1.241429e+03  35.23391157
          r4    2268.7296  47.63118     2.811241e+03  53.02113582
          r2     241.7894  15.54958     9.282275e+02  30.46682578
          r1    9199.9022  95.91612     1.036358e+04 101.80169429
        <NA>    4412.1096  66.42371     4.126832e+03  64.24042100

        term var-boby   std-boby    var-neld  std-neld
 (Intercept)     2869      53.57        3228     56.82 
       r1:c3     5532      74.37        7688     87.68 
       r1:c2    58230     241.3        69750    264.1  
       r1:c1   128000     357.8       107400    327.8  
          c8     6456      80.35        6787     82.38 
          c6     1400      37.41        1636     40.45 
          c4     1792      42.33       12270    110.8  
          c3     2549      50.49        2686     51.83 
          c2     5942      77.08        7645     87.43 
          c1        0       0              0      0.035
         r10     1133      33.66        1976     44.45 
          r8     1355      36.81        1241     35.23 
          r4     2269      47.63        2811     53.02 
          r2      241.8    15.55         928.2   30.47 
          r1     9200      95.92       10360    101.8  
        <NA>     4412      66.42        4127     64.24 

# ----------------------------------------------------------------------------

head(state.x77)
##            Population Income Illiteracy Life Exp Murder HS Grad Frost   Area
## Alabama          3615   3624        2.1    69.05   15.1    41.3    20  50708
## Alaska            365   6315        1.5    69.31   11.3    66.7   152 566432
## Arizona          2212   4530        1.8    70.55    7.8    58.1    15 113417
## Arkansas         2110   3378        1.9    70.66   10.1    39.9    65  51945
## California      21198   5114        1.1    71.71   10.3    62.6    20 156361
## Colorado         2541   4884        0.7    72.06    6.8    63.9   166 103766

lib(dplyr)

# ----------------------------------------------------------------------------

dat <- state.x77
dat <- as.data.frame(dat)
dat$State <- rownames(state.x77)
dat <- mutate(dat, Density = Population/Area)
set.seed(1)
d1 <- dat[sample(1:50),c('State','Population','Area','Density')]

d1[,c('State','Density')] %>% print
d1[,c('State','Density')] %>% lucid

R> d1[,c('State','Density')] %>% print
            State      Density
14        Indiana 0.1471867468
19          Maine 0.0342173351
28         Nevada 0.0053690542
43          Texas 0.0466822312
10        Georgia 0.0849103714
41   South Dakota 0.0089658350
42      Tennessee 0.1009727062
29  New Hampshire 0.0899523651
27       Nebraska 0.0201874926
3         Arizona 0.0195032491
9         Florida 0.1530227399
7     Connecticut 0.6375976964
44           Utah 0.0146535763
15           Iowa 0.0511431687
48  West Virginia 0.0747403407
18      Louisiana 0.0847095482
25       Missouri 0.0690919632
33 North Carolina 0.1115004713
13       Illinois 0.2008502547
34   North Dakota 0.0091955019
47     Washington 0.0534625207
39   Rhode Island 0.8875119161
49      Wisconsin 0.0842574912
4        Arkansas 0.0406198864
30     New Jersey 0.9750033240
46       Virginia 0.1252136752
1         Alabama 0.0712905261
40 South Carolina 0.0931679074
20       Maryland 0.4167424932
8        Delaware 0.2921291625
31     New Mexico 0.0094224624
12          Idaho 0.0098334482
23      Minnesota 0.0494520047
38   Pennsylvania 0.2637548370
50        Wyoming 0.0038681934
11         Hawaii 0.1350972763
36       Oklahoma 0.0394725364
2          Alaska 0.0006443845
35           Ohio 0.2619890177
5      California 0.1355708904
16         Kansas 0.0278772910
6        Colorado 0.0244877898
26        Montana 0.0051240839
17       Kentucky 0.0854224464
21  Massachusetts 0.7429082545
22       Michigan 0.1603569354
24    Mississippi 0.0494967862
32       New York 0.3779139052
45        Vermont 0.0509334197
37         Oregon 0.0237461532

R> d1[,c('State','Density')] %>% lucid
            State  Density
14        Indiana 0.147   
19          Maine 0.0342  
28         Nevada 0.00537 
43          Texas 0.0467  
10        Georgia 0.0849  
41   South Dakota 0.00897 
42      Tennessee 0.101   
29  New Hampshire 0.09    
27       Nebraska 0.0202  
3         Arizona 0.0195  
9         Florida 0.153   
7     Connecticut 0.638   
44           Utah 0.0147  
15           Iowa 0.0511  
48  West Virginia 0.0747  
18      Louisiana 0.0847  
25       Missouri 0.0691  
33 North Carolina 0.112   
13       Illinois 0.201   
34   North Dakota 0.0092  
47     Washington 0.0535  
39   Rhode Island 0.888   
49      Wisconsin 0.0843  
4        Arkansas 0.0406  
30     New Jersey 0.975   
46       Virginia 0.125   
1         Alabama 0.0713  
40 South Carolina 0.0932  
20       Maryland 0.417   
8        Delaware 0.292   
31     New Mexico 0.00942 
12          Idaho 0.00983 
23      Minnesota 0.0495  
38   Pennsylvania 0.264   
50        Wyoming 0.00387 
11         Hawaii 0.135   
36       Oklahoma 0.0395  
2          Alaska 0.000644
35           Ohio 0.262   
5      California 0.136   
16         Kansas 0.0279  
6        Colorado 0.0245  
26        Montana 0.00512 
17       Kentucky 0.0854  
21  Massachusetts 0.743   
22       Michigan 0.16    
24    Mississippi 0.0495  
32       New York 0.378   
45        Vermont 0.0509  
37         Oregon 0.0237  

