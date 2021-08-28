require 'rails_helper'

RSpec.describe Types::PostType do
  set_graphql_type

  types = GraphQL::Define::TypeDefiner.instance

  it 'has the expected fields available' do
    expect(subject).to have_field(:id).of_type(!types.ID)
    expect(subject).to have_field(:title).of_type(!types.String)
    expect(subject).to have_field(:description).of_type(!types.String)
    expect(subject).to have_field(:image).of_type(types.String)
    expect(subject).to have_field(:upvotes).of_type(types.Int)
    expect(subject).to have_field(:downvotes).of_type(types.Int)
    expect(subject).to have_field(:user_id).of_type(!types.Int)
    # require 'pry'; binding.pry
    expect(subject).to have_field(:createdAt).of_type('ISO8601DateTime!')
    expect(subject).to have_field(:updatedAt).of_type('ISO8601DateTime!')
  end
end
