Return-Path: <linux-ext4+bounces-640-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A655C82270D
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 03:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6221F23549
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2D518C31;
	Wed,  3 Jan 2024 02:30:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB8C18054;
	Wed,  3 Jan 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T4YbW1LMFz4f3mLn;
	Wed,  3 Jan 2024 10:30:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 711081A017A;
	Wed,  3 Jan 2024 10:30:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDX2A62xpRlYWmAFQ--.14269S10;
	Wed, 03 Jan 2024 10:30:18 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] ext4: remove unnecessary parameter "needed" in ext4_discard_preallocations
Date: Wed,  3 Jan 2024 18:28:20 +0800
Message-Id: <20240103102821.448134-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240103102821.448134-1-shikemeng@huaweicloud.com>
References: <20240103102821.448134-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2A62xpRlYWmAFQ--.14269S10
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4xJw1fWFW3KFW8KFWxZwb_yoWfWFW3pr
	Z8Aa18Ww13X34kuws2qr4UZr1Yga18Ka1UJrWS9w4qvFZxJrn3KF1DtF1ayF1YqFWkXF4Y
	vF10kry7Xw1I937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The "needed" controls the number of ext4_prealloc_space to discard in
ext4_discard_preallocations. Function ext4_discard_preallocations is
supposed to discard all non-used preallocated blocks when "needed"
is 0 and now ext4_discard_preallocations is always called with "needed"
= 0. Remove unnecessary parameter "needed" and remove all non-used
preallocated spaces in ext4_discard_preallocations to simplify the
code.

Note: If count of non-used preallocated spaces could be more than
UINT_MAX, there was a memory leak as some non-used preallocated
spaces are left ununsed and this commit will fix it. Otherwise,
there is no behavior change.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ext4.h        |  2 +-
 fs/ext4/extents.c     | 10 +++++-----
 fs/ext4/file.c        |  2 +-
 fs/ext4/indirect.c    |  2 +-
 fs/ext4/inode.c       |  6 +++---
 fs/ext4/ioctl.c       |  2 +-
 fs/ext4/mballoc.c     | 10 +++-------
 fs/ext4/move_extent.c |  4 ++--
 fs/ext4/super.c       |  2 +-
 9 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index fb35cae16..2fd444034 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2905,7 +2905,7 @@ extern int ext4_mb_init(struct super_block *);
 extern void ext4_mb_release(struct super_block *);
 extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
 				struct ext4_allocation_request *, int *);
-extern void ext4_discard_preallocations(struct inode *, unsigned int);
+extern void ext4_discard_preallocations(struct inode *);
 extern int __init ext4_init_mballoc(void);
 extern void ext4_exit_mballoc(void);
 extern ext4_group_t ext4_mb_prefetch(struct super_block *sb,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 880f383df..fd350889a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -100,7 +100,7 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
 	 * i_rwsem. So we can safely drop the i_data_sem here.
 	 */
 	BUG_ON(EXT4_JOURNAL(inode) == NULL);
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	*dropped = 1;
 	return 0;
@@ -4313,7 +4313,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			 * not a good idea to call discard here directly,
 			 * but otherwise we'd need to call it every free().
 			 */
-			ext4_discard_preallocations(inode, 0);
+			ext4_discard_preallocations(inode);
 			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
 				fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
 			ext4_free_blocks(handle, inode, NULL, newblock,
@@ -5354,7 +5354,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
 
 	down_write(&EXT4_I(inode)->i_data_sem);
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 	ext4_es_remove_extent(inode, punch_start, EXT_MAX_BLOCKS - punch_start);
 
 	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1);
@@ -5362,7 +5362,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 		up_write(&EXT4_I(inode)->i_data_sem);
 		goto out_stop;
 	}
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 
 	ret = ext4_ext_shift_extents(inode, handle, punch_stop,
 				     punch_stop - punch_start, SHIFT_LEFT);
