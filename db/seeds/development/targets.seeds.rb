require_relative 'helper'

after 'development:target_groups' do
  puts 'Seeding targets'

  batch = Batch.find_by(batch_number: 7)
  founder = Founder.find_by(email: 'someone@sv.co')

  # 1st week 1st group targets - all completed
  target_group = batch.program_weeks.find_by(number: 1).target_groups.find_by(sort_index: 1)
  target_details = [
    { title: 'Add Info to your Startup Profile', role: 'product', type: Target::TYPE_TODO, days: 7 },
    { title: 'Add Info to your Founder Profile', role: 'founder', type: Target::TYPE_TODO, days: 7 },
    { title: 'Join Public Slack', role: 'founder', type: Target::TYPE_TODO, days: 3 }
  ]

  target_details.each do |details|
    target = Target.create!(
      title: details[:title],
      role: details[:role],
      description: Faker::Lorem.words(10).join(' '),
      target_type: details[:type],
      days_to_complete: details[:days],
      target_group: target_group,
      batch: batch
    )

    founder.timeline_events.create!(
      startup: founder.startup,
      timeline_event_type: TimelineEventType.all.sample,
      event_on: batch.start_date + 3.days,
      description: Faker::Lorem.words(10).join(' '),
      verified_status: TimelineEvent::VERIFIED_STATUS_VERIFIED,
      verified_at: 1.week.ago,
      target: target
    )
  end

  # 1st week 2nd group targets - partially completed
  target_group = batch.program_weeks.find_by(number: 1).target_groups.find_by(sort_index: 2)
  target_details = [
    { title: 'Apply for a Passport', role: 'founder', type: Target::TYPE_TODO, days: 5 },
    { title: 'Open a Personal Bank Account', role: 'founder', type: Target::TYPE_TODO, days: 10 },
    { title: 'Confirm Partnership Registration', role: 'product', type: Target::TYPE_TODO, days: 10 },
    { title: 'Apply for a Company PAN Card', role: 'product', type: Target::TYPE_TODO, days: 20 },
    { title: 'Open Company Bank Account', role: 'product', type: Target::TYPE_TODO, days: 15 },
    { title: 'Apply for AWS Credits', role: 'product', type: Target::TYPE_TODO, days: 15 }
  ]

  target_details.each do |details|
    Target.create!(
      title: details[:title],
      role: details[:role],
      description: Faker::Lorem.words(10).join(' '),
      target_type: details[:type],
      days_to_complete: details[:days],
      target_group: target_group,
      batch: batch
    )
  end

  # mark one target as not accepted
  founder.timeline_events.create!(
    startup: founder.startup,
    timeline_event_type: TimelineEventType.all.sample,
    event_on: batch.start_date + 5.days,
    description: Faker::Lorem.words(10).join(' '),
    verified_status: TimelineEvent::VERIFIED_STATUS_NOT_ACCEPTED,
    target: target_group.targets.find_by(title: 'Confirm Partnership Registration')
  )

  # add a prerequisite for one target
  target_group.targets.find_by(title: 'Apply for a Company PAN Card').prerequisite_targets << target_group.targets.find_by(title: 'Confirm Partnership Registration')

  # mark one target as pending
  founder.timeline_events.create!(
    startup: founder.startup,
    timeline_event_type: TimelineEventType.all.sample,
    event_on: batch.start_date + 9.days,
    description: Faker::Lorem.words(10).join(' '),
    verified_status: TimelineEvent::VERIFIED_STATUS_PENDING,
    target: target_group.targets.find_by(title: 'Open Company Bank Account')
  )

  # mark one target as needs improvement
  founder.timeline_events.create!(
    startup: founder.startup,
    timeline_event_type: TimelineEventType.all.sample,
    event_on: batch.start_date + 9.days,
    description: Faker::Lorem.words(10).join(' '),
    verified_status: TimelineEvent::VERIFIED_STATUS_NEEDS_IMPROVEMENT,
    target: target_group.targets.find_by(title: 'Apply for AWS Credits')
  )

  # 1st week 3rd group targets - all pending
  target_group = batch.program_weeks.find_by(number: 1).target_groups.find_by(sort_index: 3)
  target_details = [
    { title: 'Framework Expectations', role: 'product', type: Target::TYPE_ATTEND, days: 20 },
    { title: 'Town Hall #1', role: 'product', type: Target::TYPE_ATTEND, days: 1 },
    { title: 'What is SaaS?', role: 'product', type: Target::TYPE_ATTEND, days: 1 }
  ]

  target_details.each do |details|
    Target.create!(
      title: details[:title],
      role: details[:role],
      description: Faker::Lorem.words(10).join(' '),
      target_type: details[:type],
      days_to_complete: details[:days],
      target_group: target_group,
      batch: batch
    )
  end

  # 1st week 4th group target - pending
  Target.create!(
    title: "Freshdesk's Story",
    role: 'product',
    description: Faker::Lorem.words(10).join(' '),
    target_type: Target::TYPE_ATTEND,
    days_to_complete: 1,
    target_group: batch.program_weeks.find_by(number: 1).target_groups.find_by(sort_index: 4),
    batch: batch
  )

  # 1st week 5th group targets - all pending
  target_group = batch.program_weeks.find_by(number: 1).target_groups.find_by(sort_index: 5)
  target_details = [
    { title: 'Study the Idea Library', role: 'product', type: Target::TYPE_TODO, days: 14 },
    { title: 'Shortlist Ideas', role: 'product', type: Target::TYPE_TODO, days: 14 },
    { title: 'Design Experiments, Surveys & Interviews', role: 'product', type: Target::TYPE_TODO, days: 20 }
  ]

  target_details.each do |details|
    Target.create!(
      title: details[:title],
      role: details[:role],
      description: Faker::Lorem.words(10).join(' '),
      target_type: details[:type],
      days_to_complete: details[:days],
      target_group: target_group,
      batch: batch
    )
  end
end
