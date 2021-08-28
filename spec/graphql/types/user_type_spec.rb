require 'rails_helper'

RSpec.describe Types::UserType do
  set_graphql_type

  types = GraphQL::Define::TypeDefiner.instance

  it 'has the expected fields available' do
    expect(subject).to have_field(:id)
    expect(subject).to have_field(:id)
    expect(subject).to have_field(:username).of_type(!types.String)
    expect(subject).to have_field(:region).of_type(!types.String)
    expect(subject).to have_field(:biography).of_type(types.String)
    expect(subject).to have_field(:avatar).of_type(types.String)
    expect(subject).to have_field(:created_at).of_type('ISO8601DateTime!')
    expect(subject).to have_field(:updated_at).of_type('ISO8601DateTime!')
  end
end