@@ -5494,7 +5494,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 		goto out_stop;
 
 	down_write(&EXT4_I(inode)->i_data_sem);
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 
 	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
 	if (IS_ERR(path)) {
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0166bb9ca..89cb28da8 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -174,7 +174,7 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
 			(atomic_read(&inode->i_writecount) == 1) &&
 			!EXT4_I(inode)->i_reserved_data_blocks) {
 		down_write(&EXT4_I(inode)->i_data_sem);
-		ext4_discard_preallocations(inode, 0);
+		ext4_discard_preallocations(inode);
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
 	if (is_dx(inode) && filp->private_data)
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index a9f371611..d8ca7f64f 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -714,7 +714,7 @@ static int ext4_ind_trunc_restart_fn(handle_t *handle, struct inode *inode,
 	 * i_rwsem. So we can safely drop the i_data_sem here.
 	 */
 	BUG_ON(EXT4_JOURNAL(inode) == NULL);
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	*dropped = 1;
 	return 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d77323204..53ed4a0ad 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -371,7 +371,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
 	 */
 	if ((ei->i_reserved_data_blocks == 0) &&
 	    !inode_is_open_for_write(inode))
-		ext4_discard_preallocations(inode, 0);
+		ext4_discard_preallocations(inode);
 }
 
 static int __check_block_validity(struct inode *inode, const char *func,
@@ -4014,7 +4014,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (stop_block > first_block) {
 
 		down_write(&EXT4_I(inode)->i_data_sem);
-		ext4_discard_preallocations(inode, 0);
+		ext4_discard_preallocations(inode);
 
 		ext4_es_remove_extent(inode, first_block,
 				      stop_block - first_block);
@@ -4167,7 +4167,7 @@ int ext4_truncate(struct inode *inode)
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		err = ext4_ext_truncate(handle, inode);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 0bfe2ce58..2e2bcd22b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -458,7 +458,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	ext4_reset_inode_seed(inode);
 	ext4_reset_inode_seed(inode_bl);
 
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err < 0) {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e6561a09d..0e6beb3b4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5469,7 +5469,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
  *
  * FIXME!! Make sure it is valid at all the call sites
  */
-void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
+void ext4_discard_preallocations(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -5491,15 +5491,12 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 	mb_debug(sb, "discard preallocation for inode %lu\n",
 		 inode->i_ino);
 	trace_ext4_discard_preallocations(inode,
-			atomic_read(&ei->i_prealloc_active), needed);
-
-	if (needed == 0)
-		needed = UINT_MAX;
+			atomic_read(&ei->i_prealloc_active), 0);
 
 repeat:
 	/* first, collect all pa's in the inode */
 	write_lock(&ei->i_prealloc_lock);
-	for (iter = rb_first(&ei->i_prealloc_node); iter && needed;
+	for (iter = rb_first(&ei->i_prealloc_node); iter;
 	     iter = rb_next(iter)) {
 		pa = rb_entry(iter, struct ext4_prealloc_space,
 			      pa_node.inode_node);
@@ -5523,7 +5520,6 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 			spin_unlock(&pa->pa_lock);
 			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
 			list_add(&pa->u.pa_tmp_list, &list);
-			needed--;
 			continue;
 		}
 
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 18a9e7c47..0abfc104a 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -689,8 +689,8 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 
 out:
 	if (*moved_len) {
-		ext4_discard_preallocations(orig_inode, 0);
-		ext4_discard_preallocations(donor_inode, 0);
+		ext4_discard_preallocations(orig_inode);
+		ext4_discard_preallocations(donor_inode);
 	}
 
 	ext4_free_ext_path(path);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d062383ea..c0cfc3e46 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1518,7 +1518,7 @@ void ext4_clear_inode(struct inode *inode)
 	ext4_fc_del(inode);
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
-	ext4_discard_preallocations(inode, 0);
+	ext4_discard_preallocations(inode);
 	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
 	dquot_drop(inode);
 	if (EXT4_I(inode)->jinode) {
-- 
2.30.0


