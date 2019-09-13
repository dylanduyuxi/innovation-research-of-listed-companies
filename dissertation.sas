
*****************************************************************************
Program Description: Chinese patent
Date Modified :      June 2019
*****************************************************************************;
/*set and clear the work fold*/
libname locallib 'C:\Users\Du\Desktop\Chinese data';

proc datasets library=work kill nolist; run; quit;



data pat; set locallib.pat0;run;
/*note: grant below means the grant date*/
data pat;set pat;
if  grant<='31DEC2010'd then delete;if grant>='30SEP2018'd then delete;
run;

/*mark the patents with dummy variable*/
data pat1;set pat ; if '31DEC2010'd<grant<='31MAR2011'd then a1=1 ;else a1=0;drop expire;run;
data pat1;set pat1; if '31MAR2011'd<grant<='30JUN2011'd then a2=1 ;else a2=0;run;
data pat1;set pat1; if '30JUN2011'd<grant<='30SEP2011'd then a3=1 ;else a3=0;run;
data pat1;set pat1; if '30SEP2011'd<grant<='31DEC2011'd then a4=1 ;else a4=0;run;
data pat1;set pat1; if '31DEC2011'd<grant<='31MAR2012'd then b1=1 ;else b1=0;run;
data pat1;set pat1; if '31MAR2012'd<grant<='30JUN2012'd then b2=1 ;else b2=0;run;
data pat1;set pat1; if '30JUN2012'd<grant<='30SEP2012'd then b3=1 ;else b3=0;run;
data pat1;set pat1; if '30SEP2012'd<grant<='31DEC2012'd then b4=1 ;else b4=0;run;
data pat1;set pat1; if '31DEC2012'd<grant<='31MAR2013'd then c1=1 ;else c1=0;run;
data pat1;set pat1; if '31MAR2013'd<grant<='30JUN2013'd then c2=1 ;else c2=0;run;
data pat1;set pat1; if '30JUN2013'd<grant<='30SEP2013'd then c3=1 ;else c3=0;run;
data pat1;set pat1; if '30SEP2013'd<grant<='31DEC2013'd then c4=1 ;else c4=0;run;
data pat1;set pat1; if '31DEC2013'd<grant<='31MAR2014'd then d1=1 ;else d1=0;run;
data pat1;set pat1; if '31MAR2014'd<grant<='30JUN2014'd then d2=1 ;else d2=0;run;
data pat1;set pat1; if '30JUN2014'd<grant<='30SEP2014'd then d3=1 ;else d3=0;run;
data pat1;set pat1; if '30SEP2014'd<grant<='31DEC2014'd then d4=1 ;else d4=0;run;
data pat1;set pat1; if '31DEC2014'd<grant<='31MAR2015'd then e1=1 ;else e1=0;run;
data pat1;set pat1; if '31MAR2015'd<grant<='30JUN2015'd then e2=1 ;else e2=0;run;
data pat1;set pat1; if '30JUN2015'd<grant<='30SEP2015'd then e3=1 ;else e3=0;run;
data pat1;set pat1; if '30SEP2015'd<grant<='31DEC2015'd then e4=1 ;else e4=0;run;
data pat1;set pat1; if '31DEC2015'd<grant<='31MAR2016'd then f1=1 ;else f1=0;run;
data pat1;set pat1; if '31MAR2016'd<grant<='30JUN2016'd then f2=1 ;else f2=0;run;
data pat1;set pat1; if '30JUN2016'd<grant<='30SEP2016'd then f3=1 ;else f3=0;run;
data pat1;set pat1; if '30SEP2016'd<grant<='31DEC2016'd then f4=1 ;else f4=0;run;
data pat1;set pat1; if '31DEC2016'd<grant<='31MAR2017'd then g1=1 ;else g1=0;run;
data pat1;set pat1; if '31MAR2017'd<grant<='30JUN2017'd then g2=1 ;else g2=0;run;
data pat1;set pat1; if '30JUN2017'd<grant<='30SEP2017'd then g3=1 ;else g3=0;run;
data pat1;set pat1; if '30SEP2017'd<grant<='31DEC2017'd then g4=1 ;else g4=0;run;
data pat1;set pat1; if '31DEC2017'd<grant<='31MAR2018'd then h1=1 ;else h1=0;run;
data pat1;set pat1; if '31MAR2018'd<grant<='30JUN2018'd then h2=1 ;else h2=0;run;
data pat1;set pat1; if '30JUN2018'd<grant<='30SEP2018'd then h3=1 ;else h3=0;run;




