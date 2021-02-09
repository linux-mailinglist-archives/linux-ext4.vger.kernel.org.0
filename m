Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E2A3157DE
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Feb 2021 21:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhBIUmI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Feb 2021 15:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbhBIUhA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Feb 2021 15:37:00 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F44C0698D8
        for <linux-ext4@vger.kernel.org>; Tue,  9 Feb 2021 12:29:11 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o38so1704274pgm.9
        for <linux-ext4@vger.kernel.org>; Tue, 09 Feb 2021 12:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3bcMPVMaB084N3tKlKrXHspi/RHe+qo2Ads4pGrgJY=;
        b=QM4ll7Bywls7jajJApeMXmZPtU2vJLBwFqoLUeODQbpbBIuHiToW385FWBcqX3HbhX
         8ERzAD15iTUBgY5Dki2TQD5YA/3WOqAEo1ikDmkppRbN1tHDinYcXPsP7MJbZDVub3CD
         qMsP2FKHhPmh15m8YzTAfpVZxmN0rcEH2Cp7iWkNi11bNyIcuoVrK/KUZgua3vO0ea+x
         c0uYwR7YVH/m1FF7pATEZd1Hw4+qEK5h+bErW94qI9lAwmQRgQUnHYBLSlOwhW5aD5bL
         C0dlpmQT35zfE9Y4p+pxlReumQ+5Wxhgh9JTx4ZHGaXIr0TEa6XmEHkN9RMtg/2vlHSd
         NLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3bcMPVMaB084N3tKlKrXHspi/RHe+qo2Ads4pGrgJY=;
        b=ZCyirDo+37ZFNjsQzYT5LxjM06iLztmkLGdEsbglrCTCV6hvf9wLU+Sw8xUFI5FcRw
         +XD5ViBnetEyVN95271aPMORslAVlkWQj3+tivSLTtgvPwYsyWWIfr48XlqBVaWVTMO/
         tZEcNcLFpqp3UhzUO9cULsg996wBHHHqLkKwm5IONzDfbz/mmWohGm/Yxog6m+WdFP3T
         KX/CziZn7Knb1ck6C+34Rb+L9Nd9HRNOUgNMFdo49ZafY2VABuJo1e0g2ycea7L17reu
         noUetGel2AJLE5q8E4EQjvTx6hBrkvzqEYkLgI2n4peyjE7Lz4Cq4fTaibHAfZm/E4N4
         wdWA==
X-Gm-Message-State: AOAM530dnImpPsKhTNSd4WDrc7FcMQXxAHAQ7Bax0GE7HMoaOPL6iD/Q
        2ysLYPtm6na7p3R4uczRorPnr6e/RbA=
X-Google-Smtp-Source: ABdhPJxj0CBJcCn1wKanlivVKz4+O31Qhd2b1H1MscR05FrhlMa4OS5KG+XcQiyVlD+WXSKXrK+t3w==
X-Received: by 2002:a65:5b47:: with SMTP id y7mr23370440pgr.221.1612902551015;
        Tue, 09 Feb 2021 12:29:11 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:1d7c:b2d9:c196:949c])
        by smtp.googlemail.com with ESMTPSA id p12sm3325827pju.35.2021.02.09.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:29:09 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, bzzz@whamcloud.com, artem.blagodarenko@gmail.com,
        sihara@ddn.com, adilger@dilger.ca,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 5/5] ext4: add proc files to monitor new structures
Date:   Tue,  9 Feb 2021 12:28:57 -0800
Message-Id: <20210209202857.4185846-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds a new file "mb_structs_summary" which allows us to see the
summary of the new allocator structures added in this series.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/mballoc.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/sysfs.c   |  2 ++
 3 files changed, 87 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0601c997c87f..39830c07c27e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2817,6 +2817,7 @@ int __init ext4_fc_init_dentry_cache(void);
 
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
+extern const struct seq_operations ext4_mb_seq_structs_summary_ops;
 extern long ext4_mb_stats;
 extern long ext4_mb_max_to_scan;
 extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 63562f5f42f1..d9cb74787a47 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2864,6 +2864,90 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
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
+	int count, min, max;
+
+	position--;
+
+	if (position >= MB_NUM_ORDERS(sb)) {
+		seq_puts(seq, "Tree\n");
+		n = rb_first(&sbi->s_mb_avg_fragment_size_root);
+		if (!n) {
+			seq_puts(seq, "<Empty>\n");
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
+		seq_printf(seq, "Min: %d, Max: %d, Num Nodes: %d\n",
+			   min, max, count);
+		return 0;
+	}
+
+	if (position == 0)
+		seq_puts(seq, "Largest Free Order Lists:\n");
+
+	seq_printf(seq, "Order %ld list: ", position);
+	count = 0;
+	list_for_each_entry(grp, &sbi->s_mb_largest_free_orders[position],
+			    bb_largest_free_order_node)
+		count++;
+	seq_printf(seq, "%d Groups\n", count);
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
index 752d1c261e2a..b78bc6b57bce 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -529,6 +529,8 @@ int ext4_register_sysfs(struct super_block *sb)
 				&ext4_mb_seq_groups_ops, sb);
 		proc_create_single_data("mb_stats", 0444, sbi->s_proc,
 				ext4_seq_mb_stats_show, sb);
+		proc_create_seq_data("mb_structs_summary", 0444, sbi->s_proc,
+				&ext4_mb_seq_structs_summary_ops, sb);
 	}
 	return 0;
 }
-- 
2.30.0.478.g8a0d178c01-goog

