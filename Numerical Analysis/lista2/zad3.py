def converter(s, start = "", end = ""):
    result = start

    if (s[0] == "-"): return converter(s[1::], "-(", ")")

    if (s[0] == "1"): result += "1 + "

    numerator = 0
    denominator = 32

    for i in range(1,6): 
        numerator += int(s[i+1]) * (2**(5-i))

    while (numerator % 2 == 0): 
        numerator//=2
        denominator//=2

    result += f"{numerator}/{denominator}"
    return result + end

print(converter("-0.01000"))