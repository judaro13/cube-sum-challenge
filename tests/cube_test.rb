require 'minitest/autorun'
require 'pry'
require_relative '../lib/cube'

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

    point0 = {x: 0, y: 0, z: 0}
    point1 = {x: 0, y: 0, z: 1}
    point2 = {x: 1, y: 0, z: 0}
    point3 = {x: 0, y: 1, z: 0}
    point33 = {x: 1, y: 1, z: 0}
    point4 = {x: 1, y: 0, z: 1}
    point5 = {x: 0, y: 1, z: 1}
    point55 = {x: 1, y: 1, z: 1}

    cube.update(point: point0, value: 1)
    cube.update(point: point1, value: 2)
    cube.update(point: point2, value: 3)
    cube.update(point: point3, value: 4)
    cube.update(point: point33, value: 44)
    cube.update(point: point4, value: 5)
    cube.update(point: point5, value: 6)
    cube.update(point: point55, value: 66)

    assert cube.matrix === [[[1, 4], [3, 44]], [[2, 6], [5, 66]]]

  end

  def test_valid_point_intersection
    cube = Cube.new(matrix_size: 4)
    point1 = {x: 0, y: 1, z: 1}
    point2 = {x: 0, y: 2, z: 3}

    assert cube.valid_point_intersection?(point1, point2)

    point2 = {x: 0, y: 0, z: 3}
    assert cube.valid_point_intersection?(point1, point2) == false

  end

  def test_query
    cube = Cube.new(matrix_size: 4)

    point0 = {x: 0, y: 0, z: 0}
    point1 = {x: 1, y: 1, z: 1}
    point2 = {x: 2, y: 2, z: 2}
    point3 = {x: 3, y: 3, z: 3}

    cube.update(point: point1, value: 4)
    assert cube.query(point1: point0, point2: point2) == 4

    cube.update(point: point0, value: 3)
    cube.update(point: point2, value: 23)
    assert cube.query(point1: point1, point2: point3) == 27

    assert cube.query(point1: point2, point2: point3) == 23
  end

end
