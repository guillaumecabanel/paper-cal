# frozen_string_literal: true

class Month
  DAYS = Date::DAYNAMES.rotate
  attr_reader :cells, :date

  def initialize(date)
    @cells = []
    @date = date
    set_start_padding
    set_days
    set_end_padding
  end

  def add_event(event, date)
    event_cell = cells.find { |cell| cell.title == date.day.to_s }
    event_cell.content << "▸#{event}" if event_cell
  end

  def to_s
    display = []
    cells.each_slice(7).with_index do |week, index|
      position = :first if index.zero?
      position = :last if index == cells.each_slice(7).size - 1

      display << Row.new(week, position)
    end

    "#{date.strftime('%B %Y')}\n#{day_names}\n#{display.join("\n")}\n"
  end

  private

  def set_start_padding
    (date.beginning_of_month.cwday - 1).times { cells << Cell.new("", "") }
  end

  def set_end_padding
    (7 - date.end_of_month.cwday).times { cells << Cell.new("", "") }
  end

  def set_days
    ((date.beginning_of_month)..(date.end_of_month)).each do |day|
      title = day.day.to_s
      title.prepend("● ") if day.today?

      cells << Cell.new(title, "")
    end
  end

  def day_names
    DAYS.map { |d| " #{d.ljust(Cell::WIDTH)}" }.join
  end
end
