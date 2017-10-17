; Participatory Planning Procedure Prototype (PPPP, AKA Pequod)
;
; See the Info tab for the model in NetLogo for model purpose,
; etc. The agents, variables, procedures, and reporters of the model
; are documented directly below, with some minor information
; documented within the code.
;
; Documentation is in-progress. The text "@..." occurs where more
; information will be added.
;
;
;
; @AGENTS
;
; The primary agents of the model are councils whose collective
; behavior affects prices and quantities for supply and demand.
;
; cc - consumer council
; wc - worker council
;
;
;
; @VARIABLES
;
; CONSUMER COUNCILS
;
; effort             - allows for differential consumption commensurate with
;                      effort; not yet implemented...not currently tied
;                      to the effort of the consumers vis-a-vis their
;                      worker council
; df[N]              - proposed consumption quantities (demands) of the given good
; income             - scales effort and acts as a budget constraint in optimizing
;                      the utility function
; cy                 - scalar for entire product in utility function; interpreted as
;                      the total factor of utility
; yf[N]              - exponents in utility function representing the utility
;                      elasticity of consumption of the given good
; final-demands      - list of df[N]
; utility-multiplier - INTERFACE PARAMETER allowing additional zeros
;                      to be added to consumer utility; currently unused
;
; WORKER COUNCILS
;
; industry       - numerical index (1 is final and 2 is intermediate); is
;                  not industry in the sense of manufacturing, etc
; product        - numerical index; more like an industry; see product-price
;                  reporter for interpretation
; qi[N]          - (deprecated) see [P]-quantities
; ql             - (deprecated) see [P]-quantities
; effort         - scales labor to output; allows consumers who are workers to
;                  receive consumption commensurate with effort; not currently tied to
;                  the effort of the consumers vis-a-vis their worker council
; output         - quantity of the firm's final good
; xe             - exponent for effort in the production function
; cq             - scalar for entire product in production function; sometimes
;                  interpreted as technology scalar or the total factor of
;                  productivity; coefficient in production function; controllable
;                  parameter
; ce             - coefficient for disutility of effort; controllable parameter;
;                  interpreted as being "unpleasentness elastisitcity"
; du             - exponent for disutility of effort; controllable parameter
; [P]-quantities - quantities for category P from {input, nature,
;                  labor} (orders for firm)
; [P]-exponents  - exponents in C-D production function for category P
;                  from {input, nature, labor}
; k              - alias for du
; S              - alias for ce
; A              - alias for cq
;
; GLOBALS
;
; lorenz-points       - along with GINI, used to measure income inequality
; gini-index-reserve  - along with Lorenz values, used to measure income inequality
; final-goods         - list of the economy's final goods (currently a
;                       numerical index)
; intermediate-inputs - list of the economy's intermediate goods
;                       (currently a numerical index)
; nature-types      - list of the economy's natural nature categories
;                       (currently a numerical index)
; labor-types         - list of the economy's labor nature categories
;                       (currently a numerical index)
; [P]-prices          - prices for category P from {final, input, nature,
;                       labor}
; [P]-surpluses       - surpluses for category P from {final, input,
;                       nature, labor}
; threshold-met?      - signals end of iterations once equilibrium is
;                       obtained
; experiment-number   - seed for random number generator; facilitates experimental reproduce-ability
; surplus-threshold   - interface value; the difference between values at which the model stops
;
;
;
; @PROCEDURES
;
; reset-prices           - part of setup
; standardize-prices     - interface item; sets prices to defaults
; randomize-prices       - uses experiment-number to seed random prices
; randomize-councils     - randomly changes experiment-number
; setup                  - standard procedure to set up agents and world, along with default variable values
; propose-c              - set proposed consumption quantities (demands)
; propose-f              - (deprecated) alias for produce-final-goods
; produce-final-goods    - updates the values for the final goods
; propose-i              - (deprecated) alias for produce-input-goods
; produce-input-goods    - updates the values for the input goods
; go                     - iterates (updates ticks) until the surplus threshold is met
; check-surpluses        - compares differences between each nature and good to the surplus-threshold value
; iterate-plan           - the heart of the model; invokes the planning/proposal procedures and updates the interface
; list-prices            - tuplifies prices
; round-prices           - rounds the prices
; color-ccs              - pretties agents
; color-wcs              - pretties agents
; plot-if-small [x]      - used in Quantity History graph
; update-lorenz-and-gini - @... ; borrowed from Uri Wilensky's SugarScape 3 Model in the Social Sciences library
; normalize-prices       - (obsolete)
;
;
;
; @REPORTERS
;
; x-sum                 - (obsolete)
; consumer-utility      - reports consumer utility
; GDP                   - the global sum of production
; final-demand [x]      - reports the given item from the final-demands tuple
; final-producers [x]   - reports the given item from the final-producers tuple
; input-producers [x]   - reports the given item from the input-producers tuple
; pf1s                  - reports the WCs for final good 1
; pf2s                  - reports the WCs for final good 2
; pfs                   - reports all final good WCs
; pi1s                  - reports the WCs for intermediate good 1
; pi2s                  - reports the WCs for intermediate good 2
; pis                   - reports all intermediate good WCs
; invoice               - one of four details for WC debugging @...
; productivity          - one of four details for WC debugging @...
; check-bounds [x]      - sets upper and lower bounds on the input
; labor-supply          - reports the sum of all workers in CCs
; pf1                   - reports the current prices of final good 1
; pf2                   - reports the current prices of final good 2
; pi1                   - reports the current prices of intermediate good 1
; pi2                   - reports the current prices of intermediate good 2
; pn                    - reports the current prices for the nature input
; pl                    - reports the current prices for the labor input
; gini                  - report the GINI
; gini-people           - used in GINI analysis
; gini-wealth           - used in GINI analysis
; input [x]             - (unused)
; nature [x]          - (unused)
; labor [x]             - (unused)
; final-surplus [x]     - reports the given item from the final-surplus tuple
; input-surplus [x]     - reports the given item from the input-surplus tuple
; nature-surplus [x]  - reports the given item from the nature-surplus tuple
; labor-surplus [x]     - reports the given item from the labor-surplus tuple
; final-price [x]       - reports the given item from the final-price tuple
; input-price [x]       - reports the given item from the input-price tuple
; nature-price [x]    - reports the given item from the nature-price tuple
; labor-price [x]       - reports the given item from the labor-price tuple
; input-quantity [x]    - reports the given item from the input-quantity tuple
; nature-quantity [x] - reports the given item from the nature-quantity tuple
; labor-quantity [x]    - reports the given item from the labor-quantity tuple
; input-exponent [x]    - reports the given item from the input-exponent tuple
; nature-exponent [x] - reports the given item from the nature-exponent tuple
; labor-exponent [x]    - reports the given item from the labor-exponent tuple
; effort-exponent       - creates alias for xe of WCs
; product-price         - allows WCs to find their own prices of outputs
; price-list            - tuplifies prices
; supply-list           - tuplifies economic input values
; demand-list           - tuplifies economic demand values
; surplus-list          - tuplifies economic surplus values
; percent-surplus-list  - reports the surplus:supply ratio as a percentage
; total-surplus         - reports the total surplus as the sum of all the surpluses
; space-list [listx]    - reduces the given listx tuple; used in interface reporters
; produce               - (obsolete)
; deltas                - (obsolete)
; normal-price-vector   - (obsolete)
;
;
;
; @INCLUDES
;
; price-adjustment.nls     - procedures: planning-bureau-3
; production-proposals.nls - procedures: produce-final-goods, produce-input-goods
;



