class Conect4

	attr_reader :string_board, :count
	
	def initialize
		@string_board = []
		@string_board << [] << [] << [] << [] << [] << [] << []
		@count = 0
		@forbidden = [0,1,2,3,4,5,6]
	end

	def drop_chip!
		if !finished?
			if @count % 2 == 0
				puts "\nTurno de X"
				where_to_put("X")
				@count += 1
				drop_chip!
			else
				puts "\nTurno de O"
				where_to_put("O")
				@count += 1
				drop_chip!
			end
		else
			winner
		end	
	end

	def where_to_put(elem)
		col = @forbidden.sample
		if @string_board[col].length > 6
			@forbidden.delete(col)
			where_to_put(elem)
		else
			@string_board[col] << elem
			print_board
		end
	end

	def finished?
		flag = false
		@string_board.each {  |col|
			if col.length > 6
				flag = true
			else
				flag = false
				break
			end
		}
		flag
	end

	def winner
		if @count % 2 == 0
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

end

c = Conect4.new
c.drop_chip!
#print_board














