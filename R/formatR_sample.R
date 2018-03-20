In a nutshell, tidy_source(text = code) is basically deparse(parse(text = code)), but actually it is more complicated only because of one thing: deparse() drops comments, e.g.,

deparse(parse(text = "1+2-3*4/5 # a comment"))