/*count the total number of each quarter*/
proc sql; create table qw as 
select stkcd ,
sum(a1) as a1,sum(a2)as a2,sum(a3)as a3,sum(a4)as a4,
sum(b1) as b1,sum(b2)as b2,sum(b3)as b3,sum(b4)as b4,
sum(c1) as c1,sum(c2)as c2,sum(c3)as c3,sum(c4)as c4,
sum(d1) as d1,sum(d2)as d2,sum(d3)as d3,sum(d4)as d4,
sum(e1) as e1,sum(e2)as e2,sum(e3)as e3,sum(e4)as e4,
sum(f1) as f1,sum(f2)as f2,sum(f3)as f3,sum(f4)as f4,
sum(g1) as g1,sum(g2)as g2,sum(g3)as g3,sum(g4)as g4,
sum(h1) as h1,sum(h2)as h2,sum(h3)as h3 from pat1
group by stkcd;
quit;

/*transpose the sheet*/
proc transpose data=qw out=patent ;
	by stkcd;
	Var a1 a2 a3 a4 b1 b2 b3 b4 c1 c2 c3 c4 d1 d2 d3 d4 e1 e2 e3 e4 f1 f2 f3 f4 g1 g2 g3 g4 h1 h2 h3;
run;

/*change the name of the colume*/
data patent; set patent; rename _NAME_=grant;run;
proc sort data=patent; by grant;run;
/*use a tool sheet to match a1,a2.... with the certain date*/
data patent; merge patent locallib.citenum;by grant;drop grant;run;
data patent;set patent; format fyear yymms.;rename COL1=npat;run;






/*use the similar way to mark the patents with their citation*/
data pat1;set pat;    if '01JAN2011'd<=grant< '31MAR2011'd then a1=citation ;else a1=0;drop expire;run;
data pat1;set pat1;   if '31MAR2011'd<=grant< '30JUN2011'd then a2=citation ;else a2=0;run;
data pat1;set pat1;   if '30JUN2011'd<=grant< '30SEP2011'd then a3=citation ;else a3=0;;run;
data pat1;set pat1;   if '30SEP2011'd<=grant< '01JAN2012'd then a4=citation ;else a4=0;;run;
data pat1;set pat1;   if '01JAN2012'd<=grant< '31MAR2012'd then b1=citation ;else b1=0;;run;
data pat1;set pat1;   if '31MAR2012'd<=grant< '30JUN2012'd then b2=citation ;else b2=0;;run;
data pat1;set pat1;   if '30JUN2012'd<=grant< '30SEP2012'd then b3=citation ;else b3=0;;run;
data pat1;set pat1;   if '30SEP2012'd<=grant< '01JAN2013'd then b4=citation ;else b4=0;;run;
data pat1;set pat1;   if '01JAN2013'd<=grant< '31MAR2013'd then c1=citation ;else c1=0;;run;
data pat1;set pat1;   if '31MAR2013'd<=grant< '30JUN2013'd then c2=citation ;else c2=0;;run;
data pat1;set pat1;   if '30JUN2013'd<=grant< '30SEP2013'd then c3=citation ;else c3=0;;run;
data pat1;set pat1;   if '30SEP2013'd<=grant< '01JAN2014'd then c4=citation ;else c4=0;;run;
data pat1;set pat1;   if '01JAN2014'd<=grant< '31MAR2014'd then d1=citation ;else d1=0;;run;
data pat1;set pat1;   if '31MAR2014'd<=grant< '30JUN2014'd then d2=citation ;else d2=0;;run;
data pat1;set pat1;   if '30JUN2014'd<=grant< '30SEP2014'd then d3=citation ;else d3=0;;run;
data pat1;set pat1;   if '30SEP2014'd<=grant< '01JAN2015'd then d4=citation ;else d4=0;;run;
data pat1;set pat1;   if '01JAN2015'd<=grant< '31MAR2015'd then e1=citation ;else e1=0;;run;
data pat1;set pat1;   if '31MAR2015'd<=grant< '30JUN2015'd then e2=citation ;else e2=0;;run;
data pat1;set pat1;   if '30JUN2015'd<=grant< '30SEP2015'd then e3=citation ;else e3=0;;run;
data pat1;set pat1;   if '30SEP2015'd<=grant< '01JAN2016'd then e4=citation ;else e4=0;;run;
data pat1;set pat1;   if '01JAN2016'd<=grant< '31MAR2016'd then f1=citation ;else f1=0;;run;
data pat1;set pat1;   if '31MAR2016'd<=grant< '30JUN2016'd then f2=citation ;else f2=0;;run;
data pat1;set pat1;   if '30JUN2016'd<=grant< '30SEP2016'd then f3=citation ;else f3=0;;run;
data pat1;set pat1;   if '30SEP2016'd<=grant< '01JAN2017'd then f4=citation ;else f4=0;;run;
data pat1;set pat1;   if '01JAN2017'd<=grant< '31MAR2017'd then g1=citation ;else g1=0;;run;
data pat1;set pat1;   if '31MAR2017'd<=grant< '30JUN2017'd then g2=citation ;else g2=0;;run;
data pat1;set pat1;   if '30JUN2017'd<=grant< '30SEP2017'd then g3=citation ;else g3=0;;run;
data pat1;set pat1;   if '30SEP2017'd<=grant< '01JAN2018'd then g4=citation ;else g4=0;;run;
data pat1;set pat1;   if '01JAN2018'd<=grant< '31MAR2018'd then h1=citation ;else h1=0;;run;
data pat1;set pat1;   if '31MAR2018'd<=grant< '30JUN2018'd then h2=citation ;else h2=0;;run;
data pat1;set pat1;   if '30JUN2018'd<=grant< '30SEP2018'd then h3=citation ;else h3=0;;run;