__includes [ "proposal-assignment.nls"
             "price-adjustment.nls"
             "production-proposals.nls"

             "solution1.nls"
             "solution2.nls"
             "solution3.nls"
             "solution4.nls"
             "solution5.nls"
             "solution6.nls"
             "solution7.nls"
             "solution8.nls"
;             "solution9.nls"          ;;; odd solutions for effort are unusually long
             "solution10.nls"
;             "solution11.nls"         ;;; NetLogo parser cannot handle procedures of this length at present
             "solution12.nls"
              ]

breed [ccs cc]
breed [wcs wc]

ccs-own [ effort
          income
          cy
          num-workers
          final-demands
          utility-exponents ]

wcs-own [ industry
          production-inputs
          product
          effort
          ql
          output
          xe
          z
          x1
          x2
          x3
          x4
          x5
          x6
          x7
          x8
          x9
          x10
          x11
          x12
          c
          ef
          base-color
          cq
          ce
          du
          input-quantities
          nature-quantities
          labor-quantities
          input-exponents
          nature-exponents
          labor-exponents
          k
          S
          A ]

globals [ final-goods
          intermediate-inputs
          nature-types
          labor-types

          final-prices
          input-prices
          nature-prices
          labor-prices

          old-final-prices
          old-input-prices
          old-nature-prices
          old-labor-prices

          final-surpluses
          input-surpluses
          nature-surpluses
          labor-surpluses

          threshold-met?
          pdlist
          price-deltas
          delta-delay
          lorenz-points
          gini-index-reserve
        ]

to initialize-prices
  set final-prices (list)
  repeat finals [set final-prices lput init-final-price final-prices]
  set input-prices (list)
  repeat inputs [set input-prices lput init-intermediate-price input-prices]
  set nature-prices (list)
  repeat resources [set nature-prices lput init-nature-price nature-prices]
  set labor-prices (list)
  repeat labors [set labor-prices lput init-labor-price labor-prices]
  set price-deltas (list 0.05 0.05 0.05 0.05)
  set pdlist (list)
  let pp 0
  while [pp < sum (list finals inputs resources labors)] [ set pdlist lput 0.05 pdlist set pp pp + 1]
end

to standardize-prices
  set init-final-price 80
  set init-intermediate-price 80
  set init-nature-price 80
  set init-labor-price 80
end

to randomize-prices
  set init-final-price 40 + random 40
  set init-intermediate-price 40 + random 60
  set init-nature-price 30 + random 30
  set init-labor-price 30 + random 30
end

to randomize-councils
  set experiment-number random 99999
end

to setup
  ca
  random-seed experiment-number ;; facilitates reproduction of results

  initialize-prices

  set price-delta 0.1
  set delta-delay 5

  set threshold-met? false

  set final-goods (list)
  let fg 0
  while [finals > fg] [
    set fg fg + 1
    set final-goods lput fg final-goods
  ]

  set intermediate-inputs (list)
  let ii 0
  while [inputs > ii] [
    set ii ii + 1
    set intermediate-inputs lput ii intermediate-inputs
  ]

  set nature-types (list)
  let rr 0
  while [resources > rr] [
    set rr rr + 1
    set nature-types lput rr nature-types
  ]

  set labor-types (list)
  let ll 0
  while [labors > ll] [
    set ll ll + 1
    set labor-types lput ll labor-types
  ]

  set final-surpluses (list)
  set input-surpluses (list)
  set nature-surpluses (list)
  set labor-surpluses (list)

  create-ccs consumer-councils [
    set num-workers workers-per-council
    set effort 1
    set income 500 * effort * num-workers

    set cy (6 + random-float 9)
    set utility-exponents (list)
    let cz .5 / finals
    repeat finals [ set utility-exponents lput (cz + random-float cz) utility-exponents ]
    set final-demands (list 0 0 0 0 0)

    set size 0.5 + (log num-workers 10)
    set color yellow
    set shape "house"
    move-house
  ]

  foreach final-goods [ create-wcs (worker-councils / 2) / length final-goods [ set industry 0 set product ? set base-color (55 + 10 * product) ] ]
  foreach intermediate-inputs [ create-wcs (worker-councils / 2) / length intermediate-inputs [ set industry 1 set product ? set base-color (5 + 10 * product) ] ]

  ask wcs [
    set xcor random-pxcor
    set ycor max list min-pycor (6 + industry * -10 + product * -2)
    set shape "factory"
    set color base-color


    let l1 (n-of (one-of intermediate-inputs) intermediate-inputs)
    let l2 (n-of (one-of nature-types) nature-types)
    let l3 (n-of (one-of labor-types) labor-types)

    set production-inputs (list l1 l2 l3 )
    if input-count = 9 [ set l1 remove one-of l1 l1 set production-inputs (list l1 l2 l3) ]             ;;change 9's to 8's
    if input-count = 11 [ set l1 remove one-of l1 l1 set production-inputs (list l1 l2 l3) ]           ;;change 11's to 10's


    set xe .05
    set c xe


    set input-exponents (list)
    if length item 0 production-inputs > 0 [
      let xz .2 / length item 0 production-inputs
      foreach item 0 production-inputs [ set input-exponents lput (xz + random-float xz) input-exponents ]
    ]

    set nature-exponents (list)
    let rz .1 / length item 1 production-inputs
    foreach item 1 production-inputs [ set nature-exponents lput (0.05 + rz + random-float rz) nature-exponents ]

    set labor-exponents (list)
    let lz .1 / length item 2 production-inputs
    foreach item 2 production-inputs [ set labor-exponents lput (0.05 + lz + random-float lz) labor-exponents ]

    set cq cq-init ;7
    set ce ce-init ;1
    set du du-init ;.25

    set k du
    set S ce
    set A cq

    set effort .5
    set output 0

    set labor-quantities (list ql)
  ]

  update-lorenz-and-gini
  reset-ticks
