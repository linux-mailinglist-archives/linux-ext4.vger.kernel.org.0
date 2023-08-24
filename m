Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150F4786BFA
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbjHXJbK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240791AbjHXJau (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:50 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020D610F
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9c3brNz4f3kjk
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S16;
        Thu, 24 Aug 2023 17:30:44 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 12/16] ext4: update reserved meta blocks in ext4_da_{release|update_reserve}_space()
Date:   Thu, 24 Aug 2023 17:26:15 +0800
Message-Id: <20230824092619.1327976-13-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S16
X-Coremail-Antispam: 1UD129KBjvJXoWxtw15Gr1Utr1rGr4UWr1xXwb_yoWfWF4kpF
        15CFy5Ka4rWr1kua1fZr47Zr4S9a40gFWUtFs7WFy7Zry5J3WIgF1DtF1SvFyYkrs3Gw1q
        qa45u34rZa1UWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9E14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
        v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

The same to ext4_da_reserve_space(), we also need to update reserved
metadata blocks when we release and convert a delalloc space range in
ext4_da_release_space() and ext4_da_update_reserve_space(). So also
prepare to reserve metadata blocks in these two functions, the
reservation logic are the same to data blocks. This patch is just a
preparation, the reserved ext_len is always zero.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h              |  4 ++--
 fs/ext4/inode.c             | 47 +++++++++++++++++++++----------------
 include/trace/events/ext4.h | 28 ++++++++++++++--------
 3 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ee2dbbde176e..3e0a39653469 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2998,9 +2998,9 @@ extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
-extern void ext4_da_release_space(struct inode *inode, int to_free);
+extern void ext4_da_release_space(struct inode *inode, unsigned int data_len);
 extern void ext4_da_update_reserve_space(struct inode *inode,
-					int used, int quota_claim);
+					unsigned int data_len, int quota_claim);
 extern int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk,
 			      ext4_fsblk_t pblk, ext4_lblk_t len);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 13036cecbcc0..38c47ce1333b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -327,53 +327,59 @@ qsize_t *ext4_get_reserved_space(struct inode *inode)
 
 static void __ext4_da_update_reserve_space(const char *where,
 					   struct inode *inode,
-					   int data_len)
+					   unsigned int data_len, int ext_len)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
-	if (unlikely(data_len > ei->i_reserved_data_blocks)) {
-		ext4_warning(inode->i_sb, "%s: ino %lu, clear %d "
-			     "with only %d reserved data blocks",
-			     where, inode->i_ino, data_len,
-			     ei->i_reserved_data_blocks);
+	if (unlikely(data_len > ei->i_reserved_data_blocks ||
+		     ext_len > (long)ei->i_reserved_ext_blocks)) {
+		ext4_warning(inode->i_sb, "%s: ino %lu, clear %d,%d "
+			     "with only %d,%d reserved data blocks",
+			     where, inode->i_ino, data_len, ext_len,
+			     ei->i_reserved_data_blocks,
+			     ei->i_reserved_ext_blocks);
 		WARN_ON(1);
-		data_len = ei->i_reserved_data_blocks;
+		data_len = min(data_len, ei->i_reserved_data_blocks);
+		ext_len = min_t(unsigned int, ext_len, ei->i_reserved_ext_blocks);
 	}
 
 	/* Update per-inode reservations */
 	ei->i_reserved_data_blocks -= data_len;
-	percpu_counter_sub(&sbi->s_dirtyclusters_counter, data_len);
+	ei->i_reserved_ext_blocks -= ext_len;
+	percpu_counter_sub(&sbi->s_dirtyclusters_counter, (s64)data_len + ext_len);
 }
 
 /*
  * Called with i_data_sem down, which is important since we can call
  * ext4_discard_preallocations() from here.
  */
-void ext4_da_update_reserve_space(struct inode *inode,
-				  int used, int quota_claim)
+void ext4_da_update_reserve_space(struct inode *inode, unsigned int data_len,
+				  int quota_claim)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
+	int ext_len = 0;
 
-	if (!used)
+	if (!data_len)
 		return;
 
 	spin_lock(&ei->i_block_reservation_lock);
-	trace_ext4_da_update_reserve_space(inode, used, quota_claim);
-	__ext4_da_update_reserve_space(__func__, inode, used);
+	trace_ext4_da_update_reserve_space(inode, data_len, ext_len,
+					   quota_claim);
+	__ext4_da_update_reserve_space(__func__, inode, data_len, ext_len);
 	spin_unlock(&ei->i_block_reservation_lock);
 
 	/* Update quota subsystem for data blocks */
 	if (quota_claim)