/*count the tatal citaiton of each quarter*/
proc sql; create table qw as 
select stkcd ,
sum(a1) as a1,sum(a2)as a2,sum(a3)as a3,sum(a4)as a4,
sum(b1) as b1,sum(b2)as b2,sum(b3)as b3,sum(b4)as b4,
sum(c1) as c1,sum(c2)as c2,sum(c3)as c3,sum(c4)as c4,
sum(d1) as d1,sum(d2)as d2,sum(d3)as d3,sum(d4)as d4,
sum(e1) as e1,sum(e2)as e2,sum(e3)as e3,sum(e4)as e4,
sum(f1) as f1,sum(f2)as f2,sum(f3)as f3,sum(f4)as f4,
sum(g1) as g1,sum(g2)as g2,sum(g3)as g3,sum(g4)as g4,
sum(h1) as h1,sum(h2)as h2,sum(h3)as h3 from pat1
group by stkcd;
quit;

/*transpose it*/
proc transpose data=qw out=cite ;
	by stkcd;
	Var a1 a2 a3 a4 b1 b2 b3 b4 c1 c2 c3 c4 d1 d2 d3 d4 e1 e2 e3 e4 f1 f2 f3 f4 g1 g2 g3 g4 h1 h2 h3;
run;

data cite; set cite; rename _NAME_=grant;run;
proc sort data=cite; by grant;run;
/*use the same tool match sheet to match the certain date*/
data cite; merge cite locallib.citenum;by grant;drop grant;run;
data cite;set cite; format fyear yymms.;rename COL1=citation;run;
/*delete the redandunt sheet*/
proc sql; drop table expire,pat,pat1,qw;quit;


/*median*/
/*input all stock data*/
data market; set locallib.market;  RUN;
data market;set market;ME=Msmvosd/1000;rename TRDMNT=month;rename Mclsprc=price;drop Msmvosd;format month yymms.;run;
proc sort data=market;by month ME;quit;
/*get the median value of the whole market in each month*/
proc univariate data=market noprint;
	var ME;
	by month;
	output out=break median=SIZEMEDN ;
run;


/*data cleaning*/
/*input the xrd data*/
data r; set locallib.Rd; rename A001219000=XRD;run;
data r; set r;if XRD=""or XRD=0 then delete;run;

PROC SQL;
CREATE TABLE rd AS
SELECT accper as fyear,stkcd,xrd FROM r;
QUIT;


proc sort data=rd; by stkcd fyear;run;
/*delete the repetive data*/
data rd; set rd; if month(fyear)=1 then delete;format fyear yymms. ;run;
/*only retain the data in certain period*/
data rd;set rd;
if  fyear<='31DEC2010'd then delete;if fyear>='01OCT2018'd then delete;
run;
/*filter the qulified data which have 31 data*/
proc sql noprint;
create table xrd as
        select * from rd
                group by stkcd
                     having count(stkcd)=31;
quit;
/*adjust data format*/
data xrd; set xrd; stkcd1=stkcd+0;drop stkcd;rename stkcd1=stkcd;xrd=xrd/1000000; run;



/*merge patent data with xrd data*/

proc sort data=patent; by stkcd fyear;run;
proc sort data=xrd; by stkcd fyear;run;
data first;merge patent(in=a) xrd(in=b); 
by stkcd ;
if a=1 and b=1;
run;

/*only retain the certain period*/
proc sql noprint;
create table first as
        select * from first
                group by stkcd
                     having count(stkcd)>=31;
quit;
proc sort data=first; by stkcd fyear;run;

/*calculate the ie*/
data first; set first;
lag1=lag4(xrd);lag2=lag5(xrd);lag3=lag6(xrd);lag4=lag7(xrd); lag5=lag8(xrd);  
ie=npat/(lag1+0.85*lag2+0.7*lag3+0.55*lag4+0.4*lag5);
run;

/*delete the useless data*/
data first; 
set first; 
count + 1; 
by stkcd; 
if first.stkcd then count = 1; 
if count < 9 then delete;
drop count;
run;



/*********************************************************/

/*merge citaition data with xrd*/
proc sort data=cite;by stkcd fyear;run;
proc sort data=xrd; by  stkcd fyear;run;
data second;merge cite(in=a) xrd(in=b); 
by stkcd ;
if a=1 and b=1;
run;


