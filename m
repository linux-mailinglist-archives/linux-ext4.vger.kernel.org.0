Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D974348535
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Mar 2021 00:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbhCXXUK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Mar 2021 19:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbhCXXTi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Mar 2021 19:19:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F8BC06175F
        for <linux-ext4@vger.kernel.org>; Wed, 24 Mar 2021 16:19:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g15so76817pfq.3
        for <linux-ext4@vger.kernel.org>; Wed, 24 Mar 2021 16:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JIedVl/g3G8bHogCXxJV3nRgFVlKnbdKZrZFQqsjYxo=;
        b=EF6v0LDmI9CPmxEcp0cchcwbmleT8Ls4Mrwl2ojBsUnlSooqGlPO3xWtJKlaNxHncf
         lteKXKA3DEJEg+s4rRYAI8+Jiv9crmBHsEFp6zzt0mqw1DAgHZFtPXuBHXeszFILnOOf
         Sx827r+qoKUtRtVS7jwVylLvh2G6jApN9t9Mpgu8lxHfZii3thbz+ICBYmK/Z2nZopBT
         aKWq5isqhIuKTmdF5e+qLXYxrSzEYuWZKugwTjVP/axVEAgJ40o+sACD9upxEC6z/40e
         3V+7g+2CHNWvkO4gIfgFq8dV8IANTi6Yl5b8fUeWTzOLzLta9ksjBD2TwVKzuykonuqa
         4u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIedVl/g3G8bHogCXxJV3nRgFVlKnbdKZrZFQqsjYxo=;
        b=WJNyCg2Wyj0F5/Nk5lWoSKVGLy74OrHUjYc4q78VoRjzvB45ptQDpWGlz+D0tjJwcy
         +qsz1Sj8SHaRGlwAVtOjokfPCRSqJ0Jhs4LrNkdJ0bPC3tn1cqOOvUrnB3JDHrzjerV0
         31WrV7y1o1Fd6YpXhWtDxGSXeuyTnZ4Rb342cdKmnQBIt7yY4oesqjsqX80OBGaWI93X
         qtg6t+ClH5NcOMlnmwrGQXFMBXh5/bYXrZmXIzF48msdCuXkZ79WrFeFEcXQbk7I0oQx
         17JC3+CZd4rsBGojVePtXVMfjqZpXijpfzbKXolrlOx3jYBVZHE4IQkgi/Sa8K2Dt+v6
         Ustw==
X-Gm-Message-State: AOAM533w3Rg+uqlJBQINf9RED4308rBov32kbPZpqIw9tQDH3QiIBbSx
        gOZYJLSRookd2g+JLgPOZ9fG+vLavq0=
X-Google-Smtp-Source: ABdhPJzT0vOjiEUihXgSXIWpsu7MA8k3gzWY8p2Z8yYCtLg7h3vRj/0kAQxnLelahs9QRPSkYts1Ag==
X-Received: by 2002:a17:902:c1d5:b029:e6:52e0:6bdd with SMTP id c21-20020a170902c1d5b02900e652e06bddmr6027431plc.49.1616627977103;
        Wed, 24 Mar 2021 16:19:37 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:f8fe:8e5d:4c9f:edfd])
        by smtp.googlemail.com with ESMTPSA id z3sm3629928pff.40.2021.03.24.16.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:19:36 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v5 6/6] ext4: add proc files to monitor new structures
Date:   Wed, 24 Mar 2021 16:19:16 -0700
Message-Id: <20210324231916.2515824-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
References: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds a new file "mb_structs_summary" which allows us to see
the summary of the new allocator structures added in this
series. Here's the sample output of file:

optimize_scan: 1
max_free_order_lists:
        list_order_0_groups: 0
        list_order_1_groups: 0
        list_order_2_groups: 0
        list_order_3_groups: 0
        list_order_4_groups: 0
        list_order_5_groups: 0
        list_order_6_groups: 0
        list_order_7_groups: 0
        list_order_8_groups: 0
        list_order_9_groups: 0
        list_order_10_groups: 0
        list_order_11_groups: 0
        list_order_12_groups: 0
        list_order_13_groups: 40
