class StageIndex
  DATA = Struct.new(:page_name, :stages)
  PAGE_NAME = 'NC Folk Festival Stages'

  def self.all
    new.call
  end

  def call
    DATA.new(PAGE_NAME, Stage.ordered)
  end
end
