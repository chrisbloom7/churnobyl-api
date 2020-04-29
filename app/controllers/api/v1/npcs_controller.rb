module Api::V1
  class NPCsController < ApiController
    before_action :set_npc, only: [:show, :update, :destroy]

    # GET /npcs
    def index
      @npcs = NPC.all

      render json: NPCSerializer.new(@npcs)
    end

    # GET /npcs/random
    def random
      @npc = NPC.random

      render json: NPCSerializer.new(@npc)
    end

    # GET /npcs/1
    def show
      render json: NPCSerializer.new(@npc)
    end

    # POST /npcs
    def create
      @npc = NPC.new(npc_params)

      if @npc.save
        render json: NPCSerializer.new(@npc), status: :created, location: @npc
      else
        render json: @npc.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /npcs/1
    def update
      if @npc.update(npc_params)
        render json: NPCSerializer.new(@npc)
      else
        render json: @npc.errors, status: :unprocessable_entity
      end
    end

    # DELETE /npcs/1
    def destroy
      @npc.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_npc
        @npc = NPC.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def npc_params
        params.require(:npc).permit(:age, :attitude, :ethnicity, :gender, :origin)
      end
  end
end
