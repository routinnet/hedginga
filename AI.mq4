// Input Parameters
extern double Lots = 0.1;
extern double StopLoss = 100;
extern double TakeProfit = 100;
extern int MagicNumber = 12345;

// Global Variables
int order_ticket = 0;
bool is_hedging = false;

// Open order function
int open_order(int type, double lots, double stoploss, double takeprofit) {
    double price = 0;
    if (type == OP_BUY) {
        price = Ask;
    } else if (type == OP_SELL) {
        price = Bid;
    }
    int ticket = OrderSend(Symbol(), type, lots, price, 3, stoploss, takeprofit, "Hedge Order", MagicNumber, 0, type == OP_BUY ? LimeGreen : Red);
    return ticket;
}

// Hedging function
void hedge() {
    if (!is_hedging) {
        double lots = MarketInfo(Symbol(), MODE_LOTSIZE);
        double stoploss = NormalizeDouble(Bid + StopLoss * Point, Digits);
        double takeprofit = NormalizeDouble(Bid - TakeProfit * Point, Digits);
        
        order_ticket = open_order(OP_SELL, lots, stoploss, takeprofit);
        is_hedging = true;
    }
}

// Close order function
bool close_order(int ticket) {
    if (OrderClose(ticket, OrderLots(), Bid, 3, LimeGreen)) {
        order_ticket = 0;
        is_hedging = false;
        return true;
    }
    
    return false;
}

// Check for open orders function
void check_orders() {
    int total = OrdersTotal();
    for (int i = 0; i < total; i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
            if (OrderMagicNumber() == MagicNumber) {
                if (OrderType() == OP_BUY) {
                    close_order(OrderTicket());
                } else if (OrderType() == OP_SELL) {
                    is_hedging = false;
                }
            }
        }
    }
}

// Expert Advisor Initialization function
int init() {
    // Initialize variables and settings here
    return (0);
}

// Expert Advisor Deinitialization function
int deinit() {
    // Cleanup code goes here
    return (0);
}

// Expert Advisor Execution function
void start() {
    // Check for open orders and hedge if necessary
    check_orders();
    if (!is_hedging) {
        hedge();
    }
}
