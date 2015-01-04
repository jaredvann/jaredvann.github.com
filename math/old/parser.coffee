cl = (s) -> console.log s

operators = [
	'+'
	'-'
]

numbers = ['0','1','2','3','4','5','6','7','8','9']

constants = {
	pi: 3.141592653589793
	e: 2.718281828459045
}


lex = (exp) ->
	out = []

	exp = exp.replace ' ', ''
	for c in exp
		for num in numbers
			if c == num
				if out.length > 0
					m1 = out.slice(-1)[0]
					if m1.type == 'num'
						out.pop()
						out.push {type: 'num', value: m1.value+c}
					else out.push {type: 'num', value: c}
				else out.push {type: 'num', value: c} 
				
		for op in operators
			out.push {type: 'op', value: c} if c == op

	for i in out
		if i.type == 'num'
			i.value = parseInt i.value
				
	return out

cl  lex '12 + 145'

i = 0

token = () -> return tokens[i]
advance = () ->
	i++
	return token

tree = {}

# exp = (rbp) ->
# 	left = [token()]
# 	advance()
# 	t1 = token()
# 	if 








