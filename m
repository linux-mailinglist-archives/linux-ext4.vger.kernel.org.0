Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C361B30901D
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Jan 2021 23:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhA2WbD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Jan 2021 17:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbhA2Waw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Jan 2021 17:30:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA35C0613D6
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 14:30:12 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l18so7117104pji.3
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 14:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IuJimPtju8thxSVYDMF6laXmhdOf6NkWBYwNpDi9DdU=;
        b=DdGrYBFBlUPL5VvLioLs80gaBwSQeA8vy2AuAkyySgNjDuOpte17v9OxbS8pNQMgY2
         KrIT/tnL32PSnfBpt1roRcLz/kEfNzS8bw7TJbG+qP221pFWR2OadW5CqgiI5IQ/JKe2
         17XX5f4MlIsHYXE+/rCWCay45lCmyum0H+Mpq0ooHuPu6W81PwyBpcAp9t08M5vXJ7Xd
         arEOuBo9EcM40fQpxoqY329dw2FguMfaX4oWLny6VRZq6eUUNXMylxx/BbexBXqINvCy
         30NIawEE/0PuTdTV/RemX6GbDZCg6kxW5S3yfS+or4WS/dB3YMkDV+AeMbRLytPwYqfy
         rS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IuJimPtju8thxSVYDMF6laXmhdOf6NkWBYwNpDi9DdU=;
        b=mJ2T+bGZxQMvwQ7/AttJq0zzD4eKYDxlEEzKXTJTz8uQm6D/jDkan8tQuNsC/0R9OA
         gEKfkHrKqJW39aKOJO5XUKDyDG0xC6T2e8UIcnfSBt6QJ5xPWpHG6xiRee4G4I5PSVFL
         QjaWQdB84e/ilPFYMOqyH+6RAvx8jVbp8jlVN+jlkcECyjciAhY5fX8bmjIw29Cq/76l
         93cvsGecvYEe5PxFG1qnWxCzXDWC3C2A/lWIt+y/9zV+MDpE/xkz34wvC0nGNhO/MQyv
         GPzJU1x6Tsb3A71ar+xe+oxWGnFEsCmbCFLO80WLPsCisFzucKd8yfFq6tmTShAKAqid
         KnCA==
X-Gm-Message-State: AOAM531Pr8gjsBMQKlJCfE/cn2ceWwUgBC4uCBFuQUxpzl00y+3yH6S8
        KT1aqpeRrkVAvUD9rA9CG1nD0dSDWYc=
X-Google-Smtp-Source: ABdhPJzmxKSsY2QVto4Gak3DOuF94G+TsTa8UxpMAyQNITEfKMKKapi1rLAL8z4XYBJiubvrpWyIVA==
X-Received: by 2002:a17:902:9349:b029:df:fab3:64b8 with SMTP id g9-20020a1709029349b02900dffab364b8mr6491771plp.72.1611959411765;
        Fri, 29 Jan 2021 14:30:11 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id d14sm9719358pfo.156.2021.01.29.14.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:30:11 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 4/4] ext4: add proc files to monitor new structures
Date:   Fri, 29 Jan 2021 14:29:31 -0800
Message-Id: <20210129222931.623008-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
References: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds a new file "mb_structs" which allows us to see the
largest free order lists and the serialized average fragment tree.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/mballoc.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/sysfs.c   |  2 ++
 3 files changed, 82 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index da12a083bf52..835e304e3113 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2809,6 +2809,7 @@ int __init ext4_fc_init_dentry_cache(void);
 
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
+extern const struct seq_operations ext4_mb_seq_structs_ops;
 extern long ext4_mb_stats;
 extern long ext4_mb_max_to_scan;
 extern int ext4_mb_init(struct super_block *);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 413259477b03..ec4656903bd4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2741,6 +2741,85 @@ const struct seq_operations ext4_mb_seq_groups_ops = {
 	.show   = ext4_mb_seq_groups_show,
 };
 
+static void *ext4_mb_seq_structs_start(struct seq_file *seq, loff_t *pos)
+{
+	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	unsigned long position;
+
+	read_lock(&EXT4_SB(sb)->s_mb_rb_lock);
+
+	if (*pos < 0 || *pos >= MB_NUM_ORDERS(sb) + ext4_get_groups_count(sb))
+		return NULL;
+	position = *pos + 1;
+	return (void *) ((unsigned long) position);
+}
+
+static void *ext4_mb_seq_structs_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	unsigned long position;
+
+	++*pos;
+	if (*pos < 0 || *pos >= MB_NUM_ORDERS(sb) + ext4_get_groups_count(sb))
+		return NULL;
+	position = *pos + 1;
+	return (void *) ((unsigned long) position);
+}
+
+static int ext4_mb_seq_structs_show(struct seq_file *seq, void *v)
+{
+	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	unsigned long position = ((unsigned long) v);
+	struct ext4_group_info *grpinfo;
+	struct rb_node *n;
+	int i;
+
+	position--;
+
+	if (position >= MB_NUM_ORDERS(sb)) {
+		position -= MB_NUM_ORDERS(sb);
+		if (position == 0)
+			seq_puts(seq, "Group, Avg Fragment Size\n");
+		n = rb_first(&sbi->s_mb_avg_fragment_size_root);
+		for (i = 0; n && i < position; i++)
+			n = rb_next(n);
+		if (!n)
+			return 0;
+		grpinfo = rb_entry(n, struct ext4_group_info, bb_avg_fragment_size_rb);
+		seq_printf(seq, "%d, %d\n",
+			   grpinfo->bb_group,
+			   grpinfo->bb_fragments ? grpinfo->bb_free / grpinfo->bb_fragments : 0);
+		return 0;
+	}
+
+	if (position == 0)
+		seq_puts(seq, "Largest Free Order Lists:\n");
+
+	seq_printf(seq, "[%ld]: ", position);
+	list_for_each_entry(grpinfo, &sbi->s_mb_largest_free_orders[position],
+			    bb_largest_free_order_node)	{
+		seq_printf(seq, "%d ", grpinfo->bb_group);
+	}
+	seq_puts(seq, "\n");
+
+	return 0;
+}
+
+static void ext4_mb_seq_structs_stop(struct seq_file *seq, void *v)
+{
+	struct super_block *sb = PDE_DATA(file_inode(seq->file));
+
+	read_unlock(&EXT4_SB(sb)->s_mb_rb_lock);
+}
+
+const struct seq_operations ext4_mb_seq_structs_ops = {
+	.start  = ext4_mb_seq_structs_start,
+	.next   = ext4_mb_seq_structs_next,
+	.stop   = ext4_mb_seq_structs_stop,
+	.show   = ext4_mb_seq_structs_show,
+};
+
 static struct kmem_cache *get_groupinfo_cache(int blocksize_bits)
 {
 	int cache_index = blocksize_bits - EXT4_MIN_BLOCK_LOG_SIZE;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 4e27fe6ed3ae..828d58b98310 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -527,6 +527,8 @@ int ext4_register_sysfs(struct super_block *sb)
 					ext4_fc_info_show, sb);
 		proc_create_seq_data("mb_groups", S_IRUGO, sbi->s_proc,
 				&ext4_mb_seq_groups_ops, sb);
+		proc_create_seq_data("mb_structs", 0444, sbi->s_proc,
+				&ext4_mb_seq_structs_ops, sb);
 	}
 	return 0;
 }
-- 
2.30.0.365.g02bc693789-goog