-		dquot_claim_block(inode, EXT4_C2B(sbi, used));
+		dquot_claim_block(inode, EXT4_C2B(sbi, data_len));
 	else {
 		/*
 		 * We did fallocate with an offset that is already delayed
 		 * allocated. So on delayed allocated writeback we should
 		 * not re-claim the quota for fallocated blocks.
 		 */
-		dquot_release_reservation_block(inode, EXT4_C2B(sbi, used));
+		dquot_release_reservation_block(inode, EXT4_C2B(sbi, data_len));
 	}
 
 	/*
@@ -1484,20 +1490,21 @@ static int ext4_da_reserve_space(struct inode *inode, unsigned int rsv_dlen,
 	return 0;       /* success */
 }
 
-void ext4_da_release_space(struct inode *inode, int to_free)
+void ext4_da_release_space(struct inode *inode, unsigned int data_len)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
+	int ext_len = 0;
 
-	if (!to_free)
+	if (!data_len)
 		return;		/* Nothing to release, exit */
 
 	spin_lock(&ei->i_block_reservation_lock);
-	trace_ext4_da_release_space(inode, to_free);
-	__ext4_da_update_reserve_space(__func__, inode, to_free);
+	trace_ext4_da_release_space(inode, data_len, ext_len);
+	__ext4_da_update_reserve_space(__func__, inode, data_len, ext_len);
 	spin_unlock(&ei->i_block_reservation_lock);
 
-	dquot_release_reservation_block(inode, EXT4_C2B(sbi, to_free));
+	dquot_release_reservation_block(inode, EXT4_C2B(sbi, data_len));
 }
 
 /*
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 7a9839f2d681..e1e9d7ead20f 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1214,15 +1214,19 @@ TRACE_EVENT(ext4_forget,
 );
 
 TRACE_EVENT(ext4_da_update_reserve_space,
-	TP_PROTO(struct inode *inode, int used_blocks, int quota_claim),
+	TP_PROTO(struct inode *inode,
+		 int data_blocks,
+		 int meta_blocks,
+		 int quota_claim),
 
-	TP_ARGS(inode, used_blocks, quota_claim),
+	TP_ARGS(inode, data_blocks, meta_blocks, quota_claim),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
 		__field(	__u64,	i_blocks		)
-		__field(	int,	used_blocks		)
+		__field(	int,	data_blocks		)
+		__field(	int,	meta_blocks		)
 		__field(	int,	reserved_data_blocks	)
 		__field(	int,	reserved_ext_blocks	)
 		__field(	int,	quota_claim		)
@@ -1233,19 +1237,20 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
-		__entry->used_blocks = used_blocks;
+		__entry->data_blocks = data_blocks;
+		__entry->meta_blocks = meta_blocks;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
 		__entry->reserved_ext_blocks = EXT4_I(inode)->i_reserved_ext_blocks;
 		__entry->quota_claim = quota_claim;
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu used_blocks %d "
+	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu data_blocks %d meta_blocks %d "
 		  "reserved_data_blocks %d reserved_ext_blocks %d quota_claim %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->mode, __entry->i_blocks,
-		  __entry->used_blocks,
+		  __entry->data_blocks, __entry->meta_blocks,
 		  __entry->reserved_data_blocks, __entry->reserved_ext_blocks,
 		  __entry->quota_claim)
 );
@@ -1289,15 +1294,16 @@ TRACE_EVENT(ext4_da_reserve_space,
 );
 
 TRACE_EVENT(ext4_da_release_space,
-	TP_PROTO(struct inode *inode, int freed_blocks),
+	TP_PROTO(struct inode *inode, int freed_blocks, int meta_blocks),
 
-	TP_ARGS(inode, freed_blocks),
+	TP_ARGS(inode, freed_blocks, meta_blocks),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
 		__field(	__u64,	i_blocks		)
 		__field(	int,	freed_blocks		)
+		__field(	int,	meta_blocks		)
 		__field(	int,	reserved_data_blocks	)
 		__field(	int,	reserved_ext_blocks	)
 		__field(	__u16,  mode			)
@@ -1308,17 +1314,19 @@ TRACE_EVENT(ext4_da_release_space,
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
 		__entry->freed_blocks = freed_blocks;
+		__entry->meta_blocks = meta_blocks;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
 		__entry->reserved_ext_blocks = EXT4_I(inode)->i_reserved_ext_blocks;
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu freed_blocks %d "
+	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu "
+		  "freed_blocks %d meta_blocks %d"
 		  "reserved_data_blocks %d reserved_ext_blocks %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->mode, __entry->i_blocks,
-		  __entry->freed_blocks,
+		  __entry->freed_blocks, __entry->meta_blocks,
 		  __entry->reserved_data_blocks,
 		  __entry->reserved_ext_blocks)
 );
-- 
2.39.2

