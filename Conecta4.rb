class Conect4

	attr_reader :string_board, :count, :flag
	
	def initialize
		@string_board = []
		@string_board << [" "," "," "," "," "," "] << [" "," "," "," "," "," "] << [" "," "," "," "," "," "] << [" "," "," "," "," "," "] << [" "," "," "," "," "," "] << [" "," "," "," "," "," "]
		@count = 0
		@forbidden = [0,1,2,3,4,5]
		@flag = false
	end

	def drop_chip!
		if @count % 2 == 0
			puts "\nTurno de X"
			where_to_put("X")
			@count += 1
			if !finished?
				drop_chip!
			else
				winner
			end
		else
			puts "\nTurno de O"
			where_to_put("O")
			@count += 1
			if !finished?
				drop_chip!
			else
				winner
			end
		end
	end

	def my_size(col)
		if col.class != Array
			new_array = @string_board[col].select {  |elem|
				elem != " "
			}
		else
			new_array = col.select{  |elem|
				elem != " "
			}
		end
		new_array.length
	end

	def where_to_put(elem)
		col = @forbidden.sample
		if my_size(col) > 5
			@forbidden.delete(col)
			where_to_put(elem)
		else
			index = @string_board[col].index(" ")
			@string_board[col][index] = elem
			print_board
		end
	end

	def finished?
		if (@count - 1) % 2 == 0
			elem = "X"
		else
			elem = "O"
		end
		# if horizontal(elem)
		# 	return @flag
		# elsif vertical(elem)
		# 	return @flag
		if diagonal(elem)
			return @flag
		else
			@string_board.each {  |col|
				if my_size(col) > 5
					@flag = true
				else
					@flag = false
					puts "Todavia se puede poner"
					break
				end
			}
		end
		flag
	end

	def horizontal(elem)
		puts "HORIZONTAL"
		word = elem * 4
		trans = @string_board.transpose
		trans.each{  |ren|
			puts "elem: #{elem} ren: #{ren.join}"
			if ren.join.include?(word)
				puts "GANO!!!!!! #{elem}"
				@flag = true
				break
			end
		}
		@flag
	end

	def vertical(elem)
		puts "VERTICAL"
		word = elem * 4
		@string_board.each{  |col|
			puts "elem: #{elem} col: #{col.join}"
			if col.join.include?(word)
				puts "GANO!!!!!! #{elem}"
				@flag = true
				break
			end
		}
		@flag
	end
  
	def diagonal(elem)
		diagonal_1(elem)
		diagonal_2(elem)
		@flag
	end

  def diagonal_1(elem)
  	puts "DIAGONAL"
  	word = elem * 4
  	espacios = mete_espacios_1
    espacios.each{  |diag|
			puts "elem: #{elem} diag: #{diag.join}"
	    if diag.join.include?(word)
				puts "GANO!!!!!! #{elem}"
				@flag = true
				break
			end
    }
    @flag
  end

  def diagonal_2(elem)
  	puts "DIAGONAL"
  	word = elem * 4
  	espacios = mete_espacios_2
    espacios.each{  |diag|
			puts "elem: #{elem} diag: #{diag.join}"
	    if diag.join.include?(word)
				puts "GANO!!!!!! #{elem}"
				@flag = true
				break
			end
    }
    @flag
  end

	def winner
		if @count - 1 % 2 == 0
			puts "\nGano X, #{@count}"
		else
			puts "\nGano O, #{@count}"
		end
	end

	def print_board
		(@string_board.length - 1).downto(0) {  |i|
			print "|"
			for j in 0...6
				if @string_board[j][i] == nil
					print " |"
				else
					print @string_board[j][i] + "|"
				end
			end
			puts
		}
		print "-" * 13
		puts
	end

  def mete_espacios_1
  	aux = []
    n = @string_board.length - 1
    for i in 0...@string_board.length
    	aux[i] = @string_board[i].dup
      i.times{aux[i].insert(0,"A")}
      (n - i).times{aux[i].push("A")}
    end
    aux = aux.transpose
  end

  def mete_espacios_2
  	aux = []
    n = @string_board.length - 1
    for i in 0...@string_board.length
    	aux[i] = @string_board[i].dup
      i.times{aux[i].push("A")}
      (n - i).times{aux[i].insert(0,"A")}
    end
    aux = aux.transpose
  end



end

c = Conect4.new
puts "Inicio"
c.print_board
c.drop_chip!














