class Cube
  attr_reader :matrix_size, :matrix
  def initialize(matrix_size:)
    return false if matrix_size > 100
    @matrix_size = matrix_size
    coord = [0]*matrix_size
    @matrix = [[coord]*matrix_size]*matrix_size
  end

  def matrix
    @matrix
  end

  # point {x: INT, y: INT, z: INT }
  def update(point:, value:)
    return false unless valid_point?(point)
  end

  def query(point1:, point2:)
    return false unless valid_point?(point1) || valid_point?(point2)
  end

  def valid_point?(point:)
    ([:x, :y, :z] - point.keys).empty? &&
    !point.values.any?{|x| !x.integer? || x > matrix_size || x < 0 }
  end

end
