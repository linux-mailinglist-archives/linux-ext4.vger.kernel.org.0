Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A1B164DAE
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2020 19:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgBSSbi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Feb 2020 13:31:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgBSSbi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Feb 2020 13:31:38 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17A8A2465D;
        Wed, 19 Feb 2020 18:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582137097;
        bh=6LlisK2XbxizEr+kJ97p87+teDSAylRe4yXE11hrsqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=duAT39LWlbDi9M6ve4eTkcIrLhVpxJMSA/yAL/E7+4+WBs2xeSlh7u4Ip4J8c+9Op
         N6V1mbbZ2Xvh/uQuicrpmACA7eubtDpmx/lK/Di68vlXpGmIw3Tpf2N7qOg/tU2hKT
         jY14UuMhh4SVjvLFf1ixaOtPiHX3yPHdnNBcQqao=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH v3 1/2] ext4: rename s_journal_flag_rwsem to s_writepages_rwsem
Date:   Wed, 19 Feb 2020 10:30:46 -0800
Message-Id: <20200219183047.47417-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219183047.47417-1-ebiggers@kernel.org>
References: <20200219183047.47417-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In preparation for making s_journal_flag_rwsem synchronize
ext4_writepages() with changes to both the EXTENTS and JOURNAL_DATA
flags (rather than just JOURNAL_DATA as it does currently), rename it to
s_writepages_rwsem.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/inode.c | 14 +++++++-------
 fs/ext4/super.c |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4441331d06cc4..487a7b430b9dd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1553,7 +1553,7 @@ struct ext4_sb_info {
 	struct ratelimit_state s_msg_ratelimit_state;
 
 	/* Barrier between changing inodes' journal flags and writepages ops. */
-	struct percpu_rw_semaphore s_journal_flag_rwsem;
+	struct percpu_rw_semaphore s_writepages_rwsem;
 	struct dax_device *s_daxdev;
 #ifdef CONFIG_EXT4_DEBUG
 	unsigned long s_simulate_fail;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c04a15fc8b6ad..f49c48ea2f170 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2628,7 +2628,7 @@ static int ext4_writepages(struct address_space *mapping,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-	percpu_down_read(&sbi->s_journal_flag_rwsem);
+	percpu_down_read(&sbi->s_writepages_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
 	/*
@@ -2849,7 +2849,7 @@ static int ext4_writepages(struct address_space *mapping,
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_journal_flag_rwsem);
+	percpu_up_read(&sbi->s_writepages_rwsem);
 	return ret;
 }
 
@@ -2864,13 +2864,13 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-	percpu_down_read(&sbi->s_journal_flag_rwsem);
+	percpu_down_read(&sbi->s_writepages_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
 	ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_journal_flag_rwsem);
+	percpu_up_read(&sbi->s_writepages_rwsem);
 	return ret;
 }
 
@@ -5861,7 +5861,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		}
 	}
 
-	percpu_down_write(&sbi->s_journal_flag_rwsem);
+	percpu_down_write(&sbi->s_writepages_rwsem);
 	jbd2_journal_lock_updates(journal);
 
 	/*
@@ -5878,7 +5878,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		err = jbd2_journal_flush(journal);
 		if (err < 0) {
 			jbd2_journal_unlock_updates(journal);
-			percpu_up_write(&sbi->s_journal_flag_rwsem);
+			percpu_up_write(&sbi->s_writepages_rwsem);
 			return err;
 		}
 		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
@@ -5886,7 +5886,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	ext4_set_aops(inode);
 
 	jbd2_journal_unlock_updates(journal);
-	percpu_up_write(&sbi->s_journal_flag_rwsem);
+	percpu_up_write(&sbi->s_writepages_rwsem);
 
 	if (val)
 		up_write(&EXT4_I(inode)->i_mmap_sem);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b0b9150c97735..feb59c7ad395f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1054,7 +1054,7 @@ static void ext4_put_super(struct super_block *sb)
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
-	percpu_free_rwsem(&sbi->s_journal_flag_rwsem);
+	percpu_free_rwsem(&sbi->s_writepages_rwsem);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < EXT4_MAXQUOTAS; i++)
 		kfree(get_qf_name(sb, sbi, i));
@@ -4600,7 +4600,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		err = percpu_counter_init(&sbi->s_dirtyclusters_counter, 0,
 					  GFP_KERNEL);
 	if (!err)
-		err = percpu_init_rwsem(&sbi->s_journal_flag_rwsem);
+		err = percpu_init_rwsem(&sbi->s_writepages_rwsem);
 
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "insufficient memory");
@@ -4694,7 +4694,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
-	percpu_free_rwsem(&sbi->s_journal_flag_rwsem);
+	percpu_free_rwsem(&sbi->s_writepages_rwsem);
 failed_mount5:
 	ext4_ext_release(sb);
 	ext4_release_system_zone(sb);

base-commit: c96dceeabf765d0b1b1f29c3bf50a5c01315b820
-- 
2.25.0

