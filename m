Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9CF23D70F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 08:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgHFG5H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgHFG5E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 02:57:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8B3C061574
        for <linux-ext4@vger.kernel.org>; Wed,  5 Aug 2020 23:57:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ha11so5988281pjb.1
        for <linux-ext4@vger.kernel.org>; Wed, 05 Aug 2020 23:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=ElARSV8Ru7TsYvNM5rr/tFZ8uoj2r/W11sIvgJnBVpI=;
        b=uBpjN8wHYb61hGneBYGcDukDne/pF9pB7CGcJ0HTxa705N8VRjjvawU0DJ3Ro9YGd9
         iHgbfoCX8pSvbM7/unJ8h7SPllTL0HIjUcBv3jeAF6hTCIpVnX9A+DGkbmT3tIhhp6Gh
         mjuaP+Hdor+cdZ5jOTaVPA7lDZykpeSwRE6UnGphZV9V2ZaWAqVnDjSWQzq4b0jHieV3
         CMlOK74t/BoC+/QPtmczj4i+01v8HKpsHsMR0J90hN3rbzPfh/esQKSPNN6vv8UzM6eX
         p56/xw5C8CMnQ5e9ssBfD8SNfc7OTmUhsfWc01J8u4M+Np7AO2h308h50fM2LXSItoGV
         BG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=ElARSV8Ru7TsYvNM5rr/tFZ8uoj2r/W11sIvgJnBVpI=;
        b=N/sXEkeSZhu2uUfOtf8AZwvcSCevQlseLlszKvgusWc41VBhUR20UYFvu9LSXf3qhs
         CNACHMWyTDFDjgmXsBjoVqpylDdnil9ssDWhhRJ5aDjrk4TaJ+I/Lt+Zk6NWWnCP2zJa
         Ju1y57HtAimm8hgyxF/gPNxk9hH8SgjzSHCKUUFwgJC+lb2v6rIuceCdXBVs7t/MqaiS
         rseyygU0uTYCp53EO9K/pr2gVPS6aULL2oQaUijKya5ANzlPWYY1R5YOHJDddMIgRQ4i
         WhlTmF8993zEwXqXbGXm/pPiMQKT1KgwcGe4WM93xxFx85i1Q4ISaCW4WSTVsuHTJxPB
         xrqw==
X-Gm-Message-State: AOAM533jMJkUnH/KHhp5tIs7s+c8xOLa7LRdXrIrm/34phE0LkgJt3Lz
        bvtcz3F+2vc8b774WKBBM3/JBrsitrc=
X-Google-Smtp-Source: ABdhPJzv9MGg7Yb3Jc+qB0iG4Vfz1dviqkObVQOa0pbzB9p8ST629zhFWd2rj6TOZf21R9OAXc7PbQ==
X-Received: by 2002:a17:902:9f94:: with SMTP id g20mr4909839plq.14.1596697021390;
        Wed, 05 Aug 2020 23:57:01 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.45])
        by smtp.gmail.com with ESMTPSA id r6sm5465959pjd.1.2020.08.05.23.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 23:57:01 -0700 (PDT)
