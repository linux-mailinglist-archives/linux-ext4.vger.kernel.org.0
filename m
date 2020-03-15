Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6A3185E6B
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Mar 2020 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgCOQPS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Mar 2020 12:15:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45392 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728695AbgCOQPS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Mar 2020 12:15:18 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02FGF9OO021672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Mar 2020 12:15:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 61D01420EBA; Sun, 15 Mar 2020 12:15:09 -0400 (EDT)
Date:   Sun, 15 Mar 2020 12:15:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/7] ext2fs: Update allocation info earlier in
 ext2fs_mkdir() and ext2fs_symlink()
Message-ID: <20200315161509.GQ225435@mit.edu>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-4-jack@suse.cz>
 <20200308000220.GF99899@mit.edu>
 <20200308022024.GG99899@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308022024.GG99899@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ah, I see now why this patch is needed.  If we don't update the block
allocation bitmap to indicate block has been taken, and there is a
need to allocate an htree index block, we will end up allocating the
same block twice.

Thanks, I've applied this patch with the following added.

     	     	  	     	 	   - Ted

diff --git a/lib/ext2fs/mkdir.c b/lib/ext2fs/mkdir.c
index 947003eb..437c8ffc 100644
--- a/lib/ext2fs/mkdir.c
+++ b/lib/ext2fs/mkdir.c
@@ -43,6 +43,7 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
 	blk64_t			blk;
 	char			*block = 0;
 	int			inline_data = 0;
+	int			drop_refcount = 0;
 
 	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
 
@@ -149,6 +150,7 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
 	if (!inline_data)
 		ext2fs_block_alloc_stats2(fs, blk, +1);
 	ext2fs_inode_alloc_stats2(fs, ino, +1, 1);
+	drop_refcount = 1;
 
 	/*
 	 * Link the directory into the filesystem hierarchy
@@ -181,10 +183,16 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
 		if (retval)
 			goto cleanup;
 	}
+	drop_refcount = 0;
 
 cleanup:
 	if (block)
 		ext2fs_free_mem(&block);
+	if (drop_refcount) {
+		if (!inline_data)
+			ext2fs_block_alloc_stats2(fs, blk, -1);
+		ext2fs_inode_alloc_stats2(fs, ino, -1, 1);
+	}
 	return retval;
 
 }
diff --git a/lib/ext2fs/symlink.c b/lib/ext2fs/symlink.c
index 3e07a539..a66fb7ec 100644
--- a/lib/ext2fs/symlink.c
+++ b/lib/ext2fs/symlink.c
@@ -54,6 +54,7 @@ errcode_t ext2fs_symlink(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t ino,
 	int			fastlink, inlinelink;
 	unsigned int		target_len;
 	char			*block_buf = 0;
+	int			drop_refcount = 0;
 
 	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
 
@@ -168,6 +169,7 @@ need_block:
 	if (!fastlink && !inlinelink)
 		ext2fs_block_alloc_stats2(fs, blk, +1);
 	ext2fs_inode_alloc_stats2(fs, ino, +1, 0);
+	drop_refcount = 1;
 
 	/*
 	 * Link the symlink into the filesystem hierarchy
@@ -185,10 +187,16 @@ need_block:
 		if (retval)
 			goto cleanup;
 	}
+	drop_refcount = 0;
 
 cleanup:
 	if (block_buf)
 		ext2fs_free_mem(&block_buf);
+	if (drop_refcount) {
+		if (!fastlink && !inlinelink)
+			ext2fs_block_alloc_stats2(fs, blk, -1);
+		ext2fs_inode_alloc_stats2(fs, ino, -1, 0);
+	}
 	return retval;
 }
 
