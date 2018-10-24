function info = Mitra01_info()

global info
global figuredir
global datadir_manuscript
global figuredir_manuscript
figuredir = 'E:\matlab_figures';
figuredir_manuscript = 'E:\figures_mitra_paper';
datadir_manuscript   = 'E:\data_mitra_paper';
mkdir(figuredir_manuscript)
mkdir(datadir_manuscript)
info = [];



info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-03-04_15-16-01'
info(end).name        = 'TT2_1';
info(end).base_start  = 869520*10^6;
info(end).base_end    = 869972*10^6;
info(end).injection_start =  870230*10^6;
info(end).seizure_onset  = 870350*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\2013-03-04_15-16-01'
info(end).sta_channel = [1, 2];
info(end).sta_cut     = 1;
info(end).ictalspike     = -34;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 4;
info(end).cre = 'PV';
info(end).stable_until = 8.704059418260000e+11;
%
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-03-04_15-16-01'
info(end).name        = 'TT3_1';
info(end).base_start  = 869820*10^6;
info(end).base_end    = 869972*10^6;
info(end).injection_start =  870230*10^6;
info(end).seizure_onset  = 870350*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\2013-03-04_15-16-01'
info(end).sta_channel = [2, 5];
info(end).sta_cut     = 1;
info(end).ictalspike     = -34;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 4;
info(end).cre = 'PV';
info(end).stable_until = 8.703927205510000e+11;

%
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-03-04_15-16-01'
info(end).name        = 'TT1_1';
info(end).base_start  = 869820*10^6;
info(end).base_end    = 869972*10^6;
info(end).injection_start =  870230*10^6;
info(end).seizure_onset  = 870350*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\2013-03-04_15-16-01'
info(end).sta_channel = [7, 10];
info(end).sta_cut     = 1;
info(end).ictalspike     = -34;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 4;
info(end).stable_until = 8.704059190826906e+11;
%
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2014-03-14_17-35-00'
info(end).name        = 'TT1_1';
info(end).base_start  = 16355195 *10^6;
info(end).base_end    = 16355500 *10^6;
info(end).injection_start = 16355550 *10^6;
info(end).seizure_onset  = 16356098 *10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\2014-03-14_17-35-00'
info(end).sta_channel = [12, 6];
info(end).ictalspike     = -17;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -40;
info(end).cre = 'PV';
info(end).stable_until = 1.635609195822400e+13
%
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2014-03-14_17-35-00'
info(end).name        = 'TT1_2';
info(end).base_start  = 16355195 *10^6;
info(end).base_end    = 16355500 *10^6;
info(end).injection_start = 16355550 *10^6;
info(end).seizure_onset  = 16356098 *10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\2014-03-14_17-35-00'
info(end).sta_channel = [12,6];
info(end).ictalspike     = -17;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -40;
info(end).cre = 'PV';
info(end).stable_until = 1.635611857887400e+13;
% 6
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2014-03-14_17-35-00'
info(end).name        = 'TT1_3';
info(end).base_start  = 16355195 *10^6;
info(end).base_end    = 16355500 *10^6;
info(end).injection_start = 16355550 *10^6;
info(end).seizure_onset  = 16356098 *10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-03-14_17-35-00'
info(end).sta_channel = [10];
info(end).ictalspike     = -17;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -40;
info(end).cre = 'PV';
info(end).stable_until =  1.635604176198334e+13;
% 7
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2014-03-14_17-35-00'
info(end).name        = 'TT3_1';
info(end).base_start  = 16355195 *10^6;
info(end).base_end    = 16355500 *10^6;
info(end).injection_start = 16355550 *10^6;
info(end).seizure_onset  = 16356098 *10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-03-14_17-35-00'
info(end).sta_channel = [6];
info(end).ictalspike     = -17;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -40;
info(end).stable_until = 1.635615132317400e+13;
%8
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2014-03-14_17-35-00'
info(end).name        = 'TT3_2';
info(end).base_start  = 16355195 *10^6;
info(end).base_end    = 16355500 *10^6;
info(end).injection_start = 16355550 *10^6;
info(end).seizure_onset  = 16356098 *10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-03-14_17-35-00'
info(end).sta_channel = [2,6];
info(end).ictalspike     = -17;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -40;
info(end).stable_until = 1.635617280312400e+13;

%9
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-02-25_18-06-16'
info(end).name        = 'TT1_1';
info(end).base_start  = 275450*10^6;
info(end).base_end    = 275750*10^6;
info(end).injection_start = 275796*10^6;  
info(end).seizure_onset  = 276260*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-02-25_18-06-16'
info(end).sta_channel = [8];
info(end).ictalspike     = -88;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -6;
info(end).stable_until = NaN;
%10
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2013-05-30_14-20-18'
info(end).name        = 'TT2_rethresh25_1';
info(end).base_start  = 1223820*10^6;
info(end).base_end    = 1223820*10^6+ 60*10^6;
info(end).injection_start = 1223860*10^6; 
info(end).seizure_onset  = 1224030*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-05-30_14-20-18'
info(end).sta_channel = [4];
info(end).ictalspike     = -62;
info(end).seizure_autodetect     = 40;
info(end).seizure_autodetect_absolute     = 43;
info(end).stable_until = 1.224076504175000e+12;

%11
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-05-30_14-20-18'
info(end).name        = 'TT1_1';
info(end).base_start  = 1223300*10^6;
info(end).base_end    = 1223860*10^6;
info(end).injection_start = 1223860*10^6; 
info(end).seizure_onset  = 1224030*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-05-30_14-20-18'
info(end).sta_channel = [14];
info(end).ictalspike     = -62;
info(end).seizure_autodetect     = 40;
info(end).seizure_autodetect_absolute     = 43;
info(end).cre = 'PV';
info(end).stable_until = 1.224081805325000e+12;
%12
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-05-30_14-20-18'
info(end).name        = 'TT1_2';
info(end).base_start  = 1223300*10^6;
info(end).base_end    = 1223860*10^6;
info(end).injection_start = 1223860*10^6; 
info(end).seizure_onset  = 1224030*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-05-30_14-20-18'
info(end).sta_channel = [14];
info(end).ictalspike     = -62;
info(end).seizure_autodetect     = 40;
info(end).seizure_autodetect_absolute     = 43;
info(end).cre = 'PV';
info(end).stable_until = 1.224096436825000e+12;
%
% info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-05-24_15-24-20'
% info(end).name        = 'TT3_1';
% info(end).base_start  = 708708*10^6;
% info(end).base_end    = 708982*10^6;
% info(end).injection_start = 709640*10^6; 
% info(end).seizure_onset  = 709880*10^6;
% info(end).neuron_type    = 'PV';
% info(end).has_rc         = 0;
% info(end).exclude_rc        =1;
% info(end).directory_brain = 'U:\2013-05-24_15-24-20'
% info(end).sta_channel = [1];
% info(end).ictalspike     = -84;
%13
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-12-30_15-52-34'
info(end).name        = 'TT1_1';
info(end).base_start  = 12250*10^6;
info(end).base_end    = 12640*10^6;
info(end).injection_start = 12740*10^6; 
info(end).seizure_onset  = 12841*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-12-30_15-52-34'
info(end).sta_channel = [9];
info(end).ictalspike     = 0;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 15;
info(end).stable_until = 1.291572985200000e+10;
%14
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-12-30_15-52-34'
info(end).name        = 'TT2_1';
info(end).base_start  = 12250*10^6;
info(end).base_end    = 12640*10^6;
info(end).injection_start = 12740*10^6; 
info(end).seizure_onset  = 12841*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-12-30_15-52-34'
info(end).sta_channel = [1];
info(end).sta_cut     = 1;
info(end).ictalspike     = 0;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 15;
info(end).stable_until = 1.287818745200000e+10
%15
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-12-31_15-11-16'
info(end).name        = 'TT2_1';
info(end).base_start  = 7350*10^6;
info(end).base_end    = 7640*10^6;
info(end).injection_start = 7640*10^6; 
info(end).seizure_onset  = 7770*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-12-31_15-11-16'
info(end).sta_channel = [4];
info(end).sta_cut     = 1;
info(end).ictalspike     = -28;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 103;
info(end).stable_until = 7859218600;
%16
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-02_14-21-34'
info(end).name        = 'TT3_1';
info(end).base_start  = 12830*10^6;
info(end).base_end    = 13200*10^6;
info(end).injection_start = 13200*10^6; 
info(end).seizure_onset  = 13430*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-02_14-21-34'
info(end).sta_channel = [5];
info(end).sta_cut     = 1;
info(end).ictalspike     = -33;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 23;
info(end).stable_until = 1.363975835000000e+10
%17
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-06_14-26-34'
info(end).name        = 'TT1_1';
info(end).base_start  = 5924*10^6;
info(end).base_end    = 6160*10^6;
info(end).injection_start = 6160*10^6; 
info(end).seizure_onset  = 6300*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-06_14-26-34'
info(end).sta_channel = [12];
info(end).ictalspike     = -35;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 61;
info(end).stable_until = 6.301757150000000e+09;
%18
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2013-12-08_13-45-35'
info(end).name        = 'TT3_1';
info(end).base_start  = 8050550*10^6;
info(end).base_end    = 8050720*10^6;
info(end).injection_start = 8050789*10^6;  
info(end).seizure_onset  = 8050977*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-12-08_13-45-35'
info(end).sta_channel = [4];
info(end).ictalspike     = -101;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -43;
info(end).stable_until = 8.051160529224001e+12;
% 19

info(end+1).directory = 'E:\SRT2014\chr2_ptz\2013-12-08_13-45-35'
info(end).name        = 'TT3_2';
info(end).base_start  = 8050550*10^6;
info(end).base_end    = 8050720*10^6;
info(end).injection_start = 8050789*10^6;  
info(end).seizure_onset  = 8050977*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-12-08_13-45-35'
info(end).sta_channel = [4];
info(end).ictalspike     = -101;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -43;
info(end).cre = 'SOM';
info(end).stable_until = 8.051160894999001e+12
%
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2013-12-08_13-45-35'
info(end).name        = 'TT3_3';
info(end).base_start  = 8050550*10^6;
info(end).base_end    = 8050720*10^6;
info(end).injection_start = 8050789*10^6;  
info(end).seizure_onset  = 8050977*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-12-08_13-45-35'
info(end).sta_channel = [1];
info(end).ictalspike     = -101;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -43;
info(end).stable_until  = 8.051161602124001e+12;

%21
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-03-09_16-15-22'
info(end).name        = 'TT3_1';
info(end).base_start  = 15918670*10^6;
info(end).base_end    = 15919000*10^6;
info(end).injection_start = 15919000*10^6; 
info(end).seizure_onset  = 15919105*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-03-09_16-15-22'
info(end).sta_channel = [2];
info(end).ictalspike     = -8;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -2;
info(end).stable_until = 1.591911366212400e+13;
%22
%
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-03-10_14-47-26old'
info(end).name        = 'TT3_1';
info(end).base_start  = 15999320*10^6;
info(end).base_end    = 15999955*10^6;
info(end).injection_start = 16000020*10^6;
info(end).seizure_onset  = 16000350*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-03-10_14-47-26'
info(end).sta_channel = [1];
info(end).ictalspike     = -73;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 57;
info(end).cre = 'SOM';
info(end).stable_until =1.600055356382400e+13

