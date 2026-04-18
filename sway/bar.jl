while true
    date = read(`date +'%Y-%m-%d %X'`, String) |> strip
    battery = read("/sys/class/power_supply/BAT0/capacity", String) |> strip

    println("$date $battery%")
    sleep(1)
end
