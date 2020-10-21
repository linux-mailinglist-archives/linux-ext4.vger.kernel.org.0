Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F25294A4C
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437537AbgJUJQM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 05:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437430AbgJUJQM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 05:16:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E09C0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t18so918641plo.1
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YFIgq6IHz+ANfoFvWyvqx6bIjmzvr6Z3VjVW5Q2qCA4=;
        b=Ulv4II0BEf0QkCY4V4/thju68+KuBdtmb1NZcq+orn6jtWQQbXaZUjyJttHADXuLm9
         fdui3yyq9bHVOMlpTY5s5eYhhZ2s4SPpJwHp4KoIvifaiR6C3HF7NIwyWOXLABauR/F6
         vTBdCoZDacxZ5kvDwQi+jIOg/53Vxp8uHQ2l2vfmCyBCRchWSv5xWmJcu1wtxsQ62CWS
         +G5ljs8F9JvkqZaDqwDtxdrkGndw4p23a8aUJCow3rJXQ1x8AoS4eJnn97um73ynp2Tu
         zKpSH1cOE5m8Mv11Oi8IXb6EfWz8YCNLtNCXmuvT0Am3qfWQl+xpyxR1KnCAYtPMHeRq
         eMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YFIgq6IHz+ANfoFvWyvqx6bIjmzvr6Z3VjVW5Q2qCA4=;
        b=tNvZxoYFqEbQaEkXLSZFx1KjDBucfjmwcsfybFOQQJMnFpZd/Iy9G8y8zoc6plOuvv
         cSZp2bR8ExxMZyIy+0e7a3hY3TTrQdPpH1VKbUkp2N1dWTnsQIphu/J6LIlz6ZAqqbRH
         bA+fEur4VDgQIlNgtG7p5TYbq3+8uFSbNpjYRIpNo1GyYtYY1ZVEs8pPmRAr9HjZIJoO
         yvvh9pypOOAaYzyTYEFxh40xc+/ZW5qJCj+I5ZhhGau5r8Ze6SHVF023Kv8izCrNoS6W
         d07vi3pxFt6YeqUXfca3pc4RKkKH3x0dg4Lf0PCJ6nYBVoVrk61P1tJcODS9hLJfArJg
         0+oQ==
X-Gm-Message-State: AOAM532Oo18hKbxCEdMQCyEJRv2BPjso9KXG+iqPcWHQRnK6jP+F2p31
        vU5dQYXKikyljgpznyRPUMtNYj086PU=
X-Google-Smtp-Source: ABdhPJwjww64UUCCOuFDIfok5LHoNmjtNkbigyFW/cWxYsx3t4tABLCb8OP6nhWyi+oIMSBS4EcqRQ==
X-Received: by 2002:a17:90a:f183:: with SMTP id bv3mr1073386pjb.23.1603271771631;
        Wed, 21 Oct 2020 02:16:11 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x16sm1573002pff.14.2020.10.21.02.16.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 02:16:11 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/8] ext4: use ext4_assert() to replace J_ASSERT()
Date:   Wed, 21 Oct 2020 17:15:21 +0800
Message-Id: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

