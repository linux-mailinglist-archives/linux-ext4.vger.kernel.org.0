Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7E39C845
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Jun 2021 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFEMzX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Jun 2021 08:55:23 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42687 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhFEMzW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Jun 2021 08:55:22 -0400
Received: by mail-lf1-f47.google.com with SMTP id a2so18196994lfc.9;
        Sat, 05 Jun 2021 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PDooDxlV/Vf4bcgK0N9C28zeqWwrdgcP194Ocfzp/4E=;
        b=hGxQYEYzp3IWIARiog2+J9pRLKXz7HF7SWAjdAIYWNo9FVZGBDoqLLmpX8kXNu9pWJ
         bzAIGvgNIChVJOd6+voVG+2nWPE/0RxwxAfdD4bzzLGaCYhNt89zqeYGQp6L03pV4laF
         CwlsGIayWbaEKtNfsTpHZ0J4kd9aIUQgxr5Wqp37W03ESwwtou9SFILNAznp1BTul9hP
         vwbsj2j0vOV8EVH4q7ZHUk1YvVKn1VsKYHM/26qwpu4SomMfHOgH4gM1KQ5NQIgqNQ0n
         i9K97RkKHK1p2yuZNgDgfkhPe3FDBT9cLYPQ96mDagWT00Yk+qRe12SGVG7FOtga6fVb
         6AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDooDxlV/Vf4bcgK0N9C28zeqWwrdgcP194Ocfzp/4E=;
        b=rNHjhvL/1HTZR9sEM1QILZVSEUrCQhE/4Gj3DAknqencWUPyM9lZUE0hIs3c7EZE/I
         VBLVn1wpWGUaiDLEbk629cJP68TM1zOMbf3j4NbS5gmSEO3X++X6uAWYB9/lY1hdnumO
         FThgH9nPl1cZsyRqj2vZQXLp52YLZKjPal0xr2Om5Y65Vbm9+84Swg9dZkOyM3QO1hO6
         e3WJu3aCnSjxGqBxo376KDcdvFFPwc2lAQ2xcrkUmBqxHxWX8RG26nvH8PKdihy12Q1/
         0LTqOVkkoWepW0RVRF0VY5xe04ql91X3Qs3ZoSX0A3iLfqvDOhs1+iHApAtwkHt/EUU2
         8EgQ==
X-Gm-Message-State: AOAM530p9U2aWiumf8cIcyXtDmn5Lwbl/0SCrqwaNk6XJmZ2ZZ66SOI1
        Bxockw5NbilEi25kbZ/utrM=
X-Google-Smtp-Source: ABdhPJwFQrIWUO9Z6+ef2E9eq+B6MuhHuWoyVbSO093RFNI/L8c70o+mnG6yS3OIiBs6fAlJo/5Cdg==
X-Received: by 2002:a05:6512:318d:: with SMTP id i13mr4145240lfe.407.1622897540359;
        Sat, 05 Jun 2021 05:52:20 -0700 (PDT)
Received: from localhost.localdomain ([94.103.224.40])
        by smtp.gmail.com with ESMTPSA id bu21sm79340lfb.180.2021.06.05.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 05:52:19 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: [RESEND PATCH v2] ext4: fix memory leak in ext4_fill_super
Date:   Sat,  5 Jun 2021 15:52:10 +0300
Message-Id: <20210605125210.10356-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517213427.3ac17247@gmail.com>
References: <20210517213427.3ac17247@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

static int kthread(void *_create) will return -ENOMEM
or -EINTR in case of internal failure or
kthread_stop() call happens before threadfn call.

To prevent fancy error checking and make code
more straightforward we moved all cleanup code out
of kmmpd threadfn.

Also, dropped struct mmpd_data at all. Now struct super_block
is a threadfn data and struct buffer_head embedded into
struct ext4_sb_info.

