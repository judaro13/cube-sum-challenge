require 'minitest/autorun'
require 'pry'
require_relative '../cube'

class  CubeTest < Minitest::Test
  def test_cube_matrix
    cube = Cube.new(matrix_size: 2)
    assert cube.matrix.class == Array
    assert cube.matrix.size == 2
  end

  def test_valid_point
    cube = Cube.new(matrix_size: 2)
    point = {x: 0, y: 1, z: 1}

    v_point = cube.valid_point?(point)
    assert v_point

    point = {x: 0, y: 1, z: 2}
    v_point = cube.valid_point?(point)
    assert v_point == false

    point = {x: 0, y: 1, z: "2"}
    v_point = cube.valid_point?(point)
    assert v_point == false

    point = {y: 1, z: "2"}
    v_point = cube.valid_point?(point)
    assert v_point == false
  end

  def test_update_point
    cube = Cube.new(matrix_size: 2)
    point = {x: 0, y: 1, z: 1}
    cube.update(point: point, value: 5)
    assert cube.matrix[point[:z]][point[:x]][point[:y]] == 5
    flat = cube.matrix.flatten
    result = flat.each_with_object(Hash.new(0)) { |k,counts| counts[k] += 1 }
    assert result[5] == 1
  end

  def test_valid_point_intersection
    cube = Cube.new(matrix_size: 4)
    point1 = {x: 0, y: 1, z: 1}
    point2 = {x: 0, y: 2, z: 3}

    assert cube.valid_point_intersection?(point1, point2)

    point2 = {x: 0, y: 0, z: 3}
    assert cube.valid_point_intersection?(point1, point2) == false

  end

end
