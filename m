Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7A3245E21
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Aug 2020 09:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHQHgV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Aug 2020 03:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgHQHgS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Aug 2020 03:36:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D169FC061388
        for <linux-ext4@vger.kernel.org>; Mon, 17 Aug 2020 00:36:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so7705618pgm.7
        for <linux-ext4@vger.kernel.org>; Mon, 17 Aug 2020 00:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=T9fsyOvnTrBdsaxtydPb1L3Fi+WziX3f/x7Njly5A/o=;
        b=MLQUGrlPdFQ78JUOyZcymjPaYKaH4He5eT2meYPyVIfhzEmSUw2YccJ5kHMkK63LTn
         jsdpXiKcxjHrxizfzQ3rjbKlwKDu06oAtmppy6EKy4VD94D8IGVGnTjcNnrm+Pq/KjJs
         /3/elgasR9MV6HBrNlQniJI6HyalUfeAtHuUVGVk/V1PhlAOlx1TMSghR6ZRn780+J+g
         00HyQalAOIA0P5wY+OOC9x4QrohC044IPiNXI993E6vzO2oEBgMtg8oPm8DulK7TQcnx
         4CXF8tov5jHVIXZCyv16eYL0hpRX7PrszFuiIXzNMKxN6WAU7g6BkIgSRxSNkOb2C09v
         2pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=T9fsyOvnTrBdsaxtydPb1L3Fi+WziX3f/x7Njly5A/o=;
        b=r9XDkFgQRm9JaX4aj1S66aocSxwKYptSOxlB7i5R4KE60IVFQi1BRymoK2ba003iZY
         M72hHvR+xUn53KdcJCkICHt2gjzVht4yG44k6AfUO49p+lwpcFRQhxfdt4yZFK6+Ek1s
         7q7/za90wI1cGz1MPAUqxsdA+oa33t0i0xA2nv7s6jlGu+5FNUIFLpECttbWY5Xmxk/4
         0ONVjVlNMJuJI1wni9n4MRdPns5R9AKFDbPu7sooIkivNv27CBL4Kp+9AiGMAlVgS+Qd
         DsxtngiietFyyXaKCM4UNhdqcvVXArN4CZ5m20YCLyrP6dTiDvUrZLpdaRwD43VfKXlo
         MgsA==
X-Gm-Message-State: AOAM532wAWvDRQwzrygAW2V1YS0ja8gi/DUOwVPYuAAcm3DVwyt8+oQ1
        P+c+mg8yVa/ldExVqUKl5GbxxUwF1lY=
X-Google-Smtp-Source: ABdhPJxOUdcImH1pwVS0YFkFTK9gegzDpGGK9ycH29xMOOml6M9cFR0JCjItLw4wTJ76pYlSJX+zzg==
X-Received: by 2002:a62:8c89:: with SMTP id m131mr10278003pfd.288.1597649777936;
        Mon, 17 Aug 2020 00:36:17 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.50])
        by smtp.gmail.com with ESMTPSA id s29sm16303630pgo.68.2020.08.17.00.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 00:36:17 -0700 (PDT)
To:     adilger.kernel@dilger.ca, tytso@mit.edu
Cc:     riteshh@linux.ibm.com, jack@suse.cz, linux-ext4@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v5 2/2] ext4: limit the length of per-inode prealloc list
Message-ID: <d7a98178-056b-6db5-6bce-4ead23f4a257@gmail.com>
Date:   Mon, 17 Aug 2020 15:36:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the scenario of writing sparse files, the per-inode prealloc list may
be very long, resulting in high overhead for ext4_mb_use_preallocated().
To circumvent this problem, we limit the maximum length of per-inode
prealloc list to 512 and allow users to modify it.

After patching, we observed that the sys ratio of cpu has dropped, and
the system throughput has increased significantly. We created a process
to write the sparse file, and the running time of the process on the
fixed kernel was significantly reduced, as follows:

