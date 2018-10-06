# frozen_string_literal: true

class Errors
  attr_reader :messages

  def initialize(messages)
    @messages = if messages.is_a? Hash
                  messages
                else
                  { default: Array(messages) }
                end
  end

  def empty?
    messages.empty?
  end

  def any?
    !empty?
  end

  def first
    messages[:default]&.first
  end

  def add_to(active_record)
    messages.each do |key, messages_array|
      messages_array.each do |message|
        active_record.errors.add(key, :invalid, message: message)
      rescue NoMethodError
        active_record.errors.add(:base, :invalid, message: message)
      end
    end
  end
end
