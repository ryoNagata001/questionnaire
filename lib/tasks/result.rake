namespace :result do
  desc 'idを渡すと設問ごとの回答数を表示する'
  task :how_many,['question_id'] => :environment do |task, args|
    question = Question.find(args.question_id)
    id_number = []
    if question.category_id == 0 || question.category_id == 1
      answers = question.answer_text
      answers.each do |answer|
        unless id_number.include?(answer.id)
          id_number.push(answer.id)
        end
      end
    else
      choices = question.choices
      choices.each do |choice|
        answers = choice.answer_select
        answers.each do |answer|
          unless id_number.include?(answer.id)
            id_number.push(answer.id)
          end
        end
      end
    end
    p id_number.count
  end
end