%23
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-03-10_14-47-26old'
info(end).name        = 'TT3_2';
info(end).base_start  = 15999320*10^6;
info(end).base_end    = 15999955*10^6;
info(end).injection_start = 16000020*10^6;
info(end).seizure_onset  = 16000350*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-03-10_14-47-26'
info(end).sta_channel = [1];
info(end).ictalspike     = -73;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 57;
info(end).cre = 'SOM';
info(end).stable_until =1.600050112687400e+13
%24
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-03-10_14-47-26old'
info(end).name        = 'TT3_3';
info(end).base_start  = 15999320*10^6;
info(end).base_end    = 15999955*10^6;
info(end).injection_start = 16000020*10^6;
info(end).seizure_onset  = 16000350*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-03-10_14-47-26'
info(end).sta_channel = [5];
info(end).ictalspike     = -73;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 57;
info(end).stable_until =1.600069828649900e+13
%25
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-03-10_14-47-26old'
info(end).name        = 'TT3_4';
info(end).base_start  = 15999320*10^6;
info(end).base_end    = 15999955*10^6;
info(end).injection_start = 16000020*10^6;
info(end).seizure_onset  = 16000350*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-03-10_14-47-26'
info(end).sta_channel = [5];
info(end).ictalspike     = -73;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 57;
info(end).cre = 'SOM';
info(end).stable_until =1.600078835034900e+13
%26
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-03-14_13-51-24som'
info(end).name        = 'TT1_1';
info(end).base_start  = 166804*10^6;
info(end).base_end    = 166804*10^6+ 60*10^6;
info(end).injection_start = 167190*10^6; 
info(end).seizure_onset  = 167290*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-03-14_13-51-24';
info(end).munumbers       = 2:5;
info(end).sta_channel = [6];
info(end).sta_cut     = 1;
info(end).ictalspike     = -35;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -14;
info(end).stable_until = 1.675703359250000e+11
%27
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-03-14_13-51-24som\old'
info(end).name        = 'TT2_1';
info(end).base_start  = 166796*10^6;
info(end).base_end    = 167020*10^6;
info(end).injection_start = 167198*10^6; 
info(end).seizure_onset  = 167285*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-03-14_13-51-24'
info(end).sta_channel = [3];
info(end).sta_cut     = 1;
info(end).ictalspike     = -35;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -14;
info(end).stable_until = 1.675698627750000e+11
%28
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-06_16-19-06'
info(end).name        = 'TT1_1';
info(end).base_start  = 12855*10^6;
info(end).base_end    = 13140*10^6;
info(end).injection_start = 13150*10^6; 
info(end).seizure_onset  = 13480*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-06_16-19-06'
info(end).sta_channel = [11];
info(end).sta_cut     = 1;
info(end).ictalspike     = -195;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 9;
info(end).cre = 'SOM';
info(end).stable_until =134784745*(10^2)
%29

info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-06_16-19-06'
info(end).name        = 'TT3_1';
info(end).base_start  = 12855*10^6;
info(end).base_end    = 13140*10^6;
info(end).injection_start = 13150*10^6; 
info(end).seizure_onset  = 13480*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-06_16-19-06'
info(end).sta_channel = [9];
info(end).sta_cut     = 1;
info(end).ictalspike     = -195;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 9;
info(end).stable_until =1.350651165000000e+10
%30

info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-06_16-19-06'
info(end).name        = 'TT3_2';
info(end).base_start  = 12855*10^6;
info(end).base_end    = 13140*10^6;
info(end).injection_start = 13150*10^6; 
info(end).seizure_onset  = 13480*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-06_16-19-06'
info(end).sta_channel = [8];
info(end).sta_cut     = 1;
info(end).ictalspike     = -195;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 9;
info(end).stable_until = 134976356*(10^2)

%31
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-06_16-19-06'
info(end).name        = 'TT3_3';
info(end).base_start  = 12855*10^6;
info(end).base_end    = 13140*10^6;
info(end).injection_start = 13150*10^6; 
info(end).seizure_onset  = 13480*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-06_16-19-06'
info(end).sta_channel = [2];
info(end).sta_cut     = 1;
info(end).ictalspike     = -195;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 9;
info(end).cre = 'SOM';
info(end).stable_until =1.347698722500000e+10
%32
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-07_13-29-08'
info(end).name        = 'TT1_1';
info(end).base_start  = 9460*10^6;
info(end).base_end    = 9750*10^6;
info(end).injection_start = 9780*10^6
info(end).seizure_onset  = 9960*10^6
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-07_13-29-08'
info(end).sta_channel = [7];
info(end).sta_cut     = 1;
info(end).ictalspike     = -73;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -4;
info(end).stable_until =9.965725402000000e+09
%33
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-07_16-43-50'
info(end).name        = 'TT2_1';
info(end).base_start  = 21402*10^6;
info(end).base_end    = 21840*10^6;
info(end).injection_start = 21880*10^6;
info(end).seizure_onset  = 22302*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-07_16-43-50'
info(end).sta_channel = [11];
info(end).ictalspike     = -270;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 123;
info(end).stable_until =2.232083665200000e+10

%34

info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-07_16-43-50'
info(end).name        = 'TT2_2';
info(end).base_start  = 21402*10^6;
info(end).base_end    = 21840*10^6;
info(end).injection_start = 21880*10^6;
info(end).seizure_onset  = 22302*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-07_16-43-50'
info(end).sta_channel = [2];
info(end).ictalspike     = -270;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 0;
info(end).seizure_autodetect_absolute     = 123;
info(end).cre = 'SOM';
info(end).stable_until = NaN

%35
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-07_16-43-50'
info(end).name        = 'TT3_1';
info(end).base_start  = 21402*10^6;
info(end).base_end    = 21840*10^6;
info(end).injection_start = 21880*10^6;
info(end).seizure_onset  = 22302*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-07_16-43-50'
info(end).sta_channel = [7];
info(end).ictalspike     = -270;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 123;
info(end).stable_until =2.241889285200000e+10
%36
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-08_17-36-13'
info(end).name        = 'TT1_1';
info(end).base_start  = 10196*10^6;
info(end).base_end    = 10580*10^6;
info(end).injection_start = 10590*10^6;
info(end).seizure_onset  = 10800*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-08_17-36-13'
info(end).sta_channel = [5];
info(end).ictalspike     = -76;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 34;
info(end).stable_until =1.078895582700000e+10

%37
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-08_17-36-13'
info(end).name        = 'TT2_1';
info(end).base_start  = 10196*10^6;
info(end).base_end    = 10580*10^6;
info(end).injection_start = 10590*10^6;
info(end).seizure_onset  = 10800*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-08_17-36-13'
info(end).sta_channel = [12];
info(end).sta_cut     = 1;
info(end).ictalspike     = -76;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 34;
info(end).cre = 'SOM';
info(end).stable_until =NaN
%38

info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-08_17-36-13'
info(end).name        = 'TT2_2';
info(end).base_start  = 10196*10^6;
info(end).base_end    = 10580*10^6;
info(end).injection_start = 10590*10^6;
info(end).seizure_onset  = 10800*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-08_17-36-13'
info(end).sta_channel = [3];
info(end).ictalspike     = -76;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 34;
info(end).stable_until = 1.076473340200000e+10

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%39
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2015-01-08_17-36-13'
info(end).name        = 'TT3_1';
info(end).base_start  = 10196*10^6;
info(end).base_end    = 10580*10^6;
info(end).injection_start = 10590*10^6;
info(end).seizure_onset  = 10800*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2015-01-08_17-36-13'
info(end).sta_channel = [6];
info(end).sta_cut     = 1;
info(end).ictalspike     = -76;
%info(end).ictalspike     %= %??;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 34;
info(end).stable_until = NaN



%40
% we checked this cell, it is very weakly driven, but this is probably
% contamination from another cluster on the same electrode that contains
% very strongly driven SOM cells
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-05-17_12-59-09som'
info(end).name        = 'TT1_1';
info(end).base_start  = 95802*10^6;
info(end).base_end    = 96300*10^6;
info(end).injection_start = 96314*10^6;
info(end).seizure_onset  = 96465*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-05-17_12-59-09'
info(end).sta_channel = [8];
info(end).sta_cut     = 1;
info(end).ictalspike     = -16;
info(end).seizure_autodetect     = +20;
info(end).seizure_autodetect_absolute     = -21;
info(end).cre = 'SOM';
info(end).stable_until = NaN

%41
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-05-17_12-59-09som'
info(end).name        = 'TT1_2';
info(end).base_start  = 95802*10^6;
info(end).base_end    = 96300*10^6;
info(end).injection_start = 96314*10^6;
info(end).seizure_onset  = 96465*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-05-17_12-59-09'
info(end).sta_channel = [6];
info(end).sta_cut     = 1;
info(end).ictalspike     = -16;
info(end).seizure_autodetect     = +20;
info(end).seizure_autodetect_absolute     = -21;
info(end).stable_until =9.649658612500000e+10
%42
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-05-17_12-59-09som'
info(end).name        = 'TT1_3';
info(end).base_start  = 95802*10^6;
info(end).base_end    = 96300*10^6;
info(end).injection_start = 96314*10^6;
info(end).seizure_onset  = 96465*10^6;
info(end).neuron_type    = 'SOM';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2013-05-17_12-59-09'
info(end).sta_channel = [10];
info(end).sta_cut     = 1;
info(end).ictalspike     = -16;
info(end).seizure_autodetect     = +20;
info(end).seizure_autodetect_absolute     = -21;
info(end).stable_until = 964762980*(10^2)
%43
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-07-12_13-56-57'
info(end).name        = 'TT1_1';
info(end).base_start  = 249972*10^6;
info(end).base_end    = 250400*10^6;
info(end).injection_start = 250443*10^6; 
info(end).seizure_onset  = 250634*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-07-12_13-56-57'
info(end).sta_channel = [8];
info(end).ictalspike     = -16;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 95;
info(end).stable_until = 2.509507259020000e+11

%44
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-07-12_13-56-57'
info(end).name        = 'TT1_2';
info(end).base_start  = 249972*10^6;
info(end).base_end    = 250400*10^6;
info(end).injection_start = 250443*10^6; 
info(end).seizure_onset  = 250634*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-07-12_13-56-57'
info(end).sta_channel = [8];
info(end).ictalspike     = -16;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 95;
info(end).stable_until = 2.509419486770000e+11

%45
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-07-12_13-56-57'
info(end).name        = 'TT3_1';
info(end).base_start  = 249972*10^6;
info(end).base_end    = 250400*10^6;
info(end).injection_start = 250443*10^6; 
info(end).seizure_onset  = 250634*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-07-12_13-56-57'
info(end).sta_channel = [8];
info(end).ictalspike     = -16;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 95;
info(end).stable_until =2.509645651770000e+11

%46
info(end+1).directory = 'E:\SRT2014\chr2_ptz\2014-07-12_13-56-57'
info(end).name        = 'TT3_2';
info(end).base_start  = 249972*10^6;
info(end).base_end    = 250400*10^6;
info(end).injection_start = 250443*10^6; 
info(end).seizure_onset  = 250634*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-07-12_13-56-57'
info(end).sta_channel = [7];
info(end).ictalspike     = -16;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 95;
info(end).stable_until = NaN


%47
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2014-09-19_18-47-34_RS'
info(end).name        = 'TT1_1';
info(end).base_start  = 19839*10^6; 
info(end).base_end    = 20060*10^6;
info(end).injection_start = 20160*10^6;
info(end).seizure_onset  = 20760*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-09-19_18-47-34'
info(end).sta_channel = [7];
info(end).ictalspike     = -9.5;
info(end).seizure_autodetect     = +20;
info(end).seizure_autodetect_absolute     = -16;
info(end).stable_until = NaN

%%%%%%%%%%%%%%%%%%%%%%%
%48
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2014-09-19_18-47-34_RS'
info(end).name        = 'TT1_2';
info(end).base_start  = 19839*10^6; 
info(end).base_end    = 20060*10^6;
info(end).injection_start = 20160*10^6;
info(end).seizure_onset  = 20760*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-09-19_18-47-34'
info(end).sta_channel = [3];
info(end).sta_cut = 1;%
info(end).ictalspike     = -9.5;
%info(end).ictalspike %= %????;
info(end).seizure_autodetect     = +20;
info(end).seizure_autodetect_absolute     = -16;
info(end).stable_until = 208803193*(10^2)


%49
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2014-09-19_18-47-34_RS'
info(end).name        = 'TT3_1';
info(end).base_start  = 19839*10^6; 
info(end).base_end    = 20060*10^6;
info(end).injection_start = 20160*10^6;
info(end).seizure_onset  = 20760*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-09-19_18-47-34'
info(end).sta_channel = [1];
%info(end).ictalspike     = 45;
info(end).ictalspike     = -9.5;
info(end).seizure_autodetect     = +20;
info(end).seizure_autodetect_absolute     = -16;
info(end).stable_until = 2.089872745000000e+10

