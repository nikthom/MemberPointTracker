module ApplicationHelper
    def sortable_members(column, title = nil)
        title ||= column.titleize
        css_class = column == sort_column_members ? "current #{sort_direction_members}" : nil
        direction = column == sort_column_members && sort_direction_members == "ASC" ? "DESC" : "ASC"
        link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    end

    def sortable_officers(column, title = nil)
        title ||= column.titleize
        css_class = column == sort_column_officers ? "current #{sort_direction_officers}" : nil
        direction = column == sort_column_officers && sort_direction_officers == "ASC" ? "DESC" : "ASC"
        link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    end

end
