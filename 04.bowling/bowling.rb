# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

frames.each do |s|
  s.pop if s[0] == 10
end

last_frame = frames[9..].flatten
frames = frames.take(9) << last_frame

n = 0
point = 0
frames.each do |frame|
  n += 1
  next_frame = frames[n]

  point += if frame == [10] && next_frame == [10]
             frame[0] + next_frame[0] + frames[n + 1][0]
           elsif frame == [10]
             frame[0] + next_frame[0] + next_frame[1]
           elsif frame.sum == 10 && frame[2].nil?
             frame.sum + next_frame[0]
           else
             frame.sum
           end
end

puts point
