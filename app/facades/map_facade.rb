class MapFacade
  def self.get_directions(from, to)
    directions = MapService.get_directions(from, to)
    directions[:route][:formattedTime]
  end
end
