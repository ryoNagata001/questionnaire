namespace :result do
  desc 'idを渡すと設問ごとの回答数を表示する'
  task :how_many,['survey_id'] => :environment do |task, args|
    survey = Survey.find(args.survey_id)
    questions = survey.questions
    questions.each do |question|
      id_number = []
      if question.category_id == 0 || question.category_id == 1
        answers = question.answer_texts
        answers.each do |answer|
          unless id_number.include?(answer.id)
            id_number.push(answer.id)
          end
        end
      else
        choices = question.choices
        choices.each do |choice|
          answers = choice.answer_selects
          answers.each do |answer|
            unless id_number.include?(answer.id)
              id_number.push(answer.id)
            end
          end
        end
      end
      puts "Q,#{question.title}: 回答#{id_number.count}人"
    end
  end
end
