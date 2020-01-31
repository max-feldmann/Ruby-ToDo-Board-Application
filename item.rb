class Item
    attr_reader :title, :deadline, :description, :done

    def self.valid_date?(date_string)

        # date-string is split into its components, yyyy, mm and dd
        # those are checked individually
        components = date_string.split("-")

        year = components[0]
        month = components[1]
        day = components[2]
        
        # year has to be exactly 4 numbers
        return false if year.length != 4
        # month has to be a two-digit-integer between 1 and 12
        return false if month.length != 2 || month.to_i > 12 || month.to_i < 1
        # day has to be a two-digit-integer between 1 and 31
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
        # setter for deadline. item has to have a valid deadline, so setter is written in a way that only a valid deadline can be set
        if Item.valid_date?(new_deadline)
            @deadline = new_deadline
        else
            raise ArgumentError, ("This is not a valid date :| It has to be in the format YYYY-MM-DD")
        end
    end

    def description=(new_description)
        #setter for description
        @description = new_description
    end

    def toggle
        # if status is not done, then its turned to done. otherwise its turned to open. (just a switcher for done)
        if @done == false
            @done = true
            return
        end
        @done = false

    end

end