Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 798237C2C2
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2019 15:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbfGaNGR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Jul 2019 09:06:17 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36727 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387730AbfGaNGQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 31 Jul 2019 09:06:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TYGGpfj_1564578368;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TYGGpfj_1564578368)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 31 Jul 2019 21:06:14 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH] ext4: disable mount with both dioread_nolock and nodelalloc
Date:   Wed, 31 Jul 2019 21:06:00 +0800
Message-Id: <20190731130600.7867-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Mount with both dioread_nolock and nodelalloc will result in huge
performance drop, which indeed is an known issue, so before we fix
this issue, currently we disable this behaviour. Below test reproducer
can reveal this performance drop.

    mount -o remount,dioread_nolock,delalloc /dev/vdb1
    rm -f testfile
    start_time=$(date +%s)
    dd if=/dev/zero of=testfile bs=4096 count=$((1024*256))
    sync
    end_time=$(date +%s)
    echo $((end_time - start_time))

    mount -o remount,dioread_nolock,nodelalloc /dev/vdb1
    rm -f testfile
    start_time=$(date +%s)
    dd if=/dev/zero of=testfile bs=4096 count=$((1024*256))
    sync
    end_time=$(date +%s)
    echo $((end_time - start_time))

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/ext4/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4079605d437a..1a2b2c0cd1b8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2098,6 +2098,12 @@ static int parse_options(char *options, struct super_block *sb,
 		int blocksize =
 			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
+		if (!test_opt(sb, DELALLOC)) {
+			ext4_msg(sb, KERN_ERR, "can't mount with "
+				 "both dioread_nolock and nodelalloc");
+			return 0;
+		}
+
 		if (blocksize < PAGE_SIZE) {
 			ext4_msg(sb, KERN_ERR, "can't mount with "
 				 "dioread_nolock if block size != PAGE_SIZE");
-- 
2.17.2

