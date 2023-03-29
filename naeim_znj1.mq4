//+------------------------------------------------------------------+
//|                                                            7.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//start az 0.15 - target 20 - sl 13 - 2 session - tp 0.1% - hade zarar 4%
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
input double LevelsPip =2;
double lot=.01;

input double LevelsPip1 =5;    // fasele buy az price
input double LevelsPip3 =5;   //fasele sell az price
 double p[100] ;
  double p1[100] ;

bool full = false;

bool full1 = false;
double extern SELLHALF1;
double extern SELLHALF2;
double extern SELLHALF3;
double extern SELLHALF4;
double extern SELLHALF5;
double extern SELLHALF6;

double gap ;

extern double Price;
extern double Price1;
extern double Price2;
extern double Price3;
extern double Price4;
extern double Price5;
extern double Price6;
extern double Price7;
extern double Price8;
extern double Price9;
extern double Price10;
extern double target =18;
double l1 ;
double l2 ;
double l3 ;
double l4 ;
double l5 ;
double t1 ;
double t2 ;
double t3 ;
double t4 ;
double t5 ;
double t6 ;

double firstbalance ;
double firstbalance1 ;
double firstbalance2 ;

double t ;
double m ;

double f ;
double r;
int u ;
int o ;
double w ;
double w1 ;
double mt;
int y ;
int c ;
int d ;
double trail_point=15;
double trail2_point=10;
double trail3_point=20;
double trail4_point=40;


double trail1_point=9;
double trail21_point=10;
double trail31_point=8;

double g ;
 double avrage ;
 double avrage3 ;
 double avrage2 ;
double k ;
double k1 ;
double k2 ;
double k3 ;
double k4 ;
double k5 ;
double k6 ;

input string  Start_Time  = "9:00"  ;
input string  End_Time  = "21:00"  ;

input string  Start_Time1  = "9:00"  ;
input string  End_Time1  = "21:00"  ;




//input string  Start_Time1  = "15:30"  ;
//input string  End_Time1  = "17:30"  ;

bool run1 = false;
bool run = false;
datetime start_hour ;
datetime end_hour ;



