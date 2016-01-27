class GroupItem < ActiveRecord::Base
  belongs_to :groupable, polymorphic: true
  belongs_to :group

  def item_name
    case groupable_type
    when "Person"
      groupable.fullname
    else
      groupable.name
    end
  end
end