/*calculate citation/xrd ie*/
data second; set second; 
lag1=lag4(xrd);lag2=lag5(xrd); lag3=lag6(xrd); lag4=lag7(xrd);lag5=lag8(xrd);
clag1=lag1(citation);clag2=lag2(citation);clag3=lag3(citation);clag4=lag4(citation);clag5=lag5(citation);
ie=(clag1+clag2+clag3+clag4+clag5)/(lag1+lag2+lag3+lag4+lag5);
run;

/*delete useless data*/
data second; 
set second; 
count + 1; 
by stkcd; 
if first.stkcd then count = 1; 
if count < 9 then delete;
drop count;
run;


/*get the return and size*/

PROC SQL;
CREATE TABLE value AS
SELECT * FROM market;
QUIT;
data value; set value ;rename month=date;run;

proc sql;
create table value as
select * from value
where month(date) in (3,6,9,12);
quit;
proc sort data=value; by  stkcd date;run;
/*calculate the return*/
data value; set value;lag=lag1(price);ret=(price/lag)**(1/3)-1;drop lag price;run;

/*delete useless data*/
data value; 
set value; 
count + 1; 
by stkcd; 
if first.stkcd then count = 1; 
if count < 2 then delete;
drop count;
run;


data value; set value;if year(date)<2011 or year(date)>2018 then delete;run;
proc sort data=value;by stkcd date;quit;
data value; set value; rename date=year;run;





/*merge first and ie*/

proc sql noprint;
create table te as
select fyear as year,stkcd,ie from first;
quit;
/*only extra data we need*/
data valuea; set value;if year(year)<2013 or year>'01OCT2018'd then delete;run;
proc sort data=te;by stkcd year;quit;
proc sort data=valuea;by stkcd year;quit;
DATA value1;
MERGE valuea(IN=a) te(IN=b);
BY stkcd;
IF a=1 and b=1;
RUN;
proc sort data=value1;by stkcd year;run;



/*merge second and ie*/

proc sql noprint;
create table te as
select fyear as year,stkcd,ie from second;
quit;

data valuea; set value;if year(year)<2013 or year>'01OCT2018'd then delete;run;
proc sort data=valuea;by stkcd year;quit;
proc sort data=te;by stkcd year;quit;
DATA value2;
MERGE valuea(IN=a) te(IN=b);
BY stkcd;
IF a=1 and b=1;
if stkcd='.' then delete;
RUN;
proc sort data=value2;by stkcd year;run;
/*delete useless sheet*/
proc sql; drop table r,rd,te,value,valuea;quit;



/***************************************************************************************************************/


/*first ie linear regression*/
/*get the data we need from different sheet then merge it*/
proc sql noprint;
create table x1 as
select fyear as year ,stkcd,npat,xrd,ie from first;
quit;
proc sql noprint;
create table x2 as
select year ,stkcd,me ,ret from value1;
quit;
data x2;set x2; format year yymms.;run;
proc sort data= x1;by stkcd year;quit;
proc sort data= x2;by stkcd year;quit;
data line1;merge x1 x2; by stkcd;run;
proc sql ;drop table x1,x2;quit;

/*constructe the data we are going to regression*/
data line1;set line1;ret=(ret+1)**3-1;
lnie=log(1+ie);lnme=log(1+me);
lnrd=log(1+xrd/me);lnpat=log(1+npat/me);drop xrd me ie npat;run;

/*do the regression of each stock and output the parameters into certain sheet*/
%macro slo(x=,y=);
proc reg data=line1  outest=&y;
model ret=lnie lnme lnpat;
where stkcd=&x;
run;
%mend slo;

%slo(x=63,y=t1);
%slo(x=597,y=t2);
%slo(x=625,y=t3);
%slo(x=682,y=t4);
%slo(x=816,y=t6);
%slo(x=903,y=t7);
%slo(x=998,y=t8);
%slo(x=999,y=t9);
%slo(x=2008,y=t10);
%slo(x=2009,y=t11);
%slo(x=2030,y=t12);
%slo(x=2038,y=t13);
%slo(x=2098,y=t14);
%slo(x=2151,y=t15);
%slo(x=2161,y=t16);
%slo(x=2202,y=t17);
%slo(x=2230,y=t18);
%slo(x=2232,y=t19);
%slo(x=2253,y=t20);
%slo(x=600062,y=t21);
%slo(x=600100,y=t22);
%slo(x=600166,y=t23);
%slo(x=600222,y=t24);
%slo(x=600268,y=t25);
%slo(x=600312,y=t26);
%slo(x=600316,y=t27);
%slo(x=600351,y=t28);
%slo(x=600406,y=t29);
%slo(x=600418,y=t30);
%slo(x=600420,y=t31);
%slo(x=600422,y=t32);
%slo(x=600497,y=t33);
%slo(x=600535,y=t34);
%slo(x=600839,y=t35);
%slo(x=600980,y=t36);
%slo(x=600990,y=t37);
%slo(x=600993,y=t38);