%50
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2014-03-11_18-38-22emx'
info(end).name        = 'TT1_1';
info(end).base_start  = 16099635*10^6;
info(end).base_end    = 16099910*10^6;
info(end).injection_start = 16099930*10^6; 
info(end).seizure_onset  = 16100185*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-03-11_18-38-22'
info(end).exclude_sta        =1;
info(end).ictalspike     = 73;
info(end).seizure_autodetect = 0;
info(end).seizure_autodetect_absolute = 134;
info(end).RS_type = 'non-fs';
info(end).sta_channel = 5;
info(end).stable_until = 1.610039643259900e+13

%51
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2014-03-11_18-38-22emx'
info(end).name        = 'TT2_1';
info(end).base_start  = 16099635*10^6;
info(end).base_end    = 16099910*10^6;
info(end).injection_start = 16099930*10^6; 
info(end).seizure_onset  = 16100185*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-03-11_18-38-22'
info(end).exclude_sta        =1;
info(end).ictalspike     = 73;
info(end).seizure_autodetect = 0;
info(end).seizure_autodetect_absolute = 134;
info(end).RS_type = 'non-fs';
info(end).sta_channel = 1;
info(end).stable_until = 1.610034059722400e+13

%52
info(end+1).directory = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2014-03-11_18-38-22emx'
info(end).name        = 'TT2_2';
info(end).base_start  = 16099635*10^6;
info(end).base_end    = 16099910*10^6;
info(end).injection_start = 16099930*10^6; 
info(end).seizure_onset  = 16100185*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1;
info(end).directory_brain = 'U:\2014-03-11_18-38-22'
info(end).exclude_sta        =1;
info(end).ictalspike     = 73;
info(end).seizure_autodetect = 0;
info(end).seizure_autodetect_absolute = 134;
info(end).RS_type = 'non-fs';
info(end).sta_channel = 1;
info(end).stable_until = 1.610040163117400e+13

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RC curves

%53
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-06-10_15-31-05';
info(end).name              = 'TT3_2';
info(end).base_start_pulse  = 7;
info(end).base_end_pulse    = 205;
info(end).injection_start_pulse   = 700; 
info(end).seizure_onset_pulse     = 1523;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 7;
info(end).light_levels      = [6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-06-10_15-31-05'
info(end).sta_channel = [8];
info(end).sta_cut     = 1;
info(end).ictalspike     = -11;
info(end).seizure_autodetect     = -10;
info(end).seizure_autodetect_absolute     = -10;
info(end).cre = 'SOM'
info(end).stable_until = 6.935745042000000e+11


% 54
info(end+1).directory           = 'E:\SRT2014\chr2_ptz\2014-06-30_18-53-48';
info(end).name                  = 'TT2_1';
info(end).base_start_pulse      = 64;
info(end).base_end_pulse        = 250;
info(end).injection_start_pulse = 822; 
info(end).seizure_onset_pulse   = 1322;
info(end).neuron_type           = 'SOM';
info(end).has_rc                = 1;
info(end).nlevels               = 8;
info(end).light_levels          = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc            = 0;
info(end).exclude_rc_numlevels  = 0;
info(end).directory_brain       = 'U:\2014-06-30_18-53-48'
info(end).sta_channel           = [3];
info(end).ictalspike            = -50;
info(end).seizure_autodetect     = +30;
info(end).seizure_autodetect_absolute     = -56;
info(end).cre = 'SOM'
info(end).stable_until = NaN


% 55
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-06-26_18-42-47';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 384;
info(end).base_end_pulse    = 795;
info(end).injection_start_pulse   = 800; 
info(end).seizure_onset_pulse     = 1211;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\2014-06-26_18-42-47'
info(end).sta_channel = [4];
info(end).ictalspike     = -75;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 77;
info(end).cre = 'SOM'
info(end).stable_until = NaN

% 56
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-06-28_14-22-16';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 164;
info(end).injection_start_pulse   = 816; 
info(end).seizure_onset_pulse     = 1488;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-06-28_14-22-16'
info(end).sta_channel = [12];
info(end).sta_cut     = 1;
info(end).ictalspike     = -156;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -2;
info(end).cre = 'SOM'
info(end).stable_until =2.244136387025000e+12

% 57
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-06-28_19-53-03';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 272;
info(end).base_end_pulse    = 436;
info(end).injection_start_pulse   = 800; 
info(end).seizure_onset_pulse     = 1148;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).directory_brain = 'U:\2014-06-28_19-53-03'
info(end).sta_channel = [3];
info(end).ictalspike     = -64;
info(end).seizure_autodetect     = -25;
info(end).seizure_autodetect_absolute     = 25;
info(end).cre = 'SOM'
info(end).stable_until =2.264005423000000e+12

% 58
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-13_18-34-04';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 215;
info(end).base_end_pulse    = 391;
info(end).injection_start_pulse   = 415; 
info(end).seizure_onset_pulse     = 965;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).directory_brain = 'U:\2014-11-13_18-34-04'
info(end).sta_channel = [12];
info(end).sta_cut     = 1;
info(end).ictalspike     = -226;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -59;
info(end).stable_until =NaN

% 59
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-18_13-01-39';
info(end).name              = 'TT3_4';
info(end).base_start_pulse  = 133;
info(end).base_end_pulse    = 453;
info(end).injection_start_pulse   = 503; 
info(end).seizure_onset_pulse     = 907;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =2;
info(end).directory_brain = 'U:\2014-11-18_13-01-39'
info(end).sta_channel = [6];
info(end).ictalspike     = -30;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 34;
info(end).cre = 'SOM'
info(end).stable_until =NaN

% 60
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-18_16-43-30';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 50;
info(end).base_end_pulse    = 175;
info(end).injection_start_pulse   = 560; 
info(end).seizure_onset_pulse     = 864;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      =[4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-11-18_16-43-30'
info(end).sta_channel = [10];
info(end).ictalspike     = -113;
info(end).seizure_autodetect     = +25;
info(end).seizure_autodetect_absolute     = -71;
info(end).stable_until =2.371857245200000e+10
% % 61
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-09-09_17-03-05';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 301;
info(end).injection_start_pulse   = 1893; 
info(end).seizure_onset_pulse     = 2164;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 12; 
info(end).light_levels      = [3.96644, 4.94407, 5.26085, 7.73848, 9.53289, 10.9273, 11.9628, 12.9933, 16.2714, 18.2013, 22.6, 25.2];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-09-09_17-03-05'
info(end).sta_channel = [4];
info(end).sta_cut     = 1;
info(end).ictalspike     = -32;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 91;
info(end).stable_until =1.553377982700000e+10

%  62

info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-09-13_16-59-53';
info(end).name              = 'TT2_2';
info(end).base_start_pulse  = 60;
info(end).base_end_pulse    = 885;
info(end).injection_start_pulse   = 1200; 
info(end).seizure_onset_pulse     = 1511;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 12;
info(end).light_levels      = [3.96644, 4.94407, 5.26085, 7.73848, 9.53289, 10.9273, 11.9628, 12.9933, 16.2714, 18.2013, 22.6, 25.2];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-09-13_16-59-53'
info(end).sta_channel = [10];
info(end).sta_cut     = 1;
info(end).ictalspike     = -39;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -17;
info(end).cre = 'SOM'
info(end).stable_until = 1.745096782500000e+10

% 63
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-09-15_19-35-46';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 48;
info(end).base_end_pulse    = 297;
info(end).injection_start_pulse   = 600; 
info(end).seizure_onset_pulse     = 948;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 12;
info(end).light_levels      = [3.96644, 4.94407, 5.26085, 7.73848, 9.53289, 10.9273, 11.9628, 12.9933, 16.2714, 18.2013, 22.6, 25.2];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-09-15_19-35-46'
info(end).sta_channel = [10];
info(end).sta_cut     = 1;
info(end).ictalspike     = -26;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 15;
info(end).cre = 'SOM'
info(end).stable_until = NaN

% 64
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-09-15_21-07-41';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 227;
info(end).base_end_pulse    = 443;
info(end).injection_start_pulse   = 787; 
info(end).seizure_onset_pulse     = 991;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 12;
info(end).light_levels      = [3.96644,7.4,8.5, 9.1, 9.53289, 10.9273, 11.5, 12.9933, 16.2714, 18.2013, 23.5 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).remove_rc         = 1;
info(end).directory_brain = 'U:\2014-09-15_21-07-41'
info(end).sta_channel = [1];
info(end).sta_cut     = 1;
info(end).ictalspike     = -32;
info(end).seizure_autodetect     = +10;
info(end).seizure_autodetect_absolute     = 3;
info(end).stable_until =2.084219015000000e+10


% %%%%%%%%%%%%%%%%%%%%%%%

%65
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-09-15_23-15-49';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 321;
info(end).injection_start_pulse   = 612; 
info(end).seizure_onset_pulse     = 1260;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 12;
info(end).light_levels      = [3.96644,5.2, 7.8,8.9, 9.53289, 10.9273, 12.8, 15.3, 16.27, 17.2, 18.9,25.2];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-09-15_23-15-49'
info(end).sta_channel = [9];
info(end).sta_cut     = 1;
info(end).ictalspike  = -155;
info(end).seizure_autodetect     = +100;
info(end).seizure_autodetect_absolute     = 128;
info(end).stable_until =2.914021602500000e+10


% 66
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-09-16_14-35-51';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 600;
info(end).base_end_pulse    = 1125;
info(end).injection_start_pulse   = 1200; 
info(end).seizure_onset_pulse     = 1692;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 12;
info(end).light_levels      = [3.96644, 4.94407, 5.26085, 7.73848, 9.53289, 10.9273, 11.9628, 12.9933, 16.2714, 18.2013, 22.6, 25.2];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\2014-09-16_14-35-51'
info(end).sta_channel = [11];
info(end).sta_cut     = 1;
info(end).ictalspike     = -68;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -6;
info(end).stable_until =1.585414242500000e+10


% 67
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-09-20_13-03-48';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 100;
info(end).base_end_pulse    = 300;
info(end).injection_start_pulse   = 500; 
info(end).seizure_onset_pulse     = 1080;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [3.96644, 4.1, 4.4, 5.9, 8.155, 10.1, 11.6, 12.9, 13.52 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =2;
info(end).directory_brain = 'U:\2014-09-20_13-03-48'
info(end).sta_channel = [2];
info(end).sta_cut     = 1;
info(end).ictalspike     = -53;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 61;
info(end).stable_until =8.664970835000000e+10


% 68
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-13_14-22-21';
info(end).name              = 'TT2_2';
info(end).base_start_pulse  = 50;
info(end).base_end_pulse    = 280;
info(end).injection_start_pulse   = 300; 
info(end).seizure_onset_pulse     = 640;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-13_14-22-21'
info(end).sta_channel = [12];
info(end).sta_cut     = 1;
info(end).ictalspike     = -123;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -8;
info(end).cre = 'SOM'
info(end).stable_until =1.265184782500000e+10

% 69
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-13_17-15-08';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 240;
info(end).base_end_pulse    = 385;
info(end).injection_start_pulse   = 491; 
info(end).seizure_onset_pulse     = 1122;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-13_17-15-08'
info(end).sta_channel = [2];
info(end).ictalspike     = -137;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -16;
info(end).stable_until = 2.356338415000000e+10

% 70
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-16_16-10-33';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 397;
info(end).base_end_pulse    = 541;
info(end).injection_start_pulse   = 597; 
info(end).seizure_onset_pulse     = 880;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-16_16-10-33'
info(end).sta_channel = [9];
info(end).sta_cut     = 1;
info(end).ictalspike     = -92;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -31;
info(end).stable_until = 224593946*(10^2)

% 71
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-20_15-14-44';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 41;
info(end).base_end_pulse    = 530;
info(end).injection_start_pulse   = 747; 
info(end).seizure_onset_pulse     = 998;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).remove_rc = 1;
info(end).directory_brain = 'U:\2015-01-20_15-14-44'
info(end).sta_channel = [4];
info(end).ictalspike     = -52;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -19;
info(end).stable_until = NaN

% 72
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-20_15-14-44';
info(end).name              = 'TT3_2';
info(end).base_start_pulse  = 41;
info(end).base_end_pulse    = 530;
info(end).injection_start_pulse   = 747; 
info(end).seizure_onset_pulse     = 998;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      =[4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\2015-01-20_15-14-44'
info(end).sta_channel = [2];
info(end).sta_cut     = 1;
info(end).ictalspike     = -52;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -19;
info(end).stable_until = NaN


% 73
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-12_17-12-11';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 163;
info(end).base_end_pulse    = 395;
info(end).injection_start_pulse   = 659; 
info(end).seizure_onset_pulse     = 943;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-11-12_17-12-11'
info(end).sta_channel = [4];
info(end).ictalspike     = -92;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -29;
info(end).stable_until = 2.970474650000000e+09


% 74
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-09-24_16-56-30SOM';
info(end).name              = 'TT2_3';
info(end).base_start_pulse  = 600;
info(end).base_end_pulse    = 1000;
info(end).injection_start_pulse   = 1001; 
info(end).seizure_onset_pulse     = 1380;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.6, 15.8, 16.6, 17.8, 19.5, 22];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-24_16-56-30';
info(end).munumbers       = 7:10;
info(end).sta_channel = [2];
info(end).ictalspike     = 32;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 96;
info(end).stable_until = NaN
% 75
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-09-24_16-56-30SOM';
info(end).name              = 'TT2_2';
info(end).base_start_pulse  = 600;
info(end).base_end_pulse    = 1000;
info(end).injection_start_pulse   = 1001; 
info(end).seizure_onset_pulse     = 1380;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.6, 15.8, 16.6, 17.8, 19.5, 22];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-24_16-56-30'
info(end).munumbers       = 7:10;
info(end).sta_channel = [2];
info(end).ictalspike     = 32;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 96;
info(end).cre = 'SOM'; 
info(end).stable_until = NaN
% 76
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-09-24_16-56-30SOM';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 600;
info(end).base_end_pulse    = 1000;
info(end).injection_start_pulse   = 1001; 
info(end).seizure_onset_pulse     = 1380;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.6, 15.8, 16.6, 17.8, 19.5, 22];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-24_16-56-30'
info(end).munumbers       = 7:10;
info(end).sta_channel = [2];
info(end).ictalspike     = 32;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 96;
info(end).cre = 'SOM';
info(end).stable_until = NaN