datetime start_hour1 ;
datetime end_hour1 ;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {

  if(firstbalance+t/2<=AccountEquity())
  {if(maxlot()>=l1-0.02){ //break half
  deletebuy2();
  deletesell2();
  deletepending();
  }}
  if(maxlot()<=l1*30/100+l1){   //rbte be l2
//  deletepending();
  }
  
  Comment(firstbalance+t,"\n",l2,"\n",firstbalance-f,"\n",firstbalance1,"\n",firstbalance1-t,"\n",gap,"\n",firstbalance,"\n",AccountBalance()+gap);
  
  

   w =iIchimoku(_Symbol,_Period,200,26,52,MODE_SENKOUSPANA,-26);
     w1 =iIchimoku(_Symbol,_Period,200,26,52,MODE_SENKOUSPANB,-26);
  mt=  iRSI(NULL,0,14,PRICE_CLOSE,1);
  k5= iMA(NULL,0,180,8,MODE_SMMA,PRICE_MEDIAN,0);
    k4= iMA(NULL,0,13,8,MODE_SMMA,PRICE_MEDIAN,0);
    k6= iMA(NULL,0,20,8,MODE_SMMA,PRICE_MEDIAN,0);
   start_hour = StrToTime(Start_Time) ;
   end_hour   = StrToTime(End_Time) ;
   
      start_hour1 = StrToTime(Start_Time1) ;
       end_hour1   = StrToTime(End_Time1) ;
   

//start_hour1 = StrToTime(Start_Time1) ;
//end_hour1   = StrToTime(End_Time1) ;

l1=firstbalance*.0005 ;
l2=maxlot()*1.3;          //falake max lot ro biaram paein va fasele poz asli va komaki ro ziad konm ya bar ax
l3=firstbalance*.0005 ;
l4=firstbalance*.0006 ;
l5=firstbalance*.0008 ;

t1=firstbalance*10/100;
t2=firstbalance*38/100;
t3=firstbalance*52/100;
t4=firstbalance*64/100;
t5=firstbalance*78/100;
t6=firstbalance*88/100;

   t = firstbalance*4/100;
   m = firstbalance*2/100;

f=firstbalance*2/100;

r =firstbalance*2;

int hicandel=iHighest(NULL, Period(),MODE_HIGH,1,0);

int lowcandel=iLowest(NULL, Period(),MODE_LOW,1,0);

g++;
   if(!run1  )
     {
     // firstbalance = AccountBalance();
    //  moneymanagement();
    //  moneymanagement2();
      
     // run1 = true;
    //create_khat();
     }
     
        if(!run  && TimeCurrent() >= start_hour && TimeCurrent() <= end_hour)
     {
       firstbalance = AccountBalance();
      moneymanagement();
      moneymanagement2();
      
      run = true;
    //create_khat();
     }
     
            if(!run  && TimeCurrent() >= start_hour1 && TimeCurrent() <= end_hour1)
     {
       firstbalance = AccountBalance();
      moneymanagement();
      moneymanagement2();
      
      run = true;
    //create_khat();
     }
     if(!run){                                         //jadid hesabe 2%ha
     firstbalance=firstbalance2;
     firstbalance2 = AccountBalance();
      run = true;
     
     
     }
     if(firstbalance>firstbalance1){
     
     //  run1 = false;
     
     
     
     }
     if(firstbalance-f>AccountEquity()){
     
    deletebuy();
    deletesell();
   deletepending();
     
     run=false;
     run1=false;
         
     
     }
     
      if(firstbalance2+4/100==AccountBalance()&& AccountEquity()>=firstbalance2){    //sood
     run=false;
     run1=false;
         
     
     }
     
     if(firstbalance<AccountBalance()){
     
    //    run=false;
 //    run1=false;
     
     
     }
     
     if(Open[1]>Close[1]){
     
     
     k1=Open[1]-Close[1];
     
     
     }
     
      if(Open[1]<Close[1]){
      
      k1=Close[1]-Open[1];
      
      
      }
     
     if(firstbalance-f>AccountEquity()){
   
     
      run = false;
      
     
     
     }
     
   if(Ask>OrderOpenPrice()){ 
      
   gap=NormalizeDouble(((((stop_price_buy()-open_price_buy())*_Point)+.09)*10000000000)-900000000,0)*maxlot();   
      
      
     } 
      
      
     if(Ask<OrderOpenPrice()){ 
      
    gap=NormalizeDouble(((((open_price_sell()-stop_price_sell())*_Point)+.09)*10000000000)-900000000,0)*maxlot();  
      
      
     }

   /*if( TimeCurrent() >= start_hour1 && TimeCurrent() <= end_hour1  )
     {
      firstbalance = AccountBalance();
      run = true;
      create_khat();
     }*/
     moneymanagement2();

     if(p[0]>p[1]){
     
     k=p[0]-p[1];
 
     
     }
       if(open_price_buystop()!=stop_price_sell()&&firstbalance+t>AccountEquity()&&S()==1&&BB()==1){
   deletepending();
     
     
     
     
     }
         if((S()==0&&BB()==1&&SS()==0)||(B()==0&&SS()==1&&BB()==0)){
     
     Sleep(1000);
     
      if((S()==0&&BB()==1&&SS()==0)||(B()==0&&SS()==1&&BB()==0)){ 
     
    deletepending();
     
     
     
     
     }}
     
     if(OrdersTotal()==0)
     {
     
     run=false;
     
     run1=false;
     }
 
     k2=p[1]+p[2]+p[3]+p[4]+p[5]+p[6]+p[7]+p[8]+p[9]+p[10];
     
     k3=k2/10;
     
    if(open_price_sellstop()!=stop_price_buy()&&firstbalance+t>AccountEquity()&&B()==1&&SS()==1){
    
    deletepending();
    
    
    
    } 
   if ( AccountEquity()>firstbalance-f){  
     if(maxlot()>=l1-0.01){
odrekomaki();
     }}
     if(p[0]<p[1]){
     
     k=p[1]-p[0];
     
     
     
     }
     
     
     if((maxlotsb()>maxlot()*1.4&&S()==1)||(maxlotsb()>maxlot()*1.4&&B()==1)){
     
     
     
      deletepending();
   
     
     
     
     
     
     }
     
     
          if(p1[0]>p1[1]){
     
    // k1=p1[0]-p1[1];
     
     
     }
     
     
     
     if(p1[0]<p1[1]){
     
    // k1=p1[1]-p1[0];
     
     
     
     }
     
    
   if(firstbalance+t <= AccountEquity())
     {
      if((Ask> Price + target*_Point || Bid < Price - target*_Point))
        {
       //  deletesell();
       //  deletebuy();
       //  deletepending();
      //   run = false;
        }
     
  } 
     
      double sum2=0;
     
     for(int i=0;i<99;i++)
     {
     sum2+=MathAbs(p1[1]-p1[i+1]);
     }
     avrage3 =sum2/99;
     
     
     double sum=0;
     
     for(int i=0;i<99;i++)
     {
     sum+=MathAbs(p[1]-p[i+1]);
     }
     avrage =sum/99;
     
       point_per_tick();
       
       //  point_per_tick1();
       

if(OrdersTotal()==0&&firstbalance<AccountEquity()&&Volume[1]<y+c){


run=false;

 }
 
//if(run){
   //stoploss_s();
   
   
   
   
   
   // } 
   
if(Ask>open_price_buy()+7*_Point&&Ask<open_price_buy()+20*_Point&&stop_price_buy()<open_price_buy()){

 
   Trailbuy20();



}


if(Ask<open_price_sell()-7*_Point&&Ask>open_price_sell()-20*_Point&&stop_price_sell()>open_price_sell()){


 Trailsell20();
   



}
   
   
   
   if(AccountEquity()>firstbalance){
   
   deletebuy1();
deletesell1();
   
   
   
   }
   
   
   if(AccountBalance()+gap<=firstbalance){
    
        if((Ask<OrderOpenPrice()&&Ask>OrderOpenPrice()-trail_point*_Point)||(Bid>OrderOpenPrice()&&Ask<OrderOpenPrice()+trail_point*_Point ))
   {Trailsell();
      Trailbuy();
        
   
   
   
   }
   
      
        if((Ask<OrderOpenPrice()-trail_point*_Point&&Ask>OrderOpenPrice()-trail3_point*_Point)||(Bid>OrderOpenPrice()+trail_point*_Point&&Ask<OrderOpenPrice()+trail3_point*_Point ))
   {
   
   Trailsell1();
Trailbuy1();
        
   
   
   
   }
             if((Ask<=OrderOpenPrice()-trail3_point*_Point)||(Ask>=OrderOpenPrice()+trail3_point*_Point ))
   {
   
   Trailsell2();
      Trailbuy2();
        
   
   }
   
   }
      if(firstbalance+t <= AccountEquity())
     {
deletebuy();
deletesell();
deletepending();
     
  } 
   
   if(Bid>OrderOpenPrice()){
      // Trailbuy();
        
        
        
   }
     


if(Bid>Price1+LevelsPip*_Point&& BB()==0){
 // deletesell();
      //   deletebuy();
       //  deletepending();
       //  run = false;
}
/*

if((open_price_sell()+ LevelsPip*_Point<Price2&&firstbalance+f<AccountEquity())||(open_price_buy()-LevelsPip*_Point>Price1&&firstbalance+f<AccountEquity())){
  deletesell();
         deletebuy();
         deletepending();
         run = false;
}

*/
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Buy_Totals()
  {
   int count = 0;
   for(int i = 0 ; i < OrdersTotal() ; i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType() == ORDER_TYPE_BUY || OrderType() == ORDER_TYPE_BUY_LIMIT|| OrderType() == ORDER_TYPE_BUY_STOP)
            count++;

        }
     }
   return count;

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Sell_Totals()
  {
   int count = 0;
   for(int i = 0 ; i < OrdersTotal() ; i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType() == ORDER_TYPE_SELL ||  OrderType() ==ORDER_TYPE_SELL_LIMIT||  OrderType() ==ORDER_TYPE_SELL_STOP)
            count++;

        }
     }
   return count;

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void LotSize()
  {
   double balance = AccountBalance();

   /*if( balance >firstbalance - 36   && balance<=firstbalance  ) lot = 0.3;
   else if( balance >firstbalance - 100    && balance<=firstbalance - 36 ) lot = 0.6;
   else if( balance >firstbalance - 260    && balance<=firstbalance - 100  ) lot = 1.2;
   else if( balance >firstbalance - 500    && balance<=firstbalance - 260 ) lot = 2.4;*/

   /*if (balance >firstbalance- 60    && balance<= firstbalance)lot = 0.6;
   else if(balance >firstbalance - 160    && balance<=firstbalance - 60) lot = 1.2;
   else if(balance >firstbalance - 300    && balance<=firstbalance - 160)lot = 2.4;
   else if(balance >firstbalance - 500   && balance<=firstbalance - 300)lot = 4.8;*/

   if(balance >firstbalance - t1  && balance<=firstbalance)
      lot = l1;
   else
      if(balance >firstbalance - t2   && balance<=firstbalance - t1)
         lot = l2;
     else
       if(balance >firstbalance - t3    && balance<=firstbalance - t2)
            lot = l3;
         else
            if(balance >firstbalance - t4   && balance<=firstbalance - t3)
               lot = l4;
            else
               if(balance >firstbalance - t5    && balance<=firstbalance - t4)
                  lot = l5;
               else
                  if(balance >firstbalance - t6    && balance<=firstbalance - t5)
                     lot = l5;

 /*  else if( balance >firstbalance - 16.5   && balance<=firstbalance - 11.9  ) lot = 0.05;
     else if( balance >firstbalance - 21.1   && balance<=firstbalance - 16.5  ) lot = 0.06;
     else if( balance >firstbalance - 25.7    && balance<=firstbalance - 21.1 ) lot = 0.07;
     else if( balance >firstbalance - 200    && balance<=firstbalance - 25.7  ) lot = 0.07;


     else if( balance >firstbalance -4.07 && balance<=firstbalance -3.36 ) lot = 0.08;
     else if( balance >firstbalance -200 && balance<=firstbalance -4.07  ) lot = 0.1;
     else if( balance >firstbalance *0.9741 && balance<=firstbalance * 0.9846  ) lot = 0.06;
     else if( balance >firstbalance *0.9593 && balance<=firstbalance * 0.9741  ) lot = 0.08;
     else if( balance >firstbalance *0.9359 && balance<=firstbalance * 0.9593  ) lot = 0.12;
     else if( balance >firstbalance *0.9128 && balance<=firstbalance * 0.9359  ) lot = 0.16;
     else if( balance >firstbalance *0.8902 && balance<=firstbalance * 0.9128  ) lot = 0.24;
     else if( balance >firstbalance *0.868  && balance<=firstbalance * 0.8902  ) lot = 0.28;
     else if( balance >firstbalance *0.8479 && balance<=firstbalance * 0.868   ) lot = 0.34;
     else if( balance >firstbalance *0.8304 && balance<=firstbalance * 0.8479  ) lot = 0.4;
     else if( balance >firstbalance *0.8139 && balance<=firstbalance * 0.8304   ) lot = 0.46;
     else if( balance >firstbalance *0.7997 && balance<=firstbalance * 0.8139   ) lot = 0.54;
     else if( balance >firstbalance *0.7886 && balance<=firstbalance * 0.7997   ) lot = 0.62;
     else if( balance >firstbalance *0.7823 && balance<=firstbalance * 0.7886   ) lot = 0.7;
     else if( balance >firstbalance *0.7679 && balance<=firstbalance * 0.7823   ) lot = 0.78;
     else if( balance >firstbalance *0.7438 && balance<=firstbalance * 0.7679   ) lot = 0.86;
     else if( balance >firstbalance *0.7085 && balance<=firstbalance * 0.7438   ) lot = 0.96;
     else if( balance >firstbalance*0.6591  && balance<=firstbalance * 0.7085   ) lot = 1.06;
     else if( balance >firstbalance *0.6155 && balance<=firstbalance * 0.6591   ) lot = 1.16;
     else if( balance >firstbalance *0.5798 && balance<=firstbalance * 0.6155   ) lot = 1.3;
     else if( balance >firstbalance *0.553  && balance<=firstbalance * 0.5798   ) lot = 1.44;
     else if( balance >firstbalance *0.5382 && balance<=firstbalance * 0.553    ) lot = 1.58;
     else if( balance >firstbalance *0.5057 && balance<=firstbalance * 0.5382   ) lot = 1.;
     else if( balance >firstbalance *0.4527 && balance<=firstbalance * 0.5057   ) lot = 1.06;*/

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void create_khat()
  {
if(Ask-Bid<4*_Point){
   Price = Ask;

if(OrdersTotal()==0){

   SELLHALF1 =Price+ LevelsPip1*_Point;
   SELLHALF2 =Price -LevelsPip3*_Point;
   /*SELLHALF3 =Price+ LevelsPip2*_Point;
     SELLHALF4 =SELLHALF3 +LevelsPip3*_Point;
     SELLHALF5 =Price -LevelsPip2*_Point;
     SELLHALF6 =SELLHALF5 - LevelsPip3*_Point;*/


   ObjectDelete(0,"1");
   ObjectDelete(0,"2");
   /*ObjectDelete(0,"3");
     ObjectDelete(0,"4");
     ObjectDelete(0,"5");
     ObjectDelete(0,"6");*/


   ObjectCreate("1",OBJ_HLINE,0,Time[0],SELLHALF1);

   ObjectCreate("2",OBJ_HLINE,0,Time[0],SELLHALF2);

   /*ObjectCreate("3",OBJ_HLINE,0,Time[0],SELLHALF3);

     ObjectCreate("4",OBJ_HLINE,0,Time[0],SELLHALF4);

     ObjectCreate("5",OBJ_HLINE,0,Time[0],SELLHALF5);

     ObjectCreate("6",OBJ_HLINE,0,Time[0],SELLHALF6);*/





  }}}



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void moneymanagement()
  {
   LotSize();

  if(Ask-Bid<4*_Point){

   int T;

    
if(OrdersTotal()==0){
//if (Volume[1]>y+d){
//if(w<w1+2*_Point&&w>w1-2*_Point){
//if(mt<30||mt>70){
//if(Ask>k5+200*_Point||Ask<k5-200*_Point){
//if(Ask>k6+15*_Point||Ask<k6-15*_Point){
//if(High[0]-Low[0]>High[1]-Low[1]*2){
//if(k4==k6){
//if(mt<30||mt>70){

       T=    OrderSend(Symbol(),OP_BUYSTOP,l1,Ask+10*_Point,3,Ask,0,NULL,1,0,clrBlue);


            T=    OrderSend(Symbol(),OP_SELLSTOP,l1,Bid-10*_Point,3,Ask,0,NULL,1,0,clrRed);

}
  } // }
}
//}}





void moneymanagement2()
  {
   LotSize();
if (firstbalance>AccountBalance()){
  if(Ask-Bid<4*_Point){



    
if(OrdersTotal()==0){
if (Volume[0]>y+c){






    //   T=    OrderSend(Symbol(),OP_BUY,l1,Bid,3,NormalizeDouble(p[1],5)-80*_Point,0,NULL,1,0,clrBlue);
 
}


         //        T=    OrderSend(Symbol(),OP_SELL,l1,Ask,3,NormalizeDouble(p[1],5)+80*_Point,0,NULL,1,0,clrRed);

}
     

}}

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deletepending()
  {

   for(int i=(OrdersTotal()-1); i>=0; i--)
     {

      //If the order cannot be selected throw and log an error
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         Comment("ERROR - Unable to select the order - ",GetLastError());
         break;
        }

      if(OrderSymbol()!=Symbol())
         continue;

      bool res=false;

      double BidPrice=MarketInfo(OrderSymbol(),MODE_BID);
      double AskPrice=MarketInfo(OrderSymbol(),MODE_ASK);


      if(OrderType()!=OP_BUY && OrderType()!=OP_SELL)
        {
         res = OrderDelete(OrderTicket());
        }


     }
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deletebuy()
  {

   for(int i=(OrdersTotal()-1); i>=0; i--)
     {

      //If the order cannot be selected throw and log an error
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         Comment("ERROR - Unable to select the order - ",GetLastError());
         break;
        }

      if(OrderSymbol()!=Symbol())
         continue;

      bool res=false;

      double BidPrice=MarketInfo(OrderSymbol(),MODE_BID);
      double AskPrice=MarketInfo(OrderSymbol(),MODE_ASK);


      if(OrderType()==OP_BUY)
        {
         res=OrderClose(OrderTicket(),OrderLots(),BidPrice,0);
        }


     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deletesell()
  {

   for(int i=(OrdersTotal()-1); i>=0; i--)
     {

      //If the order cannot be selected throw and log an error
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         Print("ERROR - Unable to select the order - ",GetLastError());
         break;
        }

      if(OrderSymbol()!=Symbol())
         continue;

      bool res=false;

      double BidPrice=MarketInfo(OrderSymbol(),MODE_BID);
      double AskPrice=MarketInfo(OrderSymbol(),MODE_ASK);



      if(OrderType()==OP_SELL)
        {
         res=OrderClose(OrderTicket(),OrderLots(),AskPrice,0);
        }


     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int B()
  {
   int count = 0;
   for(int i = 0 ; i < OrdersTotal() ; i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType() == ORDER_TYPE_BUY && OrderMagicNumber() == 1)
            count++;

        }
     }
   return count;

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int S()
  {
   int count = 0;
   for(int i = 0 ; i < OrdersTotal() ; i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType() == ORDER_TYPE_SELL && OrderMagicNumber() ==1)
            count++;
        }
     }
   return count;

  }
//+------------------------------------------------------------------+
int BB()
  {
   int count = 0;
   for(int i = 0 ; i < OrdersTotal() ; i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType() == ORDER_TYPE_BUY_STOP && OrderMagicNumber() == 1)
            count++;

        }
     }
   return count;

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int SS()
  {
   int count = 0;
   for(int i = 0 ; i < OrdersTotal() ; i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType() == ORDER_TYPE_SELL_STOP && OrderMagicNumber() == 1)
            count++;
        }
     }
   return count;

  }
