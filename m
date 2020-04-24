Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207501B704E
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgDXJLc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Apr 2020 05:11:32 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40990 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgDXJLc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 24 Apr 2020 05:11:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TwVfhQ._1587719489;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0TwVfhQ._1587719489)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Apr 2020 17:11:30 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com,
        Tomas Racek <tracek@redhat.com>
Subject: [PATCH] xfstests: 298: fix failure on ext4 with bigalloc
Date:   Fri, 24 Apr 2020 17:11:12 +0800
Message-Id: <1587719472-129572-1-git-send-email-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Tomas Racek <tracek@redhat.com>

It is just a resend of this patch from "Tomas Racek <tracek@redhat.com>".
Recently we run xfstests on ext4 with 'bigalloc' feature enabled, and
come across some failure due to poor adaption for ext4 bigalloc. One
if the failed cases is shared/298. I find this patch on internet [1] and
it works in my case. I have no idea why this patch have not been merged.
Maybe this buddy didn't send this patch at that time, or it was rejected
for some reason but I can't find any discussion on internet.

[1] https://lkml.org/lkml/2013/6/18/329

The original commit log:

Count with cluster size instead of block size if bigalloc is used.

Signed-off-by: Tomas Racek <tracek@redhat.com>
---
 tests/shared/298 | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/shared/298 b/tests/shared/298
index 5d6c6cc..86b7cdc 100755
--- a/tests/shared/298
+++ b/tests/shared/298
@@ -60,15 +60,21 @@ get_free_sectors()
 {
 	case $FSTYP in
 	ext4)
+	cluster_size=$($DUMPE2FS_PROG $img_file 2>&1 | sed -n 's/Cluster size: *\(.*\)/\1/p')
+	if [ -n "$cluster_size" ]; then
+		blocks_per_cluster=`expr $cluster_size / $block_size`
+	else
+		blocks_per_cluster=1
+	fi
 	$UMOUNT_PROG $loop_mnt
 	$DUMPE2FS_PROG $img_file  2>&1 | grep " Free blocks" | cut -d ":" -f2- | \
 		tr ',' '\n' | $SED_PROG 's/^ //' | \
-		$AWK_PROG -v spb=$sectors_per_block 'BEGIN{FS="-"};
+		$AWK_PROG -v spb=$sectors_per_block -v bpc=$blocks_per_cluster 'BEGIN{FS="-"};
 		     NF {
 			if($2 != "") # range of blocks
-				print spb * $1, spb * ($2 + 1) - 1;
+				print spb * $1, spb * ($2 + bpc) - 1;
 			else		# just single block
-				print spb * $1, spb * ($1 + 1) - 1;
+				print spb * $1, spb * ($1 + bpc) - 1;
 		     }'
 	;;
 	xfs)
-- 
1.8.3.1

