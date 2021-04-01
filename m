Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AFC351857
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhDARpo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 13:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbhDARiP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 13:38:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8837DC0319CF
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 10:21:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so3454422pjb.0
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VJEdpvnYm1xf11CPx6XTw/UhbVWV6pFupr1hw4M5OI=;
        b=kb2ujxhQHHiVQ7u7IWb8VHPQyHl+BxGWl34bQQkmpsUmaYN0EEXVV/RC4oTF7NJwsx
         7hcFNlcqzObyiixcPh2V6T12gzrJeEcdRLY9dkgY+TYUjZZxOesDv+dKVKdAZSuaVJ8p
         EUgX5oArXqJPSola5eg7L6S3HMGxCL8Gp7WlR1GybWnMS2XDM3cLy1J0NztAZ9w/qICE
         FtJrC4nYFSldkEog30SHYljv35EBL6dVUum8vVrUdiPWySkcmPCAsRhKDhK/lANSrF9R
         0uuWkAW14Kj5Mt25nrR9ViIdaTCgiu0562G88n1teoTUrN5cYKrqYSiOpgD+uoP5y+KY
         bm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VJEdpvnYm1xf11CPx6XTw/UhbVWV6pFupr1hw4M5OI=;
        b=m1iRTYWGybyLKsxFcOakgtk1eIZi+cqkBLlMqbCw9gpXPZiE+Tmidj8YWFgbxGZb5N
         etmN3KUg4p5VfZygabtcJzBdI1J2gIBiziMFk4mCXJZFfE+Ofo8U4LpJdx8kzKN9fuAO
         XcMbBN4vVimKoGIAsmtrS69CUuSI6XvRtFmzSo/ukV1/KAk+b39Mi5X8LrRJ6w0TXqXN
         o/GZoqlE5AAxzOa2zt+lKodJeer0YX2xFMcshH+3C+SmqJgAHJWdK5MlqavnAx0QV2Ww
         oPnI2w5dkrTtc/PR01OrzCRszZU029Ba4SVfQ3YadXqVepY65/pzlcEuOedJnSNDwfPo
         89og==
X-Gm-Message-State: AOAM533SeG+3PavJ5YX1yF34VITUDlmjEY3W0Jw60FaFSVAF7vpcB9vR
        r7t+z0jJC3RRM0/4IYe2tnn7IedNsqs=
X-Google-Smtp-Source: ABdhPJycB0m+qW/yYKhKp5ON/VB/0yjYKyNrV8Jow2w9+FJr4XGj8J/5lRdUu90P+fMIiICq44SYbQ==
X-Received: by 2002:a17:90a:281:: with SMTP id w1mr9340618pja.201.1617297704615;
        Thu, 01 Apr 2021 10:21:44 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:455f:9418:5b00:693])
        by smtp.googlemail.com with ESMTPSA id w26sm5751766pfn.33.2021.04.01.10.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:21:44 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v6 6/7] ext4: add proc files to monitor new structures
Date:   Thu,  1 Apr 2021 10:21:28 -0700
Message-Id: <20210401172129.189766-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
References: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
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
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/mballoc.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/sysfs.c   |  2 ++
 3 files changed, 89 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1029716928c2..9a5afe9d2310 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2824,6 +2824,7 @@ int __init ext4_fc_init_dentry_cache(void);
 
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
+extern const struct seq_operations ext4_mb_seq_structs_summary_ops;
 extern long ext4_mb_stats;
 extern long ext4_mb_max_to_scan;
 extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index bb4da7c4d113..e6441f1d94c7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2963,6 +2963,92 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
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
index 67e2f70cb84f..eddbefe94e49 100644
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

