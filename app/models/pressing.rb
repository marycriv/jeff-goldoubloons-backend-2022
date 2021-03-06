class Pressing < ApplicationRecord
    has_many :coins, -> { order('id') }

    before_create :slugify
    
    def slugify
        self.slug = name.parameterize
    end

end
