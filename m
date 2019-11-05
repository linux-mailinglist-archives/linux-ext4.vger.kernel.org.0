Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E826FEF30F
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 02:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfKEByc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 20:54:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49568 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfKEByc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 20:54:32 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA51rrRn148644;
        Tue, 5 Nov 2019 01:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=210MQdTH4TsqiQ1Hr/tuh07kenc/TNbMdCsGnM5I5+0=;
 b=lDFG4LFX9XcRwDD3a5ixqumjXkYTxOy56PhH4AkVTT1VpeXNAJUcOxY4edA0iW2k82Xt
 i/hjVJpFQhiPpetcdemKyDJzqn7wYmOBhkAv5jnRqe+B616yby77j13jXRb1wYFDzt3J
 Hkoqh8jdcGRgBt4vR9gAnJ3U3k9J7Fj6iMUNlyhfyWaS6CMrLSo0jHTjfjpBcMW293ym
 v8qLWs3TWr1ArAqpXc8vVvSqzZomk0d2/UaoAtbg9MrOpfATaCVTLoAaEaGAlFrTvQyL
 PkBAN5irUFhxWS16SlS3+g797sQlzrf+IOiqZRenpUhhX4P7ZX4srBAcIaPsT6y0zqro DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w12er2w4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 01:54:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA51s94d028973;
        Tue, 5 Nov 2019 01:54:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2w2wcgf871-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 01:54:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA51sMjd009059;
        Tue, 5 Nov 2019 01:54:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 17:54:21 -0800
Subject: [PATCH 2/2] e2scrub_all: fix broken stdin redirection
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     tytso@mit.edu, darrick.wong@oracle.com
Cc:     linux-ext4@vger.kernel.org, gregor herrmann <gregoa@debian.org>
Date:   Mon, 04 Nov 2019 17:54:20 -0800
Message-ID: <157291886085.328601.12219484583340581878.stgit@magnolia>
In-Reply-To: <157291884852.328601.5452592601628272222.stgit@magnolia>
References: <157291884852.328601.5452592601628272222.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=9 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911050013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911050013
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

gregor herrmann reports that the weekly e2scrub cronjob emits these
errors:

/sbin/e2scrub_all: line 173: /proc/8234/fd/pipe:[90083173]: No such file or directory

The root cause of this is that the ls_targets stdout is piped to stdin
to the entire ls_targets loop body to prevent the loop body from reading
the loop iteration items.  Remove all the broken hackery by reading the
target list into a bash array and iterating the bash array.

Addresses-Debian-Bug: #944033

Reported-by: gregor herrmann <gregoa@debian.org>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 scrub/e2scrub_all.in |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


diff --git a/scrub/e2scrub_all.in b/scrub/e2scrub_all.in
index 72e66ff6..f0336711 100644
--- a/scrub/e2scrub_all.in
+++ b/scrub/e2scrub_all.in
@@ -101,6 +101,12 @@ exec 3<&-
 # indicating success to avoid spamming the sysadmin with fail messages
 # when e2scrub_all is run out of cron or a systemd timer.
 
+if ! type mapfile >& /dev/null ; then
+    test -n "${SERVICE_MODE}" && exitcode 0
+    echo "e2scrub_all: can't find mapfile --- is bash 4.xx installed?"
+    exitcode 1
+fi
+
 if ! type lsblk >& /dev/null ; then
     test -n "${SERVICE_MODE}" && exitcode 0
     echo "e2scrub_all: can't find lsblk --- is util-linux installed?"
@@ -165,13 +171,13 @@ escape_path_for_systemd() {
 }
 
 # Scrub any mounted fs on lvm by creating a snapshot and fscking that.
-stdin="$(realpath /dev/stdin)"
-ls_targets | while read tgt; do
+mapfile -t targets < <(ls_targets)
+for tgt in "${targets[@]}"; do
 	# If we're not reaping and systemd is present, try invoking the
 	# systemd service.
 	if [ "${reap}" -ne 1 ] && type systemctl > /dev/null 2>&1; then
 		tgt_esc="$(escape_path_for_systemd "${tgt}")"
-		${DBG} systemctl start "e2scrub@${tgt_esc}" 2> /dev/null < "${stdin}"
+		${DBG} systemctl start "e2scrub@${tgt_esc}" 2> /dev/null
 		res=$?
 		if [ "${res}" -eq 0 ] || [ "${res}" -eq 1 ]; then
 			continue;
@@ -179,7 +185,7 @@ ls_targets | while read tgt; do
 	fi
 
 	# Otherwise use direct invocation
-	${DBG} "@root_sbindir@/e2scrub" ${scrub_args} "${tgt}" < "${stdin}"
+	${DBG} "@root_sbindir@/e2scrub" ${scrub_args} "${tgt}"
 done
 
 exitcode 0