% 77
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-09-25_15-46-33';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 1000;
info(end).injection_start_pulse   = 1000; 
info(end).seizure_onset_pulse     = 1512;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.6, 15.8, 16.6, 17.8, 19.5, 22];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-25_15-46-33'
info(end).munumbers = 7:10;
info(end).sta_channel = [2];
info(end).ictalspike     = -58;
info(end).seizure_autodetect     = +10;
info(end).seizure_autodetect_absolute     = -56;
info(end).stable_until = NaN

% 78
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-12-06_17-37-04';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 110;
info(end).base_end_pulse    = 931;
info(end).injection_start_pulse   = 1110; 
info(end).seizure_onset_pulse     = 1571;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.6, 15.8, 16.6, 17.8, 19.5, 22];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-12-06_17-37-04'
info(end).sta_channel = [1];
info(end).ictalspike     = -33;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -26;
info(end).stable_until = NaN
% 79
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-12-06_17-37-04';
info(end).name              = 'TT2_2';
info(end).base_start_pulse  = 110;
info(end).base_end_pulse    = 931;
info(end).injection_start_pulse   = 1110; 
info(end).seizure_onset_pulse     = 1571;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.6, 15.8, 16.6, 17.8, 19.5, 22];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-12-06_17-37-04'
info(end).sta_channel = [4];
info(end).ictalspike     = -33;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -26;
info(end).cre = 'SOM';
info(end).stable_until = NaN
% 80
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-12-06_16-19-45';
info(end).name              = 'TT2_4';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 616;
info(end).injection_start_pulse   = 1000; 
info(end).seizure_onset_pulse     = 1802;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [3.9, 4.8, 5.2, 7.7, 9.5, 10.2, 11.9, 14.8, 16.5, 24];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-12-06_16-19-45'
info(end).sta_channel = [10];
info(end).ictalspike     = -132;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -94;
info(end).stable_until = NaN
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-12-06_16-19-45';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 616;
info(end).injection_start_pulse   = 1000; 
info(end).seizure_onset_pulse     = 1802;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [3.9, 4.8, 5.2, 7.7, 9.5, 10.2, 11.9, 14.8, 16.5, 24];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-12-06_16-19-45'
info(end).sta_channel = [8];
info(end).ictalspike     = -132;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -94;
info(end).cre = 'SOM';
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-12-06_16-19-45';
info(end).name              = 'TT1_2';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 616;
info(end).injection_start_pulse   = 1000; 
info(end).seizure_onset_pulse     = 1802;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [3.9, 4.8, 5.2, 7.7, 9.5, 10.2, 11.9, 14.8, 16.5, 24];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-12-06_16-19-45'
info(end).sta_channel = [6];
info(end).ictalspike     = -132;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -94;
info(end).cre = 'SOM';
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-12-06_16-19-45';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 616;
info(end).injection_start_pulse   = 1000; 
info(end).seizure_onset_pulse     = 1802;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [3.9, 4.8, 5.2, 7.7, 9.5, 10.2, 11.9, 14.8, 16.5, 24];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-12-06_16-19-45'
info(end).sta_channel = [4];
info(end).ictalspike     = -132;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -94;
info(end).cre = 'SOM';
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-12-06_16-19-45';
info(end).name              = 'TT2_2';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 616;
info(end).injection_start_pulse   = 1000; 
info(end).seizure_onset_pulse     = 1802;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [3.9, 4.8, 5.2, 7.7, 9.5, 10.2, 11.9, 14.8, 16.5, 24];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-12-06_16-19-45'
info(end).sta_channel = [3];
info(end).sta_cut     = 1;
info(end).ictalspike     = -132;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -94;
info(end).cre = 'SOM';
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-12-06_16-19-45';
info(end).name              = 'TT2_3';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 616;
info(end).injection_start_pulse   = 1000; 
info(end).seizure_onset_pulse     = 1802;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [3.9, 4.8, 5.2, 7.7, 9.5, 10.2, 11.9, 14.8, 16.5, 24];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-12-06_16-19-45'
info(end).sta_channel = [3];
info(end).ictalspike     = -132;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -94;
info(end).cre = 'SOM';
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-12-06_16-19-45';
info(end).name              = 'TT2_5';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 616;
info(end).injection_start_pulse   = 1000; 
info(end).seizure_onset_pulse     = 1802;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [3.9, 4.8, 5.2, 7.7, 9.5, 10.2, 11.9, 14.8, 16.5, 24];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-12-06_16-19-45'
info(end).sta_channel = [12];
info(end).ictalspike     = -132;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -94;
info(end).cre = 'SOM';














%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-09-10_13-58-47';
info(end).name              = 'TT3_2';
info(end).base_start_pulse  = 83;
info(end).base_end_pulse    = 660;
info(end).injection_start_pulse   = 1083; 
info(end).seizure_onset_pulse     = 1593;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 22];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-10_13-58-47'
info(end).munumbers         = [5 6 11 12];
info(end).sta_channel = [4];
info(end).sta_cut     = 1;
info(end).ictalspike     = -45;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -22;

%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-09-12_21-55-24';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 155;
info(end).base_end_pulse    = 542;
info(end).injection_start_pulse   = 1155; 
info(end).seizure_onset_pulse     = 1818;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-12_21-55-24'
info(end).munumbers = [5 6 11 12];
info(end).exclude_waveform = 1;
info(end).sta_channel = [6];
info(end).ictalspike     = -64;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -23;


%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-09-12_21-55-24';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 155;
info(end).base_end_pulse    = 542;
info(end).injection_start_pulse   = 1155; 
info(end).seizure_onset_pulse     = 1818;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-12_21-55-24'
info(end).munumbers = 7:10;
info(end).sta_channel = [1];
info(end).sta_cut     = 1;
info(end).ictalspike     = -64;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -23;
info(end).cre = 'PV';


%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-09-13_15-50-16';
info(end).name              = 'TT1_2';
info(end).base_start_pulse  = 325;
info(end).base_end_pulse    = 783;
info(end).injection_start_pulse   = 1005; 
info(end).seizure_onset_pulse     = 1689;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =2;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-13_15-50-16'
info(end).munumbers = [1:4];
info(end).sta_channel = [7];
info(end).ictalspike     = -91;
info(end).seizure_autodetect     = +5;
info(end).seizure_autodetect_absolute     = -94;

%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-09-13_15-50-16';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 325;
info(end).base_end_pulse    = 783;
info(end).injection_start_pulse   = 1005; 
info(end).seizure_onset_pulse     = 1689;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-13_15-50-16'
info(end).munumbers = [1:4]; 
info(end).sta_channel = [5];
info(end).ictalspike     = -91;
info(end).seizure_autodetect     = +5;
info(end).seizure_autodetect_absolute     = -94;
info(end).cre = 'PV';
%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-09-13_15-50-16';
info(end).name              = 'TT1_3';
info(end).base_start_pulse  = 325;
info(end).base_end_pulse    = 783;
info(end).injection_start_pulse   = 1005; 
info(end).seizure_onset_pulse     = 1689;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-13_15-50-16'
info(end).munumbers = [1:4]; 
info(end).sta_channel = [5];
info(end).ictalspike     = -91;
info(end).seizure_autodetect     = +5;
info(end).seizure_autodetect_absolute     = -94;
info(end).cre = 'PV';
%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-09-19_23-13-05';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 620;
info(end).base_end_pulse    = 1000;
info(end).injection_start_pulse   = 1087; 
info(end).seizure_onset_pulse     = 1769;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-19_23-13-05'
info(end).munumbers = [5 6 11 12];
info(end).exclude_waveform = 1;
info(end).sta_channel = 1;
info(end).ictalspike     = -77;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute = -14 ;

%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-09-19_23-13-05';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 620;
info(end).base_end_pulse    = 1000;
info(end).injection_start_pulse   = 1087; 
info(end).seizure_onset_pulse     = 1769;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-19_23-13-05'
info(end).munumbers = [7:10]; 
info(end).sta_channel = [3];
info(end).sta_cut     = 1;
info(end).ictalspike     = -77;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute = -14 ;
%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-09-19_23-13-05';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 620;
info(end).base_end_pulse    = 1000;
info(end).injection_start_pulse   = 1087; 
info(end).seizure_onset_pulse     = 1769;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-19_23-13-05'
info(end).munumbers = [1:4]; 
info(end).sta_channel = [5];
info(end).sta_cut     = 1;
info(end).ictalspike     = -77;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute = -14 ;
info(end).cre = 'PV';


%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\oldfilescheckforspontpvdata\2013-09-19_23-13-05';
info(end).name              = 'TT2_2';
info(end).base_start_pulse  = 620;
info(end).base_end_pulse    = 1000;
info(end).injection_start_pulse   = 1087; 
info(end).seizure_onset_pulse     = 1769;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-09-19_23-13-05'
info(end).munumbers = [7:10]; 
info(end).sta_channel = [1];
info(end).sta_cut     = 1;
info(end).ictalspike     = -14;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute = -14 ;
info(end).cre = 'PV';



%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2013-11-24_19-16-48';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 440;
info(end).base_end_pulse    = 1000;
info(end).injection_start_pulse   = 1000; 
info(end).seizure_onset_pulse     = 1432;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).exclude_rc_fr     =0;
info(end).directory_brain = 'U:\2013-11-24_19-16-48'
info(end).sta_channel = [6];
info(end).ictalspike  = 86;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 180;














%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-01-27_18-25-01_Copy';
info(end).name              = 'TT3_rethresh20_1';
info(end).base_start_pulse  = 621;
info(end).base_end_pulse    = 1020;
info(end).injection_start_pulse   = 1041; 
info(end).seizure_onset_pulse     = 1522;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\2014-01-27_18-25-01';
info(end).sta_channel = [5];
info(end).ictalspike     = -76;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -45;


