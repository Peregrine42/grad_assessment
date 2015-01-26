class Joiner

  def initialize up_sep='->', down_sep='<-'
    @up_sep   = up_sep
    @down_sep = down_sep
  end

  def join chain_up, common_manager, chain_down
    "#{chain_up.join(" #{@up_sep} ")} #{@up_sep} #{common_manager} #{@down_sep} #{chain_down.join(" #{@down_sep} ")}"
  end

end
