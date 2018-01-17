class Cube
  attr_reader :matrix_size, :matrix

  def initialize(matrix_size:)
    raise "matrix size must be between 1 and 100" if matrix_size > 100 || matrix_size < 1
    @matrix_size = matrix_size
    reset_matrix
  end

  def reset_matrix
    @matrix = Array.new(@matrix_size){ Array.new(@matrix_size) { Array.new(@matrix_size, 0) }}
  end

  def matrix
    @matrix
  end

  # point {x: INT, y: INT, z: INT }
  def update(point:, value:)
    return false unless valid_point?(point) || !(value.kind_of? Integer)
    @matrix[point[:z]][point[:x]][point[:y]] = value
  end

  def query(point1:, point2:)
    return false unless valid_point_intersection?(point1, point2)
    sum_matrix(point1, point2)
  end

  def sum_matrix(point1, point2)
    sum = 0
    @matrix[point1[:z]...point2[:z]].each do |z|
      z[point1[:x]...point2[:x]].each do |x|
        x[point1[:y]...point2[:y]].each_with_index do |y, yi|
          sum += y
        end
      end
    end
    sum
  end


  def valid_point_intersection?(point1, point2)
    return false unless valid_point?(point1) || valid_point?(point2)
    point1[:x] <= point2[:x] && point1[:y] <= point2[:y] && point1[:z] <= point2[:z]
  end

  def valid_point?(point)
    ([:x, :y, :z] - point.keys).empty? &&
    !point.values.any?{|x| !(x.kind_of? Integer) || x > @matrix_size-1 || x < 0 }
  end

end
