// A bunch of %rename directives generated by BuildRenamers in config.py
// in order to remove the wx prefix from all global scope names.

#ifndef BUILDING_RENAMERS

%rename(MEDIASTATE_STOPPED)                 wxMEDIASTATE_STOPPED;
%rename(MEDIASTATE_PAUSED)                  wxMEDIASTATE_PAUSED;
%rename(MEDIASTATE_PLAYING)                 wxMEDIASTATE_PLAYING;
%rename(MEDIACTRLPLAYERCONTROLS_NONE)       wxMEDIACTRLPLAYERCONTROLS_NONE;
%rename(MEDIACTRLPLAYERCONTROLS_STEP)       wxMEDIACTRLPLAYERCONTROLS_STEP;
%rename(MEDIACTRLPLAYERCONTROLS_VOLUME)     wxMEDIACTRLPLAYERCONTROLS_VOLUME;
%rename(MEDIACTRLPLAYERCONTROLS_DEFAULT)    wxMEDIACTRLPLAYERCONTROLS_DEFAULT;
%rename(MediaEvent)                         wxMediaEvent;
%rename(MediaCtrl)                          wxMediaCtrl;

#endif
