class Cube
  attr_reader :matrix_size, :matrix

  def initialize(matrix_size:)
    raise "matrix size must be between 1 and 100" if matrix_size > 100 || matrix_size < 1
    @matrix_size = matrix_size-1
    @matrix = Array.new(matrix_size){ Array.new(matrix_size) { Array.new(matrix_size, 0) }}
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
    q_matrix = @matrix.dup

    x_query = arr_to_query(point1[:x], point2[:x])
    y_query = arr_to_query(point1[:y], point2[:y])
    z_query = arr_to_query(point1[:z], point2[:z])

    sum = 0
    @matrix.each_with_index do |z, zi|
      next unless z_query.include?(zi)
      z.each_with_index do |x, xi|
        next unless x_query.include?(xi)
        x.each_with_index do |y, yi|
          next unless y_query.include?(yi)
          sum += y
        end
      end
    end

    sum
  end

  def arr_to_query(coord1,coord2)
    [*coord1..coord2]
  end

  def valid_point_intersection?(point1, point2)
    return false unless valid_point?(point1) || valid_point?(point2)
    point1[:x] <= point2[:x] && point1[:y] <= point2[:y] && point1[:z] <= point2[:z]
  end

  def valid_point?(point)
    ([:x, :y, :z] - point.keys).empty? &&
    !point.values.any?{|x| !(x.kind_of? Integer) || x > @matrix_size || x < 0 }
  end

end


#
# require "pry"
#
# binding.pry

# point1 = {x: 1, y: 4, z: 2 }
# point2 = {x: 5, y: 4, z: 3 }