/*merge all the parameter into one sheet*/
data slo;set t1 t2 t3 t4 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31 t32 t33 t34 t35 t36 t37 t38;run;
proc sql; drop table t1,t2,t3,t4,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31,t32,t33,t34,t35,t36,t37,t38;quit;

/*calculate the average of the slope*/
proc means data = slo range mean;
var lnie lnme lnpat _RMSE_;
run;






/*get the data we need from different sheet then merge it*/
proc sql noprint;
create table x1 as
select fyear as year ,stkcd,citation,xrd,ie from second;
quit;
proc sql noprint;
create table x2 as
select year ,stkcd,me ,ret from value2;
quit;
data x2;set x2; format year yymms.;run;
proc sort data= x1;by stkcd year;quit;
proc sort data= x2;by stkcd year;quit;
data line1;merge x1 x2; by stkcd;run;
proc sql ;drop table x1,x2;quit;
/*constructe the data we are going to regression*/
data line1;set line1;ret=(ret+1)**3-1;
lnie=log(1+ie);lnme=log(1+me);
lnrd=log(1+xrd/me);lncite=log(1+citation/me);drop xrd me ie npat;run;

/*do the regression of each stock and output the parameters into certain sheet*/
%macro slo(x=,y=);
proc reg data=line1  outest=&y;
model ret=lnie lnme lnrd lncite ;
where stkcd=&x;
run;
%mend slo;

%slo(x=63,y=t1);
%slo(x=597,y=t2);
%slo(x=625,y=t3);
%slo(x=682,y=t4);
%slo(x=816,y=t6);
%slo(x=903,y=t7);
%slo(x=998,y=t8);
%slo(x=999,y=t9);
%slo(x=2008,y=t10);
%slo(x=2009,y=t11);
%slo(x=2030,y=t12);
%slo(x=2038,y=t13);
%slo(x=2098,y=t14);
%slo(x=2151,y=t15);
%slo(x=2161,y=t16);
%slo(x=2202,y=t17);
%slo(x=2230,y=t18);
%slo(x=2232,y=t19);
%slo(x=2253,y=t20);
%slo(x=600062,y=t21);
%slo(x=600100,y=t22);
%slo(x=600166,y=t23);
%slo(x=600222,y=t24);
%slo(x=600268,y=t25);
%slo(x=600312,y=t26);
%slo(x=600316,y=t27);
%slo(x=600351,y=t28);
%slo(x=600406,y=t29);
%slo(x=600418,y=t30);
%slo(x=600420,y=t31);
%slo(x=600422,y=t32);
%slo(x=600497,y=t33);
%slo(x=600535,y=t34);
%slo(x=600839,y=t35);
%slo(x=600980,y=t36);
%slo(x=600990,y=t37);
%slo(x=600993,y=t38);

/*merge all the parameter into one sheet*/
data slo;set t1 t2 t3 t4 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31 t32 t33 t34 t35 t36 t37 t38;run;
proc sql; drop table t1,t2,t3,t4,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31,t32,t33,t34,t35,t36,t37,t38;quit;

/*calculate the average of the slope*/
proc means data = slo range mean;
var lnie lnme lnrd lncite _RMSE_;
run;



/*******************************************************************************************************************/
 /*get the breakpoint*/
proc sql noprint;
create table breakpoint as
select month as fyear ,SIZEMEDN as point from break;
quit;
 data breakpoint; set breakpoint; format fyear yymms.;if year(fyear)>2018 or year(fyear)<2011 then delete; rename fyear=year;run;
 proc sql;
create table breakpoint as
select * from breakpoint
where month(year) in (3,6,9,12);
quit;  
proc sort data=value1;by year;quit;
proc sort data=value2;by year;quit;


/*add the market median into the sheets*/
%MACRO cha(y=,m= ,po=);
data value1;set value1;if year(year)=&y and month(year)=&m then point=&po;run;
data value2;set value2;if year(year)=&y and month(year)=&m then point=&po;run;
%mend cha;
%cha(y=2011,m=3 ,po=3056.52779);
%cha(y=2011,m=6 ,po=2810.95335);
%cha(y=2011,m=9 ,po=2447.31054);
%cha(y=2011,m=12 ,po=1983.6223);
%cha(y=2012,m=3 ,po=2055.14203);
%cha(y=2012,m=6 ,po=2028.94234);
%cha(y=2012,m=9 ,po=1911.07463);
%cha(y=2012,m=12 ,po=2000.39094);
%cha(y=2013,m=3 ,po=2248.064);
%cha(y=2013,m=6 ,po=2083.33406);
%cha(y=2013,m=9 ,po=2599.99761);
%cha(y=2013,m=12 ,po=2729.079435);
%cha(y=2014,m=3 ,po=2845.90851);
%cha(y=2014,m=6 ,po=3075.40943);
%cha(y=2014,m=9 ,po=4063.392825);
%cha(y=2014,m=12 ,po=4016.55317);
%cha(y=2015,m=3 ,po=5855.71654);
%cha(y=2015,m=6 ,po=7265.77653);
%cha(y=2015,m=9 ,po=4644.456765);
%cha(y=2015,m=12 ,po=7021.959975);
%cha(y=2016,m=3 ,po=5615.388455);
%cha(y=2016,m=6 ,po=5946.27881);
%cha(y=2016,m=9 ,po=5957.85804);
%cha(y=2016,m=12 ,po=5884.058485);
%cha(y=2017,m=3 ,po=5602.88699);
%cha(y=2017,m=6 ,po=4850.43405);
%cha(y=2017,m=9 ,po=5076.76419);
%cha(y=2017,m=12 ,po=4471.19015);
%cha(y=2018,m=3 ,po=4282.40133);
%cha(y=2018,m=6 ,po=3459.14868);
%cha(y=2018,m=9 ,po=3254.24885);





