class TvShow < ApplicationRecord
    # METHOD 3: PG Search (multi-models)
    include PgSearch::Model
    multisearchable against: [:title, :synopsis]
end
