# lib/loc_mods/base_mapper.rb
require "shale"
require_relative "comparable_mapper"

module LocMods
  class BaseMapper < Shale::Mapper
    include ComparableMapper
  end
end
