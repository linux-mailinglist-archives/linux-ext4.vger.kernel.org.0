Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B606B976E
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 15:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjCNOMS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjCNOMC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 10:12:02 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA267A72BB
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 07:11:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pbb6N3jVJz4f3kp5
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 22:11:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7NygBBkPBlyFQ--.57348S5;
        Tue, 14 Mar 2023 22:11:10 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH 1/4] lib/ext2fs: record and show journal head block
Date:   Tue, 14 Mar 2023 22:10:55 +0800
Message-Id: <20230314141058.3267404-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230314141058.3267404-1-yi.zhang@huaweicloud.com>
References: <20230314141058.3267404-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7NygBBkPBlyFQ--.57348S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1ruF48Cry3Cr4UXFy3twb_yoW8tFy7pF
        nrCa4rWry09w10kFykur4xtayrX3W2yFyDKrWDCFna9ay3Ar4fCrW8tw1UX3WrXrW8Gw1I
        qF15Xw1Y9397X37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUkPEfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Add a new parameter into on-disk journal head block to record the head
block number of a clean journal image. This is used to support
'journal_cycle_record' mount option in kernel, which will be continue to
record new journal transactions between each mount, instead of always
recording from the first block. Note that the s_head is only uptodate
while the image is clean, we still need to walk through to find the head
block if the journal is not empty.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 lib/e2p/ljs.c           | 3 +++
 lib/ext2fs/kernel-jbd.h | 6 ++++--
 lib/ext2fs/mkjournal.c  | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/e2p/ljs.c b/lib/e2p/ljs.c
index 59728198..769f635a 100644
--- a/lib/e2p/ljs.c
+++ b/lib/e2p/ljs.c
@@ -108,6 +108,9 @@ void e2p_list_journal_super(FILE *f, char *journal_sb_buf,
 		"Journal start:            %u\n",
 		(unsigned int)ntohl(jsb->s_sequence),
 		(unsigned int)ntohl(jsb->s_start));
+	if (ntohl(jsb->s_start) == 0)
+		fprintf(f, "Journal head:             %u\n",
+			(unsigned int)ntohl(jsb->s_head));
 	if (nr_users != 1)
 		fprintf(f, "Journal number of users:  %u\n", nr_users);
 	if (jsb->s_feature_compat & e2p_be32(JBD2_FEATURE_COMPAT_CHECKSUM))
diff --git a/lib/ext2fs/kernel-jbd.h b/lib/ext2fs/kernel-jbd.h
index e5695006..1a7857c0 100644
--- a/lib/ext2fs/kernel-jbd.h
+++ b/lib/ext2fs/kernel-jbd.h
@@ -221,8 +221,10 @@ typedef struct journal_superblock_s
 	__u8	s_padding2[3];
 /* 0x0054 */
 	__be32	s_num_fc_blks;		/* Number of fast commit blocks */
-/* 0x0058 */
-	__be32	s_padding[41];
+	__be32	s_head;			/* blocknr of head of log, only uptodate
+					 * while the filesystem is clean */
+/* 0x005C */
+	__be32	s_padding[40];
 	__be32	s_checksum;		/* crc32c(superblock) */
 
 /* 0x0100 */
diff --git a/lib/ext2fs/mkjournal.c b/lib/ext2fs/mkjournal.c
index 54772dd5..24245bb7 100644
--- a/lib/ext2fs/mkjournal.c
+++ b/lib/ext2fs/mkjournal.c
@@ -79,6 +79,7 @@ errcode_t ext2fs_create_journal_superblock2(ext2_filsys fs,
 		jsb->s_nr_users = 0;
 		jsb->s_first = htonl(ext2fs_journal_sb_start(fs->blocksize) + 1);
 	}
+	jsb->s_head = jsb->s_first;
 
 	*ret_jsb = (char *) jsb;
 	return 0;
-- 
2.31.1

