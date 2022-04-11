# frozen_string_literal: true
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Creating a Business professional', type: :feature) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_bpro]
    visit root_path
    click_on 'Sign in'
  end

  it 'bpro can view their own information' do
    create_business_professional(page)

    visit business_professional_path(BusinessProfessional.last.id)

    expect(page).to(have_content('bpro@example.com'))
  end

  it 'bpro can edit their own information' do
    create_business_professional(page)

    visit edit_business_professional_path(BusinessProfessional.last.id)
    fill_in 'Org name', with: 'TAMU'
    click_on 'Update account'

    expect(page).to(have_content('TAMU'))
  end

  it 'officers can see a bpro details' do
    create_business_professional(page)
    click_on 'Sign Out'

    other_account_id = BusinessProfessional.last.id

    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_admin]
    visit root_path
    click_on 'Sign in'
    create_student_member(page)

    page.set_rack_session(isAdmin: true)
    visit business_professional_path(other_account_id)

    expect(page).to(have_content('bpro@example.com'))
  end

  it 'officers can edit a bpro details' do
    create_business_professional(page)
    click_on 'Sign Out'

    other_account_id = BusinessProfessional.last.id

    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_admin]
    visit root_path
    click_on 'Sign in'
    create_student_member(page)

    page.set_rack_session(isAdmin: true)
    visit edit_business_professional_path(other_account_id)

    fill_in 'Org name', with: 'TAMU'
    click_on 'Update account'
    expect(page).to(have_content('TAMU'))
  end

  it 'members cannot see a bpro details' do
    create_business_professional(page)
    click_on 'Sign Out'

    other_account_id = BusinessProfessional.last.id

    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_admin]
    visit root_path
    click_on 'Sign in'
    create_student_member(page)

    visit business_professional_path(other_account_id)

    expect(page).to(have_content('You do not have the permission to access this page'))
  end

  it 'members cannot edit a bpro details' do
    create_business_professional(page)
    click_on 'Sign Out'

    other_account_id = BusinessProfessional.last.id

    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_admin]
    visit root_path
    click_on 'Sign in'
    create_student_member(page)

    visit edit_business_professional_path(other_account_id)

    expect(page).to(have_content('You do not have the permission to access this page'))
  end

  it 'bpro directed to dashboard after account creation' do
    create_business_professional(page)
    # expect(page).to(have_content('Hello'))
  end

  def create_business_professional(_page)
    visit(new_business_professional_path)

    fill_in('Org name', with: 'Company 1')
    fill_in('First name', with: 'John')
    fill_in('Last name', with: 'Doe')
    fill_in('Phone num', with: '+19798451234')
    fill_in('Email', with: 'bpro@email.com')
    click_on('Create account')
  end

  def create_student_member(_page)
    visit(new_student_member_path)
    fill_in('Uin', with: '328004941')
    fill_in('First name', with: 'Jiaming')
    fill_in('Last name', with: 'Fu')
    fill_in('Class year', with: '2023')
    select('2022', from: 'student_member_join_date_1i')
    select('May', from: 'student_member_join_date_2i')
    select('5', from: 'student_member_join_date_3i')
    fill_in('Phone number', with: '5127309368')
    select('2022', from: 'student_member_expected_graduation_date_1i')
    select('May', from: 'student_member_expected_graduation_date_2i')
    click_on('Create account')
  end
end