//+------------------------------------------------------------------+





void stoploss_check()
{



  bool modi;
   for(int i = 0 ; i < OrdersTotal() ; i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType() == ORDER_TYPE_BUY && OrderMagicNumber() == 1 && OrderStopLoss() != OrderOpenPrice()-LevelsPip1*_Point*2 )
            modi = OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-LevelsPip1*_Point*2,0,0,clrNONE);
         else if(OrderType() == ORDER_TYPE_SELL && OrderMagicNumber() == 2 && OrderStopLoss() != OrderOpenPrice()+LevelsPip1*_Point*2)
            modi = OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+LevelsPip1*_Point*2,0,0,clrNONE);
        }
     }
  




}








double open_price_buy()
{
double price_open = 0;
    for(int i = 0 ; i < OrdersTotal() ; i++)
     {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
        if( OrderType() == ORDER_TYPE_BUY )
           price_open = OrderOpenPrice();
        }
     
     }
 
  
return price_open;
}
double open_price_sell()
{
double price_open = 0;
    for(int i = 0 ; i < OrdersTotal() ; i++)
     {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
        if( OrderType() == ORDER_TYPE_SELL )
           price_open = OrderOpenPrice();
        }
     
     }
return price_open;
}


double stop_price_sell()
{
double price_stop = 0;
    for(int i = 0 ; i < OrdersTotal() ; i++)
     {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
        if( OrderType() == ORDER_TYPE_SELL )
           price_stop = OrderStopLoss();
        }
     
     }
