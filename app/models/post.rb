class Post < ApplicationRecord
    # is expected to validate that :title cannot be empty/falsy
    # is expected to validate that the length of :content is at least 250
    # is expected to validate that the length of :summary is at most 250
    # is expected to validate that :category is either ‹"Fiction"› or ‹"Non-Fiction"›
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: ['Fiction', 'Non-Fiction'] }

#     Custom Validations
# Finally, add a custom validator to the Post model that ensures the title is sufficiently clickbait-y. The validator should add a validation error if the title does not contain:

# "Won't Believe"
# "Secret"
# "Top [number]"
# "Guess"

    validate :clickbait?


    def clickbait?
        # if clickbait is true (contains word in clickbait) continue...
        # if  clickbait is false show "error"
        if Clickbait.none? { |pattern| pattern.match title }
            errors.add(:title, "title is clickbait")
        end
    end

    Clickbait = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
    ]

end