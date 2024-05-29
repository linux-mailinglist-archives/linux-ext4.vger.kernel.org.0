Return-Path: <linux-ext4+bounces-2690-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC6D8D29E0
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715C91C225B3
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7515ADA4;
	Wed, 29 May 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXpHak+m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351315AAC2
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945650; cv=none; b=Qa5nHA9wN6dzNyyjpjb6nOgg+Y0dQbPAacdW6y8KehJlZH0FkDeLnNZYcd5FgOdopLENvGfjiLzeWhnK9iCUCiRRofeRkYyn0x6kitIHODSwy0wWX6CZWoxJjkGgLmQt/hXv4ziCz9Rr7hpVFoQn0oU6m+QJcj2HytGHgm3sUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945650; c=relaxed/simple;
	bh=KSCPSgwhLnLyFW+SoK3pBn60F4mgp0DKBrU7RzfDUVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiQHZYz7lz7ZyFFXiUT95o99J5jlXqf6JS2RKsJW6aDq+CvFWxRh5PuYlTwdc3PkRS6pIJ/U584gQKAVJzp/P3z5Hr259ojGDBpEUU+g157z4UVFH4f5pBaA9JfL9iJ+ZpM1XXGqcMsiK5P1w+/fS2eT+6imEt/qgxpFlPYqrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXpHak+m; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2bdefdeb545so1269771a91.2
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 18:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716945648; x=1717550448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2S2/GMIYfaiISMrDZ46rs0IeHJKqj6oVyJRZM0V3UM=;
        b=SXpHak+mKeVEKjRqLsiOEFSTyXiWP5wtJi1k2ZXNK+tj6wMN/ZaqOK6ujc17LQxB1K
         4YmLCZBM3qlBylT0BSIxPyrksJFD0cbsr+bYsHfKoyU6qn1UMynlL68EVZjbjcyBHORf
         tgKvmDeHEM2DcbCDkjlGLNUpGzD2J2RINnRR6UdoZYjEkSAo++BA6C8uSinFyX5R/Dy1
         3qY8flTQJCoGfnui42fg179VEUO7uFLzJaGrX42FE1NyUK9E84Qxj+bHbuPwrg/3+6qt
         atqNd15Pycx7VjLT7R9JS5MZQs5eRyBcwg10HEALtc3qwwxJo+VtzbDizuAry7PnEpFB
         46rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945648; x=1717550448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2S2/GMIYfaiISMrDZ46rs0IeHJKqj6oVyJRZM0V3UM=;
        b=BTBg21nSE7p3JdIIvaOabgMXS706YugsJKjckUV/u04wqYIXBJRO3kP3NtTY6v/gi4
         gUaSCqCaYX1WnHCUIm/gziHaB6kKGqo5ezATjqzW1pGDlfDVOaxxbTPmgsJXegqmv/X5
         8IC6UQQN+u/bSsogWlAequNTqkIQEN86yahnlMcrUr3IPldZvmF8g79vMS705mrLJ4wz
         wUxCjf6S2eS7nAy4yMmHNE3o8PRR5byz439cZMp0IQGtmk7RVqsRE/iLRiO29gYWz/Ca
         mIluZFtjpo6xzGyBW0sce/3bQ2BL5YhFTDKUHQVBB1MjFMrmIHdgTGJZTSqJf021glV8
         DkcA==
X-Gm-Message-State: AOJu0Yz498mOTB2Wy6aC3YqynFQSsmr2TRmGIGpx+M4er1eca1w+cNoU
	pM7FptnJuQSZlWzzr90MTJENlq9GeMUQc6aLO+GmY0V+ymPyGkfdluG9mSo5
X-Google-Smtp-Source: AGHT+IHhTpv8Y0Xt7F2x3sFr7GhSwIhQSKBHDFp8BaSlU5rt+pLun3gQCVBUKvHpQwXvkrJlakz3Uw==
X-Received: by 2002:a17:90b:917:b0:2bd:b3da:87d0 with SMTP id 98e67ed59e1d1-2bf5f4075dbmr12437855a91.41.1716945648434;
        Tue, 28 May 2024 18:20:48 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm10139388a91.53.2024.05.28.18.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:20:48 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 08/10] ext4: introduce selective flushing in fast commit
