FactoryBot.define do
  factory :movie do
    title { 'Jaws' }
    year { 1975 }
    rated { 'PG' }
    released do
      DateTime.new(1975, 6, 20, 0, 0, 0)
    end
    genre { 'Adventure' }
    plot { "When a killer shark unleashes chaos on a beach community, it's up to a local sheriff, a marine biologist, and an old seafarer to hunt the beast down." }
    runtime {  '124 min' }
    language { 'Engish' }
  end
end

