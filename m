Return-Path: <linux-ext4+bounces-2589-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164FE8C98D9
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 07:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8440FB216BF
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 05:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E4719478;
	Mon, 20 May 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6lyU5NQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681917BAF
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716184335; cv=none; b=MpMXQLAXonV3FSDfFlNA7Bhdo1ywWfZJD1yaKXKa4AfCwUgh+9vfDry25EJGzCcVGsFM1gVGsUfcUnz7m7y9RCcFzff7C2T3hjCg0jA8ISn7aj6FtTrWsNM38tdTm79MQm1cG7xPmsJ+kGpBFwHuXEy0Y4tEslSslVVQuQ4z0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716184335; c=relaxed/simple;
	bh=esRfFolUwQfjZH5lKtSia5mjV8MLOxqkm8MikLkYeTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W49X+AdsCu0Cu9MkQw0zlkh8IM2shqBDUiHbZKbE+w+gJVAnWYiO8XZflkdToo0m/oniWxB3pOgddqE548EB8v0I0Ai0mWhu+9sMIPOUgY0GQUGFl+bFWbclJo+Din0BlJo4cZ6mwr1wFSttnlq0Sb3sGN9TKwUXOYTVXL6GHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6lyU5NQ; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5aa1bf6cb40so2900651eaf.1
        for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716184333; x=1716789133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuaYvGcnVEqOPF8zM8qg0nGvEsW7rIwGevpEeyh48XQ=;
        b=d6lyU5NQTCuNYLf0uhl9kKyowXFP8so9pDE6wVpUi6F9nuJNXbuwTspWza7QeNrXsV
         d9wpsPOdllOlbJSNf2C3byowoXMp+i9aRpgWxRLrPPA+tBMS6n8ca1VExZXl1Ed/O5LW
         d4OzWOJsm/AiyQr2WPjna1PdN7Lww/F7FNWvkbI1bhgSsN/e7t1iK6xQpKGGnYz67QGA
         BkAo1nzI6Q5cIvQhKqbEcj/YeaOQxKzH7q6LMx+kYgaaxGMBsL2er6ZFl5Xru+q8YjOj
         Z0CQEMSR1X8dsD/eeV/Tb9IwGrMIhnEtt49hjfJHGXbOq7AeoqayL0iOP1j09g6MLeHl
         3f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716184333; x=1716789133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuaYvGcnVEqOPF8zM8qg0nGvEsW7rIwGevpEeyh48XQ=;
        b=PO5QXFlvPf1yWPfPbf0l879z2NXLtlCJJZLmGg8ORYhbcW+dlowB8aCv/MKYHEiqQd
         +66SMqKZGY2NyxhYRaVPwbDn44+pk+QmpS6rZ9Wx90znJ+t7Uah54Fyf0MYgU1f1RMtg
         Fel5JM84d+VYG1NFFlY7sFoo9qyStHpVwH9H5BVAKCgZUoalpioxydeAwALJl8Gp1Y3Q
         aFwpcnom3dWomr2y2fuRay/ucuNviRkSYm4PlNEAusyqHne5xBStnDYo+cuuPx2y1zwI
         nlksqCXWUwVMYItEHQdxN4q23z81ZBvyfZNrBNz6nwUalvAoP8MXg6BWK77QcXkv34Nn
         UB9Q==
X-Gm-Message-State: AOJu0YzIaDLz2V0Z2tSgj34cO80A1M/9oLsF/y2ed8neq05eqaMOvW8Z
	UzVke+O2Ar6Fu+ZdSGMfbW8u17RD3wB2YN7/ZawhrFkh+kMMnOThYYkGBqT+
X-Google-Smtp-Source: AGHT+IFQdCJ8Tpf1CSi/Op/MhDMD7Y9DCSDZSrDN5FoznFupzog2Gwzgb9/HdXGquhuN7bgtEU8gUQ==
X-Received: by 2002:a05:6358:c006:b0:194:80bd:3e8c with SMTP id e5c5f4694b2df-19480bd4475mr1684743155d.4.1716184333176;
        Sun, 19 May 2024 22:52:13 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-659f66bf18csm6769297a12.46.2024.05.19.22.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 22:52:12 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 08/10] ext4: introduce selective flushing in fast commit
Date: Mon, 20 May 2024 05:51:51 +0000
Message-ID: <20240520055153.136091-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
References: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
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
2.45.0.rc1.225.g2a3ae87e7f-goog


