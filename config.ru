require "syro"
require "mote"
require "pry"
require 'json'
require_relative 'lib/cube'
require_relative 'lib/web_deck'

App = Syro.new(Web) do
  get do
    render("index", title: "Cube Summation", content: "")
  end

  post do
     cube = Cube.new(matrix_size: req.params["matrix"].to_i)
     res.text cube.matrix.to_json
  end

  on "operation" do
    post do
      data = req.params["data"].split
      action = data[0]
      data.delete_at(0)
      data.map! { |x| x.to_i-1 }

      matrix = eval(req.params["matrix"])
      cube = Cube.new(matrix_size: req.params["size"].to_i)
      cube.set_matrix(matrix: matrix)

      if action == "UPDATE"
        cube.update(point: {x: data[0], y: data[1], z: data[2]}, value: data[3]+1 )
        res.text cube.matrix.to_json
      else
        res.text cube.query(
          point1: {x: data[0], y: data[1], z: data[2]},
          point2: {x: data[3], y: data[4], z: data[5]}  ).to_json
      end
    end
  end
end

run(App)
