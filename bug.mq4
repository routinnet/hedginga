//+------------------------------------------------------------------+
//|                                           Hedging Strategy.mq4   |
//|                          Copyright 2022, Routinnet Solutions     |
//|                                       https://routinnet.com      |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Routinnet Solutions"
#property link      "https://routinnet.com"
#property version   "1.00"
#property strict

extern double LotSize = 0.01;
extern double MaxRiskPercentage = 2;
extern double TakeProfit = 100;
extern double StopLoss = 50;
extern double TrailingStop = 20;
extern double TrailingStep = 5;
extern double MaxOrders = 5;

int totalOrders;
double lotSize;
double accountEquity;
double maxRisk;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    Print("Hedging Strategy Initialized!");
    lotSize = NormalizeDouble(LotSize, 2);
    maxRisk = MaxRiskPercentage / 100.0;
    return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    Print("Hedging Strategy Deinitialized with reason:", reason);
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    accountEquity = AccountEquity();
    
    if(totalOrders < MaxOrders && LotSizeByRisk() <= MarketInfo(Symbol(), MODE_MAXLOT))
    {
        if(CountBuyOrders() == CountSellOrders())
        {
            OpenInitialOrders();
        }
        else
        {
            OpenHedgeOrders();
        }
    }
    else
    {
        CloseAllOrders();
    }
    
    TrailingStopOrders();
}

//+------------------------------------------------------------------+
//| Calculate Lot Size based on Maximum Risk Allowed                 |
//+------------------------------------------------------------------+
double LotSizeByRisk()
{
    double stopLossPips = StopLoss * MarketInfo(Symbol(), MODE_POINT);
    double lotSizeByRisk = NormalizeDouble(accountEquity * maxRisk / stopLossPips, 2);
    return MathMin(lotSizeByRisk, lotSize * MaxOrders);
}

//+------------------------------------------------------------------+
//| Open Initial Orders (Buy and Sell)                                |
//+------------------------------------------------------------------+
void OpenInitialOrders()
{
    if(totalOrders == 0)
    {
        double ask = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
        double bid = SymbolInfoDouble(Symbol(), SYMBOL_BID);
        double buyPrice = NormalizeDouble(ask + StopLoss * MarketInfo(Symbol(), MODE_POINT), 5);
        double sellPrice = NormalizeDouble(bid - StopLoss * MarketInfo(Symbol(), MODE_POINT), 5);
        double buyStopLoss = NormalizeDouble(buyPrice - StopLoss * MarketInfo(Symbol(), MODE_POINT), 5);
        double sellStopLoss = NormalizeDouble(sellPrice + StopLoss * MarketInfo(Symbol(), MODE_POINT), 5);
        double buyTakeProfit = NormalizeDouble(buyPrice + TakeProfit * MarketInfo(Symbol(), MODE_POINT), 5);
        double sellTakeProfit = NormalizeDouble(sellPrice - TakeProfit * MarketInfo(Symbol(), MODE_POINT), 5);
        double buyVolume = NormalizeDouble(lotSizeByRisk() * StopLoss * MarketInfo(Symbol(), MODE_POINT), 2);
        double sellVolume = NormalizeDouble(lotSizeByRisk() * StopLoss * MarketInfo(Symbol(), MODE_POINT), 2);
            // Opening Buy Order
    int buyTicket = OrderSend(Symbol(), OP_BUY, buyVolume, buyPrice, 5, buyStopLoss, buyTakeProfit, "Buy", 0, 0, Green);
    if(buyTicket > 0)
    {
        totalOrders++;
        Print("Buy Order opened successfully with Ticket #", buyTicket);
    }
    else
    {
        Print("Error opening Buy Order with error code", GetLastError());
    }
    
    // Opening Sell Order
    int sellTicket = OrderSend(Symbol(), OP_SELL, sellVolume, sellPrice, 5, sellStopLoss, sellTakeProfit, "Sell", 0, 0, Red);
    if(sellTicket > 0)
    {
        totalOrders++;
        Print("Sell Order opened successfully with Ticket #", sellTicket);
    }
    else
    {
        Print("Error opening Sell Order with error code", GetLastError());
    }
}
}

