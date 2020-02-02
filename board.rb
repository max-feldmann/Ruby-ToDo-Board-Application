require './list.rb'


class TodoBoard

    def initialize
        @lists = {}
        #@list = List.new(label)
    end

    def start
          puts "Welcome to Awesome-O Todo-Master 3000
        \n Do you want to start working?
        \n [y] to Start
        \n [n] to Quit
        \n "

        what = gets.chomp
        if what == "y" || what == "Y"
            self.run(true)
        elsif what == "n" || what == "N"
            self.run(false)
        end

        # self.run(what_do?) if what_do?
    end


    # Case is used for getting commands from user
    # variables are set up so that the command from the user is always first,then comes the target list and then an arbitrary amount of arguments
    # if a command is entered for that no case exists, method ends and returns true (is fired again by "run" then)
    # if a command is entered for that a case exists, the commands under that case are fired
    def get_command

        print "\nType a Command to get to work (e.g. make-list to start a new list of todo´s)
               \n( type <show-commands> to see your options)
               \n"

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
                @lists[target].add_item(*TodoBoard.todo_configurator(target))        # make-todo calls self.todo_configurator to get arguments for add_item
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

    # get_command return true in the end
    # with "run" get_command is repeatedly called
    # if user enters "quit" as command, false is returned
#     def run
#         while true
#             return if !get_command
#         end
#     end

    def run(set)
        while set
            return if !get_command
        end
    end

    # 3 steps take user through todo creation.
    def self.todo_configurator(target)
        args = []

        # first a name is asked
        print "\nEnter a name for your Todo!"
        puts

        label = gets.chomp
        args << label

        # second deadline is asked. Dealine calls helper function deadline_asker to get deadline.
        # This way always a correct deadline is returned and program does not break.
        print "\nCool, now enter a Deadline for your Todo! (Has to be YYYY-MM-DD)"
        puts

        deadline = self.deadline_asker
        args << deadline

        # Third a description is asked
        # Item.new always calls for description as an arg.
        # To make it optional, if no arg is given, empty string is shoveled
        print "\nAlmost there, now enter description (this is optional, you can leave it empty)!"
        puts
        description = gets.chomp

            if description.empty?
                args << ""
            else
                args << description
            end

        return args
    end

    # until a deadline is entered, that returns true when passed to Item.valid_date? (aka is a correctly formatted deadline)
    # the loop runs and repeatedly asks the user to fill in a deadline
    # if a correct deadline is entered, deadline is returned
    def self.deadline_asker
        correct_format = false
        while correct_format == false
            deadline = gets.chomp

            if Item.valid_date?(deadline)
                correct_cormat = true
                return deadline
            else
                puts "The date was not formatted correctly. Try again! \nHint: It has to be YYYY-MM-DD (with the -)"
            end
        end
    end


end


TodoBoard.new.start