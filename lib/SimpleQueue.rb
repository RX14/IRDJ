require 'thread'

##TODO: Comments/Doc
class SimpleQueue
    include Enumerable

    attr_reader :store
    attr_reader :mutex

    def initialize
        @store   = Array.new
        @mutex   = Mutex.new
    end

    def pop
        r = nil
        loop do
            r = pop_nonblock
            return r unless r == nil
            sleep 0.1
        end
    end

    def pop_nonblock
        @mutex.synchronize { @store.shift }
    end

    def push(object)
        @mutex.synchronize do
            @store.push(object)
            @store.size
        end
    end

    def size
        @store.size
    end

    def to_a
        @store
    end

    def [](index)
        @store[index]
    end

    def []=(index, object)
        @mutex.synchronize { @store[index] = object }
    end

    def <<(object)
        push(object)
    end

    def each(&block)
        @store.each do |val|
            if block_given?
                block.call val
            else
                yield val
            end
        end
    end
end
