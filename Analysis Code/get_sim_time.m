function [t] = get_sim_time(simnameshort)

ID = split(simnameshort,'-'); ID=cell2mat(ID(1));

switch ID
    case 'ARG1.1'
        t1 = datetime(2018,12,13,12,0,0);
        t2 = datetime(2018,12,14,06,0,0);
    case 'ARG1.2'
        t1 = datetime(2018,12,13,12,0,0);
        t2 = datetime(2018,12,14,06,0,0);
    case 'AUS1.1'
        t1 = datetime(2006,01,23,03,0,0);
        t2 = datetime(2006,01,23,16,30,0);
    case 'BOT1.1'
        t1 = datetime(2021,11,20,00,0,0);
        t2 = datetime(2021,11,20,23,0,0);
    case 'BRA1.1'
        t1 = datetime(2014,03,31,00,0,0);
        t2 = datetime(2014,04,01,16,0,0);
    case 'BRA2.1'
        t1 = datetime(2014,03,31,00,0,0);
        t2 = datetime(2014,04,01,16,0,0);
    case 'DRC1.1'
        t1 = datetime(2016,12,30,00,0,0);
        t2 = datetime(2016,12,30,22,0,0);
    case 'PHI1.1'
        t1 = datetime(2019,09,09,18,0,0);
        t2 = datetime(2019,09,10,13,0,0);
    case 'PHI2.1'
        t1 = datetime(2019,09,10,00,0,0);
        t2 = datetime(2019,09,10,21,0,0);    
    case 'RSA2.1'
        t1 = datetime(2021,11,20,00,0,0);
        t2 = datetime(2021,11,20,23,0,0);    
    case 'SAU1.1'
        t1 = datetime(2018,06,11,00,0,0);
        t2 = datetime(2018,06,11,16,0,0);  
    case 'SIO1.1'
        t1 = datetime(2011,11,23,12,0,0);
        t2 = datetime(2011,11,24,20,0,0);    
    case 'USA1.1'
        t1 = datetime(2022,09,15,12,0,0);
       % t2 = datetime(2022,09,16,15,0,0);    
        t2 = datetime(2022,09,16,23,0,0); 
    case 'USA2.1'
        t1 = datetime(2024,05,01,10,0,0);  
        t2 = datetime(2024,05,02,10,0,0); 
    case 'WPO1.1'
        t1 = datetime(2018,08,27,12,0,0);
        t2 = datetime(2018,08,28,12,0,0);    
    otherwise
        disp('Simulation ID not found in database')
end

t = t1:minutes(5):t2;
t.Format = ('yyyy-MM-dd HH:mm');

end