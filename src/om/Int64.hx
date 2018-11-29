package om;

typedef Int64 =
    #if cpp cpp.Int64
    #elseif hl hl.I64
    #else Int
    #end;