fragment_size_tree:
        tree_min: 16384
        tree_max: 32768
        tree_nodes: 40

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/mballoc.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/sysfs.c   |  2 ++
 3 files changed, 89 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5930c8cb5159..f6a36a0e07c1 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2822,6 +2822,7 @@ int __init ext4_fc_init_dentry_cache(void);
 
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
+extern const struct seq_operations ext4_mb_seq_structs_summary_ops;
 extern long ext4_mb_stats;
 extern long ext4_mb_max_to_scan;
 extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index cbf9a89c0ef5..0cd428bf2597 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2945,6 +2945,92 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+static void *ext4_mb_seq_structs_summary_start(struct seq_file *seq, loff_t *pos)
+{
+	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	unsigned long position;
+
+	read_lock(&EXT4_SB(sb)->s_mb_rb_lock);
+
+	if (*pos < 0 || *pos >= MB_NUM_ORDERS(sb) + 1)
+		return NULL;
+	position = *pos + 1;
+	return (void *) ((unsigned long) position);
+}
+
+static void *ext4_mb_seq_structs_summary_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	unsigned long position;
+
+	++*pos;
+	if (*pos < 0 || *pos >= MB_NUM_ORDERS(sb) + 1)
+		return NULL;
+	position = *pos + 1;
+	return (void *) ((unsigned long) position);
+}
+
+static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, void *v)
+{
+	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	unsigned long position = ((unsigned long) v);
+	struct ext4_group_info *grp;
+	struct rb_node *n;
+	unsigned int count, min, max;
+
+	position--;
+	if (position >= MB_NUM_ORDERS(sb)) {
+		seq_puts(seq, "fragment_size_tree:\n");
+		n = rb_first(&sbi->s_mb_avg_fragment_size_root);
+		if (!n) {
+			seq_puts(seq, "\ttree_min: 0\n\ttree_max: 0\n\ttree_nodes: 0\n");
+			return 0;
+		}
+		grp = rb_entry(n, struct ext4_group_info, bb_avg_fragment_size_rb);
+		min = grp->bb_fragments ? grp->bb_free / grp->bb_fragments : 0;
+		count = 1;
+		while (rb_next(n)) {
+			count++;
+			n = rb_next(n);
+		}
+		grp = rb_entry(n, struct ext4_group_info, bb_avg_fragment_size_rb);
+		max = grp->bb_fragments ? grp->bb_free / grp->bb_fragments : 0;
+
+		seq_printf(seq, "\ttree_min: %u\n\ttree_max: %u\n\ttree_nodes: %u\n",
+			   min, max, count);
+		return 0;
+	}
+
+	if (position == 0) {
+		seq_printf(seq, "optimize_scan: %d\n",
+			   test_opt2(sb, MB_OPTIMIZE_SCAN) ? 1 : 0);
+		seq_puts(seq, "max_free_order_lists:\n");
+	}
+	count = 0;
+	list_for_each_entry(grp, &sbi->s_mb_largest_free_orders[position],
+			    bb_largest_free_order_node)
+		count++;
+	seq_printf(seq, "\tlist_order_%u_groups: %u\n",
+		   (unsigned int)position, count);
+
+	return 0;
+}
+
+static void ext4_mb_seq_structs_summary_stop(struct seq_file *seq, void *v)
+{
+	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+
+	read_unlock(&EXT4_SB(sb)->s_mb_rb_lock);
+}
+
+const struct seq_operations ext4_mb_seq_structs_summary_ops = {
+	.start  = ext4_mb_seq_structs_summary_start,
+	.next   = ext4_mb_seq_structs_summary_next,
+	.stop   = ext4_mb_seq_structs_summary_stop,
+	.show   = ext4_mb_seq_structs_summary_show,
+};
+
 static struct kmem_cache *get_groupinfo_cache(int blocksize_bits)
 {
 	int cache_index = blocksize_bits - EXT4_MIN_BLOCK_LOG_SIZE;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 16b8a838f631..4a3b78684f83 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -525,6 +525,8 @@ int ext4_register_sysfs(struct super_block *sb)
 				&ext4_mb_seq_groups_ops, sb);
 		proc_create_single_data("mb_stats", 0444, sbi->s_proc,
 				ext4_seq_mb_stats_show, sb);
+		proc_create_seq_data("mb_structs_summary", 0444, sbi->s_proc,
+				&ext4_mb_seq_structs_summary_ops, sb);
 	}
 	return 0;
 }
-- 
2.31.0.291.g576ba9dcdaf-goog