Reported-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 fs/ext4/ext4.h  |  4 ++++
 fs/ext4/mmp.c   | 28 +++++++++++++---------------
 fs/ext4/super.c | 10 ++++------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 826a56e3bbd2..62210cbea84b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1490,6 +1490,7 @@ struct ext4_sb_info {
 	struct kobject s_kobj;
 	struct completion s_kobj_unregister;
 	struct super_block *s_sb;
+	struct buffer_head *s_mmp_bh;
 
 	/* Journaling */
 	struct journal_s *s_journal;
@@ -3663,6 +3664,9 @@ extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
 /* mmp.c */
 extern int ext4_multi_mount_protect(struct super_block *, ext4_fsblk_t);
 
+/* mmp.c */
+extern void ext4_stop_mmpd(struct ext4_sb_info *sbi);
+
 /* verity.c */
 extern const struct fsverity_operations ext4_verityops;
 
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 795c3ff2907c..623bad399612 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -127,9 +127,9 @@ void __dump_mmp_msg(struct super_block *sb, struct mmp_struct *mmp,
  */
 static int kmmpd(void *data)
 {
-	struct super_block *sb = ((struct mmpd_data *) data)->sb;
-	struct buffer_head *bh = ((struct mmpd_data *) data)->bh;
+	struct super_block *sb = (struct super_block *) data;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+	struct buffer_head *bh = EXT4_SB(sb)->s_mmp_bh;
 	struct mmp_struct *mmp;
 	ext4_fsblk_t mmp_block;
 	u32 seq = 0;
@@ -245,12 +245,18 @@ static int kmmpd(void *data)
 	retval = write_mmp_block(sb, bh);
 
 exit_thread:
-	EXT4_SB(sb)->s_mmp_tsk = NULL;
-	kfree(data);
-	brelse(bh);
 	return retval;
 }
 
+void ext4_stop_mmpd(struct ext4_sb_info *sbi)
+{
+	if (sbi->s_mmp_tsk) {
+		kthread_stop(sbi->s_mmp_tsk);
+		brelse(sbi->s_mmp_bh);
+		sbi->s_mmp_tsk = NULL;
+	}
+}
+
 /*
  * Get a random new sequence number but make sure it is not greater than
  * EXT4_MMP_SEQ_MAX.
@@ -275,7 +281,6 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct buffer_head *bh = NULL;
 	struct mmp_struct *mmp = NULL;
-	struct mmpd_data *mmpd_data;
 	u32 seq;
 	unsigned int mmp_check_interval = le16_to_cpu(es->s_mmp_update_interval);
 	unsigned int wait_time = 0;
@@ -364,24 +369,17 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		goto failed;
 	}
 
-	mmpd_data = kmalloc(sizeof(*mmpd_data), GFP_KERNEL);
-	if (!mmpd_data) {
-		ext4_warning(sb, "not enough memory for mmpd_data");
-		goto failed;
-	}
-	mmpd_data->sb = sb;
-	mmpd_data->bh = bh;
+	EXT4_SB(sb)->s_mmp_bh = bh;
 
 	/*
 	 * Start a kernel thread to update the MMP block periodically.
 	 */
-	EXT4_SB(sb)->s_mmp_tsk = kthread_run(kmmpd, mmpd_data, "kmmpd-%.*s",
+	EXT4_SB(sb)->s_mmp_tsk = kthread_run(kmmpd, sb, "kmmpd-%.*s",
 					     (int)sizeof(mmp->mmp_bdevname),
 					     bdevname(bh->b_bdev,
 						      mmp->mmp_bdevname));
 	if (IS_ERR(EXT4_SB(sb)->s_mmp_tsk)) {
 		EXT4_SB(sb)->s_mmp_tsk = NULL;
-		kfree(mmpd_data);
 		ext4_warning(sb, "Unable to create kmmpd thread for %s.",
 			     sb->s_id);
 		goto failed;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9693680463a..539f89c5431f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1244,8 +1244,8 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
 	sbi->s_ea_block_cache = NULL;
 
-	if (sbi->s_mmp_tsk)
-		kthread_stop(sbi->s_mmp_tsk);
+	ext4_stop_mmpd(sbi);
+
 	brelse(sbi->s_sbh);
 	sb->s_fs_info = NULL;
 	/*
@@ -5156,8 +5156,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 failed_mount3:
 	flush_work(&sbi->s_error_work);
 	del_timer_sync(&sbi->s_err_report);
-	if (sbi->s_mmp_tsk)
-		kthread_stop(sbi->s_mmp_tsk);
+	ext4_stop_mmpd(sbi);
 failed_mount2:
 	rcu_read_lock();
 	group_desc = rcu_dereference(sbi->s_group_desc);
@@ -5952,8 +5951,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 				 */
 				ext4_mark_recovery_complete(sb, es);
 			}
-			if (sbi->s_mmp_tsk)
-				kthread_stop(sbi->s_mmp_tsk);
+			ext4_stop_mmpd(sbi);
 		} else {
 			/* Make sure we can mount this feature set readwrite */
 			if (ext4_has_feature_readonly(sb) ||
-- 
2.31.1