//+------------------------------------------------------------------+
//| Open Hedge Orders |
//+------------------------------------------------------------------+
void OpenHedgeOrders()
{
    double ask = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
    double bid = SymbolInfoDouble(Symbol(), SYMBOL_BID);
    double lastBuyPrice = OrderSelect(CountBuyOrders() - 1, SELECT_BY_POS, MODE_TRADES) ? OrderOpenPrice() : 0;
    double lastSellPrice = OrderSelect(CountSellOrders() - 1, SELECT_BY_POS, MODE_TRADES) ? OrderOpenPrice() : 0;
    double buyPrice = NormalizeDouble(lastSellPrice + StopLoss * MarketInfo(Symbol(), MODE_POINT), 5);
    double sellPrice = NormalizeDouble(lastBuyPrice - StopLoss * MarketInfo(Symbol(), MODE_POINT), 5);
    double buyStopLoss = NormalizeDouble(buyPrice - StopLoss * MarketInfo(Symbol(), MODE_POINT), 5);
    double sellStopLoss = NormalizeDouble(sellPrice + StopLoss * MarketInfo(Symbol(), MODE_POINT), 5);
    double buyTakeProfit = NormalizeDouble(buyPrice + TakeProfit * MarketInfo(Symbol(), MODE_POINT), 5);
    double sellTakeProfit = NormalizeDouble(sellPrice - TakeProfit * MarketInfo(Symbol(), MODE_POINT), 5);
    double buyVolume = NormalizeDouble(lotSizeByRisk() * StopLoss * MarketInfo(Symbol(), MODE_POINT), 2);
    double sellVolume = NormalizeDouble(lotSizeByRisk() * StopLoss * MarketInfo(Symbol(), MODE_POINT), 2);
    
    if(lastBuyPrice == 0 || lastSellPrice == 0)
    {
        Print("Cannot Open Hedge Orders, Buy or Sell Position Not Found!");
        return;
    }
    
    if(lastBuyPrice > lastSellPrice)
    {
        OpenSellOrder(sellVolume, sellPrice, sellStopLoss, sellTakeProfit);
    }
    else if(lastBuyPrice < lastSellPrice)
    {
        OpenBuyOrder(buyVolume, buyPrice, buyStopLoss, buyTakeProfit);
    }
}


//+------------------------------------------------------------------+
//| Close all Orders |
//+------------------------------------------------------------------+
void CloseAllOrders()
{
int total = OrdersTotal();
for(int i=total-1; i>=0; i--)
{
    if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
    {
        if(OrderSymbol() == Symbol() && (OrderType() == OP_BUY || OrderType() == OP_SELL))
        {
            bool closed = OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(SymbolInfoDouble(Symbol(), SYMBOL_BID), 5), 5, Red);
            if(closed)
            {
                totalOrders--;
                Print("Order closed successfully with Ticket #", OrderTicket());
            }
            else
            {
                Print("Error closing Order with error code", GetLastError());
            }
        }
    }
}
}

