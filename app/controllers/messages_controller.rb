class MessagesController < ApplicationController

	load_and_authorize_resource
	def index
		@messages = current_user.messages.order(created_at: :DESC)
	end

	def show #thank you michael
		@other_person = current_user == @message.sender ? @message.reciever : @message.sender
		@conversation = current_user.conversation_with(@other_person)
		@message.read = true
		@message.save
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

  def edit
    render :json => @messages = current_user.messages.order(created_at: :DESC)[0].to_json
  end

private

      def message_params
      params.require(:message).permit(:sender_id, :reciever_id, :message, :title, :read)
    end
end
