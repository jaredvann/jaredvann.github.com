
###

TODO

--scientific notation input
--js latex output
--set variables


###


cl = (x)-> console.log(x)

parser = (input, debug=false)->

	log = (x)-> if debug then cl x

	ops =
		'(': {p:0, f:()-> return}
		')': {p:0, f:()-> return}
		'+':
			p: 1
			f: (a,b)-> return a+b
		'-':
			p: 1
			f: (a,b)-> return a-b
		'*':
			p: 2
			f: (a,b)-> return a*b
		'/':
			p: 2
			f: (a,b)-> return a/b
		'^':
			p: 3
			f: (a,b)-> return Math.pow(a,b)

	sops =
		'sin': {p: 0, f: (a)-> return Math.sin(a)}
		'cos': {p: 0, f: (a)-> return Math.cos(a)}
		'tan': {p: 0, f: (a)-> return Math.tan(a)}
		'ln': {p: 0, f: (a)-> return Math.log(a)}
		'log': {p: 0, f: (a)-> return Math.log10(a)}
		'sqrt': {p: 0, f: (a)-> return Math.sqrt(a)}


	constants = 
		'pi': ()-> return Math.PI
		'e': ()-> return Math.E
		'random': ()-> return Math.random()

	ops2 = Object.keys(ops)
	sops2 = Object.keys(sops)
	constants2 = Object.keys(constants)

	this.cmd = (input)->

		return

	this.toChunks = (text)->

		chunks = []
		for char in text
			if not isNaN(char) or char is '.'
				x = chunks[chunks.length-1]
				if not isNaN(x) or x is '.'
					chunks[chunks.length-1] += char
				else
					chunks.push(char)
			else if char in ops2
				chunks.push(char)
			else 
				x = chunks[chunks.length-1]
				if x and isNaN(x) and x not in ops2
					chunks[chunks.length-1] += char
				else
					chunks.push(char)

		log chunks		
		return chunks


	this.toPostfix = (infix)->

		stack = []
		postfix = []
		
		this.precedence = (x)->
			if x in ops2 then return ops[x]['p'] else return 99

		for c in infix

			if c is '('
				stack.push(c)

			else if c is ')'
				next = stack.pop()
				while next != '('
					postfix.push(next)
					next = stack.pop()

			else if not isNaN(c) or c in constants2
				postfix.push(c)

			else if c in ops2 or c in sops2
				while stack.length != 0 and this.precedence(c) <= this.precedence(stack[stack.length-1])
					postfix.push(stack.pop())
				stack.push(c)



		while stack.length > 0
			postfix.push(stack.pop())

		log postfix
		return postfix


	this.evalPostfix = (pf)->
		stack = []

		for c in pf
			if c in constants2
				stack.push(constants[c]())

			else if c in sops2
				cl stack
				a = parseFloat(stack.pop())
				r = sops[c].f(a)
				stack.push(r)
			else if c in ops2
				b = parseFloat(stack.pop())
				a = parseFloat(stack.pop())
				r = ops[c].f(a,b)
				stack.push(r)
			else
				stack.push(c)

		return stack[0]

	x = this.toChunks(input)
	x = this.toPostfix(x)
	x = this.evalPostfix(x)

	return x




cl parser('sqrt(4)', true)

