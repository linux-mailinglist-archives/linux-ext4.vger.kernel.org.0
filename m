Return-Path: <linux-ext4+bounces-7249-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBFAA88916
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB951895E55
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CD5289353;
	Mon, 14 Apr 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSUNLQ5S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63414288C8F
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649692; cv=none; b=UgAHBXI5ozR+r+XWOsEEdVFtQPDCjkjJDKOAP4uq76okhtKHm1wswOk4lOaYgaW872lJlMfsJAnrNxs+HI43I5RuFv6s30/s5PKabysmMZI1rffUHre+uNWH7JMnGOFxGmh6xCjayTxoKuAerjsJFbSmYPddB5Jo50vg9QwQd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649692; c=relaxed/simple;
	bh=YViChFIFr05tAkI1ScTabz/4l6s1zAr6tPcCO573cd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zxsv8XKy0ZieRhHvPb4uvKAA9WntV3Ee/fU3Yai8iR2zxZ3VfVDxQaJI2nJYP7i//lDBww9En5WSWZxxiQg1GBo6U+sDMaGq/eZVk+Nb6nFeyGD/ion0d4yXVUQiI4gy5IF9uD65ikw6xMyvc8r423+GwwxZACF0UQQdxwbxPuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSUNLQ5S; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so3953802a12.3
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649689; x=1745254489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DC4xiKdtMkzynd3z+vgGAl1Lx6jDZ6DtOinVg/i/8iE=;
        b=bSUNLQ5S8P6fYNQPtLrKDO9XYv6WmU0kbAKuj62E4YGzIF38evqUA/eqHoPSlVsKPJ
         qOp3NfLA15oyFqBfipTDkANulqM5KLZfV+iDc1oDEOGD1jl8vi9CTxL0Jmgk69TKwh/2
         /VCQ8zC3gzvMFJwx7I6MHs8j3KuvtYVokdgNaWT/xsrwgYUxdUaTamlr3wEygjsz0piv
         SCvJOyUEZbeOHDB9HaUlB8eUYsHQzGhUFktKedlkv1d3ccF4fMI5UtyOAKmHG7WaTasO
         07PD7Xy7HbFMXhvdxHugjpsI+J4sH3X4Cm/+8q8P1cHvxE/JoEqm9Bsg+nYu77bp+sG+
         3fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649689; x=1745254489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC4xiKdtMkzynd3z+vgGAl1Lx6jDZ6DtOinVg/i/8iE=;
        b=neeuFiz6EuwakQCityxk/3Z2hh8YHAuXHZvO/V1nCFlRVJKZBCfPfmBWy9HRaroCqM
         fTpWzRlui9ECvIwLtVDRNIIC5VHIpdm5UFMsj7cc/lf8Bh3nISJFdGmPCUsVGJdDCroZ
         5RMXpmLwPJpeDqs5WKOOKMJOzmkvw1cLgQjeF3l+dfr/K9y05xGVL6dIGfpDEHA2W2rp
         H+R3Onoe4Na0PF8zBw192RZHDwzMh92JbZ9umDA/AZUIwy8zdDhvh/1SRqAhzG/3qyr+
         FS4SYnYsoqVj+PO/0XF72cIi5DqWelyouLo9bsLerJd1pZ4Ywwp4BBUsECN0O3eKIu2d
         aZOQ==
X-Gm-Message-State: AOJu0YyCbeeaGZEVXm95Tf7Y1dGnU0JZPlB9rEJFKM8xOoZcKv9DdQOu
	AY7Er4BZ+9dF6vyEMSIG8+wQFi8GIuMqousUAFWVf03dA8ngfH6mAH4i1Gz7tnY=
X-Gm-Gg: ASbGncv/DrvFXxWhGkWWnDAU8ed5+moc4X+UIY7IRdOJ3dGI29i5n4wSTiL8BAelT7D
	XfYLum3iNdssE6OI4IRTZpXOJH9B/d2ooT/wLCKrjwBq/z43gk8SzOjVwJ6pTav2mEe2ZYXqm+Z
	yH3212uiwJ0A543smP06d2jU2r/tyITGeTz5a0Kc+nSckPAJY1v57gD2avf3v4QbMAa8I2Jnigo
	yMuioET4XDhtAJ6mg4ol4+tojIG6+VsagQ+E7N1ttvBZNWYYUU5FRl6pjwI9OzMxZfsYBspekwI
	QrmGfrV9eWYyeTTlYSPx1je4rSG7YjNoRNxXWa4xkVE/yXDbRMn2L4q648Jxsh11k93a46gKPEo
	el1Y0dY6rJvkJSQQmhDikdcHswnGnpIb+zg==
X-Google-Smtp-Source: AGHT+IFTfbkku8SIza/f0G2O56HwNqOeLmHg4lPyE9GyQ8PKc9vJcFOnAevjuMRGu6p2+UEqgKMLnw==
X-Received: by 2002:a17:90b:4c04:b0:2ff:62b7:dcc0 with SMTP id 98e67ed59e1d1-3082367dd5emr20305544a91.15.1744649689314;
        Mon, 14 Apr 2025 09:54:49 -0700 (PDT)
Received: from harshads.c.googlers.com.com (121.61.83.34.bc.googleusercontent.com. [34.83.61.121])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm11543107a91.31.2025.04.14.09.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:54:48 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 9/9] ext4: hold s_fc_lock while during fast commit
Date: Mon, 14 Apr 2025 16:54:16 +0000
Message-ID: <20250414165416.1404856-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
In-Reply-To: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
References: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Leaving s_fc_lock in between during commit in ext4_fc_perform_commit()
function leaves room for subtle concurrency bugs where ext4_fc_del() may
delete an inode from the fast commit list, leaving list in an inconsistent
state.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 57 ++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 89895ba2e011..1c28ef79654c 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -400,6 +400,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 	node->fcd_ino = inode->i_ino;
 	take_dentry_name_snapshot(&node->fcd_name, dentry);
 	INIT_LIST_HEAD(&node->fcd_dilist);
