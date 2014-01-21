class CubeAndEarthDistance < ActiveRecord::Migration
  def change
    execute 'CREATE EXTENSION IF NOT EXISTS cube'
    execute 'CREATE EXTENSION IF NOT EXISTS earthdistance'
  end
end
