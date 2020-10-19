module RandomTables
  extend self

  def klass(generator)
    return nil unless exists?(generator)
    RandomTables.const_get(generator)
  end

  def exists?(generator)
    RandomTables.const_defined?(generator) &&
      RandomTables.const_get(generator).is_a?(Class)
  rescue NameError
    false
  end
end
