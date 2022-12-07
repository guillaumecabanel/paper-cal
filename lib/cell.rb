# frozen_string_literal: true

class Cell
  WIDTH = 13
  HEIGHT = 4

  attr_accessor :position, :row_position, :content
  attr_reader :title

  def initialize(title, content)
    @title = title
    @content = content.is_a?(Array) ? content : [content]
  end

  def display
    display = [
      cell_header,
      cell_title
    ]

    content.each do |line|
      text_splitter(line).split("\n").first(HEIGHT).each do |l|
        display << cell_line(l)
      end
    end

    HEIGHT.times { display << cell_line("") }

    display << cell_footer if last_row?

    display
  end

  private

  def text_splitter(text)
    text.gsub(/(?:.{1,#{WIDTH}}|\S+)\K(?:$|\s)/, "\n")
  end

  def cell_header
    "#{starting_char}#{'─' * WIDTH}#{ending_char}"
  end

  def cell_footer
    "#{first? ? '└' : '┴'}#{'─' * WIDTH}#{last? ? '┘' : ''}"
  end

  def cell_line(text)
    "│#{text.ljust(WIDTH)}#{'│' if last?}"
  end

  def cell_title
    "│#{title.to_s.rjust(WIDTH - 1)} #{'│' if last?}"
  end

  def first?
    position == :first
  end

  def last?
    position == :last
  end

  def first_row?
    row_position == :first
  end

  def last_row?
    row_position == :last
  end

  def starting_char
    if first? && first_row?
      "┌"
    elsif first?
      "├"
    elsif first_row?
      "┬"
    else
      "┼"
    end
  end

  def ending_char
    if last? && first_row?
      "┐"
    elsif last?
      "┤"
    else
      ""
    end
  end
end
