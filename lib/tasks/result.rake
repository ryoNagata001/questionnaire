namespace :result do
  desc 'idを渡すと設問ごとの回答数を表示する'
  task :how_many,['survey_id'] => :environment do |task, args|
    survey = Survey.find(args.survey_id)
    questions = survey.questions
    questions.each do |question|
      user_ids = []
      if Question::TEXT_QUESTION_CATEGORY_IDS.include?(question.category_id)
        answers = question.answer_texts
        user_ids = answers.map{|answer| answer.id}.uniq
        puts "Q,#{question.title}: 回答#{user_ids.count}個"
      else
        choices = question.choices
        choices.each do |choice|
          answers = choice.answer_selects
          user_ids = answers.map{|answer| answer.user_id}.uniq
        end
        puts "Q,#{question.title}: 回答#{user_ids.count}人"
      end
    end
  end
end