end

to-report unit-width
  report world-width / (consumer-councils + 1)
end

to move-house
  set xcor min-pxcor + (unit-width * who)
  set ycor min list max-pycor cy
end

to-report x-sum
  report sum (list sum input-exponents sum nature-exponents sum labor-exponents)
end

to-report consumer-utility
  let util-list (list)
  foreach final-goods [
    let fq ( final-demand ? ) ^ (utility-exponent ? )
    set util-list lput fq util-list
  ]
  report cy * (reduce * util-list)
end

to-report GDP
  report sum map [ final-price ? * sum [output] of final-producers ? ] final-goods
end

;;; wc reporter for number of inputs to production function (x's)
to-report input-count
  report length (sentence item 0 production-inputs item 1 production-inputs item 2 production-inputs)
end

to-report utility-exponent [x]
  report item (x - 1) utility-exponents
end

to consume
  set final-demands (list)
  foreach final-goods [
    let fq ( (utility-exponent ? * income) / (sum utility-exponents * final-price ?) )
    set final-demands lput fq final-demands  ;;(50 * fq) final-demands
  ]
end

to proposal [ pc ]
  let p [input-count] of pc
  if p = 1 [ produce-1 pc ]
  if p = 2 [ produce-2 pc ]
  if p = 3 [ produce-3 pc ]
  if p = 4 [ produce-4 pc ]
  if p = 5 [ produce-5 pc ]
  if p = 6 [ produce-6 pc ]
  if p = 7 [ produce-7 pc ]
  if p = 8 [ produce-8 pc ]
  if p = 10 [ produce-10 pc ]
  if p = 12 [ produce-12 pc ]
end

to go
  iterate-plan
  update-lorenz-and-gini
  check-surpluses
  if threshold-met? [stop ]
  if total-surplus < (100) and delta-delay <= 0 [lower-delta]
  if total-surplus > (100000) and delta-delay <= 0 [raise-delta]
  if delta-delay > 0 [set delta-delay delta-delay - 1]
  record-prices
  tick
end

to record-prices
  set old-final-prices final-prices
  set old-input-prices input-prices
  set old-nature-prices nature-prices
  set old-labor-prices labor-prices
end

to raise-delta
    set price-delta precision min (list 0.1 (price-delta + 0.01)) 2
    set delta-delay 10
end

to lower-delta
  set price-delta precision max (list 0.01 (price-delta - 0.01)) 2
  set delta-delay 5
end

to iterate-plan
  ask wcs [ proposal self ]
  ask ccs [consume]
  color-wcs
  color-ccs
  planning-bureau
  set price-deltas (list price-change 0 price-change 1 price-change 2 price-change 3)
  set pdlist (list)
  let pp 0
  while [pp < sum (list finals inputs resources labors)] [ set pdlist lput other-price-change pp pdlist set pp pp + 1]
end

to check-surpluses
  set threshold-met? true
  foreach final-goods [
    let I ?
    if abs final-surplus I > (surplus-threshold * sum [output] of final-producers I) [set threshold-met? false]
  ]
  foreach intermediate-inputs [
    let I ?
    if abs input-surplus I > (surplus-threshold * sum [output] of input-producers I) [set threshold-met? false]
  ]
  foreach nature-types [
    let I ?
    if abs nature-surplus I > (surplus-threshold * natural-resources-supply) [set threshold-met? false]
  ]
  foreach labor-types [
    let I ?
    if abs labor-surplus I > (surplus-threshold * labor-supply) [set threshold-met? false]
  ]
end

to-report mean-utility
  report mean [consumer-utility] of ccs
end

to-report final-demand [x]
  report item (x - 1) final-demands
end

to-report final-producers [x]
  report wcs with [industry = 0 and product = x]
end

to-report input-producers [x]
  report wcs with [industry = 1 and product = x]
end

to-report pfs
  report wcs with [industry = 0]
end

to-report pis
  report wcs with [industry = 1]
end

to-report productivity
  let plist [ ]
  foreach (sentence input-exponents nature-exponents labor-exponents) [set plist lput precision ? 3 plist]
  report plist
end

to color-ccs
  ask ccs [
    set color scale-color yellow consumer-utility 0 150
  ]
end

to color-wcs
  ask wcs [
    set color base-color - 1 + log check-bounds effort 10
    set size 1 + log check-bounds (labor-quantity 1) 10
  ]
end

to-report check-bounds [x]
  if x > 10000 [report 10000]
  ifelse x <= 0.0001 [report .0001][report x]
end

to plot-if-small [x]
  if x < 100000 [plot x]
end

to-report labor-supply
  report sum [num-workers] of ccs
end

to-report gini
  report (gini-index-reserve / count gini-people) * 2
end

to-report gini-people
  report ccs
end

to-report gini-wealth
  report consumer-utility
end

to update-lorenz-and-gini
  let num-people count gini-people
  let sorted-wealths sort [gini-wealth] of gini-people
  let total-wealth sum sorted-wealths
  if total-wealth > 0 [
    let wealth-sum-so-far 0
    let index 0
    set gini-index-reserve 0
    set lorenz-points []
    repeat num-people [
      set wealth-sum-so-far (wealth-sum-so-far + item index sorted-wealths)
      set lorenz-points lput ((wealth-sum-so-far / total-wealth) * 100) lorenz-points
      set index (index + 1)
      set gini-index-reserve
        gini-index-reserve +
        (index / num-people) -
        (wealth-sum-so-far / total-wealth)
    ]
  ]
end

to-report input [x]
  report item x input-quantities
end

to-report nature [x]
  report item x nature-quantities
end

to-report labor [x]
  report item x labor-quantities
end

to-report final-surplus [x]
  report item (x - 1) final-surpluses
end

to-report input-surplus [x]
  report item (x - 1) input-surpluses
end

to-report nature-surplus [x]
  report item (x - 1) nature-surpluses
end

to-report labor-surplus [x]
  report item (x - 1) labor-surpluses
end

to-report final-price [x]
  report item (x - 1) final-prices
end

to-report input-price [x]
  report item (x - 1) input-prices
end

to-report nature-price [x]
  report item (x - 1) nature-prices
end

to-report labor-price [x]
  report item (x - 1) labor-prices

end

to-report input-quantity [x]
  report item (x - 1) input-quantities
end

to-report nature-quantity [x]
  report item (x - 1) nature-quantities
end

to-report labor-quantity [x]
  report item (x - 1) labor-quantities
end

to-report input-exponent [x]
  report item (x - 1) input-exponents
end

to-report nature-exponent [x]
  report item (x - 1) nature-exponents
end

to-report labor-exponent [x]
  report item (x - 1) labor-exponents
end

to-report effort-exponent
  report xe
end

to-report product-price
  if industry = 0 [report final-price product]
  if industry = 1 [report input-price product]
end

to-report price-list
  report (list final-prices input-prices nature-prices labor-prices )
end
to-report surplus-list
  report (list final-surpluses input-surpluses nature-surpluses labor-surpluses )
end

to-report percent-surplus-list
  report (map [100 * ?1 / ?2] reduce sentence surplus-list reduce sentence supply-list)
end

to-report total-surplus
  report sum map abs reduce sentence surplus-list
end

to-report supply-list
  report (list map [ sum [output] of final-producers ? ] final-goods
               map [ sum [output] of input-producers ? ] intermediate-inputs
               map [ natural-resources-supply ] nature-types
               map [ labor-supply ] labor-types )
end

to-report final-demand-list
  report map [ sum [final-demand ?] of ccs ] final-goods
end

to-report input-demand-list
  report map [ sum [input-quantity (1 + position ? item 0 production-inputs)] of wcs with [member? ? item 0 production-inputs] ] intermediate-inputs
end

to-report nature-demand-list
  report map [ sum [nature-quantity (1 + position ? item 1 production-inputs)] of wcs with [member? ? item 1 production-inputs] ] nature-types
end

to-report labor-demand-list
  report map [ sum [labor-quantity (1 + position ? item 2 production-inputs)] of wcs with [member? ? item 2 production-inputs] ] labor-types
end

to-report demand-list
  report (list map [ sum [final-demand ?] of ccs ] final-goods
               map [ sum [input-quantity (1 + position ? item 0 production-inputs)] of wcs with [member? ? item 0 production-inputs] ] intermediate-inputs
               map [ sum [nature-quantity (1 + position ? item 1 production-inputs)] of wcs with [member? ? item 1 production-inputs] ] nature-types
               map [ sum [labor-quantity (1 + position ? item 2 production-inputs)] of wcs with [member? ? item 2 production-inputs] ] labor-types )
end

to-report space-list [somelist]
  report butlast reduce sentence map [(list ? "        ")] somelist
end

to-report total-produced
  ifelse industry = 0
    [report cq * (input-quantity 1 ^ input-exponent 1) * (input-quantity 2 ^ input-exponent 2) * (nature-quantity 1 ^ nature-exponent 1) * (labor-quantity 1 ^ labor-exponent 1) * (effort ^ xe)]
    [report cq * (nature-quantity 1 ^ nature-exponent 1) * (labor-quantity 1 ^ labor-exponent 1) * (effort ^ xe)]
end
@#$#@#$#@
GRAPHICS-WINDOW
14
105
453
565
16
16
13.0
1
10
1
1
1
0
0
0
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
33
22
177
55
NIL
setup
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

PLOT
1124
607
1421
727
labor distribution (wcs)
NIL
NIL
0.0
500.0
0.0
10.0
false
false
"" ""
PENS
"pen-1" 10.0 1 -13840069 true "" "histogram [labor-quantity 1] of final-producers 1"
"pen-2" 10.0 1 -13345367 true "" "histogram [labor-quantity 1] of final-producers 2"
"pen-3" 10.0 1 -2674135 true "" "histogram [labor-quantity 1] of input-producers 1"
"pen-4" 10.0 1 -955883 true "" "histogram [labor-quantity 1] of input-producers 2"
"pen-5" 10.0 1 -7500403 true "" "histogram [labor-quantity 1] of wcs"

BUTTON
33
62
102
95
NIL
go
T
1
T
OBSERVER
NIL
F
NIL
NIL
0

MONITOR
894
159
1142
204
GDP / "wage-rate" (real labor product)
GDP / mean labor-prices
2
1
11

BUTTON
201
23
322
56
NIL
randomize-prices
NIL
1
T
OBSERVER
NIL
W
NIL
NIL
1

PLOT
1240
184
1488
304
price history
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -10899396 true "" "plot final-price 1"
"pen-1" 1.0 0 -13345367 true "" "plot final-price 2"
"pen-2" 1.0 0 -2674135 true "" "plot input-price 1"
"pen-3" 1.0 0 -955883 true "" "plot input-price 2"
"pen-4" 1.0 0 -6459832 true "" "plot nature-price 1"
"pen-5" 1.0 0 -1184463 true "" "plot labor-price 1"

PLOT
1240
308
1487
428
quantity history
NIL
NIL
0.0
10.0
0.0
2000.0
true
false
"" ""
PENS
"default" 1.0 0 -10899396 true "" "plot-if-small sum [output] of final-producers 1"
"pen-1" 1.0 0 -13345367 true "" "plot-if-small sum [output] of final-producers 2"
"pen-2" 1.0 0 -2674135 true "" "plot-if-small sum [output] of input-producers 1"
"pen-3" 1.0 0 -955883 true "" "plot-if-small sum [output] of input-producers 2"

INPUTBOX
464
211
558
271
init-final-price
100
1
0
Number

INPUTBOX
811
211
903
271
init-labor-price
150
1
0
Number

INPUTBOX
570
211
702
271
init-intermediate-price
100
1
0
Number

INPUTBOX
712
211
812
271
init-nature-price
150
1
0
Number

INPUTBOX
629
77
770
137
natural-resources-supply
1000
1
0
Number

SLIDER
483
147
656
180
workers-per-council
workers-per-council
1
100
10
1
1
NIL
HORIZONTAL

MONITOR
463
648
768
693
NIL
[productivity] of wc viewing
17
1
11

SLIDER
130
622
163
772
du-init
du-init
1
10
2
.25
1
NIL
VERTICAL

SLIDER
36
621
69
771
cq-init
cq-init
1
50
10
1
1
NIL
VERTICAL

SLIDER
83
621
116
771
ce-init
ce-init
1
10
1
.25
1
NIL
VERTICAL

PLOT
826
608
1123
728
effort distribution (wcs)
NIL
NIL
0.0
50.0
0.0
25.0
false
false
"" ""
PENS
"default" 2.5 1 -16777216 true "" "histogram [ effort ] of wcs"

BUTTON
1019
729
1121
762
show effort
foreach (list pfs pis) [show sort [precision effort 2] of ?]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1124
728
1224
761
show labor
foreach (list pfs pis) [show sort [precision ql 2] of ?]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
1238
480
1430
600
mean consumer utility
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot mean-utility"

PLOT
1488
49
1681
169
consumer utility distribution
NIL
NIL
0.0
200.0
0.0
10.0
false
false
"" ""
PENS
"default" 2.0 1 -16777216 true "" "histogram [consumer-utility] of ccs"

PLOT
1494
185
1685
305
lorenz
NIL
NIL
0.0
100.0
0.0
100.0
false
false
"" ""
PENS
"default" 100.0 0 -16777216 true "plot 0\nplot 100" ""
"pen-1" 1.0 0 -7500403 true "" "plot-pen-reset\ncarefully [set-plot-pen-interval 100 / count gini-people][set-plot-pen-interval 100]\nplot 0\ncarefully [foreach lorenz-points plot] [ ]"

PLOT
1494
305
1685
425
gini
NIL
NIL
0.0
10.0
0.0
1.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "carefully [plot (gini-index-reserve / count gini-people) * 2][plot gini-index-reserve * 2]"

MONITOR
1565
309
1622
354
NIL
gini
4
1
11

INPUTBOX
484
17
605
77
experiment-number
1
1
0
Number

MONITOR
947
77
1065
122
NIL
total-surplus
3
1
11

BUTTON
329
23
463
56
NIL
randomize-councils
NIL
1
T
OBSERVER
NIL
R
NIL
NIL
1

INPUTBOX
831
12
935
72
surplus-threshold
0.02
1
0
Number

INPUTBOX
830
73
934
133
price-delta
0.1
1
0
Number

MONITOR
1239
436
1457
481
NIL
mean-utility
2
1
11

BUTTON
201
61
322
94
NIL
standardize-prices
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
1

BUTTON
330
61
462
94
current-prices
set init-final-price final-price 1\nset init-intermediate-price input-price 1\nset init-nature-price nature-price 1\nset init-labor-price labor-price 1
NIL
1
T
OBSERVER
NIL
C
NIL
NIL
1

MONITOR
803
728
1016
773
NIL
sort [precision effort 2] of wcs
17
1
11

MONITOR
457
693
762
738
NIL
[input-quantities] of wc viewing
3
1
11

MONITOR
952
18
1018
63
NIL
threshold-met?
17
1
11

TEXTBOX
52
600
160
618
A             S             k
11
0.0
1

MONITOR
472
299
1216
344
price list
space-list map [precision ? 2] reduce sentence price-list
17
1
11

MONITOR
473
455
1215
500
surplus list
space-list map [precision ? 2] reduce sentence surplus-list
17
1
11

MONITOR
473
402
1216
447
demand list
space-list map [precision ? 2] reduce sentence demand-list
17
1
11

MONITOR
473
355
1216
400
supply list
space-list map [precision ? 2] reduce sentence supply-list
17
1
11

MONITOR
473
503
1215
548
percent surpluses
space-list map [precision ? 2] percent-surplus-list
17
1
11

TEXTBOX
469
277
886
295
final goods                intermediate inputs            natural resources        labor
11
0.0
1

MONITOR
484
90
604
135
NIL
labor-supply
17
1
11

MONITOR
770
159
895
204
GDP per consum. co.
GDP / count ccs
2
1
11

INPUTBOX
628
16
771
76
consumer-councils
100
1
0
Number

INPUTBOX
200
679
355
739
viewing
101
1
0
Number

BUTTON
114
62
177
95
step
go
NIL
1
T
OBSERVER
NIL
G
NIL
NIL
1

TEXTBOX
787
25
830
123
stop when?\n\n\nrate of adjustment
11
0.0
1

TEXTBOX
746
141
930
162
final consumption goods product
11
0.0
1

MONITOR
669
159
769
204
GDP per worker
GDP / labor-supply
2
1
11

MONITOR
655
593
765
638
NIL
[sum productivity] of wc viewing
3
1
11

PLOT
1026
142
1218
262
price-delta
NIL
NIL
0.0
10.0
0.0
0.1
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot price-delta"
"pen-1" 1.0 0 -7500403 true "" "plot 0.05"

PLOT
1026
20
1219
140
total surplus
NIL
NIL
0.0
50.0
0.0
300.0
false
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot total-surplus"

SLIDER
1249
19
1353
52
finals
finals
2
5
4
1
1
NIL
HORIZONTAL

SLIDER
1248
57
1353
90
inputs
inputs
2
5
4
1
1
NIL
HORIZONTAL

SLIDER
1248
97
1353
130
resources
resources
1
5
1
1
1
NIL
HORIZONTAL

SLIDER
1248
137
1352
170
labors
labors
1
5
1
1
1
NIL
HORIZONTAL

INPUTBOX
1371
21
1473
81
worker-councils
80
1
0
Number

MONITOR
373
641
446
686
inputs
[item 0 production-inputs] of wc viewing
17
1
11

MONITOR
373
685
448
730
resources
[item 1 production-inputs] of wc viewing
17
1
11

MONITOR
375
732
432
777
labors
[item 2 production-inputs] of wc viewing
17
1
11

MONITOR
456
737
541
782
input count
[input-count] of wc viewing
17
1
11

MONITOR
1239
731
1502
776
price-deltas
map [precision ? 3] price-deltas
3
1
11

BUTTON
479
598
638
631
boost labor productivity
ask wcs [set labor-exponents (list (0.01 + item 0 labor-exponents)) ]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
915
224
1019
257
set init prices
set init-final-price round mean map [5 * (round (? / 5))] final-prices\nset init-intermediate-price round mean map [5 * (round (? / 5))] input-prices\nset init-nature-price round mean map [5 * (round (? / 5))] nature-prices\nset init-labor-price round mean map [5 * (round (? / 5))] labor-prices
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
1432
486
1653
606
input-count of worker councils
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "" "histogram [input-count] of wcs"

PLOT
1426
609
1659
729
output distribution
NIL
NIL
0.0
200.0
0.0
20.0
false
false
"" ""
PENS
"default" 5.0 1 -16777216 true "" "histogram [output] of wcs"

@#$#@#$#@
## WHAT IS IT?

This Netlogo model--the Participatory Planning Procedure Prototype (PPPP, AKA _Pequod_)--is a feasibility study for an aspect of participatory economics, which requires participatory economic planning in iterations between councils composed of workers and councils composed of consumers. These councils are the agents of the system. Factory icons represent worker councils and house icons represent consumer councils.

Participatory economics is a model for a new economy based on democracy, justice, and ecological sustainability proposed as an alternative to current Western economic systems. For an introduction to the primary concepts of participatory economics, see [ParticipatoryEconomics.info](http://participatoryeconomics.info), which provides free e-books and other informational materials.

Macroscopic aspects of this Netlogo model are documented here. The variables, procedures, and reporters of the model are individually documented in the Code tab. A number of BehaviorSpace experiments have also been configured, which are documented in the section _How to Use It_.

EDIT: A non-competitive market model can reach the same Equilibrium prices in a reasonable number of iterations. [convergence, BS exp's...] [rosenbrach search method...a heuristic search method to solution...heuristic optimization]

## HOW IT WORKS

### Background Microeconomic Theory

Some knowledge of microeconomics is necessary in order to explore participatory economic planning with the model, but some basics are explained here.

Economic production is quantified by supply, and economic consumption is quantified by demand. When there is an imbalance between these, there is said to be a surplus. An important activity of economic planning is _quickly_ reducing surplus. Commonly in economic literature these quantities are calculated using the Cobb-Douglas production/utility functions. For supply the production function is used and for demand the utility function is used. Each has the same general form, which is

<center>Quantity = A(Input<sub>1</sub><sup>Elasticity<sub>1</sub></sup> * Input<sub>2</sub><sup>Elasticity<sub>2</sub></sup> * ... * Input<sub>N</sub><sup>Elasticity<sub>N</sub></sup>),</center>

where A represents the total factor of productivity or utility, the inputs are things like resources, and the elasticities measure the responsiveness of the total quantity to a change in levels of each input quantity, which facilitates fine-tuning of unique outcomes for each economic agent.

Supply and demand are normally represented graphically as curves of prices with respect to quantities.

### The Model

This Netlogo model centers around planning iterations, with the goal of quickly reducing surplus by matching supply and demand of consumer goods. Worker and consumer councils make proposals concerning what they want to produce and consume, based upon current estimates of opportunity and social costs as shown by the indicative prices for each good. The indicative prices are adjusted between each iteration, and the iterations stop when demand is within a configurable threshold of the supply for each economic category (industries, resources, etc.). Though not a part of this Netlogo model, the authors assume a yearly planning cycle will occur if this planning model is implemented in a real economy. For example, the planning process modeled could occur within the month of December for use starting in January for that year.

#### Technical notes

Requiring exact equality between supply and demand is unnecessary because the next year's plan is assumed to begin with parameters resulting in an initial divergence, though the initial price vector should be very similar to that reached during the prior planning cycle.

The solutions to the production and utility functions are obtained analytically with a computer algebra system, and then added to the included file production-proposals.nls.

## HOW TO USE IT

### Graphs

The most important aspects of the interface are the graphs of price and quantity histories. If/when the surplus threshold is reached and the iterations stop, the number of iterations is the primary quantity of interest, followed by the shape of the graph that led to that equilibrium state. Following convergence, the particular values of each category at which equilibrium was reached are given in the middle of the interface, below the parameter controls.

### Control Parameters

The model contains more parameters than are accessible in the interface, each of which is documented at the top of the Code tab. The controllable parameters of primary interest to researchers in the model's current state are those in the middle of the interface. At the bottom of the interface are parameters of interest in exploring performance enhancements, or for debugging purposes.

#### Surplus threshold

This is the threshold, as the ratio of supply to demand, at or under which the model will cease iteration. Default: 1%.

#### Price delta

This moderates the rate at which price adjustments are made. Default: 10%.

#### Initial price vector

This is the list of starting prices for each input quantity.

#### Experiment number

This facilitates pseudo-randomization of the initial conditions affecting model behavior and heterogeneity of agents, which facilitates replication of results. That is, _all else being equal_, different experiment numbers produce different behavior, and running the model with the same experiment number will always produce the same behavior, allowing interesting behavior to be further explored and shared with colleagues. If you wish to explore the same initial conditions for varying populations, leave all but the experiment constant, and if you wish to explore changing parameters within the same population, change anything but the experiment.

#### Workers per council

This is the number of units of labor supplied to the general labor supply by each consumer council. The labor-supply reporter reflects this as the arithmetic product of this and the number of consumer councils.

#### Natural resources supply

This is the quantity of one input to the production functions, a hypothetical natural resource. Default: 1000.

### BehaviorSpace Experiments

By going to Tools > BehaviorSpace, users will find a number of per-configured experiments that can be executed to explore the dynamics of the model under specific initial conditions. The results are tabulated for analysis.

## THINGS TO NOTICE

### Number of Ticks/Iterations

Reducing the number of ticks, which correspond to iterations in council negotiations, is a primary objective of model experiments. The authors suggest that approximately seven ticks is a maximum, which makes the processes feasible for human activity. When exploring the model, take note of what parameter combinations result in the smallest number of ticks.

### Price/Quantity Dynamics

As time progresses, the price and quantity values change in classifiable patterns. Take note of what gives rise to classes of dynamics, and look for new classes of dynamics.

## THINGS TO TRY

### Control Parameters

Though any parameter can be modified, and the outcome dynamics explored, three parameters are of primary interest in exploring paths to rapid convergence of supply and demand.

#### Surplus threshold

This value has been found to be inversely proportional to the number of ticks to "convergence", but it must be decided what distances between supply and demand are acceptable.

#### Price delta

This value has been found to be inversely proportional to the number of ticks to convergence, but beyond a certain increasing value of the parameter, it is directly proportional to the number of ticks to convergence. Therefore, for any given experiment there exists an optimal delta, which leads to convergence in the fewest number of iterations. Current experimental results suggests that the optimal range is between 0.05 and 0.15.

#### Initial price vector

As expected, for any given set of initial conditions, as these values approach the converging price vector, fewer ticks are needed to reach that converging set of values.

## EXTENDING THE MODEL

The immediate objectives of the research team are to

* increase the number of councils,

* increase the number of produced goods and add public goods,

* increase the categories of labor,

* increase the number of primary resources,

* relax convexity conditions on the production and utility functions, which is to allow the exponents to sum to a number greater than one,

* add pollutants/externalities,

* and to create a set of protocols for more meaningful BehaviorSpace experiments.

## CREDITS AND REFERENCES

This model is based upon the work of Robin Hahnel and Michael Albert on participatory economics. Along with Robin Hahnel, the researchers developing the model's conceptual and computational aspects are Michael Weisdorf, Christan Echt, and Nick Gilla.

The model can be shared and modified under the terms of the GPL version 3. The code can be downloaded from and changes submitted to its [Github repository](https://github.com/ParticipatoryEconomics/pequod).

[ParticipatoryEconomics.info](http://participatoryeconomics.info) provides free e-books and other informational materials on participatory economics.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

factory
false
0
Rectangle -7500403 true true 76 194 285 270
Rectangle -7500403 true true 36 95 59 231
Rectangle -16777216 true false 90 210 270 240
Line -7500403 true 90 195 90 255
Line -7500403 true 120 195 120 255
Line -7500403 true 150 195 150 240
Line -7500403 true 180 195 180 255
Line -7500403 true 210 210 210 240
Line -7500403 true 240 210 240 240
Line -7500403 true 90 225 270 225
Circle -1 true false 37 73 32
Circle -1 true false 55 38 54
Circle -1 true false 96 21 42
Circle -1 true false 105 40 32
Circle -1 true false 129 19 42
Rectangle -7500403 true true 14 228 78 270

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.3.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="price-experiment" repetitions="50" runMetricsEveryStep="false">
    <setup>randomize-prices
setup</setup>
    <go>go</go>
    <metric>final-price 1</metric>
    <metric>final-price 2</metric>
    <metric>input-price 1</metric>
    <metric>input-price 2</metric>
    <metric>resource-price 1</metric>
    <metric>labor-price 1</metric>
    <metric>GDP</metric>
    <metric>mean [consumer-utility] of ccs</metric>
    <metric>gini</metric>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f2">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="experiment-number">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="100"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="council-experiment" repetitions="50" runMetricsEveryStep="false">
    <setup>standardize-prices
randomize-councils
setup</setup>
    <go>go</go>
    <timeLimit steps="3000"/>
    <metric>final-price 1</metric>
    <metric>final-price 2</metric>
    <metric>input-price 1</metric>
    <metric>input-price 2</metric>
    <metric>resource-price 1</metric>
    <metric>labor-price 1</metric>
    <metric>GDP</metric>
    <metric>mean [consumer-utility] of ccs</metric>
    <metric>gini</metric>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f2">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="experiment-number">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="100"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="price-delta experiment" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>final-price 1</metric>
    <metric>final-price 2</metric>
    <metric>input-price 1</metric>
    <metric>input-price 2</metric>
    <metric>resource-price 1</metric>
    <metric>labor-price 1</metric>
    <metric>GDP</metric>
    <metric>mean [consumer-utility] of ccs</metric>
    <metric>gini</metric>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f2">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.01"/>
      <value value="0.02"/>
      <value value="0.03"/>
      <value value="0.04"/>
      <value value="0.05"/>
      <value value="0.06"/>
      <value value="0.07"/>
      <value value="0.08"/>
      <value value="0.09"/>
      <value value="0.1"/>
      <value value="0.11"/>
      <value value="0.12"/>
      <value value="0.13"/>
      <value value="0.14"/>
      <value value="0.15"/>
      <value value="0.16"/>
      <value value="0.17"/>
      <value value="0.18"/>
      <value value="0.19"/>
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="experiment-number">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="100"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="new-councils-experiment-05" repetitions="500" runMetricsEveryStep="false">
    <setup>randomize-councils
setup</setup>
    <go>go</go>
    <timeLimit steps="3000"/>
    <metric>final-price 1</metric>
    <metric>final-price 2</metric>
    <metric>input-price 1</metric>
    <metric>input-price 2</metric>
    <metric>resource-price 1</metric>
    <metric>labor-price 1</metric>
    <metric>sum [output] of final-producers 1</metric>
    <metric>sum [output] of final-producers 2</metric>
    <metric>sum [output] of input-producers 1</metric>
    <metric>sum [output] of input-producers 2</metric>
    <metric>GDP</metric>
    <metric>mean [consumer-utility] of ccs</metric>
    <metric>gini</metric>
    <enumeratedValueSet variable="experiment-number">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f2">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="114"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="114"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="new-price-delta-experiment" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="3000"/>
    <metric>final-price 1</metric>
    <metric>final-price 2</metric>
    <metric>input-price 1</metric>
    <metric>input-price 2</metric>
    <metric>resource-price 1</metric>
    <metric>labor-price 1</metric>
    <metric>sum [output] of final-producers 1</metric>
    <metric>sum [output] of final-producers 2</metric>
    <metric>sum [output] of input-producers 1</metric>
    <metric>sum [output] of input-producers 2</metric>
    <metric>GDP</metric>
    <metric>mean [consumer-utility] of ccs</metric>
    <metric>gini</metric>
    <enumeratedValueSet variable="experiment-number">
      <value value="99434"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.01"/>
      <value value="0.02"/>
      <value value="0.03"/>
      <value value="0.04"/>
      <value value="0.05"/>
      <value value="0.06"/>
      <value value="0.07"/>
      <value value="0.08"/>
      <value value="0.09"/>
      <value value="0.1"/>
      <value value="0.11"/>
      <value value="0.12"/>
      <value value="0.13"/>
      <value value="0.14"/>
      <value value="0.15"/>
      <value value="0.16"/>
      <value value="0.17"/>
      <value value="0.18"/>
      <value value="0.19"/>
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f2">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="114"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="114"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="big-experiment" repetitions="10000" runMetricsEveryStep="false">
    <setup>set experiment-number behaviorspace-run-number
setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>final-price 1</metric>
    <metric>final-price 2</metric>
    <metric>input-price 1</metric>
    <metric>input-price 2</metric>
    <metric>resource-price 1</metric>
    <metric>labor-price 1</metric>
    <metric>sum [output] of final-producers 1</metric>
    <metric>sum [output] of final-producers 2</metric>
    <metric>sum [output] of input-producers 1</metric>
    <metric>sum [output] of input-producers 2</metric>
    <metric>GDP</metric>
    <metric>mean [consumer-utility] of ccs</metric>
    <metric>gini</metric>
    <enumeratedValueSet variable="experiment-number">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f2">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="42"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="107"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="114"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="114"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="mean-price-experiment-05" repetitions="100" runMetricsEveryStep="false">
    <setup>randomize-councils
setup</setup>
    <go>go</go>
    <timeLimit steps="2000"/>
    <metric>final-price 1</metric>
    <metric>final-price 2</metric>
    <metric>input-price 1</metric>
    <metric>input-price 2</metric>
    <metric>resource-price 1</metric>
    <metric>labor-price 1</metric>
    <metric>sum [output] of final-producers 1</metric>
    <metric>sum [output] of final-producers 2</metric>
    <metric>sum [output] of input-producers 1</metric>
    <metric>sum [output] of input-producers 2</metric>
    <metric>GDP</metric>
    <metric>mean [consumer-utility] of ccs</metric>
    <metric>gini</metric>
    <enumeratedValueSet variable="experiment-number">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.05"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f2">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="120"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="120"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="consumer-experiment" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>final-price 1</metric>
    <metric>final-price 2</metric>
    <metric>input-price 1</metric>
    <metric>input-price 2</metric>
    <metric>resource-price 1</metric>
    <metric>labor-price 1</metric>
    <metric>sum [output] of final-producers 1</metric>
    <metric>sum [output] of final-producers 2</metric>
    <metric>sum [output] of input-producers 1</metric>
    <metric>sum [output] of input-producers 2</metric>
    <metric>GDP</metric>
    <metric>mean [consumer-utility] of ccs</metric>
    <metric>gini</metric>
    <enumeratedValueSet variable="experiment-number">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f2">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="50"/>
      <value value="60"/>
      <value value="70"/>
      <value value="80"/>
      <value value="90"/>
      <value value="100"/>
      <value value="110"/>
      <value value="120"/>
      <value value="130"/>
      <value value="140"/>
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="120"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="120"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="new councils experiment 05 mark 2" repetitions="100" runMetricsEveryStep="false">
    <setup>randomize-councils
setup</setup>
    <go>go</go>
    <timeLimit steps="2500"/>
    <metric>final-price 1</metric>
    <metric>final-price 2</metric>
    <metric>input-price 1</metric>
    <metric>input-price 2</metric>
    <metric>resource-price 1</metric>
    <metric>labor-price 1</metric>
    <metric>sum [output] of final-producers 1</metric>
    <metric>sum [output] of final-producers 2</metric>
    <metric>sum [output] of input-producers 1</metric>
    <metric>sum [output] of input-producers 2</metric>
    <metric>GDP</metric>
    <metric>mean [consumer-utility] of ccs</metric>
    <metric>gini</metric>
    <enumeratedValueSet variable="init-price-f2">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.05"/>
      <value value="0.07"/>
      <value value="0.09"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="103"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="120"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="experiment-number">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="120"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="mod-councils-experiment" repetitions="1000" runMetricsEveryStep="false">
    <setup>randomize-councils
setup</setup>
    <go>go</go>
    <timeLimit steps="2000"/>
    <metric>final-price 1</metric>
    <metric>final-price 2</metric>
    <metric>input-price 1</metric>
    <metric>input-price 2</metric>
    <metric>resource-price 1</metric>
    <metric>labor-price 1</metric>
    <metric>sum [output] of final-producers 1</metric>
    <metric>sum [output] of final-producers 2</metric>
    <metric>sum [output] of input-producers 1</metric>
    <metric>sum [output] of input-producers 2</metric>
    <metric>GDP</metric>
    <metric>mean [consumer-utility] of ccs</metric>
    <metric>gini</metric>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="103"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="experiment-number">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="120"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="120"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f2">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment" repetitions="500" runMetricsEveryStep="false">
    <setup>randomize-councils
setup</setup>
    <go>go</go>
    <timeLimit steps="999"/>
    <metric>experiment-number</metric>
    <metric>ticks</metric>
    <metric>mean-utility</metric>
    <metric>first final-prices</metric>
    <metric>first input-prices</metric>
    <metric>first resource-prices</metric>
    <metric>first labor-prices</metric>
    <enumeratedValueSet variable="inputs">
      <value value="2"/>
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="finals">
      <value value="2"/>
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="labors">
      <value value="1"/>
      <value value="2"/>
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="worker-councils">
      <value value="500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f2">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="inputs">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="experiment-number">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="resources">
      <value value="1"/>
      <value value="2"/>
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="resources">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="labors">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="102"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="use-new?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="finals">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="newnew?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="resource experiment" repetitions="100" runMetricsEveryStep="false">
    <setup>randomize-councils
setup</setup>
    <go>go</go>
    <timeLimit steps="999"/>
    <metric>experiment-number</metric>
    <metric>ticks</metric>
    <metric>mean-utility</metric>
    <metric>first final-prices</metric>
    <metric>first input-prices</metric>
    <metric>first resource-prices</metric>
    <metric>first labor-prices</metric>
    <enumeratedValueSet variable="inputs">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price-delta">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="finals">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="labors">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i2">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="worker-councils">
      <value value="500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f2">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="inputs">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="100"/>
      <value value="250"/>
      <value value="500"/>
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="experiment-number">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="resources">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="resources">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="labors">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="102"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="use-new?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="finals">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="newnew?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="500x2 experiment" repetitions="100" runMetricsEveryStep="false">
    <setup>randomize-councils
setup</setup>
    <go>go</go>
    <timeLimit steps="999"/>
    <metric>experiment-number</metric>
    <metric>ticks</metric>
    <metric>mean-utility</metric>
    <metric>mean final-prices</metric>
    <metric>mean input-prices</metric>
    <metric>mean resource-prices</metric>
    <metric>mean labor-prices</metric>
    <enumeratedValueSet variable="price-delta">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="labors">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-i1">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="workers-per-council">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="worker-councils">
      <value value="500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-n">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="inputs">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="natural-resources-supply">
      <value value="500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="experiment-number">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="resources">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="surplus-threshold">
      <value value="0.02"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="viewing">
      <value value="102"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="use-new?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cq-init">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-f1">
      <value value="95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consumer-councils">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="finals">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="utility-multiplier">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="du-init">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="newnew?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="init-price-l">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ce-init">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