return price_stop;
}

double stop_price_buy()
{
double price_stop = 0;
    for(int i = 0 ; i < OrdersTotal() ; i++)
     {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
        if( OrderType() == ORDER_TYPE_BUY )
           price_stop = OrderStopLoss();
        }
     
     }
 
  
return price_stop;
}

double stop_price_ssell()
{
double price_sstop = 0;
    for(int i = 0 ; i < OrdersTotal() ; i++)
     {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
        if( OrderType() == ORDER_TYPE_SELL )
           price_sstop = OrderStopLoss();
        }
     
     }
return price_sstop;
}

double stop_price_sbuy()
{
double price_sstop = 0;
    for(int i = 0 ; i < OrdersTotal() ; i++)
     {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
        if( OrderType() == ORDER_TYPE_BUY )
           price_sstop = OrderStopLoss();
        }
     
     }
 
  
return price_sstop;
}





void point_per_tick()
{
  double count = 0;
  for( int i = 0 ; i< 100 ; i++ )
  {
   if( p[i] != NULL && p[i] != 0  )
   {
   count++;
   
   
   }
   else
   
   {
   p[i] = Ask;
    break;
    }
  
  }
  if( count == 100 ) full = true;
  
  
  if( full ) 
  {
     
     for( int j = 99 ; j>0 ; j-- )
     {
       p[j] = p[j-1];
     }
     p[0] = Ask;
  
  }}


