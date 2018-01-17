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
    q_matrix = reduce_matrix(point1, point2)
    q_matrix.flatten.inject(0){|sum,x| sum + x }
  end

  def reduce_matrix(point1, point2)
    q_matrix = @matrix.clone
    x_remove = positions_for_remove(point1[:x], point2[:x])
    y_remove = positions_for_remove(point1[:y], point2[:y])
    z_remove = positions_for_remove(point1[:z], point2[:z])

    z_remove.each_with_index do |z, i|
      q_matrix.delete_at(z-i)
    end

    q_matrix.each_with_index do |z, zi|
      x_remove.each_with_index do |x, xi|
        q_matrix[zi].delete_at(x-xi)
      end
    end

    q_matrix.each_with_index do |z, zi|
      z.each do |x, xi|
        y_remove.each_with_index do |y, yi|
          q_matrix[zi][xi].delete_at(y-yi)
        end
      end
    end

    q_matrix

  end

  def positions_for_remove(coord1, coord2)
    [*0..@matrix_size] - ([*coord1..coord2]||[*0..@matrix_size])
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