+	INIT_LIST_HEAD(&node->fcd_list);
 	mutex_lock(&sbi->s_fc_lock);
 	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
 		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
@@ -949,11 +950,9 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 
 	mutex_lock(&sbi->s_fc_lock);
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		mutex_unlock(&sbi->s_fc_lock);
 		ret = jbd2_submit_inode_data(journal, ei->jinode);
 		if (ret)
-			return ret;
-		mutex_lock(&sbi->s_fc_lock);
+			break;
 	}
 	mutex_unlock(&sbi->s_fc_lock);
 
@@ -973,22 +972,18 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
 		if (!ext4_test_inode_state(&pos->vfs_inode,
 					   EXT4_STATE_FC_COMMITTING))
 			continue;
-		mutex_unlock(&sbi->s_fc_lock);
 
 		ret = jbd2_wait_inode_data(journal, pos->jinode);
 		if (ret)
-			return ret;
-		mutex_lock(&sbi->s_fc_lock);
+			break;
 	}
 	mutex_unlock(&sbi->s_fc_lock);
 
-	return 0;
+	return ret;
 }
 
 /* Commit all the directory entry updates */
 static int ext4_fc_commit_dentry_updates(journal_t *journal, u32 *crc)
-__acquires(&sbi->s_fc_lock)
-__releases(&sbi->s_fc_lock)
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1002,26 +997,22 @@ __releases(&sbi->s_fc_lock)
 	list_for_each_entry_safe(fc_dentry, fc_dentry_n,
 				 &sbi->s_fc_dentry_q[FC_Q_MAIN], fcd_list) {
 		if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT) {
-			mutex_unlock(&sbi->s_fc_lock);
-			if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry)) {
-				ret = -ENOSPC;
-				goto lock_and_exit;
-			}
-			mutex_lock(&sbi->s_fc_lock);
+			if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry))
+				return -ENOSPC;
 			continue;
 		}
 		/*
 		 * With fcd_dilist we need not loop in sbi->s_fc_q to get the
-		 * corresponding inode pointer
+		 * corresponding inode. Also, the corresponding inode could have been
+		 * deleted, in which case, we don't need to do anything.
 		 */
-		WARN_ON(list_empty(&fc_dentry->fcd_dilist));
+		if (list_empty(&fc_dentry->fcd_dilist))
+			continue;
 		ei = list_first_entry(&fc_dentry->fcd_dilist,
 				struct ext4_inode_info, i_fc_dilist);
 		inode = &ei->vfs_inode;
 		WARN_ON(inode->i_ino != fc_dentry->fcd_ino);
 
-		mutex_unlock(&sbi->s_fc_lock);
-
 		/*
 		 * We first write the inode and then the create dirent. This
 		 * allows the recovery code to create an unnamed inode first
@@ -1031,23 +1022,14 @@ __releases(&sbi->s_fc_lock)
 		 */
 		ret = ext4_fc_write_inode(inode, crc);
 		if (ret)
-			goto lock_and_exit;
-
+			return ret;
 		ret = ext4_fc_write_inode_data(inode, crc);
 		if (ret)
-			goto lock_and_exit;
-
-		if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry)) {
-			ret = -ENOSPC;
-			goto lock_and_exit;
-		}
-
-		mutex_lock(&sbi->s_fc_lock);
+			return ret;
+		if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry))
+			return -ENOSPC;
 	}
 	return 0;
-lock_and_exit:
-	mutex_lock(&sbi->s_fc_lock);
-	return ret;
 }
 
 static int ext4_fc_perform_commit(journal_t *journal)
@@ -1107,17 +1089,14 @@ static int ext4_fc_perform_commit(journal_t *journal)
 
 	mutex_lock(&sbi->s_fc_lock);
 	ret = ext4_fc_commit_dentry_updates(journal, &crc);
-	if (ret) {
-		mutex_unlock(&sbi->s_fc_lock);
+	if (ret)
 		goto out;
-	}
 
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		inode = &iter->vfs_inode;
 		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
 			continue;
 
-		mutex_unlock(&sbi->s_fc_lock);
 		ret = ext4_fc_write_inode_data(inode, &crc);
 		if (ret)
 			goto out;
@@ -1136,13 +1115,11 @@ static int ext4_fc_perform_commit(journal_t *journal)
 #else
 		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
 #endif
-		mutex_lock(&sbi->s_fc_lock);
 	}
-	mutex_unlock(&sbi->s_fc_lock);
-
 	ret = ext4_fc_write_tail(sb, crc);
 
 out:
+	mutex_unlock(&sbi->s_fc_lock);
 	blk_finish_plug(&plug);
 	return ret;
 }
@@ -1325,11 +1302,9 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 					     fcd_list);
 		list_del_init(&fc_dentry->fcd_list);
 		list_del_init(&fc_dentry->fcd_dilist);
-		mutex_unlock(&sbi->s_fc_lock);
 
 		release_dentry_name_snapshot(&fc_dentry->fcd_name);
 		kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
-		mutex_lock(&sbi->s_fc_lock);
 	}
 
 	list_splice_init(&sbi->s_fc_dentry_q[FC_Q_STAGING],
-- 
2.49.0.604.gff1f9ca942-goog


