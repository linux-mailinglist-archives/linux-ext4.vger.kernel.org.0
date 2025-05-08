Return-Path: <linux-ext4+bounces-7777-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E389AB01F9
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 20:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DCD4C0537
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326212874F4;
	Thu,  8 May 2025 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrIQyurP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E0286D76
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727179; cv=none; b=X/CjQj8NbYMX5X+OeUFjpXjgmUBiq9t+5i6T7MKN2PFpWREVqGl0+BcmnXwJXDToiPuQoyA9uAw9QL9wI2nCTHI5lmUTVQtAdtU+Y0VhV4hqJCEi5xqB4Hee85dGnn1qrjh8LnlMuQduqFkxL6XkK9KHoH6910+GfHuDLL4zqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727179; c=relaxed/simple;
	bh=X7n7Wtq2qhB5VaRW7EcFGNoLqtyyUYK8On7Cm9uoqKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chIXZksORTJQz+bT5yGGTE/wjpLFjh8oQPzlLalTFBATQJWUpHwit6GOb+SzvZ6DdnCzHdrRSLRUvRD5PZrXGuP3obTS+W/G+HzM3cWPOl2cz2adNlkN8fTw/UQNRzrjFqTPyaZ1WeX8C4wNSL4PsnV+A6T/ghKAUC2DYNH2JLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrIQyurP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739be717eddso1177598b3a.2
        for <linux-ext4@vger.kernel.org>; Thu, 08 May 2025 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746727177; x=1747331977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkNakbZ3I/jJnUJlrPFtE58abfJJ8pR6wAdHQWq6G/A=;
        b=OrIQyurPh2dpt2KDBaoZPPbTZKLv8XbuBgw9Hi5ynhHeefetV9Fzo2Y/p4L6QNPDEE
         0BCJwIUDF1ofSTH9ldZTRrA5YpuSs8oz3mD/zhiLClzeKbsk0TvU4gU6QMSqwRobyL+H
         4LWP/XKx4P0yxh+Jj55VbvFHdRWpF/LRS2NKgdyZjc7ZvAaJq7uv/WN2r5lkCmsDO2CV
         uDGn90A+eLY/1NQPpLw2xBNH0at4DrbOYjEep0rNcXSDue/xvquRuv4EcbIsD20OubY+
         xuqp9qw9OOH5JnGKBgE9k6Mazo4eZ+V4G+1++cTQ2NfWsfO4KAF+9esDfkoGDDDeqGhA
         lmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727177; x=1747331977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkNakbZ3I/jJnUJlrPFtE58abfJJ8pR6wAdHQWq6G/A=;
        b=rYsP3U6nuMC8ZQ6KtBltDpcxsFHI3e8F9ZAZ5gvA39dV32dfCSA+68+TgzgWnKx733
         A2PxirbMyv8cEkYleMLyWDLy/dYk+1oW/tFkvh15tBd//kpy4IWqVsWllCWsusQN0YDu
         XZzDzYA+0v5vnAsrc4EhsZHtmsvPA2Ud7Dn0olZTtjcrDU5XPEhmxI4Ex/HZk1SiuduQ
         ZDseZtrGprpIiC4NcNYnbsk9PWlqR5yII3DQfIRC4a8RvsyneZysoE0JXnFRIbcpVnH+
         LUT9KJmA21476SQxyUIO6A1WpXlkHhA87DFxkzDOBeraiqvTgzBCt7RLFvYmg4XxVVva
         7QQQ==
X-Gm-Message-State: AOJu0Yzdhw9zrzmTBADSAIAhD+A4SWMOkUniRKOCBnp+5S83AFbWPUJa
	nAXUIBMx+Q1zRjR/OZb3v25634rahTAu2175vbplRNkYkd60IsmTj8oNuL0T6P8=
X-Gm-Gg: ASbGnct+I/Xj/uxvp84W76lwV60geFMzvw/2vms3yLjWEYWrS3aRy8uQpMAHpkNM04Z
	PrPcAs5jgfxYHoLQKbLczFkLXDTJzFHDL5f9W6sMOYaCJg/Y4C02dZbTcpi3bfd49HCXmgdCg3T
	ZImWNT66Ia8BbIf6FF87boHac4BkpoBYYB5jXfbK5nCcygWHXvqzXqiDYTYNsbtBDohdYifGhBk
	6xKrYayl6hNQd2kXxHDtJuaEBwNv2TZxk/iRAVmMeSmFAaDKJz0Jy+pN4pEjHyL97Cvx3hlYwg3
	/+j2Q43ou79WFnve3+PYHx46X/HfAl5nssnfAz1Ds+q9b3c4AxgA4xStxpTK58T1dNCGDnJH671
	qBOED9p99xgmT/8/242pg3bW4vRviXBs1poAX
X-Google-Smtp-Source: AGHT+IGFVNXSf39l43wTFSEfAXg4KsmuHPg0dweGrNzB/vCG1+IY/Sfyi3wPVEHp0XAEawTxFZ0a2w==
X-Received: by 2002:a17:903:230e:b0:223:325c:89f6 with SMTP id d9443c01a7336-22fc8b1b1a6mr4024815ad.10.1746727177251;
        Thu, 08 May 2025 10:59:37 -0700 (PDT)
Received: from harshads.c.googlers.com.com (156.242.82.34.bc.googleusercontent.com. [34.82.242.156])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22fc828939asm2153535ad.164.2025.05.08.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:59:36 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 9/9] ext4: hold s_fc_lock while during fast commit
Date: Thu,  8 May 2025 17:59:08 +0000
Message-ID: <20250508175908.1004880-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
In-Reply-To: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
References: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/fast_commit.c | 44 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index eb888e522..7ac672e35 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -424,6 +424,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 	node->fcd_ino = inode->i_ino;
 	take_dentry_name_snapshot(&node->fcd_name, dentry);
 	INIT_LIST_HEAD(&node->fcd_dilist);
+	INIT_LIST_HEAD(&node->fcd_list);
 	mutex_lock(&sbi->s_fc_lock);
 	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
 		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
@@ -985,8 +986,6 @@ static int ext4_fc_flush_data(journal_t *journal)
 
 /* Commit all the directory entry updates */
 static int ext4_fc_commit_dentry_updates(journal_t *journal, u32 *crc)
-__acquires(&sbi->s_fc_lock)
-__releases(&sbi->s_fc_lock)
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1000,26 +999,22 @@ __releases(&sbi->s_fc_lock)
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
@@ -1029,23 +1024,14 @@ __releases(&sbi->s_fc_lock)
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
@@ -1148,10 +1134,8 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	/* Step 6.2: Now write all the dentry updates. */
 	mutex_lock(&sbi->s_fc_lock);
 	ret = ext4_fc_commit_dentry_updates(journal, &crc);
-	if (ret) {
-		mutex_unlock(&sbi->s_fc_lock);
+	if (ret)
 		goto out;
-	}
 
 	/* Step 6.3: Now write all the changed inodes to disk. */
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
@@ -1159,7 +1143,6 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
 			continue;
 
-		mutex_unlock(&sbi->s_fc_lock);
 		ret = ext4_fc_write_inode_data(inode, &crc);
 		if (ret)
 			goto out;
@@ -1171,6 +1154,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	ret = ext4_fc_write_tail(sb, crc);
 
 out:
+	mutex_unlock(&sbi->s_fc_lock);
 	blk_finish_plug(&plug);
 	return ret;
 }
@@ -1353,11 +1337,9 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
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
2.49.0.1045.g170613ef41-goog