%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-03-14_20-55-27';
info(end).name              = 'TT3_rethresh30_1';
info(end).base_start_pulse  = 618;
info(end).base_end_pulse    = 1187;
info(end).injection_start_pulse   = 1267; 
info(end).seizure_onset_pulse     = 2063;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-03-14_20-55-27'
info(end).sta_channel = [3];
info(end).ictalspike     = -27;
%info(end).seizure_autodetect     = +5;
info(end).seizure_autodetect_absolute     = -27;



% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-05-02_20-17-52';
info(end).name              = 'TT3_rethresh30_1';
info(end).base_start_pulse  = 500;
info(end).base_end_pulse    = 1084;
info(end).injection_start_pulse   = 2500; 
info(end).seizure_onset_pulse     = 3382;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        = 1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-05-02_20-17-52'
info(end).sta_channel = [8];
info(end).ictalspike     = -20;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -4;
info(end).cre = 'PV';


% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-05-02_20-17-52';
info(end).name              = 'TT3_rethresh30_2';
info(end).base_start_pulse  = 500;
info(end).base_end_pulse    = 1084;
info(end).injection_start_pulse   =2500 ; 
info(end).seizure_onset_pulse     =3382;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-05-02_20-17-52'
info(end).sta_channel = [5];
info(end).ictalspike     = -20;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -4;
%


info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-07-10_17-32-53';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 256;
info(end).injection_start_pulse   = 400; 
info(end).seizure_onset_pulse     = 663;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 21.8 24]; % take the last 2 points out
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =2;
info(end).directory_brain = 'U:\2014-07-10_17-32-53'
info(end).sta_channel = [9];
info(end).ictalspike     = -35;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -27;


%103
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-07-28_18-53-46';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 799;
info(end).injection_start_pulse   = 800; 
info(end).seizure_onset_pulse     = 1160;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        = 1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-07-28_18-53-46'
info(end).sta_channel = [4];
info(end).sta_cut     = 1;
info(end).ictalspike     = -35;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 22;
info(end).stable_until =1.375960695200000e+08


%104

info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-07-28_18-53-46';
info(end).name              = 'TT3_2';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 799;
info(end).injection_start_pulse   = 800; 
info(end).seizure_onset_pulse     = 1160;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-07-28_18-53-46'
info(end).sta_channel = [4];
info(end).sta_cut     = 1;
info(end).ictalspike     = -35;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 22;
info(end).cre = 'PV';
info(end).stable_until =NaN
%105
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-07-28_18-53-46';
info(end).name              = 'TT3_3';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 799;
info(end).injection_start_pulse   = 800; 
info(end).seizure_onset_pulse     = 1160;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-07-28_18-53-46'
info(end).sta_channel = [4];
info(end).sta_cut     = 1;
info(end).ictalspike     = -35;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 22;
info(end).stable_until =1.385444052700000e+08
%106

info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-07-29_17-57-51';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 799;
info(end).injection_start_pulse   = 800; 
info(end).seizure_onset_pulse     = 1352;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-07-29_17-57-51'
info(end).sta_channel = [11];
info(end).sta_cut     = 1;
info(end).ictalspike     = -105;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 2;
info(end).stable_until = 9.695334214770149e+10;

%107

info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-07-30_19-21-30';
info(end).name              = 'TT3_2';
info(end).base_start_pulse  = 800;
info(end).base_end_pulse    = 959;
info(end).injection_start_pulse   = 976; 
info(end).seizure_onset_pulse     = 1408; 
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-07-30_19-21-30'
info(end).sta_channel = [6];
info(end).ictalspike     = -75;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -73;
info(end).stable_until =4.001226475000000e+07
%108

info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-10-03_16-50-15';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 70;
info(end).base_end_pulse    = 268;
info(end).injection_start_pulse   = 1080; 
info(end).seizure_onset_pulse     = 1683;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-10-03_16-50-15';
info(end).sta_channel = [10];
info(end).sta_cut     = 1;
info(end).ictalspike     = -180;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -13;
info(end).stable_until = 5.080142388000000e+07
%

% info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-05_18-26-00';
% info(end).name              = 'TT2_1';
% info(end).base_start_pulse  = 60;
% info(end).base_end_pulse    = 270;
% info(end).injection_start_pulse   = 960; 
% info(end).seizure_onset_pulse     = 1290;
% info(end).neuron_type       = 'PV';
% info(end).has_rc            = 1;
% info(end).nlevels           = 10;
% info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
% info(end).exclude_rc        =0;
% info(end).exclude_rc_numlevels    =1;
% info(end).directory_brain = 'U:\2014-11-05_18-26-00'
% info(end).sta_channel = [3];
% info(end).sta_cut     = 1;
% info(end).ictalspike     = -37;

%% remove this later on
%109
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-05_18-26-00';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 60;
info(end).base_end_pulse    = 270;
info(end).injection_start_pulse   = 960; 
info(end).seizure_onset_pulse     = 1290;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\2014-11-05_18-26-00'
info(end).sta_channel = [3];
info(end).sta_cut     = 1;
info(end).ictalspike     = -37;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -6;
info(end).stable_until = 2.872198205000000e+08

%%110

info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-06_13-37-29';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 210;
info(end).base_end_pulse    = 415;
info(end).injection_start_pulse   = 630; 
info(end).seizure_onset_pulse     = 995;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\2014-11-06_13-37-29'
info(end).sta_channel = [10];
info(end).sta_cut     = 1;
info(end).ictalspike     = -18;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 122;
info(end).stable_until =NaN
%111


info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-07_16-55-50';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 238;
info(end).base_end_pulse    = 407;
info(end).injection_start_pulse   = 678; 
info(end).seizure_onset_pulse     = 1069;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8,16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\2014-11-07_16-55-50'
info(end).sta_channel = [4];
info(end).sta_cut     = 1;
info(end).ictalspike     = -53;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 20;
info(end).stable_until =NaN

%112
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-10_13-27-13';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 446;
info(end).base_end_pulse    = 620;
info(end).injection_start_pulse   = 673; 
info(end).seizure_onset_pulse     = 1733;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 18.9, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =2;
info(end).directory_brain = 'U:\2014-11-10_13-27-13'
info(end).sta_channel = [9];
info(end).sta_cut     = 1;
info(end).ictalspike     = -180;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 69;
info(end).stable_until =9.467645051000001e+07



%113
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-10_19-52-46';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 280;
info(end).base_end_pulse    = 439;
info(end).injection_start_pulse   = 460; 
info(end).seizure_onset_pulse     = 710;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.6, 16.6, 17.8, 18.9, 21.8, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\2014-11-10_19-52-46'
info(end).sta_channel = [5];
info(end).ictalspike     = -65;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 5;
info(end).stable_until =NaN

%114


info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-01-27_15-06-31';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 256;
info(end).base_end_pulse    = 897;
info(end).injection_start_pulse   = 1329; 
info(end).seizure_onset_pulse     = 2430;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-01-27_15-06-31'
info(end).sta_channel = [5];
info(end).ictalspike     = -74;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 153;
info(end).stable_until =NaN

%115

info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-01-27_15-06-31';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 256;
info(end).base_end_pulse    = 897;
info(end).injection_start_pulse   = 1329; 
info(end).seizure_onset_pulse     = 2430;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-01-27_15-06-31'
info(end).sta_channel = [2];
info(end).ictalspike     = -74;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 153;
info(end).cre = 'PV';
info(end).stable_until =NaN
%116


info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-01_16-31-05';
info(end).name              = 'TT2_2';
info(end).base_start_pulse  = 110;
info(end).base_end_pulse    = 510;
info(end).injection_start_pulse   = 530; 
info(end).seizure_onset_pulse     = 946;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-01_16-31-05'
info(end).sta_channel = [10];
info(end).sta_cut     = 1;
info(end).ictalspike     = -94;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -58;
info(end).stable_until =9.606793075000000e+07

% %
% info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-13_20-20-56';
% info(end).name              = '';
% info(end).base_start_pulse  = ;
% info(end).base_end_pulse    = ;
% info(end).injection_start_pulse   = ; 
% info(end).seizure_onset_pulse     = ;
% info(end).neuron_type       = 'PV';
% info(end).has_rc            = 1;
% info(end).nlevels           = 10;
% % info(end).light_levels      = 


%117
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-14_17-16-11';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 57;
info(end).base_end_pulse    = 457;
info(end).injection_start_pulse   = 457; 
info(end).seizure_onset_pulse     = 1360;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\2015-01-14_17-16-11'
info(end).sta_channel = [11];
info(end).sta_cut     = 1;
info(end).ictalspike     = -384;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -203;
info(end).stable_until =NaN
%118
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-14_17-16-11';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 57;
info(end).base_end_pulse    = 457;
info(end).injection_start_pulse   = 457; 
info(end).seizure_onset_pulse     = 1360;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-14_17-16-11'
info(end).sta_channel = [2];
info(end).ictalspike     = -384;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -203;
info(end).cre = 'PV';
info(end).stable_until =NaN

%119

info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-14_17-16-11';
info(end).name              = 'TT2_2';
info(end).base_start_pulse  = 57;
info(end).base_end_pulse    = 457;
info(end).injection_start_pulse   = 457; 
info(end).seizure_onset_pulse     = 1360;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-14_17-16-11'
info(end).sta_channel = [1];
info(end).sta_cut     = 1;
info(end).ictalspike     = -384;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -203;
info(end).stable_until =1.526105610200000e+08

%120
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-14_17-16-11';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 57;
info(end).base_end_pulse    = 457;
info(end).injection_start_pulse   = 457; 
info(end).seizure_onset_pulse     = 1360;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-14_17-16-11'
info(end).sta_channel = [6];
info(end).sta_cut     = 1;
info(end).ictalspike     = -508;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -203;
info(end).stable_until = 1.528258407700000e+08


%121
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-15_13-47-37';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 386;
info(end).base_end_pulse    = 606;
info(end).injection_start_pulse   = 626; 
info(end).seizure_onset_pulse     = 959;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-15_13-47-37'
info(end).sta_channel = [1];
info(end).ictalspike     = -55;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -13;
info(end).stable_until =150732354

%122

info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-15_13-47-37';
info(end).name              = 'TT3_2';
info(end).base_start_pulse  = 386;
info(end).base_end_pulse    = 606;
info(end).injection_start_pulse   = 626; 
info(end).seizure_onset_pulse     = 959;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-15_13-47-37'
info(end).sta_channel = [1];
info(end).sta_cut     = 1;
info(end).ictalspike     = -55;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -13;
info(end).cre = 'PV';
info(end).stable_until =NaN
%123
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-15_17-16-49';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 438;
info(end).base_end_pulse    = 649;
info(end).injection_start_pulse   = 668; 
info(end).seizure_onset_pulse     = 1031;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\2015-01-15_17-16-49'
info(end).sta_channel = [12];
info(end).sta_cut     = 1;
info(end).ictalspike     = -135;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 71;
info(end).stable_until =2.667013482500000e+08

%124
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-15_17-16-49';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 438;
info(end).base_end_pulse    = 649;
info(end).injection_start_pulse   = 668; 
info(end).seizure_onset_pulse     = 1031;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-15_17-16-49'
info(end).sta_channel = [5];
info(end).ictalspike     = -135;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 71;
info(end).cre = 'PV';
info(end).stable_until = NaN

%125


info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-15_17-16-49';
info(end).name              = 'TT3_2';
info(end).base_start_pulse  = 438;
info(end).base_end_pulse    = 649;
info(end).injection_start_pulse   = 668; 
info(end).seizure_onset_pulse     = 1031;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-15_17-16-49'
info(end).sta_channel = [5];
info(end).sta_cut     = 1;
info(end).ictalspike     = -135;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 71;
info(end).cre = 'PV';
info(end).stable_until = NaN
%126
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-16_13-43-42';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 750;
info(end).base_end_pulse    = 1071;
info(end).injection_start_pulse   = 1070; 
info(end).seizure_onset_pulse     = 1267;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-16_13-43-42'
info(end).sta_channel = [5];
info(end).sta_cut     = 1;
info(end).ictalspike     = -55;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 22;
info(end).stable_until = 1.379341885000000e+08



