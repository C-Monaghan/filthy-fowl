load_literature_data <- function() {
  tribble(
    ~study_id  , ~n  , ~fsc_wbi_mean_r , ~fsc_fsrh_r , ~wbi_mean_fsrh_r , ~fsc_wbi_mean_semi_r , ~percent_female , ~fsc_measure   , ~sample     , ~lab_study , ~mean_age , ~fsc_wbi_mean_z , ~fsc_fsrh_z , ~wbi_mean_fsrh_z , ~fsc_wbi_mean_semi_z , ~vi         ,
    "study_22" , 370 , 0.05            , NA          , NA               , NA                   , 0.532           , "multi-item"   , "community" , FALSE      , 36.00     , 0.05004173      , NA          , NA               , NA                   , 0.002724796 ,
    "study_23" ,  58 , 0.46            , NA          , NA               , NA                   , 0.741           , "experimental" , "student"   , FALSE      , 21.38     , 0.4973113       , NA          , NA               , NA                   , 0.01818182  ,
    "study_24" , 788 , 0.20            , NA          , NA               , NA                   , 0.6396          , "multi-item"   , "student"   , FALSE      , 19.94     , 0.2027326       , NA          , NA               , NA                   , 0.001273885 ,
    "study_25" , 147 , 0.33            , NA          , NA               , NA                   , 0.5714          , "multi-item"   , "student"   , FALSE      , 18.45     , 0.3428283       , NA          , NA               , NA                   , 0.006944444 ,
    "study_26" , 344 , 0.50            , NA          , NA               , NA                   , 0.4826          , "multi-item"   , "community" , FALSE      , 39.66     , 0.5493061       , NA          , NA               , NA                   , 0.002932551 ,
    "study_27" , 358 , 0.15            , NA          , NA               , NA                   , 0.5277          , "multi-item"   , "community" , FALSE      , 27.00     , 0.1511404       , NA          , NA               , NA                   , 0.002816901
  )
}
