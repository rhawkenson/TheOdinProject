def caesar_cipher(message, shift)
  message_caesar = []
  message.bytes.each do |c|
    if (97..122).include?(c)
      c26 = c % 97 + shift % 26
      c26 = c26 < 0 ? (26 + c26) % 26 : c26 % 26
      message_caesar << c26 + 97
    elsif (65..90).include?(c)
      c26 = c % 65 + shift % 26
      c26 = c26 < 0 ? (26 + c26) % 26 : c26 % 26
      message_caesar << c26 + 65
    else
      message_caesar << c
    end
  end
  puts message_caesar.pack('c*')
end

caesar_cipher("What a string!", 5)