%127
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-11_15-13-25';
info(end).name              = 'TT2_1';
info(end).base_start  = 16240*10^6;
info(end).base_end    = 16550*10^6;
info(end).injection_start   = 16563*10^6; 
info(end).seizure_onset     = 17028*10^6;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-11_15-13-25'
info(end).sta_channel = [2];
info(end).ictalspike     = -89;
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 8;
info(end).cre = 'PV';
info(end).stable_until =1.719216942700000e+10

%128
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-11_15-13-25';
info(end).name              = 'TT4_1';
info(end).base_start  = 16240*10^6;
info(end).base_end    = 16550*10^6;
info(end).injection_start   = 16563*10^6; 
info(end).seizure_onset     = 17028*10^6;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-11_15-13-25'
info(end).sta_channel = [2];
info(end).ictalspike     = -89;

%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 8;
info(end).stable_until = 1.698106767700000e+10


%129
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-11_15-13-25';
info(end).name              = 'TT4_2';
info(end).sta_channel = [2];
info(end).base_start  = 16240*10^6;
info(end).base_end    = 16550*10^6;
info(end).injection_start   = 16563*10^6; 
info(end).seizure_onset     = 17028*10^6;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-11_15-13-25'
info(end).ictalspike     = -89;
info(end).cre = 'PV';
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 8;
info(end).stable_until = NaN

%130
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-11_15-13-25';
info(end).name              = 'TT4_3';
info(end).base_start  = 16240*10^6;
info(end).base_end    = 16550*10^6;
info(end).injection_start   = 16563*10^6; 
info(end).seizure_onset     = 17028*10^6;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-11_15-13-25'
info(end).sta_channel = [2];
info(end).ictalspike     = -89;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 8;
info(end).cre = 'PV';
info(end).stable_until = NaN
%131

info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-12_14-21-04';
info(end).name              = 'TT2_1';
info(end).base_start  = 13868*10^6;
info(end).base_end    = 14400*10^6;
info(end).injection_start   = 14420*10^6; 
info(end).seizure_onset     = 14792*10^6;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-12_14-21-04'
info(end).sta_channel = [2];
info(end).ictalspike     = -273;
%info(end).sta_channel = [2];
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -150;
info(end).cre = 'PV';
info(end).stable_until = 1.462875927800000e+10

%132
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-12_14-21-04';
info(end).name              = 'TT4_1';
info(end).base_start  = 13868*10^6;
info(end).base_end    = 14400*10^6;
info(end).injection_start   = 14420*10^6; 
info(end).seizure_onset     = 14792*10^6;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-12_14-21-04'
info(end).sta_channel = [2];
info(end).ictalspike     = -273;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -150;
info(end).cre = 'PV';
info(end).stable_until = 1.453789915300000e+10

%133
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-12_14-21-04';
info(end).name              = 'TT4_2';
info(end).base_start  = 13868*10^6;
info(end).base_end    = 14400*10^6;
info(end).injection_start   = 14420*10^6; 
info(end).seizure_onset     = 14792*10^6;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-12_14-21-04'
info(end).sta_channel = [2];
info(end).ictalspike     = -273;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -150;
info(end).cre = 'PV';
info(end).stable_until = NaN

%134
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-13_14-36-11';
info(end).name              = 'TT1_1';
info(end).base_start  = 10645*10^6;
info(end).base_end    = 11000*10^6;
info(end).injection_start   = 11015*10^6; 
info(end).seizure_onset     = 11400*10^6;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-13_14-36-11'
info(end).sta_channel = [8];
info(end).ictalspike     = -150;
info(end).seizure_autodetect     = +150;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -197;
info(end).cre = 'PV';
info(end).stable_until =1.142087227500000e+10
%135
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-13_14-36-11';
info(end).name              = 'TT4_1';
info(end).base_start  = 10645*10^6;
info(end).base_end    = 11000*10^6;
info(end).injection_start   = 11015*10^6; 
info(end).seizure_onset     = 11400*10^6;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-13_14-36-11'
info(end).sta_channel = [8];
info(end).ictalspike     = -150;
info(end).seizure_autodetect     = +150;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -197;
info(end).cre = 'PV';
info(end).stable_until =1.139538682500000e+10
%136
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-16_15-06-44';
info(end).name              = 'TT1_1';
info(end).base_start  = 12400*10^6;
info(end).base_end    = 12900*10^6;
info(end).injection_start   = 12915*10^6; 
info(end).seizure_onset     = 13170*10^6;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-16_15-06-44'
info(end).sta_channel = [8];
info(end).ictalspike     = -131;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -144;
info(end).stable_until = 1.309849656400000e+10

%137
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-18_16-24-01';
info(end).name              = 'TT3_1';
info(end).base_start  = 101600*10^6;
info(end).base_end    = 102200*10^6;
info(end).injection_start   = 102230*10^6; 
info(end).seizure_onset    = 102826*10^6;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-18_16-24-01'
info(end).sta_channel = [3];
info(end).ictalspike     = -402;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -248;
info(end).stable_until = NaN


%138
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-18_16-24-01';
info(end).name              = 'TT2_1';
info(end).base_start = 101600*10^6;
info(end).base_end    = 102200*10^6;
info(end).injection_start   = 102230*10^6; 
info(end).seizure_onset     = 102826*10^6;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-18_16-24-01'
info(end).sta_channel = [3];
info(end).ictalspike     = -402;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -248;
info(end).cre = 'PV';
info(end).stable_until = 1.025497256000000e+11

%139
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-18_16-24-01';
info(end).name              = 'TT1_1';
info(end).base_start        = 101600*10^6;
info(end).base_end          = 102200*10^6;
info(end).injection_start   = 102230*10^6; 
info(end).seizure_onset     = 102826*10^6;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-18_16-24-01'
info(end).sta_channel = [3];
info(end).ictalspike     = -402;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -248;
info(end).cre = 'PV';
info(end).stable_until = 1.027784222250000e+11
























%140
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-07_18-10-32'
info(end).name        = 'TT1_1';
info(end).base_start  = 20100*10^6;
info(end).base_end    = 20400*10^6;
info(end).injection_start =  20455*10^6;
info(end).seizure_onset  = 21129*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-10-07_18-10-32'
info(end).sta_channel = [6];
%info(end).sta_cut     = 1;
info(end).ictalspike     = -8;
info(end).seizure_autodetect_absolute     = 0;
info(end).stable_until = NaN

%141
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-09_17-28-10'
info(end).name        = 'TT1_1';
info(end).base_start  = 11000*10^6;
info(end).base_end    = 11350*10^6;
info(end).injection_start =  11400*10^6;
info(end).seizure_onset  = 12220*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-10-09_17-28-10'
info(end).sta_channel = [9];
%info(end).sta_cut     = 1;
info(end).ictalspike     = -9;
info(end).seizure_autodetect_absolute     = 45;
info(end).cre = 'PV';
info(end).stable_until = 120166231*(10^2)

%142
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-09_17-28-10'
info(end).name        = 'TT2_1';
info(end).base_start  = 11000*10^6;
info(end).base_end    = 11350*10^6;
info(end).injection_start =  11400*10^6;
info(end).seizure_onset  = 12220*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-10-09_17-28-10'
info(end).sta_channel = [9];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -215;

info(end).ictalspike     = -9;
info(end).seizure_autodetect_absolute     = 45;
info(end).cre = 'PV';
info(end).stable_until = 1.222137185000000e+10

%143
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-12_17-39-25'
info(end).name        = 'TT2_1';
info(end).base_start  = 25220*10^6;
info(end).base_end    = 25600*10^6;
info(end).injection_start =  25622*10^6;
info(end).seizure_onset  = 26742*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-10-12_17-39-25'
info(end).sta_channel = [9];
%info(end).sta_cut     = 1;
info(end).ictalspike     = -215;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -235;
info(end).stable_until =2.679461685200000e+10



%144
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-13_11-54-53'
info(end).name        = 'TT1_1';
info(end).base_start  = 4400*10^6;
info(end).base_end    = 4890*10^6;
info(end).injection_start =  4900*10^6;
info(end).seizure_onset  = 5642*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-10-13_11-54-53'
info(end).sta_channel = [9];
%info(end).sta_cut     = 1;
%info(end).exclude_sta = 1;
info(end).ictalspike     = 0 ;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 93;
info(end).stable_until = NaN

%145
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-15_14-42-42'
info(end).name        = 'TT2_1';
info(end).base_start  = 12748*10^6;
info(end).base_end    = 12980*10^6;
info(end).injection_start =  13000*10^6;
info(end).seizure_onset  = 13415*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).sta_channel = [9];
info(end).directory_brain = 'U:\Pilocarpine\2015-10-15_14-42-42'
%info(end).sta_exclude = [1];
%info(end).sta_cut     = 1;
info(end).ictalspike     = 0;
info(end).seizure_autodetect     =0;
info(end).seizure_autodetect_absolute     = 8;
info(end).stable_until = NaN
%146
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-16_17-39-29'
info(end).name        = 'TT1_1';
info(end).base_start  = 20650*10^6;
info(end).base_end    = 21020*10^6;
info(end).injection_start =  20650*10^6;
info(end).seizure_onset  = 21615*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).sta_channel = [9];
info(end).directory_brain = 'U:\Pilocarpine\2015-10-16_17-39-29'
%info(end).sta_channel = [7, 10];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
%info(end).sta_exclude = [1];
info(end).ictalspike     = -91;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -62;
info(end).stable_until = 2.159950472700000e+10

%147
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-20_20-06-29'
info(end).name        = 'TT4_1';
info(end).base_start  = 19182*10^6;
info(end).base_end    = 19400*10^6;
info(end).injection_start =  19454*10^6;
info(end).seizure_onset  = 19985*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-10-20_20-06-29'
%info(end).sta_channel = 6;
%info(end).sta_cut     = 1;
info(end).ictalspike     = -104;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -12;
info(end).cre = 'PV';
info(end).stable_until = NaN

%148
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-20_22-06-40'
info(end).name        = 'TT2_1';
info(end).base_start  = 26472*10^6;
info(end).base_end    = 26900*10^6;
info(end).injection_start =  26925*10^6;
info(end).seizure_onset  = 27410*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-10-20_22-06-40'
info(end).sta_channel = [2,9];
%info(end).sta_cut     = 1;
info(end).sta_channel = 6;
info(end).ictalspike     = -1;
info(end).cre = 'PV';
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -12;
info(end).stable_until = NaN

%149
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-20_22-06-40'
info(end).name        = 'TT4_1';
info(end).base_start  = 26472*10^6;
info(end).base_end    = 26900*10^6;
info(end).injection_start =  26925*10^6;
info(end).seizure_onset  = 27410*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).sta_channel = 6;
info(end).directory_brain = 'U:\Pilocarpine\2015-10-20_22-06-40'
info(end).sta_channel = [2];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
info(end).cre = 'PV';
info(end).seizure_autodetect     = 0;
info(end).ictalspike     = -1;
info(end).seizure_autodetect_absolute     = -12;
info(end).stable_until = NaN

%150
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-21_15-00-14'
info(end).name        = 'TT4_1';
info(end).base_start  = 13565*10^6;
info(end).base_end    = 13950*10^6;
info(end).injection_start =  13969*10^6;
info(end).seizure_onset  = 14532*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-10-21_15-00-14'
info(end).sta_channel = [7, 10];
%info(end).sta_cut     = 1;0
info(end).sta_exclude = [1];
info(end).ictalspike     = -19;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -100;
info(end).stable_until =1.448810230100000e+10


