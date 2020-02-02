require './item.rb'

class List

    # print styles
    LINE_WIDTH = 50
    INDEX_COL_WIDTH = 5
    ITEM_COL_WIDTH = 20
    DEADLINE_COL_WIDTH = 10
    STATUS_COL_WIDTH = 8
    # CHECKMARK = "\u2713".force_encoding('utf-8')"" # pretty checkmark


    attr_reader :label, :items

    def initialize(label)
        @label = label
        @items = []
    end

    # setter for a new label
    def label=(new_label)
        @label = new_label
    end

    # method initialises a todo as a new instance of item and shovels it to items-arr
    def add_item(title, deadline, *description)
        
        # if description is not to function, new-description is set to an empty array.
        if description.empty?
            new_descr = ""
        else
            new_descr = description.first
        end

        new_item = Item.new(title, deadline, new_descr)

        @items << new_item
    end

    def size
        return @items.length
    end

    def valid_index?(index)
        # Index must be 0 or greater and smaller than the list´s size - 1 (index starts at 0)
        return false if index < 0 || index > self.size - 1
        true
    end

    def swap(index_1, index_2)
        # if both indeces are valid, items at indices are swapped
        # placeholder stores first item, first item is set to second item
        # second item is set to placeholder(first item)
        # returns true
        if valid_index?(index_1) && valid_index?(index_2)
            placeholder = items[index_1]
            items[index_1] = items[index_2]
            items[index_2] = placeholder
            return true
        end

        false
    end

    def [](index)
        if valid_index?(index)
            return items[index]
        end
        nil
    end

    def priority
        # returns first item of items array
        return @items[0]
    end

    def print
        
        puts "-" * LINE_WIDTH
        puts " " * 16 + self.label.upcase
        puts "-" * LINE_WIDTH
        puts "#{'Index'.ljust(INDEX_COL_WIDTH)} | #{'Item'.ljust(ITEM_COL_WIDTH)} | #{'Deadline'.ljust(DEADLINE_COL_WIDTH)} | #{'Status'.ljust(STATUS_COL_WIDTH)}"
        puts "-" * LINE_WIDTH
        @items.each_with_index do |item, i|
            status = :O
            if item.done
                status = :X
            end
            puts "#{i.to_s.ljust(INDEX_COL_WIDTH)} | #{item.title.ljust(ITEM_COL_WIDTH)} | #{item.deadline.ljust(DEADLINE_COL_WIDTH)} | #{status}"

        end
        puts "-" * LINE_WIDTH

    end

    def print_full_item(index)
        status = :OPEN
        if items[index].done
            status = :DONE
        end
        item = self[index]
        return if item.nil?
        puts "-" * LINE_WIDTH
        puts "#{item.title.ljust(LINE_WIDTH/2)}#{item.deadline.rjust(LINE_WIDTH/2)}"
        puts item.description
        puts
        puts "Current Status: #{status}"
        puts "-" * LINE_WIDTH
    end

    def print_priority
        # prints first item of items array
        self.print_full_item(0)
    end

    def up(index, amount = 1)

        return false if !self.valid_index?(index)

        # uses swap method
        # swaps as long as there are swaps (amount) left item and item with an index of 1 fewer (aka item above) are swapped
        while amount > 0 && index != 0
            swap(index, index - 1)
            index -= 1
            amount -= 1
        end

        true
    end
    
    def down(index, amount = 1)
        
        return false if !self.valid_index?(index)

        # same logic as in "up" only that index of item below (index +1) is used for swap
        while amount > 0 && index != self.size - 1
            swap(index, index + 1)
            index += 1
            amount -= 1
        end

        true
    end

    def sort_by_date!
        items.sort_by! { |ele| ele.deadline}
    end

    def toggle_item(index)
        @items[index].toggle
    end

    def remove_item(index)
        # deletes item at given index
        @items.delete_at(index)
    end

    def purge
        # models original @items arr (same memory position) to only include those with the status "done"
        @items.select! {|item| !item.done}
    end
end