Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED8B9EF30E
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 02:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfKEByX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 20:54:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49440 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfKEByX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 20:54:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA51sHlh148850;
        Tue, 5 Nov 2019 01:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Gyia7qeoRL3jR4b4vqrQF/B1jx3StCjKnnxiiG1kUvc=;
 b=Xk7x/7DmsDqDwk7GUYw/WSeZ2ULm2MGG9X01JrVF5EznIEGw1p5QM/jo6LuDX6W/fqRK
 z0B0nfdeoh/+LuRfPkVru2hejMa/3+DRBPHQL588wp07XBrYf9QY/6DTdyeQLSRarvPn
 PK61hNZ/OHRZDlQuibSU+m/b1Vd5X7h0SCvaXaS1xUH9oTqpmOLq7g7OHw1HtpjImRIT
 s8Az5xW7FP7XjpHLiVQ8/JyhXF1yvrIu/tbmA+P1fp/z4IYwRQDZ0sVkoDsWbQsLB1IK
 L4eiJCsPMW2HAuENlXfD+RKTkHbkphqAtWAF4b5h0CuAWs5BYWhuC9glz2cjLHn6fXAT 6w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w12er2w3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 01:54:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA51s8PI028821;
        Tue, 5 Nov 2019 01:54:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2w2wcgf7dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 01:54:16 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA51sFCf020023;
        Tue, 5 Nov 2019 01:54:16 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 17:54:15 -0800
Subject: [PATCH 1/2] e2scrub_all: don't even reap if the config file doesn't
 allow it
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     tytso@mit.edu, darrick.wong@oracle.com
Cc:     linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Date:   Mon, 04 Nov 2019 17:54:14 -0800
Message-ID: <157291885470.328601.3636347989207329860.stgit@magnolia>
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

Dave Chinner complains that the automated on-boot e2scrub reaping takes
a long time (because the lvs command can take a while to run) even
though the automated e2scrub is disabled via e2scrub.conf on his
systems.

We still need the reaping service to kill off stale e2scrub snapshots
after a crash, but it's unnecessary to annoy everyone with slow bootup.
Because we can look for the e2scrub snapshots in /dev/mapper, let's
skip reaping if periodic e2scrub is disabled unless we find evidence of
e2scrub snapshots in /dev.

Reported-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 scrub/e2scrub_all.in |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)


diff --git a/scrub/e2scrub_all.in b/scrub/e2scrub_all.in
index 1418a229..72e66ff6 100644
--- a/scrub/e2scrub_all.in
+++ b/scrub/e2scrub_all.in
@@ -80,9 +80,18 @@ while getopts "nrAV" opt; do
 done
 shift "$((OPTIND - 1))"
 
-if [ -n "${SERVICE_MODE}" -a "${reap}" -ne 1 -a "${periodic_e2scrub}" -ne 1 ]
-then
-    exitcode 0
+# If we're in service mode and the service is not enabled via config file...
+if [ -n "${SERVICE_MODE}" -a "${periodic_e2scrub}" -ne 1 ]; then
+	# ...don't start e2scrub processes.
+	if [ "${reap}" -eq 0 ]; then
+		exitcode 0
+	fi
+
+	# ...and if we don't see any leftover e2scrub snapshots, don't
+	# run the reaping process either, because lvs can be slow.
+	if ! readlink -q -s -e /dev/mapper/*.e2scrub* > /dev/null; then
+		exitcode 0
+	fi
 fi
 
 # close file descriptor 3 (from cron) since it causes lvm to kvetch

