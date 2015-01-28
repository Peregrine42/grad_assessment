class Joiner
  def initialize(up_sep = '->', down_sep = '<-')
    @up_sep   = up_sep
    @down_sep = down_sep
  end

  def join(chain_up, manager, chain_down)
    chain_up << [nil]
    chain_down = [nil] + chain_down
    up_output   = chain_up.join(" #{@up_sep} ")
    down_output = chain_down.join(" #{@down_sep} ")

    up_output + manager.to_s + down_output
  end
end