void point_per_tick1()
{
  double count = 0;
  for( int i = 0 ; i< 100 ; i++ )
  {
   if( p1[i] != NULL && p1[i] != 0  )
   {
   count++;
   
   
   }
   else
   
   {
   p1[i] = Bid;
    break;
    }
  
  }
  if( count == 100 ) full1 = true;
  
  
  if( full1 ) 
  {
     
     for( int j = 99 ; j>0 ; j-- )
     {
       p1[j] = p1[j-1];
     }
     p1[0] = Bid;
  
  }}



void Trailbuy()
  {





// bool t;
   for(int i=0 ; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {


         if(OrderType()==OP_BUY)
           {

            if((Bid >  OrderStopLoss()+trail21_point * _Point))
              {
               bool tt = OrderModify(OrderTicket(),OrderOpenPrice(), (Bid -((trail21_point * _Point))), 0, clrAqua);
              }

           }

        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Trailsell()
  {
// bool t;
   for(int i=0 ; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {


         if(OrderType()==OP_SELL)
           {

            if(Ask <  OrderStopLoss()-trail21_point * _Point)
              {
               bool tt = OrderModify(OrderTicket(),OrderOpenPrice(), (Ask+((trail21_point * _Point))), 0, clrAqua);
              }


           }


        }
     }

  }


void odrekomaki()
{
int T;

  if(Ask-Bid<10*_Point){


if ( B()==0&&BB()==0&&S()==1){



   T=    OrderSend(Symbol(),OP_BUYSTOP,l2,stop_price_sell(),3,stop_price_sell()-10*_Point,0,NULL,1,0,clrBlue);



}



if(S()==0&&SS()==0&&B()==1){


  T=    OrderSend(Symbol(),OP_SELLSTOP,l2,stop_price_buy(),3,stop_price_buy()+10*_Point,0,NULL,1,0,clrRed);




}
}}


double open_price_buystop()
{
double price_open = 0;
    for(int i = 0 ; i < OrdersTotal() ; i++)
     {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
        if( OrderType() == ORDER_TYPE_BUY_STOP )
           price_open = OrderOpenPrice();
        }
     
     }
 
  
return price_open;
}
double open_price_sellstop()
{
double price_open = 0;
    for(int i = 0 ; i < OrdersTotal() ; i++)
     {
       if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
        if( OrderType() == ORDER_TYPE_SELL_STOP )
           price_open = OrderOpenPrice();
        }
     
     }
return price_open;
}


void Trailbuy1()
  {





// bool t;
   for(int i=0 ; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {


         if(OrderType()==OP_BUY)
           {

            if((Bid >  OrderStopLoss()+trail1_point * _Point))
              {
               bool tt = OrderModify(OrderTicket(),OrderOpenPrice(), (Bid -((trail1_point * _Point))), 0, clrAqua);
              }

           }

        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Trailsell1()
  {
// bool t;
   for(int i=0 ; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {


         if(OrderType()==OP_SELL)
           {

            if(Ask <  OrderStopLoss()-trail1_point * _Point)
              {
               bool tt = OrderModify(OrderTicket(),OrderOpenPrice(), (Ask+((trail1_point * _Point))), 0, clrAqua);
              }


           }


        }
     }

  }

void Trailbuy2()
  {





// bool t;
   for(int i=0 ; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {


         if(OrderType()==OP_BUY)
           {

            if((Bid >  OrderStopLoss()+trail31_point * _Point))
              {
               bool tt = OrderModify(OrderTicket(),OrderOpenPrice(), (Bid -((trail31_point * _Point))), 0, clrAqua);
              }

           }

        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Trailsell2()
  {
// bool t;
   for(int i=0 ; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {


         if(OrderType()==OP_SELL)
           {

            if(Ask <  OrderStopLoss()-trail31_point * _Point)
              {
               bool tt = OrderModify(OrderTicket(),OrderOpenPrice(), (Ask+((trail31_point * _Point))), 0, clrAqua);
              }


           }


        }
     }

  }

void Trailbuy4()
  {





// bool t;
   for(int i=0 ; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {


         if(OrderType()==OP_BUY)
           {

            if((Bid >  OrderStopLoss()+5* _Point))
              {
               bool tt = OrderModify(OrderTicket(),OrderOpenPrice(), (Bid -((5 * _Point))), 0, clrAqua);
              }

           }

        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Trailsell4()
  {
// bool t;
   for(int i=0 ; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {


         if(OrderType()==OP_SELL)
           {

            if(Ask <  OrderStopLoss()-5 * _Point)
              {
               bool tt = OrderModify(OrderTicket(),OrderOpenPrice(), (Ask+((5 * _Point))), 0, clrAqua);
              }


           }


        }
     }

  }


double maxlot()
  {
   double n =0 ;
   for(int i=(OrdersTotal()-1); i>=0; i--)
     {

      //If the order cannot be selected throw and log an error
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         Print("ERROR - Unable to select the order - ",GetLastError());
         break;
        }

      if(OrderSymbol()!=Symbol())
         continue;

      if((OrderLots()> n &&OrderType()==OP_BUY)||(OrderLots()> n &&OrderType()==OP_SELL))
      
         n=OrderLots();

     }

   return n;

}

void Trailbuy20()
  {





// bool t;
   for(int i=0 ; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {


         if(OrderType()==OP_BUY)
           {

            if(( OrderStopLoss()!=OrderOpenPrice()))
              {
               bool tt = OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(), 0, clrAqua);
              }

           }

        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Trailsell20()
  {
// bool t;
   for(int i=0 ; i<OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {


         if(OrderType()==OP_SELL)
           {

            if( OrderStopLoss()!=OrderOpenPrice())
              {
               bool tt = OrderModify(OrderTicket(),OrderOpenPrice(), OrderOpenPrice(), 0, clrAqua);
              }


           }


        }
     }

  }

void deletebuy1()
  {

   for(int i=(OrdersTotal()-1); i>=0; i--)
     {

      //If the order cannot be selected throw and log an error
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         Comment("ERROR - Unable to select the order - ",GetLastError());
         break;
        }

      if(OrderSymbol()!=Symbol())
         continue;

      bool res=false;

      double BidPrice=MarketInfo(OrderSymbol(),MODE_BID);
      double AskPrice=MarketInfo(OrderSymbol(),MODE_ASK);


      if(OrderType()==OP_BUY)
        {
         res=OrderClose(OrderTicket(),maxlot()-l1,BidPrice,0);
        }


     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deletesell1()
  {

   for(int i=(OrdersTotal()-1); i>=0; i--)
     {

      //If the order cannot be selected throw and log an error
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         Print("ERROR - Unable to select the order - ",GetLastError());
         break;
        }

      if(OrderSymbol()!=Symbol())
         continue;

      bool res=false;

      double BidPrice=MarketInfo(OrderSymbol(),MODE_BID);
      double AskPrice=MarketInfo(OrderSymbol(),MODE_ASK);



      if(OrderType()==OP_SELL)
        {
         res=OrderClose(OrderTicket(),maxlot()-l1,AskPrice,0);
        }


     }
  }
  
  
  double maxlotsb()
  {
   double n =0 ;
   for(int i=(OrdersTotal()-1); i>=0; i--)
     {

      //If the order cannot be selected throw and log an error
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         Print("ERROR - Unable to select the order - ",GetLastError());
         break;
        }

      if(OrderSymbol()!=Symbol())
         continue;

      if((OrderLots()> n &&OrderType()==OP_BUYSTOP)||(OrderLots()> n &&OrderType()==OP_SELLSTOP))
      
         n=OrderLots();

     }

   return n;

}
  
 //--------------------------------------------------------------- 
  
  
  void deletebuy2()
  {

   for(int i=(OrdersTotal()-1); i>=0; i--)
     {

      //If the order cannot be selected throw and log an error
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         Comment("ERROR - Unable to select the order - ",GetLastError());
         break;
        }

      if(OrderSymbol()!=Symbol())
         continue;

      bool res=false;

      double BidPrice=MarketInfo(OrderSymbol(),MODE_BID);
      double AskPrice=MarketInfo(OrderSymbol(),MODE_ASK);


      if(OrderType()==OP_BUY)
        {
         res=OrderClose(OrderTicket(),maxlot()/3,BidPrice,0);
        }


     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deletesell2()
  {

   for(int i=(OrdersTotal()-1); i>=0; i--)
     {

      //If the order cannot be selected throw and log an error
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
        {
         Print("ERROR - Unable to select the order - ",GetLastError());
         break;
        }

      if(OrderSymbol()!=Symbol())
         continue;

      bool res=false;

      double BidPrice=MarketInfo(OrderSymbol(),MODE_BID);
      double AskPrice=MarketInfo(OrderSymbol(),MODE_ASK);



      if(OrderType()==OP_SELL)
        {
         res=OrderClose(OrderTicket(),maxlot()/3,AskPrice,0);
        }

}
     }
  
  
  
  