/*build the classified data. big or small*/
data value1; set value1; if ME>point then size="b";if ME<=point then size="s";run;
proc sort data= value1;by year ie;quit;

/*group the stock by ie into high, middle and low groups*/
data value1; 
set value1; 
count + 1; 
by year; 
if first.year then count = 1; 
if count<=37/3 then ipoint="l";
if 37/3<count<=37*2/3 then ipoint="m";
if count>37*2/3  then ipoint="h";
class=cat(size,ipoint);
drop count point size ipoint;
run;


/*according to the group, calculate the value-weighted return and ie of three ie groups*/
%MACRO rad1(y1=,m1=,y2=,m2=,t=);
proc sort data= value1;by year class;quit;
proc sql;
create table &t as
select year, stkcd,ME,ret,ie from value1
having year(year)=&y1 and month(year)=&m1;
create table tem as
select stkcd,class from value1
having year(year)=&y2 and month(year)=&m2;
quit;
proc sort data= tem;by stkcd;quit;
proc sort data= &t;by stkcd;quit;
data &t; merge &t tem;by stkcd;run;
proc sql;
   create table tem1 as
   select class, sum(ME*ret)/sum(ME) as average
      from &t
      group by class;
quit;
proc sql;
   create table tem2 as
   select class, sum(ME*ie)/sum(ME) as ie
      from &t
      group by class;
quit;
data tem1; set tem1; if class="" then delete;run;
data tem2; set tem2; if class="" then delete;run;
proc transpose data=tem1(keep=class average) out=tem1 (drop=_name_ _label_);
	ID class;
	Var average;
run;
proc transpose data=tem2 (keep=class ie) out=tem2 (drop=_name_ _label_);
	ID class;
	Var ie;
run;
data temp;
input bl bm bh sl sm sh;run;
data tem1; merge temp tem1;run;
data tem1;
set tem1;
array a(*) _numeric_;
do i=1 to dim(a);
if a(i) = . then a(i) = 0;
end;
drop i;run;
data tem1;set tem1;year=&y1;month=&m1;l=(bl+sl)/2;m=(bm+sm)/2;h=(bh+sh)/2;drop bl bm bh sl sm sh;run;

data &t; set tem1 ;run;
proc sql; drop table tem,temp,tem1,tem2;quit;
%MEND rad1;


%rad1(y1=2013,m1=6,y2=2013,m2=3,t=y136);
%rad1(y1=2013,m1=9,y2=2013,m2=6,t=y139);
%rad1(y1=2013,m1=12,y2=2013,m2=9,t=y1312);
%rad1(y1=2014,m1=3,y2=2013,m2=12,t=y143);
%rad1(y1=2014,m1=6,y2=2014,m2=3,t=y146);
%rad1(y1=2014,m1=9,y2=2014,m2=6,t=y149);
%rad1(y1=2014,m1=12,y2=2014,m2=9,t=y1412);
%rad1(y1=2015,m1=3,y2=2014,m2=12,t=y153);
%rad1(y1=2015,m1=6,y2=2015,m2=3,t=y156);
%rad1(y1=2015,m1=9,y2=2015,m2=6,t=y159);
%rad1(y1=2015,m1=12,y2=2015,m2=9,t=y1512);
%rad1(y1=2016,m1=3,y2=2015,m2=12,t=y163);
%rad1(y1=2016,m1=6,y2=2016,m2=3,t=y166);
%rad1(y1=2016,m1=9,y2=2016,m2=6,t=y169);
%rad1(y1=2016,m1=12,y2=2016,m2=9,t=y1612);
%rad1(y1=2017,m1=3,y2=2016,m2=12,t=y173);
%rad1(y1=2017,m1=6,y2=2017,m2=3,t=y176);
%rad1(y1=2017,m1=9,y2=2017,m2=6,t=y179);
%rad1(y1=2017,m1=12,y2=2017,m2=9,t=y1712);
%rad1(y1=2018,m1=3,y2=2017,m2=12,t=y183);
%rad1(y1=2018,m1=6,y2=2018,m2=3,t=y186);
%rad1(y1=2018,m1=9,y2=2018,m2=6,t=y189);


