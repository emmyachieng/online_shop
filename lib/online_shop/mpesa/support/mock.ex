defmodule Mpesa.ClientMock do
  def generate_token(_) do
    {:ok,
     %Tesla.Env{
       status: 200,
       body: generate_token_response()
     }}
  end

  def transaction_status(_) do
    {:ok,
     %Tesla.Env{
       status: 200,
       body: transaction_status_response()
     }}
  end

  def customer_to_business(_) do
    {:ok,
     %Tesla.Env{
       status: 200,
       body: customer_to_business_response()
     }}
  end

  defp generate_token_response do
    %{
      "access_token" => "hGf6mSqHxffsGxEtqJ1odAouDaBH",
      "expires_in" => "3599"
    }
  end

  def transaction_status_response do
    %{
      "OriginatorConversationID" => "25022-95644889-1",
      "ConversationID" => "AG_20230713_2010625e2da43e22a68f",
      "ResponseCode" => "23",
      "ResponseDescription" =>
        "The element The value of Request.Identity.ReceiverParty.IdentifierType can not be Till Number is invalid."
    }
  end

  def customer_to_business_response do
    %{
      "OriginatorCoversationID" => "55925-20109533-1",
      "ResponseCode" => "0",
      "ResponseDescription" => "Success"
    }
  end
end
