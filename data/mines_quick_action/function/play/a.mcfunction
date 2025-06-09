tellraw @s [\
    {\
        "text":"abc",\
        "color":"red",\
        "extra":[\
            {\
                "text":"这是什么颜色？"\
            }\
        ]\
    }\
]

give @s snowball[use_remainder={"id":"snowball",components:{use_remainder:{id:"snowball"}}}]