data wereturn1; set y136 y139 y1312 y143 y146 y149 y1412 y153 y156 y159 y1512 y163 y166 y169 y1612 y173 y176 y179 y1712 y183 y186 y189;run;
proc sql; drop table y136, y139, y1312, y143, y146, y149, y1412, y153, y156, y159, y1512, y163, y166, y169, y1612, y173, y176 ,y179 ,y1712, y183, y186, y189;quit;



/*classify the value2*/
data value2; set value2; if me>point then size="b";if me<=point then size="s";run;
proc sort data= value2;by year ie;quit;

/*group the stock by ie into high, middle and low groups*/
data value2; 
set value2; 
count + 1; 
by year; 
if first.year then count = 1; 
if count<=37/3 then ipoint="l";
if 37/3<count<=37*2/3 then ipoint="m";
if count>37*2/3 then ipoint="h";
class=cat(size,ipoint);
drop count point size ipoint;
run;



/*according to the group, calculate the value-weighted return and ie of three ie groups*/
%MACRO rad2(y1=,m1=,y2=,m2=,t=);
proc sort data= value2;by year class;quit;
proc sql;
create table &t as
select year, stkcd,ME,ret,ie from value2
having year(year)=&y1 and month(year)=&m1;
create table tem as
select stkcd,class from value2
having year(year)=&y2 and month(year)=&m2;
quit;
proc sort data= tem;by stkcd;quit;
proc sort data= &t;by stkcd;quit;
data &t; merge &t tem;by stkcd;run;
proc sql;
   create table tem1 as
   select class, sum(ME*ret)/sum(ME) as average
      from &t
      group by class;
quit;
proc sql;
   create table tem2 as
   select class, sum(ME*ie)/sum(ME) as ie
      from &t
      group by class;
quit;
data tem1; set tem1; if class="" then delete;run;
data tem2; set tem2; if class="" then delete;run;
proc transpose data=tem1(keep=class average) out=tem1 (drop=_name_ _label_);
	ID class;
	Var average;
run;
proc transpose data=tem2 (keep=class ie) out=tem2 (drop=_name_ _label_);
	ID class;
	Var ie;
run;
data temp;
input bl bm bh sl sm sh;run;
data tem1; merge temp tem1;run;
data tem1;
set tem1;
array a(*) _numeric_;
do i=1 to dim(a);
if a(i) = . then a(i) = 0;
end;
drop i;run;
data tem1;set tem1;year=&y1;month=&m1;l=(bl+sl)/2;m=(bm+sm)/2;h=(bh+sh)/2;drop bl bm bh sl sm sh;run;

data &t; merge tem1;run;
proc sql; drop table tem,temp,tem1,tem2;quit;
%MEND rad2;


%rad2(y1=2013,m1=6,y2=2013,m2=3,t=y136);
%rad2(y1=2013,m1=9,y2=2013,m2=6,t=y139);
%rad2(y1=2013,m1=12,y2=2013,m2=9,t=y1312);
%rad2(y1=2014,m1=3,y2=2013,m2=12,t=y143);
%rad2(y1=2014,m1=6,y2=2014,m2=3,t=y146);
%rad2(y1=2014,m1=9,y2=2014,m2=6,t=y149);
%rad2(y1=2014,m1=12,y2=2014,m2=9,t=y1412);
%rad2(y1=2015,m1=3,y2=2014,m2=12,t=y153);
%rad2(y1=2015,m1=6,y2=2015,m2=3,t=y156);
%rad2(y1=2015,m1=9,y2=2015,m2=6,t=y159);
%rad2(y1=2015,m1=12,y2=2015,m2=9,t=y1512);
%rad2(y1=2016,m1=3,y2=2015,m2=12,t=y163);
%rad2(y1=2016,m1=6,y2=2016,m2=3,t=y166);
%rad2(y1=2016,m1=9,y2=2016,m2=6,t=y169);
%rad2(y1=2016,m1=12,y2=2016,m2=9,t=y1612);
%rad2(y1=2017,m1=3,y2=2016,m2=12,t=y173);
%rad2(y1=2017,m1=6,y2=2017,m2=3,t=y176);
%rad2(y1=2017,m1=9,y2=2017,m2=6,t=y179);
%rad2(y1=2017,m1=12,y2=2017,m2=9,t=y1712);
%rad2(y1=2018,m1=3,y2=2017,m2=12,t=y183);
%rad2(y1=2018,m1=6,y2=2018,m2=3,t=y186);
%rad2(y1=2018,m1=9,y2=2018,m2=6,t=y189);

