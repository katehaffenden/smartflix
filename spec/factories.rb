# frozen_string_literal: true

FactoryBot.define do
  factory :external_rating do
    source { "imdb" }
    rating { 1.5 }
  end

  factory :movie do
    title { 'Jaws' }
    year { 1975 }
    rated { 'PG' }
    released do
      Time.zone.local(1975, 6, 20, 0, 0, 0)
    end
    genre { 'Adventure' }
    plot do
      "When a killer shark unleashes chaos on a beach community, it's up to a local sheriff, a marine biologist,
      and an old seafarer to hunt the beast down."
    end
    runtime {  '124 min' }
    language { 'Engish' }
  end
end
