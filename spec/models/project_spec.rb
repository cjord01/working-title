require 'rails_helper'

describe Project do
  before :each do
    @project = Project.create!(name: "Test", category_id: 1, initiator_id: 1)
    @initial_version = Version.create!(project_id: @project.id, contributor_id: 1, previous_version_id: nil, contribution: "Test Content 1", insertion_index: -1)
    Vote.create!(user_id: 1, voteable_id: @initial_version.id, voteable_type: "Version", positive: true)
  end

  describe '#get_popular_version' do
    it 'should return a version object' do
      expect(@project.get_popular_version).to be_kind_of(Version)
    end

    context 'winning logic' do
      before :each do
        @version_two = Version.create!(project_id: @project.id, contributor_id: 1, previous_version_id: @initial_version.id, contribution: "Test Content 2", insertion_index: -1)
        Vote.create!(user_id: 1, voteable_id: @version_two.id, voteable_type: "Version", positive: true)
        Vote.create!(user_id: 2, voteable_id: @version_two.id, voteable_type: "Version", positive: true)
      end

      it 'should return the version with the most votes' do
        expect(@project.get_popular_version).to eq(@version_two)
      end

      it 'should return the version with the longer branch when the votes are tied' do
        @version_three = Version.create!(project_id: @project.id, contributor_id: 1, previous_version_id: @version_two.id, contribution: "Test Content 3", insertion_index: -1)
        Vote.create!(user_id: 2, voteable_id: @version_three.id, voteable_type: "Version", positive: true)
        Vote.create!(user_id: 2, voteable_id: @version_three.id, voteable_type: "Version", positive: true)
        Vote.create!(user_id: 2, voteable_id: @version_three.id, voteable_type: "Version", positive: true)
        expect(@project.get_popular_version).to eq(@version_three)
      end

      it 'should return the most recent version when the votes and branch length are tied' do
        version_three = Version.create!(project_id: @project.id, contributor_id: 1, previous_version_id: @version_two.id, contribution: "Test Content 3", insertion_index: -1)
        sleep(1)
        version_four = Version.create!(project_id: @project.id, contributor_id: 1, previous_version_id: @version_two.id, contribution: "Test Content 3", insertion_index: -1)
        Vote.create!(user_id: 2, voteable_id: version_four.id, voteable_type: "Version", positive: true)
        Vote.create!(user_id: 2, voteable_id: version_four.id, voteable_type: "Version", positive: true)
        Vote.create!(user_id: 2, voteable_id: version_four.id, voteable_type: "Version", positive: true)
        expect(@project.get_popular_version).to eq(version_four)
      end
    end
  end
end
