module Helper
  def columns_and_rows(new_position, old_position)
    new_column = new_position[0]
    new_row = new_position[1]
    old_column = old_position[0]
    old_row = old_position[1]
    return new_column, new_row, old_column, old_row
  end

  def positions_between(new_position, old_position)
    new_column, new_row, old_column, old_row = columns_and_rows(new_position, old_position)
    positions_between = []
    # Check the column
    if new_column == old_column
      # Going up the column
      if new_row > old_row
        (old_row+1).upto(new_row-1) do |row|
          positions_between << [new_column, row]
        end
      # Going down the column
      else
        (old_row-1).downto(new_row+1) do |row|
          positions_between << [new_column, row]
        end
      end
    end

    # Check the row
    if new_row == old_row
      # Going up the row
      if new_column > old_column
        (old_column+1).upto(new_column-1) do |column|
          positions_between << [column, new_row]
        end
        # Going down the row
      else
        (old_column-1).downto(new_column+1) do |column|
          positions_between << [column, new_row]
        end
      end
    end

    # Check the bottom left to top right diagonal
    if (new_row - old_row) == (new_column - old_column)
      # Going from bottom left to top right
      if new_row > old_row
        (old_row+1).upto(new_row-1) do |row|
          increment = row - old_row
          positions_between << [old_column + increment, row]
        end
      # Going from top right to bottom left
      else
        (old_row-1).downto(new_row+1) do |row|
          increment = row - old_row
          positions_between << [old_column + increment, row]
        end
      end
    end

    # Check the top left to bottom right diagonal
    if (new_row + new_column) == (old_row + old_column)
      # Going from top left to bottom right
      if new_column > old_column
        (old_column+1).upto(new_column-1) do |column|
          increment = old_column - column
          positions_between << [column, old_row + increment]
        end
      # Going from bottom right to top left
      else
        (old_column-1).downto(new_column+1) do |column|
          increment = old_column - column
          positions_between << [column, old_row + increment]
        end
      end
    end
    return positions_between
  end
end