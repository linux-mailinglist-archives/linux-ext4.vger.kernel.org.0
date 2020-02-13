Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 664A315BC82
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2020 11:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgBMKQJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 05:16:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:51230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbgBMKQH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Feb 2020 05:16:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ACF6DAF6E;
        Thu, 13 Feb 2020 10:16:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 311FA1E0E3B; Thu, 13 Feb 2020 11:16:05 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/7] ext2fs: Update allocation info earlier in ext2fs_mkdir() and ext2fs_symlink()
Date:   Thu, 13 Feb 2020 11:15:58 +0100
Message-Id: <20200213101602.29096-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213101602.29096-1-jack@suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently, ext2fs_mkdir() and ext2fs_symlink() update allocation bitmaps
and other information only close to the end of the function, in
particular after calling to ext2fs_link(). When ext2fs_link() will
support indexed directories, it will also need to allocate blocks and
that would cause filesystem corruption in case allocation info isn't
properly updated. So make sure ext2fs_mkdir() and ext2fs_symlink()
update allocation info before calling into ext2fs_link().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/ext2fs/mkdir.c   | 14 +++++++-------
 lib/ext2fs/symlink.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/lib/ext2fs/mkdir.c b/lib/ext2fs/mkdir.c
index 2a63aad16715..947003ebf309 100644
--- a/lib/ext2fs/mkdir.c
+++ b/lib/ext2fs/mkdir.c
@@ -143,6 +143,13 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
 		}
 	}
 
+	/*
+	 * Update accounting....
+	 */
+	if (!inline_data)
+		ext2fs_block_alloc_stats2(fs, blk, +1);
+	ext2fs_inode_alloc_stats2(fs, ino, +1, 1);
+
 	/*
 	 * Link the directory into the filesystem hierarchy
 	 */
@@ -175,13 +182,6 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
 			goto cleanup;
 	}
 
-	/*
-	 * Update accounting....
-	 */
-	if (!inline_data)
-		ext2fs_block_alloc_stats2(fs, blk, +1);
-	ext2fs_inode_alloc_stats2(fs, ino, +1, 1);
-
 cleanup:
 	if (block)
 		ext2fs_free_mem(&block);
diff --git a/lib/ext2fs/symlink.c b/lib/ext2fs/symlink.c
index 7f78c5f75549..3e07a539daf3 100644
--- a/lib/ext2fs/symlink.c
+++ b/lib/ext2fs/symlink.c
@@ -162,6 +162,13 @@ need_block:
 			goto cleanup;
 	}
 
+	/*
+	 * Update accounting....
+	 */
+	if (!fastlink && !inlinelink)
+		ext2fs_block_alloc_stats2(fs, blk, +1);
+	ext2fs_inode_alloc_stats2(fs, ino, +1, 0);
+
 	/*
 	 * Link the symlink into the filesystem hierarchy
 	 */
@@ -179,13 +186,6 @@ need_block:
 			goto cleanup;
 	}
 
-	/*
-	 * Update accounting....
-	 */
-	if (!fastlink && !inlinelink)
-		ext2fs_block_alloc_stats2(fs, blk, +1);
-	ext2fs_inode_alloc_stats2(fs, ino, +1, 0);
-
 cleanup:
 	if (block_buf)
 		ext2fs_free_mem(&block_buf);
-- 
2.16.4

