class Cube
  attr_reader :matrix_size, :matrix
  def initialize(matrix_size:)
    @matrix_size = matrix_size
    coord = [0]*matrix_size
    @matrix = [coord, coord, coord]
  end

  def matrix
    @matrix
  end

  def update(x:, y:, z:, value:)
  end

  def query(point1:, point2:)
  end

end
