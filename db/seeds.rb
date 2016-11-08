%w(baseball basketball football hockey soccer).each do |name|
  Sport.find_or_create(name: name)
end

sports = Sport.all.reduce({}) { |h, s| h[s.name] = s.id; h }
[
  { abbreviation: 'MLB', name: 'Major League Baseball', sport: 'baseball' },
  { abbreviation: 'MLS', name: 'Major League Soccer', sport: 'soccer' },
  { abbreviation: 'NBA', name: 'National Basketball Association', sport: 'basketball' },
  { abbreviation: 'NFL', name: 'National Football League', sport: 'football' },
  { abbreviation: 'NHL', name: 'National Hockey League', sport: 'hockey' },
].each do |league|
  League.find_or_create(
    abbreviation: league[:abbreviation],
    name: league[:name],
    sport_id: sports[league[:sport]],
  )
end