Running time on unfixed kernel：
[root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
real    0m2.051s
user    0m0.008s
sys     0m2.026s

Running time on fixed kernel：
[root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
real    0m0.471s
user    0m0.004s
sys     0m0.395s

V5:
1. Fix the wrong parameter of list_move().
2. Use an atomic variable to count the length of the prealloc list.

V4:
1. Add performance data to the commit log.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 Documentation/admin-guide/ext4.rst |  3 ++
 fs/ext4/ext4.h                     |  4 ++-
 fs/ext4/extents.c                  | 10 +++---
 fs/ext4/file.c                     |  2 +-
 fs/ext4/indirect.c                 |  2 +-
 fs/ext4/inode.c                    |  6 ++--
 fs/ext4/ioctl.c                    |  2 +-
 fs/ext4/mballoc.c                  | 74 +++++++++++++++++++++++++++++++++-----
 fs/ext4/mballoc.h                  |  4 +++
 fs/ext4/move_extent.c              |  4 +--
 fs/ext4/super.c                    |  3 +-
 fs/ext4/sysfs.c                    |  2 ++
 include/trace/events/ext4.h        | 17 +++++----
 13 files changed, 104 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
index 9443fce..f37d074 100644
--- a/Documentation/admin-guide/ext4.rst
+++ b/Documentation/admin-guide/ext4.rst
@@ -482,6 +482,9 @@ Files in /sys/fs/ext4/<devname>:
         multiple of this tuning parameter if the stripe size is not set in the
         ext4 superblock
 
+  mb_max_inode_prealloc
+        The maximum length of per-inode ext4_prealloc_space list.
+
   mb_max_to_scan
         The maximum number of extents the multiblock allocator will search to
         find the best extent.
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 42f5060..c4b465c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1054,6 +1054,7 @@ struct ext4_inode_info {
 	struct timespec64 i_crtime;
 
 	/* mballoc */
+	atomic_t i_prealloc_active;
 	struct list_head i_prealloc_list;
 	spinlock_t i_prealloc_lock;
 
@@ -1501,6 +1502,7 @@ struct ext4_sb_info {
 	unsigned int s_mb_stats;
 	unsigned int s_mb_order2_reqs;
 	unsigned int s_mb_group_prealloc;
+	unsigned int s_mb_max_inode_prealloc;
 	unsigned int s_max_dir_size_kb;
 	/* where last allocation was done - for stream allocation */
 	unsigned long s_mb_last_group;
@@ -2651,7 +2653,7 @@ extern int ext4_init_inode_table(struct super_block *sb,
 extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
 				struct ext4_allocation_request *, int *);
 extern int ext4_mb_reserve_blocks(struct super_block *, int);
-extern void ext4_discard_preallocations(struct inode *);
+extern void ext4_discard_preallocations(struct inode *, unsigned int);
 extern int __init ext4_init_mballoc(void);
 extern void ext4_exit_mballoc(void);
 extern void ext4_free_blocks(handle_t *handle, struct inode *inode,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 221f240..a40f928 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -100,7 +100,7 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
 	 * i_mutex. So we can safely drop the i_data_sem here.
 	 */
 	BUG_ON(EXT4_JOURNAL(inode) == NULL);
-	ext4_discard_preallocations(inode);
+	ext4_discard_preallocations(inode, 0);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	*dropped = 1;
 	return 0;
@@ -4272,7 +4272,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			 * not a good idea to call discard here directly,
 			 * but otherwise we'd need to call it every free().
 			 */
-			ext4_discard_preallocations(inode);
+			ext4_discard_preallocations(inode, 0);
 			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
 				fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
 			ext4_free_blocks(handle, inode, NULL, newblock,
@@ -5299,7 +5299,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	}
 
 	down_write(&EXT4_I(inode)->i_data_sem);
-	ext4_discard_preallocations(inode);
+	ext4_discard_preallocations(inode, 0);
 
 	ret = ext4_es_remove_extent(inode, punch_start,
 				    EXT_MAX_BLOCKS - punch_start);
@@ -5313,7 +5313,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 		up_write(&EXT4_I(inode)->i_data_sem);
 		goto out_stop;
 	}
-	ext4_discard_preallocations(inode);
+	ext4_discard_preallocations(inode, 0);
 
 	ret = ext4_ext_shift_extents(inode, handle, punch_stop,
 				     punch_stop - punch_start, SHIFT_LEFT);
@@ -5445,7 +5445,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 		goto out_stop;
 
 	down_write(&EXT4_I(inode)->i_data_sem);
-	ext4_discard_preallocations(inode);
+	ext4_discard_preallocations(inode, 0);
 
 	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
 	if (IS_ERR(path)) {
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31..e3ab8ea 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -148,7 +148,7 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
 		        !EXT4_I(inode)->i_reserved_data_blocks)
 	{
 		down_write(&EXT4_I(inode)->i_data_sem);
-		ext4_discard_preallocations(inode);
+		ext4_discard_preallocations(inode, 0);
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
 	if (is_dx(inode) && filp->private_data)
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index be2b66e..ec6b930 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -696,7 +696,7 @@ static int ext4_ind_trunc_restart_fn(handle_t *handle, struct inode *inode,
 	 * i_mutex. So we can safely drop the i_data_sem here.
 	 */
 	BUG_ON(EXT4_JOURNAL(inode) == NULL);
-	ext4_discard_preallocations(inode);
+	ext4_discard_preallocations(inode, 0);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	*dropped = 1;
 	return 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 10dd470..bb9e1cd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -383,7 +383,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
 	 */
 	if ((ei->i_reserved_data_blocks == 0) &&
 	    !inode_is_open_for_write(inode))
-		ext4_discard_preallocations(inode);
+		ext4_discard_preallocations(inode, 0);
 }
 
 static int __check_block_validity(struct inode *inode, const char *func,
@@ -4056,7 +4056,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	if (stop_block > first_block) {
 
 		down_write(&EXT4_I(inode)->i_data_sem);
-		ext4_discard_preallocations(inode);
+		ext4_discard_preallocations(inode, 0);
 
 		ret = ext4_es_remove_extent(inode, first_block,
 					    stop_block - first_block);
@@ -4211,7 +4211,7 @@ int ext4_truncate(struct inode *inode)
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 
-	ext4_discard_preallocations(inode);
+	ext4_discard_preallocations(inode, 0);
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		err = ext4_ext_truncate(handle, inode);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 999cf6a..a5fcc23 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -202,7 +202,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	reset_inode_seed(inode);
 	reset_inode_seed(inode_bl);
 
-	ext4_discard_preallocations(inode);
+	ext4_discard_preallocations(inode, 0);
 
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err < 0) {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 51f37f1..58426c6 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2739,6 +2739,7 @@ int ext4_mb_init(struct super_block *sb)
 	sbi->s_mb_stats = MB_DEFAULT_STATS;
 	sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
 	sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
+	sbi->s_mb_max_inode_prealloc = MB_DEFAULT_MAX_INODE_PREALLOC;
 	/*
 	 * The default group preallocation is 512, which for 4k block
 	 * sizes translates to 2 megabytes.  However for bigalloc file
@@ -3677,6 +3678,26 @@ void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 	mb_debug(sb, "preallocated %d for group %u\n", preallocated, group);
 }
 
+static void ext4_mb_mark_pa_deleted(struct super_block *sb,
+				    struct ext4_prealloc_space *pa)
+{
+	struct ext4_inode_info *ei;
+
+	if (pa->pa_deleted) {
+		ext4_warning(sb, "deaded pa, type:%d, pblk:%llu, lblk:%u, len:%d\n",
+			     pa->pa_type, pa->pa_pstart, pa->pa_lstart,
+			     pa->pa_len);
+		return;
+	}
+
+	pa->pa_deleted = 1;
+
+	if (pa->pa_type == MB_INODE_PA) {
+		ei = EXT4_I(pa->pa_inode);
+		atomic_dec(&ei->i_prealloc_active);
+	}
+}
+
 static void ext4_mb_pa_callback(struct rcu_head *head)
 {
 	struct ext4_prealloc_space *pa;
@@ -3709,7 +3730,7 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
 		return;
 	}
 
-	pa->pa_deleted = 1;
+	ext4_mb_mark_pa_deleted(sb, pa);
 	spin_unlock(&pa->pa_lock);
 
 	grp_blk = pa->pa_pstart;
@@ -3833,6 +3854,7 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
 	spin_lock(pa->pa_obj_lock);
 	list_add_rcu(&pa->pa_inode_list, &ei->i_prealloc_list);
 	spin_unlock(pa->pa_obj_lock);
+	atomic_inc(&ei->i_prealloc_active);
 }
 
 /*
@@ -4043,7 +4065,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 		}
 
 		/* seems this one can be freed ... */
-		pa->pa_deleted = 1;
+		ext4_mb_mark_pa_deleted(sb, pa);
 
 		/* we can trust pa_free ... */
 		free += pa->pa_free;
@@ -4106,7 +4128,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
  *
  * FIXME!! Make sure it is valid at all the call sites
  */
-void ext4_discard_preallocations(struct inode *inode)
+void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -4124,15 +4146,19 @@ void ext4_discard_preallocations(struct inode *inode)
 
 	mb_debug(sb, "discard preallocation for inode %lu\n",
 		 inode->i_ino);
-	trace_ext4_discard_preallocations(inode);
+	trace_ext4_discard_preallocations(inode,
+			atomic_read(&ei->i_prealloc_active), needed);
 
 	INIT_LIST_HEAD(&list);
 
+	if (needed == 0)
+		needed = UINT_MAX;
+
 repeat:
 	/* first, collect all pa's in the inode */
 	spin_lock(&ei->i_prealloc_lock);
-	while (!list_empty(&ei->i_prealloc_list)) {
-		pa = list_entry(ei->i_prealloc_list.next,
+	while (!list_empty(&ei->i_prealloc_list) && needed) {
+		pa = list_entry(ei->i_prealloc_list.prev,
 				struct ext4_prealloc_space, pa_inode_list);
 		BUG_ON(pa->pa_obj_lock != &ei->i_prealloc_lock);
 		spin_lock(&pa->pa_lock);
@@ -4149,10 +4175,11 @@ void ext4_discard_preallocations(struct inode *inode)
 
 		}
 		if (pa->pa_deleted == 0) {
-			pa->pa_deleted = 1;
+			ext4_mb_mark_pa_deleted(sb, pa);
 			spin_unlock(&pa->pa_lock);
 			list_del_rcu(&pa->pa_inode_list);
 			list_add(&pa->u.pa_tmp_list, &list);
+			needed--;
 			continue;
 		}
 
@@ -4453,7 +4480,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 		BUG_ON(pa->pa_type != MB_GROUP_PA);
 
 		/* seems this one can be freed ... */
-		pa->pa_deleted = 1;
+		ext4_mb_mark_pa_deleted(sb, pa);
 		spin_unlock(&pa->pa_lock);
 
 		list_del_rcu(&pa->pa_inode_list);
@@ -4552,10 +4579,29 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
 }
 
 /*
+ * if per-inode prealloc list is too long, trim some PA
+ */
+static void ext4_mb_trim_inode_pa(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	int count, delta;
+
+	count = atomic_read(&ei->i_prealloc_active);
+	delta = (sbi->s_mb_max_inode_prealloc >> 2) + 1;
+	if (count > sbi->s_mb_max_inode_prealloc + delta) {
+		count -= sbi->s_mb_max_inode_prealloc;
+		ext4_discard_preallocations(inode, count);
+	}
+}
+
+/*
  * release all resource we used in allocation
  */
 static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 {
+	struct inode *inode = ac->ac_inode;
+	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_prealloc_space *pa = ac->ac_pa;
 	if (pa) {
@@ -4581,6 +4627,17 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 				ext4_mb_add_n_trim(ac);
 			}
 		}
+
+		if (pa->pa_type == MB_INODE_PA) {
+			/*
+			 * treat per-inode prealloc list as a lru list, then try
+			 * to trim the least recently used PA.
+			 */
+			spin_lock(pa->pa_obj_lock);
+			list_move(&pa->pa_inode_list, &ei->i_prealloc_list);
+			spin_unlock(pa->pa_obj_lock);
+		}
+
 		ext4_mb_put_pa(ac, ac->ac_sb, pa);
 	}
 	if (ac->ac_bitmap_page)
@@ -4590,6 +4647,7 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
 		mutex_unlock(&ac->ac_lg->lg_mutex);
 	ext4_mb_collect_stats(ac);
+	ext4_mb_trim_inode_pa(inode);
 	return 0;
 }
 
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 6b4d17c..e75b474 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -73,6 +73,10 @@
  */
 #define MB_DEFAULT_GROUP_PREALLOC	512
 
+/*
+ * maximum length of inode prealloc list
+ */
+#define MB_DEFAULT_MAX_INODE_PREALLOC	512
 
 struct ext4_free_data {
 	/* this links the free block information from sb_info */
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 1ed86fb..0d601b8 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -686,8 +686,8 @@
 
 out:
 	if (*moved_len) {
-		ext4_discard_preallocations(orig_inode);
-		ext4_discard_preallocations(donor_inode);
+		ext4_discard_preallocations(orig_inode, 0);
+		ext4_discard_preallocations(donor_inode, 0);
 	}
 
 	ext4_ext_drop_refs(path);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 330957e..4df5dde 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1123,6 +1123,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	inode_set_iversion(&ei->vfs_inode, 1);
 	spin_lock_init(&ei->i_raw_lock);
 	INIT_LIST_HEAD(&ei->i_prealloc_list);
+	atomic_set(&ei->i_prealloc_active, 0);
 	spin_lock_init(&ei->i_prealloc_lock);
 	ext4_es_init_tree(&ei->i_es_tree);
 	rwlock_init(&ei->i_es_lock);
@@ -1216,7 +1217,7 @@ void ext4_clear_inode(struct inode *inode)
 {
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
-	ext4_discard_preallocations(inode);
+	ext4_discard_preallocations(inode, 0);
 	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
 	dquot_drop(inode);
 	if (EXT4_I(inode)->jinode) {
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6c9fc9e..92f04e9 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -215,6 +215,7 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
 EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
 EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
 EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
+EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
 EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
 EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
 EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
@@ -257,6 +258,7 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
 	ATTR_LIST(mb_order2_req),
 	ATTR_LIST(mb_stream_req),
 	ATTR_LIST(mb_group_prealloc),
+	ATTR_LIST(mb_max_inode_prealloc),
 	ATTR_LIST(max_writeback_mb_bump),
 	ATTR_LIST(extent_max_zeroout_kb),
 	ATTR_LIST(trigger_fs_error),
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index cc41d69..628db6a 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -746,24 +746,29 @@
 );
 
 TRACE_EVENT(ext4_discard_preallocations,
-	TP_PROTO(struct inode *inode),
+	TP_PROTO(struct inode *inode, unsigned int len, unsigned int needed),
 
-	TP_ARGS(inode),
+	TP_ARGS(inode, len, needed),
 
 	TP_STRUCT__entry(
-		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
+		__field(	dev_t,		dev		)
+		__field(	ino_t,		ino		)
+		__field(	unsigned int,	len		)
+		__field(	unsigned int,	needed		)
 
 	),
 
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
+		__entry->len	= len;
+		__entry->needed	= needed;
 	),
 
-	TP_printk("dev %d,%d ino %lu",
+	TP_printk("dev %d,%d ino %lu len: %u needed %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino)
+		  (unsigned long) __entry->ino, __entry->len,
+		  __entry->needed)
 );
 
 TRACE_EVENT(ext4_mb_discard_preallocations,
-- 
1.8.3.1