%151
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-21_17-11-27'
info(end).name        = 'TT3_1';
info(end).base_start  = 21304*10^6;
info(end).base_end    = 21730*10^6;
info(end).injection_start =  21745*10^6;
info(end).seizure_onset  = 22422*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-10-21_17-11-27'
%info(end).sta_channel = [6];
info(end).sta_exclude = [1];
%info(end).sta_cut     = 1;
info(end).ictalspike     = -252;
info(end).munumbers = [8 9]; 
info(end).cre = 'PV';
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -242;
info(end).stable_until =NaN
%
%152
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-10-21_17-11-27'
info(end).name        = 'TT3_2';
info(end).base_start  = 21304*10^6;
info(end).base_end    = 21730*10^6;
info(end).injection_start =  21745*10^6;
info(end).seizure_onset  = 22422*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-10-21_17-11-27'
%info(end).sta_channel = [6];
info(end).sta_exclude = [1];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
info(end).ictalspike     = -252;
info(end).munumbers = [8 9]; 
info(end).cre = 'PV';
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -242;
info(end).stable_until =2.252056295100000e+10
%
%153
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-11-03_17-12-47'
info(end).name        = 'TT2_1';
info(end).base_start  = 22800*10^6;
info(end).base_end    = 23171*10^6;
info(end).injection_start =  23190*10^6;
info(end).seizure_onset  = 23699*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-11-03_17-12-47'
%info(end).sta_channel = 11;
info(end).sta_exclude = [1];
info(end).ictalspike     = -21.5;
%info(end).sta_channel = [7, 10];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
%info(end).ictalspike     = -252;
%info(end).munumbers = [8 9]; 
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -25;
info(end).cre = 'PV';
info(end).stable_until = 2.372532372500000e+10

%154
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-11-03_17-12-47'
info(end).name        = 'TT2_2';
info(end).base_start  = 22800*10^6;
info(end).base_end    = 23171*10^6;
info(end).injection_start =  23190*10^6;
info(end).seizure_onset  = 23699*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-11-03_17-12-47'
%info(end).sta_channel = 11;
info(end).sta_exclude = [1];
info(end).ictalspike     = -21.5;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [7, 10];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
%info(end).ictalspike     = -252;
%info(end).munumbers = [8 9]; 
info(end).seizure_autodetect_absolute     = -25;
info(end).stable_until =2.356246402500000e+10

%155
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-11-03_17-12-47'
info(end).name        = 'TT4_1';
info(end).base_start  = 22800*10^6;
info(end).base_end    = 23171*10^6;
info(end).injection_start =  23190*10^6;
info(end).seizure_onset  = 23699*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-11-03_17-12-47'
%info(end).sta_channel = 8;
info(end).sta_exclude = [1];
info(end).ictalspike     = -21.5;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [7, 10];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
%info(end).ictalspike     = -252;
%info(end).munumbers = [8 9]; 
info(end).seizure_autodetect_absolute     = -25;
info(end).cre = 'PV';
info(end).stable_until =236228534*(10^2)

%156
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-11-04_16-37-45'
info(end).name        = 'TT2_1';
info(end).base_start  = 390*10^6;
info(end).base_end    = 825*10^6;
info(end).injection_start =  840*10^6;
info(end).seizure_onset  = 1482*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-11-04_16-37-45'
%info(end).sta_channel = [13];
info(end).sta_exclude = [1];
info(end).ictalspike     = -92;
info(end).seizure_autodetect     = 0;
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
%info(end).ictalspike     = -252;
%info(end).munumbers = [8 9]; 
info(end).seizure_autodetect_absolute     = -47;
info(end).stable_until =1.462309325000000e+09



%157
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-11-05_18-17-25'
info(end).name        = 'TT2_1';
info(end).base_start  = 17822*10^6;
info(end).base_end    = 18250*10^6;
info(end).injection_start =  18333*10^6;
info(end).seizure_onset  = 18800*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-11-05_18-17-25'
%info(end).sta_channel = [13];
info(end).sta_exclude = [1];
info(end).ictalspike     = -12;
info(end).seizure_autodetect     = 0;
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
%info(end).ictalspike     = -252;
%info(end).munumbers = [8 9]; 
info(end).seizure_autodetect_absolute     = -14;
info(end).stable_until =NaN
%158
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-11-05_18-17-25'
info(end).name        = 'TT2_2';
info(end).base_start  = 17822*10^6;
info(end).base_end    = 18250*10^6;
info(end).injection_start =  18333*10^6;
info(end).seizure_onset  = 18800*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-11-05_18-17-25'
%info(end).sta_channel = [13];
info(end).sta_exclude = [1];
info(end).ictalspike     = -12;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [7, 10];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
%info(end).ictalspike     = -252;
%info(end).munumbers = [8 9]; 
info(end).seizure_autodetect_absolute     = -14;
info(end).cre = 'PV';
info(end).stable_until =188005706*(10^2)


%159
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-11-07_16-49-59'
info(end).name        = 'TT3_1';
info(end).base_start  = 19575*10^6;
info(end).base_end    = 19930*10^6;
info(end).injection_start =  19958*10^6;
info(end).seizure_onset  = 20870*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-11-07_16-49-59'
%info(end).sta_channel = [13];
info(end).sta_exclude = [1];
info(end).ictalspike     = -674;
%info(end).sta_channel = [7, 10];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
%info(end).ictalspike     = -252;
%info(end).munumbers = [8 9];
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 2;
info(end).cre = 'PV';
info(end).stable_until =2.087651942600000e+10

%160
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-11-07_16-49-59'
info(end).name        = 'TT4_1';
info(end).base_start  = 19575*10^6;
info(end).base_end    = 19930*10^6;
info(end).injection_start =  19958*10^6;
info(end).seizure_onset  = 20870*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-11-07_16-49-59'
%info(end).sta_channel = [2];
info(end).sta_exclude = [1];
info(end).ictalspike     = -674;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [7, 10];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
%info(end).ictalspike     = -252;
%info(end).munumbers = [8 9];
info(end).seizure_autodetect_absolute     = 2;
info(end).cre = 'PV';
info(end).stable_until =NaN

%161
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-11-07_16-49-59'
info(end).name        = 'TT4_2';
info(end).base_start  = 19575*10^6;
info(end).base_end    = 19930*10^6;
info(end).injection_start =  19958*10^6;
info(end).seizure_onset  = 20870*10^6;
info(end).neuron_type    = 'PV';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-11-07_16-49-59'
%info(end).sta_channel = [2];
info(end).sta_exclude = [1];
info(end).ictalspike     = -674;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [7, 10];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
%info(end).ictalspike     = -252;
%info(end).munumbers = [8 9];
info(end).seizure_autodetect_absolute     = 2;
info(end).stable_until =2.088393642600000e+10

%162
info(end+1).directory = 'E:\SRT2014\chr2_ptz\Pilocarpine\2015-11-07_16-49-59'
info(end).name        = 'TT4_3';
info(end).base_start  = 19575*10^6;
info(end).base_end    = 19930*10^6;
info(end).injection_start =  19958*10^6;
info(end).seizure_onset  = 20870*10^6;
info(end).neuron_type    = 'RS';
info(end).has_rc         = 0;
info(end).exclude_rc        =1
info(end).directory_brain = 'U:\Pilocarpine\2015-11-07_16-49-59'
%info(end).sta_channel = [2];
info(end).sta_exclude = [1];
info(end).ictalspike     = -674;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [7, 10];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = 0;
%info(end).ictalspike     = -252;
%info(end).munumbers = [8 9];
info(end).seizure_autodetect_absolute     = 2;
info(end).cre = 'PV';
info(end).stable_until =NaN














































%163
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-20_14-10-57';
info(end).name              = 'TT1_1';
info(end).base_start  = 11950*10^6;
info(end).base_end   = 12450*10^6;
info(end).injection_start   = 12475*10^6; 
info(end).seizure_onset     = 12780*10^6;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-20_14-10-57'
info(end).ictalspike     = -120.2;
%info(end).sta_channel = [12];
info(end).sta_exclude = [1];
%info(end).ictalspike     = -402;
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -56;
info(end).stable_until =1.281876760200000e+10

%164
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-20_14-10-57';
info(end).name              = 'TT1_2';
info(end).base_start  = 11950*10^6;
info(end).base_end   = 12450*10^6;
info(end).injection_start   = 12475*10^6; 
info(end).seizure_onset     = 12780*10^6;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-20_14-10-57'
info(end).ictalspike     = -120.2;
%info(end).sta_channel = [3];
%info(end).ictalspike     = -402;
info(end).sta_exclude = [1];
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -56;
info(end).stable_until =NaN

%165
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-20_14-10-57';
info(end).name              = 'TT2_1';
info(end).base_start  = 11950*10^6;
info(end).base_end   = 12450*10^6;
info(end).injection_start   = 12475*10^6; 
info(end).seizure_onset     = 12780*10^6;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-20_14-10-57'
info(end).ictalspike     = -120.2;
%info(end).sta_channel = [3];
%info(end).ictalspike     = -402;
info(end).sta_exclude = [1];
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -56;
info(end).stable_until =1.279967605200000e+10

%166
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-20_14-10-57';
info(end).name              = 'TT4_1';
info(end).base_start  = 11950*10^6;
info(end).base_end   = 12450*10^6;
info(end).injection_start   = 12475*10^6; 
info(end).seizure_onset     = 12780*10^6;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-20_14-10-57'
info(end).ictalspike     = -120.2;
%info(end).sta_channel = [3];
%info(end).ictalspike     = -402;
info(end).sta_exclude = [1];
info(end).seizure_autodetect     = 0;
%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -56;
info(end).stable_until =NaN

%167
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\ptzNEWspont\2015-11-25_12-50-43';
info(end).name              = 'TT2_1';
info(end).base_start  = 3480*10^6;
info(end).base_end   = 4000*10^6;
info(end).injection_start   = 4020*10^6; 
info(end).seizure_onset     = 4320*10^6;
info(end).neuron_type       = 'PV';
info(end).has_rc            = 0;
info(end).exclude_rc        =1;
info(end).exclude_rc_numlevels  =0;
info(end).directory_brain = 'U:\ptzNEWspont\2015-11-25_12-50-43'
%info(end).sta_channel = [8];
info(end).sta_exclude = [1];
info(end).ictalspike     = -54.5;

