function [t] = get_sim_time_local(simnameshort)

ID = simnameshort;

switch ID
    case 'ARG1.1'
        t1 = datetime(2018,12,13,15,0,0);
        t2 = datetime(2018,12,14,03,0,0);
    case 'AUS1.1'
        t1 = datetime(2018,12,13,18,30,0);
        t2 = datetime(2018,12,14,01,30,0);
    case 'DRC1.1'
        t1 = datetime(2018,12,13,8,0,0);
        t2 = datetime(2018,12,14,0,0,0);
    case 'PHI1.1'
        t1 = datetime(2018,12,13,08,0,0);
        t2 = datetime(2018,12,13,21,0,0);
    case 'WPO1.1'
        t1 = datetime(2018,12,13,03,0,0);
        t2 = datetime(2018,12,13,21,0,0);    
    otherwise
        disp('Simulation ID not found in database')
end

t = t1:minutes(15):t2;
t.Format = ('yyyy-MM-dd HH:mm');

end