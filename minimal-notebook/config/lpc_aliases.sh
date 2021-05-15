#!/bin/sh

export XRD_ROLES="  "
export EOS_NOACCESS=1
export EOS_KERNELCACHE=1
export EOS_DIRECTIO=0
export EOS_READAHEADSIZE=4000000
export EOS_READCACHESIZE=0
export EOS_MGM_URL="root://cmseos.fnal.gov"
export PS1="[\u@\h \W]\\$ "

alias eosls='/usr/bin/eos root://cmseos.fnal.gov ls'
alias eosmkdir='/usr/bin/eos root://cmseos.fnal.gov mkdir'
alias eosrm='/usr/bin/eos root://cmseos.fnal.gov rm'
alias eosgrpquota='/usr/local/bin/eosquota -g'
alias xrdfsls='xrdfs root://cmseos.fnal.gov ls'

echo "
                              NOTICE TO USERS

       This  is a Federal computer (and/or it is directly connected to a
       Fermilab local network system) that is the property of the United
       States Government.  It is for authorized use only.  Users (autho-
       rized or unauthorized) have no explicit or  implicit  expectation
       of privacy.

       Any  or  all uses of this system and all files on this system may
       be intercepted, monitored, recorded,  copied, audited, inspected,
       and  disclosed  to authorized site, Department of Energy  and law
       enforcement personnel, as  well as authorized officials of  other
       agencies,  both  domestic and foreign.  By using this system, the
       user consents to such interception, monitoring, recording,  copy-
       ing,  auditing,  inspection,  and disclosure at the discretion of
       authorized site or Department of Energy personnel.

       Unauthorized or improper use of this system may result in  admin-
       istrative  disciplinary  action and civil and criminal penalties.
       By continuing to use this system you indicate your  awareness  of
       and  consent to these terms and conditions of use.  LOG OFF IMME-
       DIATELY if you do not agree to  the  conditions  stated  in  this
       warning.

       Fermilab  policy  and  rules for computing, including appropriate
       use, may be found at http://www.fnal.gov/cd/main/cpolicy.html
------------------------------------------------------------------------------
            ..:: Powered by the ElasticAF Openshift Kubernetes ::..

       JHub URL: https:///analytics-hub.okddev.fnal.gov/user/${NB_USER}/lab
    Notebook OS: `lsb_release -ds`
    Notebook IP: `hostname -I`

------------------------------------------------------------------------------
   For information about computing at the LPC go to: lpc.fnal.gov/computing
------------------------------------------------------------------------------
"
