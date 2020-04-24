Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61461B7103
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgDXJeO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Apr 2020 05:34:14 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:33698 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbgDXJeJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 24 Apr 2020 05:34:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TwVx7HD_1587720845;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0TwVx7HD_1587720845)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Apr 2020 17:34:05 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH RFC 1/2] xfstests: fsx: add support for cluster size
Date:   Fri, 24 Apr 2020 17:33:49 +0800
Message-Id: <1587720830-11955-2-git-send-email-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587720830-11955-1-git-send-email-jefflexu@linux.alibaba.com>
References: <1587720830-11955-1-git-send-email-jefflexu@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The offset and size should be aligned with cluster size when inserting
or collapsing range on ext4 with 'bigalloc' feature enabled. Currently
I can find only ext4 with this limitation.

Since fsx should have no assumption of the underlying filesystem, and
thus add the '-u cluster_size' option. Tests can set this option when
the underlying filesystem is ext4 with bigalloc enabled.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 ltp/fsx.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 9d598a4..5fe5738 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -133,6 +133,7 @@ int	dirpath = 0;			/* -P flag */
 int	fd;				/* fd for our test file */
 
 blksize_t	block_size = 0;
+blksize_t	cluster_size = 0;
 off_t		file_size = 0;
 off_t		biggest = 0;
 long long	testcalls = 0;		/* calls to function "test" */
@@ -2146,8 +2147,8 @@ have_op:
 		break;
 	case OP_COLLAPSE_RANGE:
 		TRIM_OFF_LEN(offset, size, file_size - 1);
-		offset = offset & ~(block_size - 1);
-		size = size & ~(block_size - 1);
+		offset = offset & ~(cluster_size - 1);
+		size = size & ~(cluster_size - 1);
 		if (size == 0) {
 			log4(OP_COLLAPSE_RANGE, offset, size, FL_SKIPPED);
 			goto out;
@@ -2157,8 +2158,8 @@ have_op:
 	case OP_INSERT_RANGE:
 		TRIM_OFF(offset, file_size);
 		TRIM_LEN(file_size, size, maxfilelen);
-		offset = offset & ~(block_size - 1);
-		size = size & ~(block_size - 1);
+		offset = offset & ~(cluster_size - 1);
+		size = size & ~(cluster_size - 1);
 		if (size == 0) {
 			log4(OP_INSERT_RANGE, offset, size, FL_SKIPPED);
 			goto out;
@@ -2231,7 +2232,7 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dknqxABEFJLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
+		"fsx [-dknqxABEFJLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-u csize] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
@@ -2249,6 +2250,7 @@ usage(void)
 	-r readbdy: 4096 would make reads page aligned (default 1)\n\
 	-s style: 1 gives smaller truncates (default 0)\n\
 	-t truncbdy: 4096 would make truncates page aligned (default 1)\n\
+	-u csize: filesystem specific cluster size that may be used for ops like insert/collapse range\n\
 	-w writebdy: 4096 would make writes page aligned (default 1)\n\
 	-x: preallocate file space before starting, XFS only (default 0)\n\
 	-y synchronize changes to a file\n"
@@ -2485,7 +2487,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "b:c:dfg:i:j:kl:m:no:p:qr:s:t:w:xyABD:EFJKHzCILN:OP:RS:WXZ",
+				 "b:c:dfg:i:j:kl:m:no:p:qr:s:t:u:w:xyABD:EFJKHzCILN:OP:RS:WXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -2579,6 +2581,11 @@ main(int argc, char **argv)
 			if (truncbdy <= 0)
 				usage();
 			break;
+		case 'u':
+			cluster_size = getnum(optarg, &endp);
+			if (cluster_size <= 0)
+				usage();
+			break;
 		case 'w':
 			writebdy = getnum(optarg, &endp);
 			if (writebdy <= 0)
@@ -2720,6 +2727,7 @@ main(int argc, char **argv)
 		exit(91);
 	}
 	block_size = statbuf.st_blksize;
+	cluster_size = cluster_size ? : block_size;
 #ifdef XFS
 	if (prealloc) {
 		xfs_flock64_t	resv = { 0 };
-- 
1.8.3.1

