class Project < ActiveRecord::Base
  belongs_to :initiator, class_name: "User"
  has_many :votes, as: :voteable
  has_many :versions
  belongs_to :category

  def get_popular_version

    version = self.versions.sort_by do |element|
      [element.votes.count, element.branch.length, element.updated_at]
    end
    return version.last
  end

  def calculate_vote_score
    self.versions.reduce(0) do |score, version|
      score + version.votes.count
    end
  end


end
