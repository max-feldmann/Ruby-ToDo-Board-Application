class Item
    # this is a change
    attr_reader :title, :deadline, :description, :done

    def self.valid_date?(date_string)

        components = date_string.split("-")

        year = components[0]
        month = components[1]
        day = components[2]
        
        return false if year.length != 4
        return false if month.length != 2 || month.to_i > 12 || month.to_i < 1
        return false if day.length != 2 || day.to_i > 31 || day.to_i < 1

        true
    end

    def initialize(title, deadline, description)
        @title = title
        if Item.valid_date?(deadline)
            @deadline = deadline 
        else
            raise ArgumentError, ("This is not a valid date :| It has to be in the format YYYY-MM-DD")
            @description = description
        end
        @description = description
        @done = false
    end

    def title=(new_title)
        @title = new_title
    end

    def deadline=(new_deadline)
        if Item.valid_date?(new_deadline)
            @deadline = new_deadline
        else
            raise ArgumentError, ("This is not a valid date :| It has to be in the format YYYY-MM-DD")
        end
    end

    def description=(new_description)
        @description = new_description
    end

    def toggle
        if @done == false
            @done = true
            return
        end
        @done = false

    end

end