To:     adilger.kernel@dilger.ca, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v3 2/2] ext4: limit the length of per-inode prealloc list
Message-ID: <1b882359-7adf-9d12-796e-f0549a8cce7d@gmail.com>
Date:   Thu, 6 Aug 2020 14:56:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the scenario of writing sparse files, the Per-inode prealloc list may
be very long, resulting in high overhead for ext4_mb_use_preallocated().
To circumvent this problem, we limit the maximum length of per-inode
prealloc list to 512 and allow users to modify it.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/ext4.h              |  3 ++-
 fs/ext4/extents.c           | 10 ++++----
 fs/ext4/file.c              |  2 +-
 fs/ext4/indirect.c          |  2 +-
 fs/ext4/inode.c             |  6 ++---
 fs/ext4/ioctl.c             |  2 +-
 fs/ext4/mballoc.c           | 57 +++++++++++++++++++++++++++++++++++++++++----
 fs/ext4/mballoc.h           |  4 ++++
 fs/ext4/move_extent.c       |  4 ++--
 fs/ext4/super.c             |  2 +-
 fs/ext4/sysfs.c             |  2 ++
 include/trace/events/ext4.h | 14 ++++++-----
 12 files changed, 83 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 42f5060..68e0ebe 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1501,6 +1501,7 @@ struct ext4_sb_info {
     unsigned int s_mb_stats;
     unsigned int s_mb_order2_reqs;
     unsigned int s_mb_group_prealloc;
+    unsigned int s_mb_max_inode_prealloc;
     unsigned int s_max_dir_size_kb;
     /* where last allocation was done - for stream allocation */
     unsigned long s_mb_last_group;
@@ -2651,7 +2652,7 @@ extern int ext4_init_inode_table(struct super_block *sb,
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
-    ext4_discard_preallocations(inode);
+    ext4_discard_preallocations(inode, 0);
     up_write(&EXT4_I(inode)->i_data_sem);
     *dropped = 1;
     return 0;
@@ -4272,7 +4272,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
              * not a good idea to call discard here directly,
              * but otherwise we'd need to call it every free().
              */
-            ext4_discard_preallocations(inode);
+            ext4_discard_preallocations(inode, 0);
             if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
                 fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
             ext4_free_blocks(handle, inode, NULL, newblock,
@@ -5299,7 +5299,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
     }
 
     down_write(&EXT4_I(inode)->i_data_sem);
-    ext4_discard_preallocations(inode);
+    ext4_discard_preallocations(inode, 0);
 
     ret = ext4_es_remove_extent(inode, punch_start,
                     EXT_MAX_BLOCKS - punch_start);
@@ -5313,7 +5313,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
         up_write(&EXT4_I(inode)->i_data_sem);
         goto out_stop;
     }
-    ext4_discard_preallocations(inode);
+    ext4_discard_preallocations(inode, 0);
 
     ret = ext4_ext_shift_extents(inode, handle, punch_stop,
                      punch_stop - punch_start, SHIFT_LEFT);
@@ -5445,7 +5445,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
         goto out_stop;
 
     down_write(&EXT4_I(inode)->i_data_sem);
-    ext4_discard_preallocations(inode);
+    ext4_discard_preallocations(inode, 0);
 
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
-        ext4_discard_preallocations(inode);
+        ext4_discard_preallocations(inode, 0);
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
-    ext4_discard_preallocations(inode);
+    ext4_discard_preallocations(inode, 0);
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
-        ext4_discard_preallocations(inode);
+        ext4_discard_preallocations(inode, 0);
 }
 
 static int __check_block_validity(struct inode *inode, const char *func,
@@ -4056,7 +4056,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
     if (stop_block > first_block) {
 
         down_write(&EXT4_I(inode)->i_data_sem);
-        ext4_discard_preallocations(inode);
+        ext4_discard_preallocations(inode, 0);
 
         ret = ext4_es_remove_extent(inode, first_block,
                         stop_block - first_block);
@@ -4211,7 +4211,7 @@ int ext4_truncate(struct inode *inode)
 
     down_write(&EXT4_I(inode)->i_data_sem);
 
-    ext4_discard_preallocations(inode);
+    ext4_discard_preallocations(inode, 0);
 
     if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
         err = ext4_ext_truncate(handle, inode);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 999cf6a..a5fcc23 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -202,7 +202,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
     reset_inode_seed(inode);
     reset_inode_seed(inode_bl);
 
-    ext4_discard_preallocations(inode);
+    ext4_discard_preallocations(inode, 0);
 
     err = ext4_mark_inode_dirty(handle, inode);
     if (err < 0) {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 4f21f34..28a139f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2736,6 +2736,7 @@ int ext4_mb_init(struct super_block *sb)
     sbi->s_mb_stats = MB_DEFAULT_STATS;
     sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
     sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
+    sbi->s_mb_max_inode_prealloc = MB_DEFAULT_MAX_INODE_PREALLOC;
     /*
      * The default group preallocation is 512, which for 4k block
      * sizes translates to 2 megabytes.  However for bigalloc file
@@ -4103,7 +4104,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
  *
  * FIXME!! Make sure it is valid at all the call sites
  */
-void ext4_discard_preallocations(struct inode *inode)
+void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
 {
     struct ext4_inode_info *ei = EXT4_I(inode);
     struct super_block *sb = inode->i_sb;
@@ -4121,15 +4122,18 @@ void ext4_discard_preallocations(struct inode *inode)
 
     mb_debug(sb, "discard preallocation for inode %lu\n",
          inode->i_ino);
-    trace_ext4_discard_preallocations(inode);
+    trace_ext4_discard_preallocations(inode,  needed);
 
     INIT_LIST_HEAD(&list);
 
+    if (needed == 0)
+        needed = UINT_MAX;
+
 repeat:
     /* first, collect all pa's in the inode */
     spin_lock(&ei->i_prealloc_lock);
-    while (!list_empty(&ei->i_prealloc_list)) {
-        pa = list_entry(ei->i_prealloc_list.next,
+    while (!list_empty(&ei->i_prealloc_list) && needed) {
+        pa = list_entry(ei->i_prealloc_list.prev,
                 struct ext4_prealloc_space, pa_inode_list);
         BUG_ON(pa->pa_obj_lock != &ei->i_prealloc_lock);
         spin_lock(&pa->pa_lock);
@@ -4150,6 +4154,7 @@ void ext4_discard_preallocations(struct inode *inode)
             spin_unlock(&pa->pa_lock);
             list_del_rcu(&pa->pa_inode_list);
             list_add(&pa->u.pa_tmp_list, &list);
+            needed--;
             continue;
         }
 
@@ -4549,10 +4554,42 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
 }
 
 /*
+ * if per-inode prealloc list is too long, trim some PA
+ */
+static void
+ext4_mb_trim_inode_pa(struct inode *inode)
+{
+    struct ext4_inode_info *ei = EXT4_I(inode);
+    struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+    struct ext4_prealloc_space *pa;
+    int count = 0, delta;
+
+    rcu_read_lock();
+    list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) {
+        spin_lock(&pa->pa_lock);
+        if (pa->pa_deleted) {
+            spin_unlock(&pa->pa_lock);
+            continue;
+        }
+        count++;
+        spin_unlock(&pa->pa_lock);
+    }
+    rcu_read_unlock();
+
+    delta = (sbi->s_mb_max_inode_prealloc >> 2) + 1;
+    if (count > sbi->s_mb_max_inode_prealloc + delta) {
+        count -= sbi->s_mb_max_inode_prealloc;
+        ext4_discard_preallocations(inode, count);
+    }
+}
+
+/*
  * release all resource we used in allocation
  */
 static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 {
+    struct inode *inode = ac->ac_inode;
+    struct ext4_inode_info *ei = EXT4_I(inode);
     struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
     struct ext4_prealloc_space *pa = ac->ac_pa;
     if (pa) {
@@ -4578,6 +4615,17 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
                 ext4_mb_add_n_trim(ac);
             }
         }
+
+        if (pa->pa_type == MB_INODE_PA) {
+            /*
+             * treat per-inode prealloc list as a lru list, then try
+             * to trim the least recently used PA.
+             */
+            spin_lock(pa->pa_obj_lock);
+            list_move(&ei->i_prealloc_list, &pa->pa_inode_list);
+            spin_unlock(pa->pa_obj_lock);
+        }
+
         ext4_mb_put_pa(ac, ac->ac_sb, pa);
     }
     if (ac->ac_bitmap_page)
@@ -4587,6 +4635,7 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
     if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
         mutex_unlock(&ac->ac_lg->lg_mutex);
     ext4_mb_collect_stats(ac);
+    ext4_mb_trim_inode_pa(inode);
     return 0;
 }
 
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 6b4d17c..e75b474 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -73,6 +73,10 @@
  */
 #define MB_DEFAULT_GROUP_PREALLOC    512
 
+/*
+ * maximum length of inode prealloc list
+ */
+#define MB_DEFAULT_MAX_INODE_PREALLOC    512
 
 struct ext4_free_data {
     /* this links the free block information from sb_info */
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 1ed86fb..0d601b8 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -686,8 +686,8 @@
 
 out:
     if (*moved_len) {
-        ext4_discard_preallocations(orig_inode);
-        ext4_discard_preallocations(donor_inode);
+        ext4_discard_preallocations(orig_inode, 0);
+        ext4_discard_preallocations(donor_inode, 0);
     }
 
     ext4_ext_drop_refs(path);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 330957e..8ce61f3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1216,7 +1216,7 @@ void ext4_clear_inode(struct inode *inode)
 {
     invalidate_inode_buffers(inode);
     clear_inode(inode);
-    ext4_discard_preallocations(inode);
+    ext4_discard_preallocations(inode, 0);
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
+    ATTR_LIST(mb_max_inode_prealloc),
     ATTR_LIST(max_writeback_mb_bump),
     ATTR_LIST(extent_max_zeroout_kb),
     ATTR_LIST(trigger_fs_error),
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index cc41d69..61736d8 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -746,24 +746,26 @@
 );
 
 TRACE_EVENT(ext4_discard_preallocations,
-    TP_PROTO(struct inode *inode),
+    TP_PROTO(struct inode *inode, unsigned int needed),
 
-    TP_ARGS(inode),
+    TP_ARGS(inode, needed),
 
     TP_STRUCT__entry(
-        __field(    dev_t,    dev            )
-        __field(    ino_t,    ino            )
+        __field(    dev_t,        dev        )
+        __field(    ino_t,        ino        )
+        __field(    unsigned int,    needed        )
 
     ),
 
     TP_fast_assign(
         __entry->dev    = inode->i_sb->s_dev;
         __entry->ino    = inode->i_ino;
+        __entry->needed    = needed;
     ),
 
-    TP_printk("dev %d,%d ino %lu",
+    TP_printk("dev %d,%d ino %lu needed %u",
           MAJOR(__entry->dev), MINOR(__entry->dev),
-          (unsigned long) __entry->ino)
+          (unsigned long) __entry->ino, __entry->needed)
 );
 
 TRACE_EVENT(ext4_mb_discard_preallocations,
-- 
1.8.3.1

