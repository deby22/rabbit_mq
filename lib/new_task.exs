# preparing
{:ok, connection} = AMQP.Connection.open()
{:ok, channel} = AMQP.Channel.open(connection)

# declare queue
AMQP.Queue.declare(channel, "task_queue", durable: true)

# declare message
message =
  case System.argv() do
    [] -> "Hello World!"
    words -> Enum.join(words, " ")
  end

# publish
AMQP.Basic.publish(channel, "", "task_queue", message, persistent: true)
IO.puts(" [x] Send '#{message}'")

# close connection
AMQP.Connection.close(connection)
