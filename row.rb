# frozen_string_literal: true

class Row
  attr_reader :cells, :position

  def initialize(cells, position)
    @cells = cells
    @position = position
    set_cell_positions
  end

  def to_s
    first_cell = cells.first
    first_cell.display.zip(*cells[1..].map(&:display)).map(&:join).join("\n")
  end

  private

  def set_cell_positions
    cells.first.position = :first
    cells.last.position = :last

    cells.each { |cell| cell.row_position = position } if position
  end
end
