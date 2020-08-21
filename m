Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8F24C9B9
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Aug 2020 03:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHUBzx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Aug 2020 21:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgHUBzh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Aug 2020 21:55:37 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F95C061387
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:37 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so265556pgf.0
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/a+jf5V1NS62ktK9skuew7zctJMbM5+wgF7KkJObv6A=;
        b=Wjq6fyjz8ZPUJmvozb60jEw1EI+MmnwQ2EGUojO1fZiG2Q15bMiWqOqpmzi8Dt/8jT
         iloZ1RAR5fUBZd4taY+jI6SVY7ozGM7GDrXd2hhMBCKzpWACFwC2QIO5EVuCcbCyjftc
         A5XH2z5TDCVZ19n6UsbhJF+gn9FGCoXT84uRAyedn6TW6OWKc/QCovjuXckSqeHRghRu
         2W4JmI7LIjZfwG/celjLDulOi5iqR6VzQq+jjoODtgZ1mTP/9t4is0bjL3q/TwbVptam
         WtCgdTOt4Reibx+WLaC8HXXEk5BUCoIchEr23jUnTah8tf7PIEzkY4R2sxxPF9UjBppD
         XBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/a+jf5V1NS62ktK9skuew7zctJMbM5+wgF7KkJObv6A=;
        b=JDuVo23BeVSykZtGLHhi44jiEQ8q1FJDXqPuahNoFiw/82GsWhs8T65/EQhTbIED3i
         ztSsBYc3GF07Jugbiyols3T8TTUuB0ff37yX8eWj53jZ7Az2q1ecmKuwNWCUfmIYW0a6
         ioEkqas+uoSJ6uwKPaC5hR6hh8KWmstvjIxIrvfcFdoQxEOQ0uwkm0PMHjqVoDiLlklK
         RJm38ydz+4IC0ihjeYGLnQX1HpdupfuPMKnv8HRKtf1ti1RlYUUMVygCKmoFOvd7+yeX
         5UkW0WJ0dYWxbrWyPLuu1dNnCJoSkmFLEL/WKFc0VhTNmmit4hBBv6y0NXrVDAiuK8vs
         MzAw==
X-Gm-Message-State: AOAM5305Yj5EA/2u8W6zrWWZBMMHsUTFgquW4wWHOVZPgWhWKV1BXqLV
        7tEoDF508TOkWt97QUcm17qEs0avuEQ=
X-Google-Smtp-Source: ABdhPJzLB3EKuaE6EXjBqOpgHK6FJWNlitYqxyO7k12GgduKQYIF34MYavPjjxsCadExSu5wnS95yA==
X-Received: by 2002:aa7:9ac2:: with SMTP id x2mr561895pfp.57.1597974936620;
        Thu, 20 Aug 2020 18:55:36 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o15sm370191pfu.167.2020.08.20.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 18:55:35 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v2 6/9] ext4: add memory usage tracker for freespace trees
Date:   Thu, 20 Aug 2020 18:55:20 -0700
Message-Id: <20200821015523.1698374-7-harshads@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821015523.1698374-1-harshads@google.com>
References: <20200821015523.1698374-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Freespace trees can occupy a lot of memory with as the fragmentation
increases. This patch adds a sysfs file to monitor the memory usage of
the freespace tree allocator. Also, added a sysfs config to control
maximum memory that the allocator can use. If the allocator exceeds
this threshold, file system enters "FRSP_MEM_CRUNCH" state. The next
patch in the series performs LRU eviction when this state is reached.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h    |  8 ++++++++
 fs/ext4/mballoc.c | 20 ++++++++++++++++++++
 fs/ext4/mballoc.h |  4 ++++
 fs/ext4/sysfs.c   | 11 +++++++++++
 4 files changed, 43 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 15e6ce9f1afa..93bf2fe35cf1 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1223,6 +1223,12 @@ struct ext4_inode_info {
 						    * allocator off)
 						    */
 
+#define EXT4_MOUNT2_FRSP_MEM_CRUNCH	0x00000040 /*
+						    * Freespace tree allocator
+						    * is in a tight memory
+						    * situation.
+						    */
+
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
 #define set_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt |= \
