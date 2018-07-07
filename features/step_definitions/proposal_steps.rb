Given(/^there is a proposal called 'This is a great talk' that has been submitted to 'Boo Ruby 2017'$/) do
  event = create(:event, name: 'Boo Ruby', id: 17)
  create(:event_instance, event_id: 17, year: 2017, id: 18)
  create(:proposal, title: 'This is a great talk', id: 3)
  create(:submission, proposal_id: 3, event_instance_id: 18)
end

Given('he/she/they has/have a proposal called {string} with the body {string}') do |title, body|
  create(:proposal, title: title, body: body, speaker: @speaker)
end

Given(/^there is a proposal called 'Reading Code Good'$/) do
  speaker = create(:speaker, name: 'Saron Yitbarek')
  create(:proposal, id: 1, title: 'Reading Code Good', speaker: speaker)
end

Given('he/she/they does/do not have any proposals') do
  expect(Proposal.find_by(speaker_id: @speaker.id)).to be_nil
end

Given(/^I am on the 'Add a Proposal' page$/) do
  visit new_proposal_path
end

When(/^I add her proposal with the following information:$/) do |table|
  proposal_information = table.raw.to_h
  page.select('Saron Yitbarek', from: :proposal_speaker_id)
  page.fill_in(:proposal_title, with: proposal_information['title'])
  page.fill_in(:proposal_body, with: proposal_information['body'])
  page.click_on('Add proposal')
end

When(/^I visit the proposal page for 'Reading Code Good'$/) do
  visit speakers_path
  page.click_on('Saron Yitbarek')
  page.click_on('Reading Code Good')
end

When(/^I change the title to 'Reading Code Well'/) do
  page.fill_in(:proposal_title, with: 'Reading Code Well')
end

When('I create a proposal for her/him/them') do
  create(:proposal, speaker: @speaker)
end