data wereturn2; set y136 y139 y1312 y143 y146 y149 y1412 y153 y156 y159 y1512 y163 y166 y169 y1612 y173 y176 y179 y1712 y183 y186 y189;run;
proc sql; drop table y136, y139, y1312, y143, y146, y149, y1412, y153, y156, y159, y1512, y163, y166, y169, y1612, y173, y176 ,y179 ,y1712, y183, y186, y189;quit;





data wereturn1; set wereturn1; year=mdy(month,1,year);format year yymms.;drop month;run;
data wereturn2; set wereturn2; year=mdy(month,1,year);format year yymms.;drop month;run;




/*regression*/
/*extra the ff model factor of certain period*/
data factor; set locallib.factor; if year(year)>2018 or year(year)<2013  then delete;format year yymms.;run;

/*preprocess the data*/
data regression1; merge wereturn1 factor;by year;l=l-rf;m=m-rf; h=h-rf;drop rf;run;
data regression2; merge wereturn2 factor;by year;l=l-rf;m=m-rf; h=h-rf;drop rf;run;



/*replace the none value with the last value*/
%macro loop(y=,x=);
data &y;
retain old;
set &y;
if &x ne . then old=&x;
else &x=old;
drop old;
run;
%mend loop();

%loop(y=regression1,x=l);
%loop(y=regression1,x=m);
%loop(y=regression1,x=h);


%loop(y=regression2,x=l);
%loop(y=regression2,x=m);
%loop(y=regression2,x=h);


data regression1;set regression1;if l='.' then delete; run;
data regression2;set regression2;if l='.' then delete; run;

/*first part of the regression*/
proc reg data=regression1;
model l=mkt smb hml;
run;
proc reg data=regression1;
model m=mkt smb hml;
run;
proc reg data=regression1;
model h=mkt smb hml ;
run;

proc reg data=regression2;
model l=mkt smb hml;
run;
proc reg data=regression2;
model m=mkt smb hml;
run;
proc reg data=regression2;
model h=mkt smb hml;
run;

/*second part*/
proc reg data=regression1;
model l=mkt inv roe;
run;

proc reg data=regression1;
model m=mkt inv roe;
run;

proc reg data=regression1;
model h=mkt inv roe;
run;

proc reg data=regression2;
model l=mkt inv roe;

run;

proc reg data=regression2;
model m=mkt inv roe;
run;

proc reg data=regression2;
model h=mkt inv roe;
run;







/*used for IE portfolio statistic*/
proc sql noprint;
create table x1 as
select fyear as year ,stkcd,npat,xrd,ie from first;
quit;
proc sql noprint;
create table x2 as
select year ,stkcd,me ,ret ,class from value1;
quit;
data x2;set x2; format year yymms.;run;
proc sort data= x1;by stkcd year;quit;
proc sort data= x2;by stkcd year;quit;
data sta;merge x1 x2; by stkcd;run;
proc sql ;drop table x1,x2;quit;

/*constructe the data we are going to regression*/
data sta;set sta;ret=(ret+1)**3-1;
lnie=log(1+ie);lnme=(1+me);
lnrd=log(1+xrd/me);lnpat=log(1+npat/me);run;

proc means data = sta  mean;
var me ie xrd ret lnie lnrd lnpat npat;
where class="sl"or class="bl";
run;
proc means data = sta  mean;
var me ie xrd ret lnie lnrd lnpat npat;
where class="sm"or class="bm";
run;
proc means data = sta  mean;
var me ie xrd ret lnie lnrd lnpat npat;
where class="sh"or class="bh";
run;
proc corr data=sta outp=cor1;
var npat xrd ie me  ret lnie lnrd lnpat;
run;




/*used for statistic*/
proc sql noprint;
create table x1 as
select fyear as year ,stkcd,citation,xrd,ie from second;
quit;
proc sql noprint;
create table x2 as
select year ,stkcd,me ,ret ,class from value2;
quit;
data x2;set x2; format year yymms.;run;
proc sort data= x1;by stkcd year;quit;
proc sort data= x2;by stkcd year;quit;
data sta;merge x1 x2; by stkcd;run;
proc sql ;drop table x1,x2;quit;

/*constructe the data we are going to regression*/
data sta;set sta;ret=(ret+1)**3-1;
lnie=log(1+ie);lnme=(1+me);
lnrd=log(1+xrd/me);lncite=log(1+citation/me);run;

proc means data = sta  mean;
var me ie xrd ret lnie lnrd lncite citation;
where class="sl"or class="bl";
run;
proc means data = sta  mean;
var me ie xrd ret lnie lnrd lncite citation;
where class="sm"or class="bm";
run;
proc means data = sta  mean;
var me ie xrd ret lnie lnrd lncite citation;
where class="sh"or class="bh";
run;

proc corr data=sta outp=cor2;
var citation xrd ie me  ret lnie lnrd lncite;
run;
