root = exports ? window

class root.CoffeeScheme
    checkList: (list) ->
        return ({}.toString.call list) is '[object Array]'

    checkValue: (value) ->
        return not isNaN( parseFloat value ) and isFinite value

    car: (list) ->
        return unless @checkList list
        list.shift()

    cdr: (list) ->
        return unless @car list
        list

    @FUNCTIONS:
        '+': (list) -> list.reduce (t, s) -> t + s
        '-': (list) -> list.reduce (t, s) -> t - s
        '*': (list) -> list.reduce (t, s) -> t * s
        '/': (list) -> list.reduce (t, s) -> t / s

    lookUp: (fun) ->
        CoffeeScheme.FUNCTIONS[fun]

    eval: (exp) ->
        unless @checkList exp
            return exp if @checkValue exp
            return @lookUp exp
        else
            orgExp = exp.slice 0
            fun = (@eval @car exp)
            return orgExp unless typeof fun is 'function'
            fun @evalMap @cdr orgExp

    evalMap: (exp) ->
        that = @
        exp.map (e) -> that.eval e
