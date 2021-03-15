Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153E133C49C
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 18:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhCORhx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 13:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbhCORhf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Mar 2021 13:37:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665E0C06175F
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n17so12105437plc.7
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TROpCwYkPpzzXtABhBbK8kl/d2awuYmFIiV1Ljhd3gI=;
        b=RWOq7r45sMK887GcTZW6r/wYPNVHoinuhQIHkzLDvjC9WR/pmSkPaFNNRWDmTr6j2q
         i0x3xekhnsLUhLnzQl7IhPeSxN3Lq7qXwbnaUTbXqtvgZSCZh8iMSRNLNv6bGrC39ILL
         yLeBYjJ8FS251RHvM+wB+r0nFdRmTKCicgymaXGvlieQRndt7guJDEosFLvbNvKlmyO8
         i+NCFYfdgGffaYXP6vRAPOJuhwTvyW5N1PMkwawfqDKB5/TzDIOmz8hi+YHwNSwCMrpw
         8LPAe1STZf0tIkopUDQjmjKlDv3aNrJMcvdT0uwRg0s4bJ+O+NB0ZTg2CcnRuHKTvYJe
         RVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TROpCwYkPpzzXtABhBbK8kl/d2awuYmFIiV1Ljhd3gI=;
        b=dWSEenrHnxmKTOgPBZEGbhQVNu3+awxX5YgI9D7bfGDcc850j3J0S8cXgJtDHCwX8c
         RNrXXgXJ5K3ey4zifXoetNM93UEx9eaBq+hzt+JJ22TPS3b+wHGkEcVd84HWCsVjVnmZ
         3PGfncMoQf5sRR3kAlRtL4Ejh+h8/Ngb+hvbrv+j2H+kVTo5pNKirbmfPNrYX/kyHVRk
         pQa6uYl2sn7R7nb3TmhWvzle7Zr51mkyVW4LT1aQWV9XNIhCsT3Bg0amckpKgGnc+ykZ
         fzQWzMkHiu6LnVfggjdQDfbnmhlIGjG16eBhtzMMkhNWbwCzdUbSLvrkgUWrLlqDVttY
         Csug==
X-Gm-Message-State: AOAM530RNTkb89rUeTwbzW1h4uN0bFQszCr2JE5mODZoxbVsL0Vk1Szr
        1j6K/rqTwTzZtq2Fv0FMhgLb9qLhKIk=
X-Google-Smtp-Source: ABdhPJwvTWqS0xiABiGJr9lUCFd775tnEgQyohm/jinY0AywCHU87adUvEU4kwMD1EFh/YGo2buzow==
X-Received: by 2002:a17:90b:ece:: with SMTP id gz14mr202314pjb.192.1615829854550;
        Mon, 15 Mar 2021 10:37:34 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:1025:7e5a:33cc:4e9c])
        by smtp.googlemail.com with ESMTPSA id p190sm13520178pga.78.2021.03.15.10.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:37:33 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 6/6] ext4: add proc files to monitor new structures
Date:   Mon, 15 Mar 2021 10:37:16 -0700
Message-Id: <20210315173716.360726-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
References: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
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
index fb53ec1e1d37..7ce1d1283fd9 100644
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
2.31.0.rc2.261.g7f71774620-goog

