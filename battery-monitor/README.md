# battery monitor
### USAGE
```sh
./script.sh <path-to-output-file>
```

### sample output file
```csv
2024-05-27T18:25:03UTC,discharging,67
2024-05-27T18:26:03UTC,discharging,67
2024-05-27T18:27:03UTC,discharging,66
```

### algorithm
- Writes battery % with timestamp(iso 8601) to the *output file* when the device is *discharging*

-  A new *output file* with numbered suffix is created on _every discharge cycle_.