@@ -1607,6 +1613,8 @@ struct ext4_sb_info {
 	atomic_t s_mb_num_frsp_trees_cached;
 	struct list_head s_mb_uncached_trees;
 	u32 s_mb_frsp_cache_aggression;
+	atomic_t s_mb_num_fragments;
+	u32 s_mb_frsp_mem_limit;
 
 	/* workqueue for reserved extent conversions (buffered io) */
 	struct workqueue_struct *rsv_conversion_wq;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1da63afdbb3d..b28b7fb0506e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -869,6 +869,7 @@ void ext4_mb_frsp_print_tree_len(struct super_block *sb,
 static struct ext4_frsp_node *ext4_mb_frsp_alloc_node(struct super_block *sb)
 {
 	struct ext4_frsp_node *node;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
 	node = kmem_cache_alloc(ext4_freespace_node_cachep, GFP_NOFS);
 	if (!node)
@@ -877,13 +878,31 @@ static struct ext4_frsp_node *ext4_mb_frsp_alloc_node(struct super_block *sb)
 	RB_CLEAR_NODE(&node->frsp_node);
 	RB_CLEAR_NODE(&node->frsp_len_node);
 
+	atomic_inc(&sbi->s_mb_num_fragments);
+
+	if (sbi->s_mb_frsp_mem_limit &&
+		atomic_read(&sbi->s_mb_num_fragments) >
+		EXT4_FRSP_MEM_LIMIT_TO_NUM_NODES(sb))
+		set_opt2(sb, FRSP_MEM_CRUNCH);
+	else
+		clear_opt2(sb, FRSP_MEM_CRUNCH);
+
+
 	return node;
 }
 
 static void ext4_mb_frsp_free_node(struct super_block *sb,
 		struct ext4_frsp_node *node)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
 	kmem_cache_free(ext4_freespace_node_cachep, node);
+	atomic_dec(&sbi->s_mb_num_fragments);
+
+	if (!sbi->s_mb_frsp_mem_limit ||
+		atomic_read(&sbi->s_mb_num_fragments) <
+		EXT4_FRSP_MEM_LIMIT_TO_NUM_NODES(sb))
+		clear_opt2(sb, FRSP_MEM_CRUNCH);
 }
 
 /* Evict a tree from memory */
@@ -1607,6 +1626,7 @@ int ext4_mb_init_freespace_trees(struct super_block *sb)
 	}
 	rwlock_init(&sbi->s_mb_frsp_lock);
 	atomic_set(&sbi->s_mb_num_frsp_trees_cached, 0);
+	atomic_set(&sbi->s_mb_num_fragments, 0);
 
 	return 0;
 }
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 1fcdd3e6f7d5..6cfb228e4da2 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -92,6 +92,10 @@ struct ext4_frsp_node {
 	struct rb_node frsp_node;
 	struct rb_node frsp_len_node;
 };
+
+#define EXT4_FRSP_MEM_LIMIT_TO_NUM_NODES(__sb)				\
+	((sbi->s_mb_frsp_mem_limit / sizeof(struct ext4_frsp_node)))
+
 struct ext4_free_data {
 	/* this links the free block information from sb_info */
 	struct list_head		efd_list;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index bfabb799fa45..19301b10944b 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include "mballoc.h"
 #include <linux/time.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
@@ -24,6 +25,7 @@ typedef enum {
 	attr_session_write_kbytes,
 	attr_lifetime_write_kbytes,
 	attr_reserved_clusters,
+	attr_frsp_tree_usage,
 	attr_inode_readahead,
 	attr_trigger_test_error,
 	attr_first_error_time,
@@ -208,6 +210,7 @@ EXT4_ATTR_FUNC(delayed_allocation_blocks, 0444);
 EXT4_ATTR_FUNC(session_write_kbytes, 0444);
 EXT4_ATTR_FUNC(lifetime_write_kbytes, 0444);
 EXT4_ATTR_FUNC(reserved_clusters, 0644);
+EXT4_ATTR_FUNC(frsp_tree_usage, 0444);
 
 EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
 		 ext4_sb_info, s_inode_readahead_blks);
@@ -248,6 +251,7 @@ EXT4_ATTR(last_error_time, 0444, last_error_time);
 EXT4_ATTR(journal_task, 0444, journal_task);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
+EXT4_RW_ATTR_SBI_UI(mb_frsp_max_mem, s_mb_frsp_mem_limit);
 
 static unsigned int old_bump_val = 128;
 EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
@@ -257,6 +261,7 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(session_write_kbytes),
 	ATTR_LIST(lifetime_write_kbytes),
 	ATTR_LIST(reserved_clusters),
+	ATTR_LIST(frsp_tree_usage),
 	ATTR_LIST(inode_readahead_blks),
 	ATTR_LIST(inode_goal),
 	ATTR_LIST(mb_stats),
@@ -296,6 +301,7 @@ static struct attribute *ext4_attrs[] = {
 #endif
 	ATTR_LIST(mb_prefetch),
 	ATTR_LIST(mb_prefetch_limit),
+	ATTR_LIST(mb_frsp_max_mem),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4);
@@ -378,6 +384,11 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 		return snprintf(buf, PAGE_SIZE, "%llu\n",
 				(unsigned long long)
 				atomic64_read(&sbi->s_resv_clusters));
+	case attr_frsp_tree_usage:
+		return snprintf(buf, PAGE_SIZE, "%llu\n",
+				(unsigned long long)
+				atomic_read(&sbi->s_mb_num_fragments) *
+				sizeof(struct ext4_frsp_node));
 	case attr_inode_readahead:
 	case attr_pointer_ui:
 		if (!ptr)
-- 
2.28.0.297.g1956fa8f8d-goog

