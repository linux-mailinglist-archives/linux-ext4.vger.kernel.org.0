Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1E2A1A75
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Oct 2020 21:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgJaUFz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Oct 2020 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgJaUFu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Oct 2020 16:05:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759E4C0617A6
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a200so7814646pfa.10
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9LrY+vPhhgE3E5YZBPeCoZd6BVmh55jyaQT21g59sQ=;
        b=bfRaWt+d7m6/+HOq2V4MWpDHrOGc8+cYjcyR92XxAZgx+iZZ6wPULKKyAvYree9hdT
         LM0X7XcAP+6wlfmaPx8hGreNWmDm+1WAnPazhcBFFl+NGdOii7ANh56vckwReQF0iEy3
         19cymaNHhuB+gbQBEkAHLS+yKhbbITUQevYKOZ9+jsCGuePx1RHmnOjQG+SJcqDgwL8c
         RddjGgtXiacN/ma3zTmziYCO0RUuYEHU3lAsaMuLYTmwUyuseGvXt3vcIOeSp4kR1eYX
         hr7Klr4V9y/5oBpH268Z+sNTwD73D7LCjfzX5tluHhDA0VuoeStzwAWf0VFDSQUi1H87
         HZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9LrY+vPhhgE3E5YZBPeCoZd6BVmh55jyaQT21g59sQ=;
        b=FwM3Iim/8IRV5TUYJJpRmA3RFiYoQyd/aOWbpAAIxJAHTgxSXMg9CfsXn6Hry7vck3
         1v1c9IJDHaU6CkmcsfBzGm+Lo6NuZrJGcxDl8+WNaTREP/la7pE5A1y6LltgQt9zK3yA
         OpWtgPA9bEmgg+0cyUtypHAew8hq9HKA7hbvSXF0nsQha4QXIK/Ir4zmgu4l98/qJn9j
         tFyAW1HlybUhAOkOy5Te0XSQi4rmNsEypH4tHBLK+MVknMEb46Xwmn5ITQFrQ3BmsroL
         vMp+Jq6S9YfDKO7aQYNNCB9aE0L4DVICBOO9830g5x7PZjA1dmlHKu6e05ZHGc7pJVgU
         0FgA==
X-Gm-Message-State: AOAM530oP02+5uUzSyucnG28Yp+EuvMC9b87jzgoW47f4WrC29NIdamz
        ngN+7UR/nLw9JcI0yIq9xs4jaAs6Jjk=
X-Google-Smtp-Source: ABdhPJzNPl2onqSRX+g9NlyS2PELr/SwDGPQVOxoJBApOyhuKgQk+6CVSmLjMsq51hAxCNBBxlVujw==
X-Received: by 2002:a65:6705:: with SMTP id u5mr7730660pgf.9.1604174748547;
        Sat, 31 Oct 2020 13:05:48 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm17177102pjq.3.2020.10.31.13.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:05:47 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 07/10] ext4: misc fast commit fixes
Date:   Sat, 31 Oct 2020 13:05:15 -0700
Message-Id: <20201031200518.4178786-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds a small number of misc fast commit fixes. Along with
functional fixes such as setting the right buffer flags, there also
typo fixes and comment additions.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4_jbd2.h   | 6 +++++-
 fs/ext4/fast_commit.c | 5 +++--
 fs/ext4/file.c        | 2 --
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 00dc668e052b..10855cd230c7 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -422,9 +422,13 @@ static inline int ext4_journal_force_commit(journal_t *journal)
 static inline int ext4_jbd2_inode_add_write(handle_t *handle,
 		struct inode *inode, loff_t start_byte, loff_t length)
 {
-	if (ext4_handle_valid(handle))
+	if (ext4_handle_valid(handle)) {
+		ext4_fc_track_range(handle, inode,
+			start_byte >> inode->i_sb->s_blocksize_bits,
+			(start_byte + length) >> inode->i_sb->s_blocksize_bits);
 		return jbd2_journal_inode_ranged_write(handle,
 				EXT4_I(inode)->jinode, start_byte, length);
+	}
 	return 0;
 }
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0f2543220d1d..b7b1fe6dbb24 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -83,7 +83,7 @@
  *
  * Atomicity of commits
  * --------------------
- * In order to gaurantee atomicity during the commit operation, fast commit
+ * In order to guarantee atomicity during the commit operation, fast commit
  * uses "EXT4_FC_TAG_TAIL" tag that marks a fast commit as complete. Tail
  * tag contains CRC of the contents and TID of the transaction after which
  * this fast commit should be applied. Recovery code replays fast commit
@@ -531,10 +531,11 @@ static void ext4_fc_submit_bh(struct super_block *sb)
 	int write_flags = REQ_SYNC;
 	struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
 
+	/* TODO: REQ_FUA | REQ_PREFLUSH is unnecessarily expensive. */
 	if (test_opt(sb, BARRIER))
 		write_flags |= REQ_FUA | REQ_PREFLUSH;
 	lock_buffer(bh);
-	clear_buffer_dirty(bh);
+	set_buffer_dirty(bh);
 	set_buffer_uptodate(bh);
 	bh->b_end_io = ext4_end_buffer_io_sync;
 	submit_bh(REQ_OP_WRITE, write_flags, bh);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index d85412d12e3a..80ad5ccc0288 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -761,7 +761,6 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!daxdev_mapping_supported(vma, dax_dev))
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	file_accessed(file);
 	if (IS_DAX(file_inode(file))) {
 		vma->vm_ops = &ext4_dax_vm_ops;
@@ -769,7 +768,6 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 	} else {
 		vma->vm_ops = &ext4_file_vm_ops;
 	}
-	ext4_fc_stop_update(inode);
 	return 0;
 }
 
-- 
2.29.1.341.ge80a0c044ae-goog

