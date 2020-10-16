Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1999228FD01
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Oct 2020 05:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394316AbgJPD4C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 23:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394314AbgJPD4B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 23:56:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7FBC061755
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y14so678837pfp.13
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bDvLnZpC7VjIftKIevOdiUqg5b8WOf4ZhcX0frlwzlA=;
        b=nrZ4C663NZcfbo+5REf4KJkjDJodyY3HbeCPOxcS/hOnwn8Mr5eUPyZ1lAVoy7JIbN
         zIh8hkbISi6qIHEEjKl2yN4XUFXxzLLOwoShYj+U0pE8bl314+jUjMjRY3yR00kxr5uP
         3rTC999BMIU/+gySVRy6Yr51YR9XbCK+nb1CcEGTyyE5mM2THgWygTiSa9ySjXVhaNca
         JI66SO3b4Uddpsoe5DyFw9BCo3LSij0KK+CRL7jsNK/lrFwW9m/iuqVsO39u6bMG+ldh
         OcWYD/jM+9m/nCliidhxQRI8DILUKf6w/5Yx+s+LTubPsEFSLq9yaXgUPQkBZBLpUi3P
         UedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bDvLnZpC7VjIftKIevOdiUqg5b8WOf4ZhcX0frlwzlA=;
        b=qZemo9d81t/DWSbxivCVIuG/E2ASBzfYPyCCNfVXVRGWWy1k8NYBZuxhP4VHeT/lI2
         RQiOiedmgh9Ao1R9yHDSQt6I70QrsQQa0Tk9SObsHiDY4YeE6glGfcg362gT66yGMUYk
         LZJaEnYixf1VOmPIKFhLL+Iy9EiW5shx8Z0quc7weM0X7F/ugpHqi0eIpzAcO4V+eHbW
         nRdJSpaoj/mKV2aFNKQM0ipRyuq9fbUc4bxlfuAiBPmX0y52iYb2DjntiI+Fae90YdSw
         CocQZnl58hrUNP9o1+Fw6j0b1xyeIMojr55Dks3/W/FYGUP+HKp229oVNY8ODOdSK+OM
         782Q==
X-Gm-Message-State: AOAM530zSyh8vf9UDlbeIG4Ow87rcqKcE+Cm7XTjtYelrZTLxKk5la0O
        gme3ZReZNdLOmubTzHHF2kU=
X-Google-Smtp-Source: ABdhPJzfQKxDBZ3PF1+8mh/4mLDQPhHVKW5RbeJgV/w2HpFmncqWSW4XBCa9/CLJhuJqGKJO4q5faQ==
X-Received: by 2002:a62:32c5:0:b029:158:7361:58d3 with SMTP id y188-20020a6232c50000b0290158736158d3mr1776747pfy.75.1602820560819;
        Thu, 15 Oct 2020 20:56:00 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id v12sm861555pgr.4.2020.10.15.20.55.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 20:56:00 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/8] ext4: use ASSERT() to replace J_ASSERT()
Date:   Fri, 16 Oct 2020 11:55:45 +0800
Message-Id: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

There are currently multiple forms of assertion, such as J_ASSERT().
J_ASEERT is provided for the jbd module, which is a public module.
Maybe we should use custom ASSERT() like other file systems, such as
xfs, which would be better.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/balloc.c   |  2 +-
 fs/ext4/ext4.h     | 10 ++++++++++
 fs/ext4/fsync.c    |  2 +-
 fs/ext4/indirect.c |  4 ++--
 fs/ext4/inode.c    |  6 +++---
 fs/ext4/namei.c    | 12 ++++--------
 fs/ext4/super.c    |  2 +-
 7 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 48c3df4..db7fa3e 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -185,7 +185,7 @@ static int ext4_init_block_bitmap(struct super_block *sb,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t start, tmp;
 
-	J_ASSERT_BH(bh, buffer_locked(bh));
+	ASSERT(buffer_locked(bh));
 
 	/* If checksum is bad mark all blocks used to prevent allocation
 	 * essentially implementing a per-group read-only flag. */
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b883a78..85d6900 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -99,6 +99,16 @@
 #define ext_debug(ino, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
+#define ASSERT(assert)							\
+do {									\
+	if (unlikely(!(assert))) {					\
+		printk(KERN_EMERG					\
+		       "Assertion failure in %s() at %s:%d: \"%s\"\n",	\
+		       __func__, __FILE__, __LINE__, #assert);		\
+		BUG();							\
+	}								\
+} while (0)
+
 /* data type for block offset of block group */
 typedef int ext4_grpblk_t;
 
diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 1d668c8..b21394d 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -136,7 +136,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (unlikely(ext4_forced_shutdown(sbi)))
 		return -EIO;
 
-	J_ASSERT(ext4_journal_current_handle() == NULL);
+	ASSERT(ext4_journal_current_handle() == NULL);
 
 	trace_ext4_sync_file_enter(file, datasync);
 
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 80c9f33..7442490 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -534,8 +534,8 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	ext4_fsblk_t first_block = 0;
 
 	trace_ext4_ind_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
-	J_ASSERT(!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)));
-	J_ASSERT(handle != NULL || (flags & EXT4_GET_BLOCKS_CREATE) == 0);
+	ASSERT(!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)));
+	ASSERT(handle != NULL || (flags & EXT4_GET_BLOCKS_CREATE) == 0);
 	depth = ext4_block_to_path(inode, map->m_lblk, offsets,
 				   &blocks_to_boundary);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf59646..6c70d8c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -825,7 +825,7 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	int create = map_flags & EXT4_GET_BLOCKS_CREATE;
 	int err;
 
-	J_ASSERT(handle != NULL || create == 0);
+	ASSERT(handle != NULL || create == 0);
 
 	map.m_lblk = block;
 	map.m_len = 1;
@@ -840,8 +840,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 	if (map.m_flags & EXT4_MAP_NEW) {
-		J_ASSERT(create != 0);
-		J_ASSERT(handle != NULL);
+		ASSERT(create != 0);
+		ASSERT(handle != NULL);
 
 		/*
 		 * Now that we do not always journal data, we should
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 153a9fb..f2ca312 100644
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
+			ASSERT(at == p - 1);
 		}
 
 		at = p - 1;
@@ -1266,8 +1262,8 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 	struct dx_entry *old = frame->at, *new = old + 1;
 	int count = dx_get_count(entries);
 
-	assert(count < dx_get_limit(entries));
-	assert(old < entries + count);
+	ASSERT(count < dx_get_limit(entries));
+	ASSERT(old < entries + count);
 	memmove(new + 1, new, (char *)(entries + count) - (char *)(new));
 	dx_set_hash(new, hash);
 	dx_set_block(new, block);
@@ -2960,7 +2956,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	 * hold i_mutex, or the inode can not be referenced from outside,
 	 * so i_nlink should not be bumped due to race
 	 */
-	J_ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+	ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 		  S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
 
 	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ea425b4..12f0b5d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1069,7 +1069,7 @@ static void ext4_put_super(struct super_block *sb)
 	 * in-memory list had better be clean by this point. */
 	if (!list_empty(&sbi->s_orphan))
 		dump_orphan_list(sb, sbi);
-	J_ASSERT(list_empty(&sbi->s_orphan));
+	ASSERT(list_empty(&sbi->s_orphan));
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-- 
1.8.3.1

