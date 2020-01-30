require './list.rb'


class TodoBoard

    def initialize
        @lists = {}
        #@list = List.new(label)
    end


    def get_command

        print "\nWhat do you want to do? ( type <show-commands> to see option) "

        cmd, target, *args = gets.chomp.split(' ')

        
        case cmd
            when 'up'
                @lists[target].up(*args.map(&:to_i))
            when 'down'
                @lists[target].down(*args.map(&:to_i))
            when 'swap'
                @lists[target].swap(*args.map(&:to_i))
            when 'sort'
                @lists[target].sort_by_date!
            when 'priority'
                @lists[target].print_priority
            when 'print'
                if args.empty?
                    @lists[target].print
                else
                    @lists[target].print_full_item(*args.first.to_i)
                end
            when 'make-list'
                @lists[target] = List.new(target.to_s)
            when 'ls'
                @lists.each_key do |key|
                    puts key
                end
            when 'showall'
                @lists.each do |k, v|
                    v.print
                end
            when 'make-todo'
                @lists[target].add_item(*TodoBoard.todo_configurator)        # make-todo calls self.todo_configurator to get arguments for add_item
            when 'remove'
                @lists[target].remove_item(*args.first.to_i)
            when 'quit'
                return false
            when 'check'
                @lists[target].toggle_item(*args.first.to_i)
            when 'purge'
                @lists[target].purge
            when 'show-commands' || '<show-commands>'
                puts
                p "You can type the following commands, followed by the parameters (all seperated by " " and withouth the <>)"
                puts "---"
                puts "CREATE LISTS AND TODO-ITEMS"
                p "make-list <list name>"
                p "=> (Create a new list)"
                p "make-todo <list name>"
                p "=> (Create a new todo)"
                p "---"
                p "DISPLAY LISTS AND TODO ITEMS"
                p "print <list name>"
                p "=> (Print a specific list)"
                p "print <list name> <item-index>"
                p "=> (shows more detail on specific item on list)" 
                p "ls" 
                p "=> (shows all lists)"
                p "priority <list name>"
                p "=> (shows top item on list)"
                p "---"
                p "MANAGE LISTS AND TODO ITEMS"
                p "sort <list name>"
                p "=> (sorts list by deadline)"
                p "swap <list name> <index1> <index2>"
                p "=> (swaps items with the indexes on list)"
                p "up <list name> <index> <optional amount of ups>"
                p "=> (moves item with index UP on list. If no amout is put, item is moved up once. If amount is put, item is moved up amount times."
                p "down <index> <optional amount of downs>"
                p "=> (moves item with index DOWN on list. If no amout is put, item is moved down once. If amount is put, item is moved down amount times."
                p "remove <list name> <item-index>"
                p "=> (Removes item with index on list)"
                p "check < list name> <item-index>"
                p "=> (Checks off/marks as done item index on list)"
                p "---"
                p "END THE PROGRAM"
                p "quit"
                p "=> (ends program)"

            else
                print "Sorry, that command is not recognized."
        end

        true
    end

    def run
        while true
            return if !get_command
        end
    end

    def self.todo_configurator      # User is lead through todo-creation in 3 steps
        args = []

        print "\nEnter a name for your Todo!"
        puts

        label = gets.chomp
        args << label

        print "\nCool, now enter a Deadline for your Todo! (Has to be YYYY-MM-DD)"
        puts
        deadline = gets.chomp
        args << deadline

        print "\nAlmost there, now enter description (this is optional, you can leave it empty)!"
        puts
        description = gets.chomp

            if description.empty?         # if description given by user is empty, empty string "" is shoveled to args.
                args << ""
            else
                args << description
            end

        return args
    end
end


TodoBoard.new.run