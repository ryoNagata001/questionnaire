namespace :result do
  desc 'idを渡すと設問ごとの回答数を表示する'
  task :how_many,['survey_id'] => :environment do |task, args|
    survey = Survey.find(args.survey_id)
    questions = survey.questions
    questions.each do |question|
      if Question::TEXT_QUESTION_CATEGORY_IDS.include?(question.category_id)
        puts "Q,#{question.title}: 回答#{question.answer_texts.count}個"
      else
        user_ids = []
        question.choices.each do |choice|
          selected_users = choice.answer_selects.map{|answer| answer.user_id}
          user_ids.concat(selected_users)
        end
        puts "Q,#{question.title}: 回答#{user_ids.uniq.count}人"
      end
    end
  end
end
