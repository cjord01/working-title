class Version < ActiveRecord::Base
  belongs_to :project
  belongs_to :previous_version, class_name: "Version"
  belongs_to :contributor, class_name: "User"
  has_many :votes, as: :voteable


  def ancestors
    ancestors = []
    ancestor = self.previous_version
    until ancestor == nil
      ancestors << ancestor
      ancestor = ancestor.previous_version
    end
    ancestors
  end

  def ancestors_text
    ancestors.map(&:contribution)
  end

  def branch
    ancestors << self
  end

  def branch_text
    branch.map(&:contribution)
  end

  def calculate_branch_vote_score
    branch.reduce(0) do |score, branchee|
      score + branchee.votes.count
    end
  end

end