There are currently multiple forms of assertion, such as J_ASSERT().
J_ASEERT() is provided for the jbd module, which is a public module.
Maybe we should use custom ASSERT() like other file systems, such as
xfs, which would be better.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/balloc.c   |  2 +-
 fs/ext4/ext4.h     | 10 ++++++++++
 fs/ext4/fsync.c    |  2 +-
 fs/ext4/indirect.c |  4 ++--
 fs/ext4/inode.c    | 10 +++++-----
 fs/ext4/namei.c    | 12 ++++--------
 fs/ext4/super.c    |  2 +-
 7 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 1d640b1..2d7f4eb 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -185,7 +185,7 @@ static int ext4_init_block_bitmap(struct super_block *sb,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t start, tmp;
 
-	J_ASSERT_BH(bh, buffer_locked(bh));
+	ext4_assert(buffer_locked(bh));
 
 	/* If checksum is bad mark all blocks used to prevent allocation
 	 * essentially implementing a per-group read-only flag. */
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18a6df4..e7344ef 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -98,6 +98,16 @@
 #define ext_debug(ino, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
+#define ext4_assert(assert)						\
+do {									\
+	if (unlikely(!(assert))) {					\
+		printk(KERN_EMERG					\
+		       "Assertion failure in %s() at %s:%d: '%s'\n",	\
+		       __func__, __FILE__, __LINE__, #assert);		\
+		BUG();							\
+	}								\
+} while (0)
+
 /* data type for block offset of block group */
 typedef int ext4_grpblk_t;
 
diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 81a545f..123a0cb 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -136,7 +136,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (unlikely(ext4_forced_shutdown(sbi)))
 		return -EIO;
 
-	J_ASSERT(ext4_journal_current_handle() == NULL);
+	ext4_assert(ext4_journal_current_handle() == NULL);
 
 	trace_ext4_sync_file_enter(file, datasync);
 
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 05efa682..bffc5e4 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -534,8 +534,8 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	ext4_fsblk_t first_block = 0;
 
 	trace_ext4_ind_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
-	J_ASSERT(!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)));
-	J_ASSERT(handle != NULL || (flags & EXT4_GET_BLOCKS_CREATE) == 0);
+	ext4_assert(!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)));
+	ext4_assert(handle != NULL || (flags & EXT4_GET_BLOCKS_CREATE) == 0);
 	depth = ext4_block_to_path(inode, map->m_lblk, offsets,
 				   &blocks_to_boundary);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2154e08..97ebf61 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -828,8 +828,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	int create = map_flags & EXT4_GET_BLOCKS_CREATE;
 	int err;
 
-	J_ASSERT((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
-		 || handle != NULL || create == 0);
+	ext4_assert((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		    || handle != NULL || create == 0);
 
 	map.m_lblk = block;
 	map.m_len = 1;
@@ -844,9 +844,9 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 	if (map.m_flags & EXT4_MAP_NEW) {
-		J_ASSERT(create != 0);
-		J_ASSERT((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
-			 || (handle != NULL));
+		ext4_assert(create != 0);
+		ext4_assert((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+			    || (handle != NULL));
 
 		/*
 		 * Now that we do not always journal data, we should
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cde3460..fa16578 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -182,10 +182,6 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 	return bh;
 }
 
-#ifndef assert
-#define assert(test) J_ASSERT(test)
-#endif
-
 #ifdef DX_DEBUG
 #define dxtrace(command) command
 #else
@@ -850,7 +846,7 @@ struct stats dx_show_entries(struct dx_hash_info *hinfo, struct inode *dir,
 					break;
 				}
 			}
-			assert (at == p - 1);
+			ext4_assert(at == p - 1);
 		}
 
 		at = p - 1;
@@ -1266,8 +1262,8 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 	struct dx_entry *old = frame->at, *new = old + 1;
 	int count = dx_get_count(entries);
 
-	assert(count < dx_get_limit(entries));
-	assert(old < entries + count);
+	ext4_assert(count < dx_get_limit(entries));
+	ext4_assert(old < entries + count);
 	memmove(new + 1, new, (char *)(entries + count) - (char *)(new));
 	dx_set_hash(new, hash);
 	dx_set_block(new, block);
@@ -2971,7 +2967,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	 * hold i_mutex, or the inode can not be referenced from outside,
 	 * so i_nlink should not be bumped due to race
 	 */
-	J_ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+	ext4_assert((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 		  S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
 
 	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5308f0d..7773d7c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1251,7 +1251,7 @@ static void ext4_put_super(struct super_block *sb)
 	 * in-memory list had better be clean by this point. */
 	if (!list_empty(&sbi->s_orphan))
 		dump_orphan_list(sb, sbi);
-	J_ASSERT(list_empty(&sbi->s_orphan));
+	ext4_assert(list_empty(&sbi->s_orphan));
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-- 
1.8.3.1

