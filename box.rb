require 'prawn'
require 'pry'

module Prawn::Graphics
  alias old_move_to move_to
  def move_to(*point)
    @last_x, @last_y = point
    absolute = map_to_absolute(*point)
    old_move_to(*point)
  end

  def line_delta dx, dy
    #binding.pry
    line_to @last_x+dx, @last_y+dy
    @last_x += dx
    @last_y += dy
  end
end

FOAM_THICKNESS=(3.0/16) * 72.0

xc, yc, zc = ARGV[0..2].map(&:to_f)

page_layout = xc > yc ? :landscape : :portrait
Prawn::Document.generate "out.pdf", :page_layout => page_layout do |pdf|
  pdf.stroke do
    pdf.stroke_color = "000000"
    pdf.move_to zc+FOAM_THICKNESS, zc+FOAM_THICKNESS
    pdf.line_delta -(zc+FOAM_THICKNESS), 0
    pdf.line_delta 0, (2*FOAM_THICKNESS+yc)
    pdf.line_delta (zc+FOAM_THICKNESS), 0
    pdf.line_delta 0, (zc+FOAM_THICKNESS)
    pdf.line_delta (xc+2*FOAM_THICKNESS), 0
    pdf.line_delta 0, -(zc+FOAM_THICKNESS)
    pdf.line_delta (zc+FOAM_THICKNESS), 0
    pdf.line_delta 0, -(yc+2*FOAM_THICKNESS)
    pdf.line_delta -(zc+FOAM_THICKNESS), 0
    pdf.line_delta 0, -(zc+FOAM_THICKNESS)
    pdf.line_delta -(xc+2*FOAM_THICKNESS), 0
    pdf.line_delta 0, (zc+FOAM_THICKNESS)
  end

  pdf.stroke do
    pdf.stroke_color = "cc00000"
    pdf.move_to (zc+FOAM_THICKNESS),(zc+FOAM_THICKNESS)
    pdf.line_delta (xc+FOAM_THICKNESS*2), 0
    pdf.move_to 0, (zc+FOAM_THICKNESS)+FOAM_THICKNESS
    pdf.line_delta (zc+FOAM_THICKNESS)+(xc+FOAM_THICKNESS*2)+(zc+FOAM_THICKNESS), 0
    pdf.move_to 0, (zc+FOAM_THICKNESS)+(yc+FOAM_THICKNESS)
    pdf.line_delta (zc+FOAM_THICKNESS)+(xc+FOAM_THICKNESS*2)+(zc+FOAM_THICKNESS), 0
    pdf.move_to (zc+FOAM_THICKNESS), (zc+FOAM_THICKNESS)+(yc+FOAM_THICKNESS*2)
    pdf.line_delta (xc+FOAM_THICKNESS*2), 0
    pdf.move_to zc, (zc+FOAM_THICKNESS)+FOAM_THICKNESS
    pdf.line_delta 0, yc
    pdf.move_to (zc+FOAM_THICKNESS), (zc+FOAM_THICKNESS)+FOAM_THICKNESS
    pdf.line_delta 0, yc
    pdf.move_to (zc+FOAM_THICKNESS)+(xc+FOAM_THICKNESS*2), (zc+FOAM_THICKNESS)+FOAM_THICKNESS
    pdf.line_delta 0, yc
    pdf.move_to (zc+FOAM_THICKNESS)+(xc+FOAM_THICKNESS*2)+FOAM_THICKNESS, (zc+FOAM_THICKNESS)+FOAM_THICKNESS
    pdf.line_delta 0, yc
  end
end
