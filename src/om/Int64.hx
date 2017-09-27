package om;

typedef Int64 =
    #if cpp cpp.Int64
    #else Int
    #end;
