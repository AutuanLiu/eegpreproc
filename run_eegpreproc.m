%% run brand new eegpreproc function

restoredefaultpath

%%
addpath('Z:\Toolboxes\Git\eegpreproc\')

%-% part I: loading raw data and filter
cfg = [];
cfg.eeglab_path = 'path/to/eeglab12_0_2_3b';
cfg.ft_path     = 'path/to/fieldtrip-20150318';
cfg.readdir     = 'some_dir_to/EEG/raw';
cfg.writdir     = 'some_dir_to/EEG/processed';
cfg.layout      = [cfg.eeglab_path '/plugins/dipfit2.2/standard_BESA/standard-10-5-cap385.elp']; % for eeglab versions >13 this is the dipfit2.3 folder
cfg.projectname = 'a_sensible_name';

cfg.nchan       = 64;
cfg.ref         = {'EXG5','EXG6'};
cfg.veog        = {'EXG1','EXG2'};
cfg.heog        = {'EXG3','EXG4'};
cfg.resrate     = 512;
cfg.highcut     = .1; % desired high-pass filter cut-off
cfg.icacut      = 1.5; % cut-off for ICA and visualization / cleaning decisions; final steps are done on the cut-off specified above!

%-% part II: epoching and trial rejection marking

triggers={
    'conditionA'        { '1' };
    'conditionB'        { '2' };
    };

cfg.epochtime   = [-1.5 2.5];
cfg.artiftime   = [-0.5 1.5];
cfg.artcutoff   = 12;
cfg.triggers    = triggers;
cfg.trigger_subtract = []; % depending on physical lab settings, sometimes weird high numbers get added to the trigger values specified in your experiment script
cfg.inspect_chans = true; % if true, pauses function and shows figures with topomaps of variance, to highlight bad channels

%-% part III: ICA
cfg.chanfilename = 'chans2interp.txt';

%-% part IV: final cleaning
cfg.icafilename = 'ICs2remove.txt';
cfg.inspect_ica = true;

%-% now run it
eegpreproc(cfg);
