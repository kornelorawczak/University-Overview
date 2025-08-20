DIR="./testy_C/duze" #tu zmienic na male jesli potrzeba
PROG="szachownica"
TIME_LIMIT=0.5 #(s)
MEMORY_LIMIT=16 #(MB)
TIMEOUT_RET_VALUE=124
for((i = 1; i <= 150; ++i)); do
    out="$(ulimit -v $((MEMORY_LIMIT * 1024)); timeout $TIME_LIMIT ./$PROG < "$DIR/in/$i.in"; exit $?)"
    ret_value=$?
    if [ $ret_value -ne 0 ]; then
        if [ $ret_value -eq $TIMEOUT_RET_VALUE ]; then
            echo "$i: TLE"
        else
            echo "$i: RE"
        fi
        exit 1
    fi
    if echo "$out" | cmp "$DIR/out/$i.out"; then
        echo "$i: OK"
    else
        echo "$i: WA"
        exit 1
    fi
done

