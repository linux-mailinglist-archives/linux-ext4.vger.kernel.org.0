Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E450326786
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 20:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBZThx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 14:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhBZThr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Feb 2021 14:37:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD10C06178A
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:30 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w18so6931978pfu.9
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=49EDlZVVSxTK87jM2E5PpJbXAaD48xgczLduYkRGSyQ=;
        b=ddVTnTz7aP/3eS/Q+ykUHZDHGfoJBi1LTmwd8ddYhGHSFd7ZIcaZC2qMcPk2pWn66Y
         rAfwgMyvcaGyVY0MMSQcDNuWL100T0/aTDegZyTRjCSWpYhnrKFt8KpJp71wulvetIJu
         irl0nVEZ23ZKetAEmia0xCcfW9Bvxxv9wJy6NLPSGP4L3ikgU/ERkqO0tRX1lKwl0mxH
         Wn9fvpeQpMe5xC6565P+d5xxRiINBy1eFciio3VQMt3RNR0x/9hqrfNe/uH7PMhVHXiO
         PymTHd5CxZYzoVoUKLyf3jDxm+afw+Y3toObODzTJToIxOYr0MnnzZrIGbJInUBqlJuZ
         xxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=49EDlZVVSxTK87jM2E5PpJbXAaD48xgczLduYkRGSyQ=;
        b=kHK9iv6wF/P69RmyWK2JCiuwFmaeIBO3ghz8A5Jit0Dy9hUQtwn3Geo/6DKY1UMptI
         PE6ka10BPM/iecHmiHh1w8RxXV61Qn7qWrI53ohV+Lzf1BA2rThS7j/Ty9CC2A26X3hi
         lZdFCwsxv4oTXL+8vFN+lqmdoyORldgFVqL5swoM0noUG4G4ft/BPXJxk+l4gbFjekUY
         dgvzxNhxAXMAC9CVrM6/HIXFNyLHTmNT6En/s2jHdk7YKQACbsH6n3Pz9X/FZpPoON4F
         DMwQm9C5cPKzprHcEMrLRZon6VoUVgZ/0fRi8DDov6foY+WrQK4Yp40rvNz9qVpyhozD
         mkMA==
X-Gm-Message-State: AOAM531QHrFu7bu8I4duJqdOKmVdEdTcUm2QgSVeONFHkX3RncFhbXzi
        oxFghralVQV3r6lsR2LIFZqQ5ItD3To=
X-Google-Smtp-Source: ABdhPJzQnYY03o6oDGxExeZvhfsI51EjS+AWPh6DitMf8nWW0ori+UQlu6KN3t2I72EXKzEV5aPQBg==
X-Received: by 2002:a63:4b21:: with SMTP id y33mr4221058pga.73.1614368189578;
        Fri, 26 Feb 2021 11:36:29 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:e88c:d103:27dc:612d])
        by smtp.googlemail.com with ESMTPSA id x129sm2935041pfc.96.2021.02.26.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 11:36:29 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger@dilger.ca,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 5/5] ext4: add proc files to monitor new structures
Date:   Fri, 26 Feb 2021 11:36:12 -0800
Message-Id: <20210226193612.1199321-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
References: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
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
index d792418c39ca..81209a749e75 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2818,6 +2818,7 @@ int __init ext4_fc_init_dentry_cache(void);
 
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
+extern const struct seq_operations ext4_mb_seq_structs_summary_ops;
 extern long ext4_mb_stats;
 extern long ext4_mb_max_to_scan;
 extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index bcfd849bc61e..4378b36be8b9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2910,6 +2910,92 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
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
2.30.1.766.gb4fecdf3b7-goog

