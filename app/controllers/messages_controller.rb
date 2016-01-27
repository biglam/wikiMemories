class MessagesController < ApplicationController

	load_and_authorize_resource
	def index
		@messages = current_user.messages.order(created_at: :DESC)
	end

	def show
    # binding.pry;''
		@other_person = current_user == @message.sender ? @message.reciever : @message.sender
    # messages = Message.where("sender_id = #{@message.sender_id} OR reciever_id = #{@message.sender_id}").order(created_at: :DESC)
		@conversation = current_user.conversation_with(@other_person)
		@message.read = true
		@message.save
    # @message = @conversation
	end

  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { render @message}
        format.json { render @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

private

      def message_params
      params.require(:message).permit(:sender_id, :reciever_id, :message, :title, :read)
    end
end
