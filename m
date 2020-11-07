Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408582AA67A
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 16:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgKGP6o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 10:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgKGP6n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 10:58:43 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19151C0613CF
        for <linux-ext4@vger.kernel.org>; Sat,  7 Nov 2020 07:58:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x15so1576616pll.2
        for <linux-ext4@vger.kernel.org>; Sat, 07 Nov 2020 07:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TpF3slMatQgkTK4jzVKgzgOPdgG3dN/vynMXvLn747k=;
        b=FQSPwAYelJHxN1NrYTp6XKNOub1eXIBZvJkwQ/ZLlWY62MhqQAmpVvswdLyNvtOn8F
         jt58dTDaaazcMZfVPrrghOVyRRZsojU4JUtN0ZYtF59pjhKmV/Q9v/PM1x6XTcZTE3DZ
         XQ2RirRRrpJ+u3LA0UZVV/Zq6ei9z2Lc4aPhVG9h6qA7hLDemdItcsilsBQDK3ngMz8G
         1PJOBRBdR3H03DGSMNpC8/JDJ1lYKftEaLCWvw9sznZsdtzk1uxtiYqyF1GAT1n5hGa5
         ZAX3/mE7AgFFC8v4tM2U1aw4L+fLMZEniNj+z3lkv+nE7tqBflaz1h6RxcZk4bab77X1
         Bc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TpF3slMatQgkTK4jzVKgzgOPdgG3dN/vynMXvLn747k=;
        b=uFjpMIHTfo1KVuSV4w15vCot8hlTENFzTe8VAfkiUwPpSvhwZIixDC2o3/zJ+hoP7I
         wrr1Ciph/yrghhZl+hdhTq+/gHnvviUkEDjDM2JiKZpmNZXR+wgv/njMXyPMJEBYScii
         4yFXbz/CslvjivAnQjEnBVPdXuN0aSiUMsHiLFEMlstVoS8wnR6JsWMkXg2aptCNfiZV
         W+dkoDHzYYI3A/+f5aokIG1sx/+gYWouUr2Z8//xhZC/obJq1TkU95PU9YC32GF6VRxi
         uGfSPzZPuHaw/eEBWKcy9B5PvpZmaLU+B0OXNCbdoRKpNKILkA3XfgAuOjusxDmqLB+c
         5w3w==
X-Gm-Message-State: AOAM532g3FUP7SJeu480q8/XLeqgpxqbcMXKKxrDK3QawFkyKevWDGPV
        B3QpSvztYIoSZKTrBiUw+DY5d2c4RYA=
X-Google-Smtp-Source: ABdhPJzc2sQ5md5qvuw5cfDvaqbcN4TG87qy50yd7BBg2Gp4I+4iR5bH7n+IjPNub6XKc+rf2COFVg==
X-Received: by 2002:a17:90a:d590:: with SMTP id v16mr4780100pju.88.1604764721517;
        Sat, 07 Nov 2020 07:58:41 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id e81sm6049956pfh.104.2020.11.07.07.58.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 07:58:41 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH RESEND 1/8] ext4: use ext4_assert() to replace J_ASSERT()
Date:   Sat,  7 Nov 2020 23:58:11 +0800
Message-Id: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
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
index 1b399ca..bd88b4a 100644
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
index a42ca95..7e74279 100644
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
index 0d8385a..67fa932 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -830,8 +830,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	int create = map_flags & EXT4_GET_BLOCKS_CREATE;
 	int err;
 
-	J_ASSERT((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
-		 || handle != NULL || create == 0);
+	ext4_assert((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		    || handle != NULL || create == 0);
 
 	map.m_lblk = block;
 	map.m_len = 1;
@@ -846,9 +846,9 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
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
index 3350926..9177352 100644
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
@@ -849,7 +845,7 @@ struct stats dx_show_entries(struct dx_hash_info *hinfo, struct inode *dir,
 					break;
 				}
 			}
-			assert (at == p - 1);
+			ext4_assert(at == p - 1);
 		}
 
 		at = p - 1;
@@ -1265,8 +1261,8 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 	struct dx_entry *old = frame->at, *new = old + 1;
 	int count = dx_get_count(entries);
 
-	assert(count < dx_get_limit(entries));
-	assert(old < entries + count);
+	ext4_assert(count < dx_get_limit(entries));
+	ext4_assert(old < entries + count);
 	memmove(new + 1, new, (char *)(entries + count) - (char *)(new));
 	dx_set_hash(new, hash);
 	dx_set_block(new, block);
@@ -2961,7 +2957,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	 * hold i_mutex, or the inode can not be referenced from outside,
 	 * so i_nlink should not be bumped due to race
 	 */
-	J_ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+	ext4_assert((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 		  S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
 
 	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c3b8645..5006c42 100644
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

