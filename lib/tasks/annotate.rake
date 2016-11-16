desc 'Annotate all model files'
task annotate: :environment do
  puts Annotator.annotate
end