//+------------------------------------------------------------------+
//| Trailing Stop Orders |
//+------------------------------------------------------------------+
void TrailingStopOrders()
{
int total = OrdersTotal();
for(int i=total-1; i>=0; i--)
{
    if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
    {
        if(OrderSymbol() == Symbol() && (OrderType() == OP_BUY || OrderType() == OP_SELL))
        
}

//+------------------------------------------------------------------+
//| Close All Open Orders |
//+------------------------------------------------------------------+
void CloseAllOrders()
{
int total = OrdersTotal();
}

//+------------------------------------------------------------------+
//| Close All Open Orders |
//+------------------------------------------------------------------+
void CloseAllOrders()
{
int total = OrdersTotal();
for(int i=total-1; i>=0; i--)
{
    if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
    {
        if(OrderSymbol() == Symbol() && (OrderType() == OP_BUY || OrderType() == OP_SELL))
        {
            if(OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red))
            {
                totalOrders = 0;
            }
        }
    }
}
}

//+------------------------------------------------------------------+
//| Trailing Stop Orders |
//+------------------------------------------------------------------+
void TrailingStopOrders()
{
int total = OrdersTotal();
for(int i=total-1; i>=0; i--)
{
    if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
    {
        if(OrderSymbol() == Symbol() && (OrderType() == OP_BUY || OrderType() == OP_SELL))
        {
            double orderOpenPrice = OrderOpenPrice();
            double currentStopLoss = OrderStopLoss();
            double currentTakeProfit = OrderTakeProfit();
            
            if(OrderType() == OP_BUY && currentTakeProfit < SymbolInfoDouble(Symbol(), SYMBOL_BID) - TrailingStop * MarketInfo(Symbol(), MODE_POINT))
            {
                if(OrderModify(OrderTicket(), OrderOpenPrice(), NormalizeDouble(SymbolInfoDouble(Symbol(), SYMBOL_BID) - TrailingStop * MarketInfo(Symbol(), MODE_POINT), 5), currentTakeProfit, 0, Blue))
                {
                    currentStopLoss = NormalizeDouble(SymbolInfoDouble(Symbol(), SYMBOL_BID) - TrailingStop * MarketInfo(Symbol(), MODE_POINT), 5);
                }
            }
            
            if(OrderType() == OP_SELL && currentTakeProfit > SymbolInfoDouble(Symbol(), SYMBOL_ASK) + TrailingStop * MarketInfo(Symbol(), MODE_POINT))
            {
                if(OrderModify(OrderTicket(), OrderOpenPrice(), NormalizeDouble(SymbolInfoDouble(Symbol(), SYMBOL_ASK) + TrailingStop * MarketInfo(Symbol(), MODE_POINT), 5), currentTakeProfit, 0, Blue))
                {
                    currentStopLoss = NormalizeDouble(SymbolInfoDouble(Symbol(), SYMBOL_ASK) + TrailingStop * MarketInfo(Symbol(), MODE_POINT), 5);
                }
            }
            
            if(currentStopLoss < orderOpenPrice + TrailingStep * MarketInfo(Symbol(), MODE_POINT) && currentStopLoss >= orderOpenPrice)
            {
                if(OrderModify(OrderTicket(), OrderOpenPrice(), NormalizeDouble(currentStopLoss + TrailingStep * MarketInfo(Symbol(), MODE_POINT), 5), currentTakeProfit, 0, Blue))
                {
                    currentStopLoss = NormalizeDouble(currentStopLoss + TrailingStep * MarketInfo(Symbol(), MODE_POINT), 5);
                }
            }
        }
    }
}
}

//+------------------------------------------------------------------+
//| Calculate Net Orders |
//+------------------------------------------------------------------+
int NetOrders()
{
return(CountBuyOrders() - CountSellOrders());
}

//+------------------------------------------------------------------+
//| Count Buy Orders |
//+------------------------------------------------------------------+
int CountBuyOrders()
{
int total = OrdersTotal();
int buyOrders = 0;
for(int i=total-1; i>=0; i--)
{
    if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
    {
        if(OrderSymbol() == Symbol() && OrderType() == OP_BUY)
        {
            buyOrders++;
        }
    }
}

return buyOrders;
int CountSellOrders()
{
int sellOrders = 0;
int total = OrdersTotal();
for(int i = total - 1; i >= 0; i--)
{
if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
{
if(OrderSymbol() == Symbol() && (OrderType() == OP_SELL || OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT))
{
sellOrders++;
}
}
}
return sellOrders;
}

//+------------------------------------------------------------------+
//| Calculate Trailing Stop for Orders |
//+------------------------------------------------------------------+
void TrailingStopOrders()
{
int total = OrdersTotal();
for(int i = total - 1; i >= 0; i--)
{
if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
{
if(OrderSymbol() == Symbol() && (OrderType() == OP_BUY || OrderType() == OP_SELL))
{
if(OrderType() == OP_BUY)
{
double currentTrailingStop = NormalizeDouble(OrderOpenPrice() + TrailingStop * MarketInfo(Symbol(), MODE_POINT), 5);
double currentTrailingStep = NormalizeDouble(TrailingStep * MarketInfo(Symbol(), MODE_POINT), 5);
if(OrderStopLoss() < currentTrailingStop - currentTrailingStep)
{
OrderModify(OrderTicket(), OrderOpenPrice(), currentTrailingStop, OrderTakeProfit(), 0, Blue);
}
}
else if(OrderType() == OP_SELL)
{
double currentTrailingStop = NormalizeDouble(OrderOpenPrice() - TrailingStop * MarketInfo(Symbol(), MODE_POINT), 5);
double currentTrailingStep = NormalizeDouble(TrailingStep * MarketInfo(Symbol(), MODE_POINT), 5);
if(OrderStopLoss() > currentTrailingStop + currentTrailingStep)
{
OrderModify(OrderTicket(), OrderOpenPrice(), currentTrailingStop, OrderTakeProfit(), 0, Blue);
}
}
}
}
}
}

//+------------------------------------------------------------------+
//| Close All Orders |
//+------------------------------------------------------------------+
void CloseAllOrders()
{
int total = OrdersTotal();
for(int i = total - 1; i >= 0; i--)
{
if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
{
if(OrderSymbol() == Symbol())
{
if(OrderType() == OP_BUY || OrderType() == OP_SELL)
{
OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red);
}
else if(OrderType() == OP_BUYSTOP || OrderType() == OP_SELLSTOP || OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT)
{
OrderDelete(OrderTicket());
}
}
}
}
}
