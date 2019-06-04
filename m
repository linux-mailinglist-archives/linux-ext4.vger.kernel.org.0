Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3066C33E10
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jun 2019 06:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFDE1T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jun 2019 00:27:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48960 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfFDE1T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jun 2019 00:27:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x544NYCo182673;
        Tue, 4 Jun 2019 04:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=jzjUsAZw7DxTFMyoFJ85Ydv0FB6fi91DyAlmtUqSeGE=;
 b=Gmto3INNSc/0i1UfqrwkiRXQjwWndxEyFFOuHOxldkc+osS/3hmTLGhvWmhwAZsOanjP
 dp3S//fw/LVo4zU+Ohx9M0JqaDqmfjIvha5oOP9iaqwWvDOySz3y7QNOf51AnnsvfN/d
 qmYblkEGNJrbRP2u4tRBXJqspHxhhURkmcmqdONsaYhWVzripyPgfFYcOiJiMdKtpM0Q
 8emoBbiJ8Ykj5D+xyd+7gYWpFFqFfENreVxH/jG7sOyLBWRM4cCeZvgWO3oDJWMJUSXJ
 9F8w9+MfOAP4U9c/IJO/qLsaMdir3Uf2VRg24m3cU7jPv5uPhA6RPo9yFSEoLNE8t+uh Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sugstak10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jun 2019 04:27:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x544Q5RM065040;
        Tue, 4 Jun 2019 04:27:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2supp7frc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jun 2019 04:27:15 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x544RDt3000429;
        Tue, 4 Jun 2019 04:27:14 GMT
Received: from localhost (/10.159.151.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Jun 2019 21:27:13 -0700
Date:   Mon, 3 Jun 2019 21:27:12 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] e2scrub: remove -C from e2scrub_all
Message-ID: <20190604042712.GB5378@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9277 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906040029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9277 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906040029
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

We already have the "SERVICE_MODE=1" feature that signals to e2scrub
that we're running as a background daemon and therefore we should exit
quietly if conditions aren't right.

It's therefore unnecessary to have a separate -C flag to achieve the
same outcome for cron jobs.  Merge the two together.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 scrub/e2scrub_all.cron.in     |    4 ++--
 scrub/e2scrub_all.in          |   12 +++---------
 scrub/e2scrub_all.service.in  |    2 +-
 scrub/e2scrub_all_cron.in     |    2 +-
 scrub/e2scrub_reap.service.in |    3 ++-
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/scrub/e2scrub_all.cron.in b/scrub/e2scrub_all.cron.in
index 5bf83ec97..395fb2ab4 100644
--- a/scrub/e2scrub_all.cron.in
+++ b/scrub/e2scrub_all.cron.in
@@ -1,2 +1,2 @@
-30 3 * * 0 root test -e /run/systemd/system || @pkglibdir@/e2scrub_all_cron
-10 3 * * * root test -e /run/systemd/system || @root_sbindir@/e2scrub_all -C -A -r
+30 3 * * 0 root test -e /run/systemd/system || SERVICE_MODE=1 @pkglibdir@/e2scrub_all_cron
+10 3 * * * root test -e /run/systemd/system || SERVICE_MODE=1 @root_sbindir@/e2scrub_all -A -r
diff --git a/scrub/e2scrub_all.in b/scrub/e2scrub_all.in
index d99c81978..cdc37ced4 100644
--- a/scrub/e2scrub_all.in
+++ b/scrub/e2scrub_all.in
@@ -26,7 +26,6 @@ if (( $EUID != 0 )); then
 fi
 
 scrub_all=0
-run_from_cron=0
 snap_size_mb=256
 reap=0
 conffile="@root_sysconfdir@/e2scrub.conf"
@@ -69,12 +68,11 @@ exitcode() {
 	exit "${ret}"
 }
 
-while getopts "nrACV" opt; do
+while getopts "nrAV" opt; do
 	case "${opt}" in
 	"n") DBG="echo Would execute: " ;;
 	"r") scrub_args="${scrub_args} -r"; reap=1;;
 	"A") scrub_all=1;;
-	"C") run_from_cron=1;;
 	"V") print_version; exitcode 0;;
 	*) print_help; exitcode 2;;
 	esac
@@ -86,17 +84,13 @@ shift "$((OPTIND - 1))"
 # when e2scrub_all is run out of cron or a systemd timer.
 
 if ! type lsblk >& /dev/null ; then
-    if [ "${run_from_cron}" -eq 1 ] ; then
-	exitcode 0
-    fi
+    test -n "${SERVICE_MODE}" && exitcode 0
     echo "e2scrub_all: can't find lsblk --- is util-linux installed?"
     exitcode 1
 fi
 
 if ! type lvcreate >& /dev/null ; then
-    if [ "${run_from_cron}" -eq 1 ] ; then
-	exitcode 0
-    fi
+    test -n "${SERVICE_MODE}" && exitcode 0
     echo "e2scrub_all: can't find lvcreate --- is lvm2 installed?"
     exitcode 1
 fi
diff --git a/scrub/e2scrub_all.service.in b/scrub/e2scrub_all.service.in
index 77b6ad599..20f42bfe3 100644
--- a/scrub/e2scrub_all.service.in
+++ b/scrub/e2scrub_all.service.in
@@ -8,5 +8,5 @@ Documentation=man:e2scrub_all(8)
 [Service]
 Type=oneshot
 Environment=SERVICE_MODE=1
-ExecStart=@root_sbindir@/e2scrub_all -C
+ExecStart=@root_sbindir@/e2scrub_all
 SyslogIdentifier=e2scrub_all
diff --git a/scrub/e2scrub_all_cron.in b/scrub/e2scrub_all_cron.in
index bc26fee3d..f9cff878c 100644
--- a/scrub/e2scrub_all_cron.in
+++ b/scrub/e2scrub_all_cron.in
@@ -65,4 +65,4 @@ on_ac_power() {
 test -e /run/systemd/system && exit 0
 on_ac_power || exit 0
 
-exec @root_sbindir@/e2scrub_all -C
+exec @root_sbindir@/e2scrub_all
diff --git a/scrub/e2scrub_reap.service.in b/scrub/e2scrub_reap.service.in
index 40511f735..10d25f06f 100644
--- a/scrub/e2scrub_reap.service.in
+++ b/scrub/e2scrub_reap.service.in
@@ -16,7 +16,8 @@ NoNewPrivileges=yes
 User=root
 IOSchedulingClass=idle
 CPUSchedulingPolicy=idle
-ExecStart=@root_sbindir@/e2scrub_all -C -A -r
+Environment=SERVICE_MODE=1
+ExecStart=@root_sbindir@/e2scrub_all -A -r
 SyslogIdentifier=%N
 RemainAfterExit=no
 
