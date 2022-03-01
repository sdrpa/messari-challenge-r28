# messari-challenge-r28 
https://resonant-zipper-d74.notion.site/Messari-Market-Data-Coding-Challenge-rev-28-Feb-2022-e513357eaeb34b9a9ab9805af37d96b0

Created and tested on Ubuntu 20.04.4 LTS; Swift version 5.3.3 (swift-5.3.3-RELEASE)

### Usage
```
swift build -c release
./stdoutinator_amd64_linux.bin | .build/release/messari-challenge-r28
```

{"market":8293,"total_volume":220097.43834125812,"mean_price":25.50979640782012,"mean_volume":2529.8556131179093,"volume_weighted_average_price":8627.95746475603,"percentage_buy":1.0}
{"market":4450,"total_volume":230603.59119214735,"mean_price":30.51412581926835,"mean_volume":2620.49535445622,"volume_weighted_average_price":7557.273393902412,"percentage_buy":0.0}
{"market":8904,"total_volume":225517.71714570865,"mean_price":12.513763150787097,"mean_volume":2592.1576683414787,"volume_weighted_average_price":18021.574679677706,"percentage_buy":1.0}
{"market":10475,"total_volume":216035.85251258593,"mean_price":23.48986859635097,"mean_volume":2483.1707185354703,"volume_weighted_average_price":9196.980035305349,"percentage_buy":0.0}
...

It took: 124.68546078300096 secs.

### Measure messari-challenge-r28 performance
```
time ./stdoutinator_amd64_linux.bin | .build/release/messari-challenge-r28
```

### Measure stdoutinator_amd64_linux.bin data generation
```
time ./stdoutinator_amd64_linux.bin > output.txt
```

real	0m22.883s
user	0m9.672s
sys	0m14.677s

```
wc -l output.txt 
10_000_007
```
