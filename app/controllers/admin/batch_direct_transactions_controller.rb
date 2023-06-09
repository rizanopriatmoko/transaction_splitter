class Admin::BatchDirectTransactionsController < AdminController
    before_action :set_transaction, only: [:show, :edit, :update] 
    before_action :set_single_trx, only: [:show_single, :regenerate_single]

    def index
      @q = BatchDirectTransaction.all.order(created_at: :desc).ransack(params[:q])
      @batch_trx = @q.result.paginate(:page => params[:page], :per_page => 10)
    end
  
    def show
      @q = SingleDirectTransaction.where(batch_id: @trx.id).order(created_at: :desc).ransack(params[:q])
      @single_trx= @q.result.paginate(:page => params[:page], :per_page => 10)
    end

    def show_single

    end

    def regenerate_single 
      @single.confirm! unless @single.confirmed?
      if @single.confirmed?
        respond_to do |format|
          format.json { render json: { status: 200, data: @transaction.as_json}}
          format.html { redirect_to request.referrer, notice: "Transaction has been regenerated"}
        end
      else
        respond_to do |format|
          format.json { render json: { status: 422, message: @transaction.errors }}
          format.html { redirect_to request.referrer, alert: "Unable to regenerate Transaction"}
        end
      end
      
    end
    

    def edit
      @batch_trx = @trx
    end

    def update
      @batch_trx = @trx
      respond_to do |format|
        if @batch_trx.update(payment_params)
          @batch_trx.confirm!
          format.html { redirect_to admin_batch_direct_transaction_url(@batch_trx.id), notice: 'Payment was successfully submitted.'}
          format.json { render :show, status: :ok, location: admin_batch_direct_transaction_url(@batch_trx.id) }
        else
          format.html { render :edit }
          format.json { render json: @batch_trx.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def new
      @batch_trx = BatchDirectTransaction.new
    end

    def create
      @batch_trx = BatchDirectTransaction.new(create_params)
      respond_to do |format|
        if @batch_trx.save
          format.html { redirect_to admin_batch_direct_transaction_url(@batch_trx.id), notice: 'Transaction was successfully quoted.' }
          format.json { render :show, status: :created, location: admin_batch_direct_transaction_url(@batch_trx.id) }
        else
          format.html { render :new }
          format.json { render json: @batch_trx.errors, status: :unprocessable_entity }
        end
      end
    end

  
    private
      def set_transaction
        @trx = BatchDirectTransaction.find_by(id: params[:id])
      end

      def set_single_trx
        @single = SingleDirectTransaction.find(params[:id])
      end
  
      def create_params
        params.require(:batch_direct_transaction).permit(:reference_id, :transaction_type, :currency, :amount, :amount_limit_per_trx, :bank_id)
      end

      def payment_params
        params.require(:batch_direct_transaction).permit(:bank_account_number, :purpose_of_remittance, :document_reference_number, recipient: {}, sender: {})
      end
end
  