%info(end).sta_channel = [5];
%info(end).sta_cut     = 1;
%info(end).ictalspike     = -55;
info(end).seizure_autodetect_absolute     = -123;
info(end).stable_until =52768394*(10^2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%168
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-01_15-00-57';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 733;
info(end).base_end_pulse    = 1133;
info(end).injection_start_pulse   = 1233; 
info(end).seizure_onset_pulse     = 3002;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = linspace(4.9, 25, 10);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-01_15-00-57'
info(end).sta_channel = [12];
info(end).ictalspike     = -60;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -21;
info(end).cre = 'SOM'
info(end).stable_until =NaN

%169
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-01_15-00-57';
info(end).name              = 'TT2_2';
info(end).base_start_pulse  = 733;
info(end).base_end_pulse    = 1133;
info(end).injection_start_pulse   = 1233; 
info(end).seizure_onset_pulse     = 3002;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = linspace(4.9, 25, 10);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-01_15-00-57'
info(end).sta_channel = [12];
info(end).ictalspike     = -60;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -21;
info(end).cre = 'SOM'
info(end).stable_until =NaN

%170
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-01_18-00-13';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 639;
info(end).injection_start_pulse   = 671; 
info(end).seizure_onset_pulse     = 967;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = linspace(4.9, 25, 8);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-01_18-00-13'
info(end).sta_channel = [1];
info(end).ictalspike     = -89;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -40;
info(end).cre = 'SOM'
info(end).stable_until =NaN

%171
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-01_18-00-13';
info(end).name              = 'TT2_2';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 639;
info(end).injection_start_pulse   = 671; 
info(end).seizure_onset_pulse     = 967;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = linspace(4.9, 25, 8);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-01_18-00-13'
info(end).sta_channel = [1];
info(end).ictalspike     = -89;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -40;
info(end).cre = 'SOM'
info(end).stable_until =3.877386176000000e+09
%
%172
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-01_18-00-13';
info(end).name              = 'TT4_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 639;
info(end).injection_start_pulse   = 671; 
info(end).seizure_onset_pulse     = 967;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = linspace(4.9, 25, 8);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-01_18-00-13'
info(end).sta_channel = [1];
info(end).ictalspike     = -89;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -40;
info(end).cre = 'SOM'
info(end).stable_until = NaN
%
%173
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-01_18-00-13';
info(end).name              = 'TT4_2';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 639;
info(end).injection_start_pulse   = 671; 
info(end).seizure_onset_pulse     = 967;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = linspace(4.9, 25, 8);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-01_18-00-13'
info(end).sta_channel = [1];
info(end).ictalspike     = -89;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -40;
info(end).cre = 'SOM'
info(end).stable_until =3.874925476000000e+09
%
%174
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-01_20-33-42';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 399;
info(end).injection_start_pulse   = 416; 
info(end).seizure_onset_pulse     = 679;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = linspace(4.9, 25, 8);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-01_20-33-42'
info(end).sta_channel = [1];
info(end).ictalspike     = -82;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -20;
info(end).cre = 'SOM'
info(end).stable_until =1.304131972600000e+10

%
%175
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-01_20-33-42';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 399;
info(end).injection_start_pulse   = 416; 
info(end).seizure_onset_pulse     = 679;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = linspace(4.9, 25, 8);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-01_20-33-42'
info(end).sta_channel = [1];
info(end).ictalspike     = -82;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -20;
info(end).cre = 'SOM'
info(end).stable_until =NaN
%
%176
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-02_16-49-14';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 639;
info(end).injection_start_pulse   = 648; 
info(end).seizure_onset_pulse     = 975;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = linspace(4.9, 25, 8);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-02_16-49-14'
info(end).sta_channel = [12];
info(end).ictalspike     = -82;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -20;
info(end).cre = 'SOM'
info(end).stable_until =1.144931162500000e+10
%
%177
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-02_16-49-14';
info(end).name              = 'TT1_2';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 639;
info(end).injection_start_pulse   = 648; 
info(end).seizure_onset_pulse     = 975;

info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = linspace(4.9, 25, 8);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-02_16-49-14'
info(end).sta_channel = [12];
info(end).ictalspike     = -82;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -20;
info(end).cre = 'SOM'
info(end).stable_until =NaN
%
%178
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-02_16-49-14';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 639;
info(end).injection_start_pulse   = 648; 
info(end).seizure_onset_pulse     = 975;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = linspace(4.9, 25, 8);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-02_16-49-14'
info(end).sta_channel = [12];
info(end).ictalspike     = -82;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -20;
info(end).cre = 'SOM'
info(end).stable_until =1.151911357500000e+10
%
%179
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-02_19-28-31';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 239;
info(end).injection_start_pulse   = 248; 
info(end).seizure_onset_pulse     = 599;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = linspace(4.9, 25, 8);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-02_19-28-31'
info(end).sta_channel = [12];
info(end).ictalspike     = -76;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 77;
info(end).cre = 'SOM'
info(end).stable_until =2.489728225000000e+09
%
%180
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\SOM_RSinhibition\2016-02-02_19-28-31';
info(end).name              = 'TT1_2';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 239;
info(end).injection_start_pulse   = 248; 
info(end).seizure_onset_pulse     = 599;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = linspace(4.9, 25, 8);%[4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
%info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\SOM_RSinhibition\2016-02-02_19-28-31'
info(end).sta_channel = [12];
info(end).ictalspike     = -76;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -4;
info(end).cre = 'SOM'
info(end).stable_until =NaN
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%RS cells from old SOM RC expts

% RC curves
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-06-10_15-31-05';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 7;
info(end).base_end_pulse    = 205;
info(end).injection_start_pulse   = 700; 
info(end).seizure_onset_pulse     = 1523;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 7;
info(end).light_levels      = [6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-06-10_15-31-05'
info(end).sta_channel = [8];
info(end).sta_cut     = 1;
info(end).ictalspike     = -11;
info(end).seizure_autodetect     = -10;
info(end).seizure_autodetect_absolute     = -10;
info(end).cre = 'SOM'

%%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-06-26_18-42-47';
info(end).name              = 'TT1_1';
info(end).base_start_pulse  = 384;
info(end).base_end_pulse    = 795;
info(end).injection_start_pulse   = 800; 
info(end).seizure_onset_pulse     = 1211;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =1;
info(end).directory_brain = 'U:\2014-06-26_18-42-47'
info(end).sta_channel = [4];
info(end).ictalspike     = -75;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 77;
info(end).cre = 'SOM'
%%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-06-28_14-22-16';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 164;
info(end).injection_start_pulse   = 816; 
info(end).seizure_onset_pulse     = 1488;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-06-28_14-22-16'
info(end).sta_channel = [12];
info(end).sta_cut     = 1;
info(end).ictalspike     = -156;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -2;
info(end).cre = 'SOM'
%%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-06-28_14-22-16';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 0;
info(end).base_end_pulse    = 164;
info(end).injection_start_pulse   = 816; 
info(end).seizure_onset_pulse     = 1488;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-06-28_14-22-16'
info(end).sta_channel = [12];
info(end).sta_cut     = 1;
info(end).ictalspike     = -156;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -2;
info(end).cre = 'SOM'
%%%%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-06-28_19-53-03';
info(end).name              = 'TT3_2';
info(end).base_start_pulse  = 272;
info(end).base_end_pulse    = 436;
info(end).injection_start_pulse   = 800; 
info(end).seizure_onset_pulse     = 1148;
info(end).neuron_type       = 'SOM';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).directory_brain = 'U:\2014-06-28_19-53-03'
info(end).sta_channel = [3];
info(end).ictalspike     = -64;
info(end).seizure_autodetect     = -25;
info(end).seizure_autodetect_absolute     = 25;
info(end).cre = 'SOM';
%%%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-06-28_19-53-03';
info(end).name              = 'TT3_3';
info(end).base_start_pulse  = 272;
info(end).base_end_pulse    = 436;
info(end).injection_start_pulse   = 800; 
info(end).seizure_onset_pulse     = 1148;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 8;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 17.8, 19.5, 25];
info(end).exclude_rc        =0;
info(end).directory_brain = 'U:\2014-06-28_19-53-03'
info(end).sta_channel = [3];
info(end).ictalspike     = -64;
info(end).seizure_autodetect     = -25;
info(end).seizure_autodetect_absolute     = 25;
info(end).cre = 'SOM'
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-18_13-01-39';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 133;
info(end).base_end_pulse    = 453;
info(end).injection_start_pulse   = 503; 
info(end).seizure_onset_pulse     = 907;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =2;
info(end).directory_brain = 'U:\2014-11-18_13-01-39'
info(end).sta_channel = [6];
info(end).ictalspike     = -30;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 34;
info(end).cre = 'SOM'
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-18_13-01-39';
info(end).name              = 'TT3_2';
info(end).base_start_pulse  = 133;
info(end).base_end_pulse    = 453;
info(end).injection_start_pulse   = 503; 
info(end).seizure_onset_pulse     = 907;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =2;
info(end).directory_brain = 'U:\2014-11-18_13-01-39'
info(end).sta_channel = [6];
info(end).ictalspike     = -30;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 34;
info(end).cre = 'SOM'
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-18_13-01-39';
info(end).name              = 'TT3_3';
info(end).base_start_pulse  = 133;
info(end).base_end_pulse    = 453;
info(end).injection_start_pulse   = 503; 
info(end).seizure_onset_pulse     = 907;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =2;
info(end).directory_brain = 'U:\2014-11-18_13-01-39'
info(end).sta_channel = [6];
info(end).ictalspike     = -30;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 34;
info(end).cre = 'SOM'
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-18_13-01-39';
info(end).name              = 'TT3_5';
info(end).base_start_pulse  = 133;
info(end).base_end_pulse    = 453;
info(end).injection_start_pulse   = 503; 
info(end).seizure_onset_pulse     = 907;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =2;
info(end).directory_brain = 'U:\2014-11-18_13-01-39'
info(end).sta_channel = [6];
info(end).ictalspike     = -30;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 34;
info(end).cre = 'SOM'
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-18_13-01-39';
info(end).name              = 'TT3_6';
info(end).base_start_pulse  = 133;
info(end).base_end_pulse    = 453;
info(end).injection_start_pulse   = 503; 
info(end).seizure_onset_pulse     = 907;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =2;
info(end).directory_brain = 'U:\2014-11-18_13-01-39'
info(end).sta_channel = [6];
info(end).ictalspike     = -30;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 34;
info(end).cre = 'SOM'
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-11-18_13-01-39';
info(end).name              = 'TT3_7';
info(end).base_start_pulse  = 133;
info(end).base_end_pulse    = 453;
info(end).injection_start_pulse   = 503; 
info(end).seizure_onset_pulse     = 907;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =2;
info(end).directory_brain = 'U:\2014-11-18_13-01-39'
info(end).sta_channel = [6];
info(end).ictalspike     = -30;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 34;
info(end).cre = 'SOM'
%  

info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-09-13_16-59-53';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 60;
info(end).base_end_pulse    = 885;
info(end).injection_start_pulse   = 1200; 
info(end).seizure_onset_pulse     = 1511;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 12;
info(end).light_levels      = [3.96644, 4.94407, 5.26085, 7.73848, 9.53289, 10.9273, 11.9628, 12.9933, 16.2714, 18.2013, 22.6, 25.2];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-09-13_16-59-53'
info(end).sta_channel = [10];
info(end).sta_cut     = 1;
info(end).ictalspike     = -39;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -17;
info(end).cre = 'SOM'
%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-09-13_16-59-53';
info(end).name              = 'TT2_3';
info(end).base_start_pulse  = 60;
info(end).base_end_pulse    = 885;
info(end).injection_start_pulse   = 1200; 
info(end).seizure_onset_pulse     = 1511;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 12;
info(end).light_levels      = [3.96644, 4.94407, 5.26085, 7.73848, 9.53289, 10.9273, 11.9628, 12.9933, 16.2714, 18.2013, 22.6, 25.2];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-09-13_16-59-53'
info(end).sta_channel = [10];
info(end).sta_cut     = 1;
info(end).ictalspike     = -39;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -17;
info(end).cre = 'SOM'
%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-09-13_16-59-53';
info(end).name              = 'TT2_4';
info(end).base_start_pulse  = 60;
info(end).base_end_pulse    = 885;
info(end).injection_start_pulse   = 1200; 
info(end).seizure_onset_pulse     = 1511;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 12;
info(end).light_levels      = [3.96644, 4.94407, 5.26085, 7.73848, 9.53289, 10.9273, 11.9628, 12.9933, 16.2714, 18.2013, 22.6, 25.2];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-09-13_16-59-53'
info(end).sta_channel = [10];
info(end).sta_cut     = 1;
info(end).ictalspike     = -39;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -17;
info(end).cre = 'SOM'
%%
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2014-09-15_19-35-46';
info(end).name              = 'TT3_1';
info(end).base_start_pulse  = 48;
info(end).base_end_pulse    = 297;
info(end).injection_start_pulse   = 600; 
info(end).seizure_onset_pulse     = 948;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 12;
info(end).light_levels      = [3.96644, 4.94407, 5.26085, 7.73848, 9.53289, 10.9273, 11.9628, 12.9933, 16.2714, 18.2013, 22.6, 25.2];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2014-09-15_19-35-46'
info(end).sta_channel = [10];
info(end).sta_cut     = 1;
info(end).ictalspike     = -26;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = 15;
info(end).cre = 'SOM'
% 
info(end+1).directory       = 'E:\SRT2014\chr2_ptz\2015-01-13_14-22-21';
info(end).name              = 'TT2_1';
info(end).base_start_pulse  = 50;
info(end).base_end_pulse    = 280;
info(end).injection_start_pulse   = 300; 
info(end).seizure_onset_pulse     = 640;
info(end).neuron_type       = 'RS';
info(end).has_rc            = 1;
info(end).nlevels           = 10;
info(end).light_levels      = [4.9, 6.8, 9.8, 13.2, 15.8, 16.6, 17.8, 19.2, 19.5, 25];
info(end).exclude_rc        =0;
info(end).exclude_rc_numlevels    =0;
info(end).directory_brain = 'U:\2015-01-13_14-22-21'
info(end).sta_channel = [12];
info(end).sta_cut     = 1;
info(end).ictalspike     = -123;
info(end).seizure_autodetect     = 0;
info(end).seizure_autodetect_absolute     = -8;
info(end).cre = 'SOM'