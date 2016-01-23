class MessagesController < ApplicationController

	load_and_authorize_resource
	def index
		@messages = current_user.messages
	end

	def show
		other_person = @message.sender_id
		@conversation = Message.all.where("sender_id = #{other_person} OR reciever_id = #{other_person}").order(created_at: :DESC)
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

private

      def message_params
      params.require(:message).permit(:sender_id, :reciever_id, :message, :title, :read)
    end
end
