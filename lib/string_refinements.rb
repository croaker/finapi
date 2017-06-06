module StringRefinements
  refine String do
    def camelize
      self.dup.split(/_/).instance_eval { |a|
        [a.first] + a.drop(1).map(&:capitalize)
      }.join
    end
  end
end