Date: Wed, 29 May 2024 01:20:01 +0000
Message-ID: <20240529012003.4006535-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fast commits, if the entire commit is contained within a single
block and there isn't any data that needs a flush, we can avoid sending
expensive cache flush to disk. Single block metadata only fast commits
can be written using FUA to guarantee consistency.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        | 12 ++++++++++++
 fs/ext4/ext4_jbd2.h   | 20 ++++++++++++--------
 fs/ext4/fast_commit.c | 23 ++++++++++++++++++-----
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 196c513f82dd..3721daea2890 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1744,6 +1744,13 @@ struct ext4_sb_info {
 					 */
 	struct list_head s_fc_dentry_q[2];	/* directory entry updates */
 	unsigned int s_fc_bytes;
+
+	/*
+	 * This flag indicates whether a full flush is needed on
+	 * next fast commit.
+	 */
+	int fc_flush_required;
+
 	/*
 	 * Main fast commit lock. This lock protects accesses to the
 	 * following fields:
@@ -2905,6 +2912,11 @@ void ext4_fc_del(struct inode *inode);
 bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
 int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
+static inline void ext4_fc_mark_needs_flush(struct super_block *sb)
+{
+	EXT4_SB(sb)->fc_flush_required = 1;
+}
+
 int __init ext4_fc_init_dentry_cache(void);
 void ext4_fc_destroy_dentry_cache(void);
 int ext4_fc_record_regions(struct super_block *sb, int ino,
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 0c77697d5e90..e3a4f5c49b6e 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -420,19 +420,23 @@ static inline int ext4_journal_force_commit(journal_t *journal)
 static inline int ext4_jbd2_inode_add_write(handle_t *handle,
 		struct inode *inode, loff_t start_byte, loff_t length)
 {
-	if (ext4_handle_valid(handle))
-		return jbd2_journal_inode_ranged_write(handle,
-				EXT4_I(inode)->jinode, start_byte, length);
-	return 0;
+	if (!ext4_handle_valid(handle))
+		return 0;
+
+	ext4_fc_mark_needs_flush(inode->i_sb);
+	return jbd2_journal_inode_ranged_write(handle,
+			EXT4_I(inode)->jinode, start_byte, length);
 }
 
 static inline int ext4_jbd2_inode_add_wait(handle_t *handle,
 		struct inode *inode, loff_t start_byte, loff_t length)
 {
-	if (ext4_handle_valid(handle))
-		return jbd2_journal_inode_ranged_wait(handle,
-				EXT4_I(inode)->jinode, start_byte, length);
-	return 0;
+	if (!ext4_handle_valid(handle))
+		return 0;
+
+	ext4_fc_mark_needs_flush(inode->i_sb);
+	return jbd2_journal_inode_ranged_wait(handle,
+			EXT4_I(inode)->jinode, start_byte, length);
 }
 
 static inline void ext4_update_inode_fsync_trans(handle_t *handle,
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0b7064f8dfa5..35c89bee452c 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -638,11 +638,24 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
 static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
 {
 	blk_opf_t write_flags = REQ_SYNC;
-	struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct buffer_head *bh = sbi->s_fc_bh;
+	int old = 1, new = 0;
+
+	if (!is_tail) {
+		/*
+		 * This commit has at least 1 non-tail block,
+		 * thus FLUSH is required.
+		 */
+		ext4_fc_mark_needs_flush(sb);
+	} else {
+		/* Use cmpxchg to ensure that no flush requrest is lost. */
+		if (cmpxchg(&sbi->fc_flush_required, old, new))
+			/* Old value was 1, so request a flush. */
+			write_flags |= REQ_PREFLUSH;
+		write_flags |= REQ_FUA;
+	}
 
-	/* Add REQ_FUA | REQ_PREFLUSH only its tail */
-	if (test_opt(sb, BARRIER) && is_tail)
-		write_flags |= REQ_FUA | REQ_PREFLUSH;
 	lock_buffer(bh);
 	set_buffer_dirty(bh);
 	set_buffer_uptodate(bh);
@@ -1090,7 +1103,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	 * If file system device is different from journal device, issue a cache
 	 * flush before we start writing fast commit blocks.
 	 */
-	if (journal->j_fs_dev != journal->j_dev)
+	if (sbi->fc_flush_required && journal->j_fs_dev != journal->j_dev)
 		blkdev_issue_flush(journal->j_fs_dev);
 
 	blk_start_plug(&plug);
-- 
2.45.1.288.g0e0cd299f1-goog


