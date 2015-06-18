class Conect4

	attr_reader :string_board, :count, :flag
	
	def initialize
		@string_board = []
		@string_board << [" "," "," "," "," "," "] << [" "," "," "," "," "," "] << [" "," "," "," "," "," "] << [" "," "," "," "," "," "] << [" "," "," "," "," "," "] << [" "," "," "," "," "," "]
		@count = 0
		@forbidden = [0,1,2,3,4,5]
		@flag = false
		puts "Jugador 1"
		x = gets.chomp.capitalize
		puts "Jugador 2"
		y = gets.chomp.capitalize
		@names = [x,y]
	end

	def drop_chip!
		if @count % 2 == 0
			puts "\nTurno de #{@names[0]}"
			where_to_put("X")
			@count += 1
			if !finished?
				drop_chip!
			else
				winner
			end
		else
			puts "\nTurno de #{@names[1]}"
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
#		col = @forbidden.sample
		puts "Donde quieres poner tu ficha"
		input = gets.chomp
		if input.to_s == "q"
			puts "Adios!!"
			return @flag = true
		end
		input = input.to_i - 1
		if input < - 1 || input > 5
			puts "Posicion incorrecta"
			where_to_put(elem)
		elsif my_size(input) > 5#TENIA +col+
#			@forbidden.delete(col)
			puts "No se puede poner ahi"
			where_to_put(elem)
		else
			index = @string_board[input].index(" ")
			5.downto(index) {  |i|
				@string_board[input][i] = elem
				sleep(0.1)
				clear_screen!
				@string_board[input][i + 1] = " "
				move_to_home!
				puts print_board
			}
			@string_board[input].pop
		end
	end

	def finished?
		if (@count - 1) % 2 == 0
			elem = "X"
		else
			elem = "O"
		end
		if horizontal(elem)
			return @flag
		elsif vertical(elem)
			return @flag
		elsif diagonal(elem)
			return @flag
		else
			@string_board.each {  |col|
				if my_size(col) > 5
					@flag = true
				else
					@flag = false
					break
				end
			}
		end
		flag
	end

	def horizontal(elem)
		word = elem * 4
		trans = @string_board.transpose
		trans.each{  |ren|
			if ren.join.include?(word)
				@flag = true
				break
			end
		}
		@flag
	end

	def vertical(elem)
		word = elem * 4
		@string_board.each{  |col|
			if col.join.include?(word)
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
  	word = elem * 4
  	espacios = mete_espacios_1
    espacios.each{  |diag|
	    if diag.join.include?(word)
				@flag = true
				break
			end
    }
    @flag
  end

  def diagonal_2(elem)
  	word = elem * 4
  	espacios = mete_espacios_2
    espacios.each{  |diag|
	    if diag.join.include?(word)
				@flag = true
				break
			end
    }
    @flag
  end

	def winner
		if (@count - 1) % 2 == 0
			puts "\nGano #{@names[0]}, #{@count}"
		else
			puts "\nGano #{@names[1]}, #{@count}"
		end
	end

	def print_board
		tablero = ""
		(@string_board.length - 1).downto(0) {  |i|
#			print "|"
			tablero += "|"
			for j in 0...6
				if @string_board[j][i] == nil
#					print " |"
					tablero += " |"
				else
#					print @string_board[j][i] + "|"
					tablero += @string_board[j][i] + "|"
				end
			end
#			puts
			tablero += "\n"
		}
#		print "-" * 13
		tablero += "-" * 13
#		puts
		tablero += "\n"
		tablero += "|1|2|3|4|5|6|"
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

	# Clear the screen
	def clear_screen!
	  print "\e[2J"
	end

	# Moves cursor to the top left of the terminal
	def move_to_home!
	  print "\e[H"
	end

	# Use "reputs" to print over a previously printed line,
	# assuming the cursor is positioned appropriately.
	def reputs(str = '')
	  puts "\e[0K" + str
	end
end

c = Conect4.new
puts "Inicio"
c.print_board
c.drop_chip!
#c.reputs(print_board)
#c.move_to_home!
#c.clear_screen!














