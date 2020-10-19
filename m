Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776C029242E
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgJSJCm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgJSJCm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 05:02:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73182C0613CE
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a1so5309881pjd.1
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yw181Un+iNI85L/oY3AH/ewIof756biovKz5jt1zJSs=;
        b=ryv+WlYpodxIsrXun+fWrS07Wh3YP4hXslWhI0YO+OO98KrIOjp36ICrrIi2xrRolW
         7MFnPjk8/sf7PbtKo3PtKv1cOZrdvcbgAhQuVTd3zYoA9ZomRERM+3pg4Oa76WKzCgXT
         ikP/AeDWF4ADqnFv4FeI3r1mQoEppLT2+W2aV2hZj0RhqwGGjRg7loNO09CjDCMqewty
         lmNe548PUZ140p6MzEuW4EvCOJU/jwTZla0KruTYH1megEy5D5opJqzri5PAftI5OsNh
         STPnF7LZMU2kruRzaMhuVcW7imaGLoXbIPmqE5svSjLdZ7D4wtflPPw4CtBIrn/hejpG
         QaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yw181Un+iNI85L/oY3AH/ewIof756biovKz5jt1zJSs=;
        b=FNdHQZWCAhpkc4bei735cx49MmF7w6OXyQRgfoSAhbD/VLSlOcdQ0PmxlDwpgYF9ev
         uuboMSwzyTH5JbN8Tga1gd6+npThO1YVzdu6uoTMEJ72N3w90aq1pM7Vm/1OkE9ZGx0/
         zCyNBP9ibQfND7gD1wnDHXlTBoeDFpPLJzRaEGZ4LRS9CEUmeIInL2nq7vHVxwfqhXMb
         lFqQa8vDzAJcF+q1MMofmFBDxa5FKgwm2THya5zDb1AcXcoFT8moz57K3oaOoR30Ekn0
         xPpBCQMyE9hv86e+Pur9Ks2nNOxCHa7+YJCqcAvhN/rgdu7S1xpZxciNm6Dx7UaNXSC8
         ojJg==
X-Gm-Message-State: AOAM532DmsjAfodQVGvVXQigHQ8xOXAGV2EfnJeVEO0Q9Yp02xCdOOTx
        d4rsNP2PcZ6Lt45+QwU3O8KfsVgO6uU=
X-Google-Smtp-Source: ABdhPJzEFLCIWLXaUbzzn6P7/RlOzjnS8mW20VDSUhIIqFHs31H2u32QGyiPqyQJ8yCYtGrpcWQ7yQ==
X-Received: by 2002:a17:902:b111:b029:d4:cf7c:2ff1 with SMTP id q17-20020a170902b111b02900d4cf7c2ff1mr16629205plr.59.1603098162021;
        Mon, 19 Oct 2020 02:02:42 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id 14sm11422880pjn.48.2020.10.19.02.02.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 02:02:41 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 1/8] ext4: use ASSERT() to replace J_ASSERT()
Date:   Mon, 19 Oct 2020 17:02:31 +0800
Message-Id: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
index dea738b..386cfc3 100644
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
index 250e905..512f833 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -98,6 +98,16 @@
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
index 6476994..f9e33c7 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -136,7 +136,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (unlikely(ext4_forced_shutdown(sbi)))
 		return -EIO;
 
-	J_ASSERT(ext4_journal_current_handle() == NULL);
+	ASSERT(ext4_journal_current_handle() == NULL);
 
 	trace_ext4_sync_file_enter(file, datasync);
 
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 05efa682..1223a18 100644
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
index 09096fe..8113898 100644
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
index b735372..1cb9424 100644
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
+			ASSERT(at == p - 1);
 		}
 
 		at = p - 1;
@@ -1265,8 +1261,8 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 	struct dx_entry *old = frame->at, *new = old + 1;
 	int count = dx_get_count(entries);
 
-	assert(count < dx_get_limit(entries));
-	assert(old < entries + count);
+	ASSERT(count < dx_get_limit(entries));
+	ASSERT(old < entries + count);
 	memmove(new + 1, new, (char *)(entries + count) - (char *)(new));
 	dx_set_hash(new, hash);
 	dx_set_block(new, block);
@@ -2959,7 +2955,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	 * hold i_mutex, or the inode can not be referenced from outside,
 	 * so i_nlink should not be bumped due to race
 	 */
-	J_ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+	ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 		  S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
 
 	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9d01318..8aa163a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1251,7 +1251,7 @@ static void ext4_put_super(struct super_block *sb)
 	 * in-memory list had better be clean by this point. */
 	if (!list_empty(&sbi->s_orphan))
 		dump_orphan_list(sb, sbi);
-	J_ASSERT(list_empty(&sbi->s_orphan));
+	ASSERT(list_empty(&sbi->s_orphan));
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-- 
1.8.3.1

