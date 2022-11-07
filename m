Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA30161F2E7
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiKGMXk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiKGMXh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:23:37 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E80E63D5
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:23:36 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g24so10914548plq.3
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvTW6jamv93zZLHw0sL+JvIG/eGiiBZQA/Z4AIhsJ3o=;
        b=odGGP31j3pmLdnvIeQWAvG6AuTassx+sRxlS3x0ci1plwjWl6w6gxpaM5sG9nBVMQu
         SpdZTEDlu27uxgCLDVyHAn4R5JIym/jynpSo5mjVy1kUdh1A1zpyVH8YUDvxbLnPzQWR
         RHlh+UA93awQlWbADjfxPQ/8nRhZz6/PwDyV9ln/JIj6xkRT3/g6eLhdwoW3EqyKsyYE
         qlK6HkSgpD2iJr123YhHIyn6VvzTIj6Wif+tlZb6O1kBHgyGC93uoV31MmGHzVHgUjXI
         Adftpouogfrc94K9rj5AQ5O0dOgfnz6LEfQMpqLNZIHl+FuEv2tN47WiDMGnU5S3CBRv
         V/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvTW6jamv93zZLHw0sL+JvIG/eGiiBZQA/Z4AIhsJ3o=;
        b=tmwj9BiDrCkImHI28bKjjned/HFD5LuFTJH6h9seJ+ll1dylULACSWUeS0w0QPkENs
         Pj0/SDZdPmMX8RT5w4HYYMgdPMWLrnn3Z6phXlTMGoUY+4UZDT9e3lg3eP5fakbgkSPf
         PpT0s0z2DvO1Ddag8x0L6qA7UqrjgmqJXgZLRQUQVwe8s1WBhUP/OeemS9tIMolADpV6
         O3/tFPf81Agdgfw+9lp+i1KjgCgsCHgvvR2rFAFD4mWT1sdKMLU3AuGcUskys8CJxnHC
         Ci8P1SggVzL580POtSAiLEYl2Pfb+h+OXm+5v62DGJURNrurFDbFhLuaDe3/UnzqTOiI
         Q7DA==
X-Gm-Message-State: ACrzQf1OxWzSGX5CE/cneeEtfTWkhCpo8KR2UjN86pUQIBTYaP/uPJNO
        ps5SmI5WyYuOCgU/elLziKU=
X-Google-Smtp-Source: AMsMyM5NjqEgDyyV1fO1zckTVtif+gXHKM3W7Y3bzzCZeYpnxBRu6YE42v7G1gZev9kiIRq01kfU/A==
X-Received: by 2002:a17:90a:d084:b0:213:8cf1:4d34 with SMTP id k4-20020a17090ad08400b002138cf14d34mr52416138pju.150.1667823815701;
        Mon, 07 Nov 2022 04:23:35 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902784400b001871acf245csm4867010pln.37.2022.11.07.04.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:23:35 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 12/72] libext2fs: dupfs: Add fs clone & merge api
Date:   Mon,  7 Nov 2022 17:51:00 +0530
Message-Id: <e6d1ef1be6dd5a82b223e77d2d6713c1c84aa977.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Saranya Muruganandam <saranyamohan@google.com>

This patch mainly adds "parent" & "clone_flags" member in ext2_filsys struct
for enabling multi-threading. Based on what CLONE flags will be passed from
the client of libext2fs down to ext2fs_clone_fs(), those structures/bitmaps will
be cloned (thread-aware child copy) and rest will be shared with the parent fs.

The same flags will also help to merge those cloned bitmap structures back into
the parent bitmaps when ext2fs_merge_fs() will be called with childfs struct.

Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/dupfs.c  | 183 ++++++++++++++++++++++++++++++++++++++++++++
 lib/ext2fs/ext2fs.h |  23 ++++++
 2 files changed, 206 insertions(+)

diff --git a/lib/ext2fs/dupfs.c b/lib/ext2fs/dupfs.c
index 02721e1a..ecc57cf7 100644
--- a/lib/ext2fs/dupfs.c
+++ b/lib/ext2fs/dupfs.c
@@ -14,8 +14,12 @@
 #if HAVE_UNISTD_H
 #include <unistd.h>
 #endif
+#if HAVE_PTHREAD_H
+#include <pthread.h>
+#endif
 #include <time.h>
 #include <string.h>
+#include <assert.h>
 
 #include "ext2_fs.h"
 #include "ext2fsP.h"
@@ -120,3 +124,182 @@ errout:
 
 }
 
+#ifdef HAVE_PTHREAD
+errcode_t ext2fs_clone_fs(ext2_filsys fs, ext2_filsys *dest, unsigned int flags)
+{
+	errcode_t retval;
+	ext2_filsys childfs;
+
+	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
+
+	retval = ext2fs_get_mem(sizeof(struct struct_ext2_filsys), &childfs);
+	if (retval)
+		return retval;
+
+	/* make an exact copy implying lists and memory structures are shared */
+	memcpy(childfs, fs, sizeof(struct struct_ext2_filsys));
+	childfs->inode_map = NULL;
+	childfs->block_map = NULL;
+	childfs->badblocks = NULL;
+	childfs->dblist = NULL;
+
+	pthread_mutex_lock(&fs->refcount_mutex);
+	fs->refcount++;
+	pthread_mutex_unlock(&fs->refcount_mutex);
+
+	if ((flags & EXT2FS_CLONE_INODE) && fs->inode_map) {
+		retval = ext2fs_copy_bitmap(fs->inode_map, &childfs->inode_map);
+		if (retval)
+			return retval;
+		childfs->inode_map->fs = childfs;
+	}
+
+	if ((flags & EXT2FS_CLONE_BLOCK) && fs->block_map) {
+		retval = ext2fs_copy_bitmap(fs->block_map, &childfs->block_map);
+		if (retval)
+			return retval;
+		childfs->block_map->fs = childfs;
+	}
+
+	if ((flags & EXT2FS_CLONE_BADBLOCKS) && fs->badblocks) {
+		retval = ext2fs_badblocks_copy(fs->badblocks, &childfs->badblocks);
+		if (retval)
+			return retval;
+	}
+
+	if ((flags & EXT2FS_CLONE_DBLIST) && fs->dblist) {
+		retval = ext2fs_copy_dblist(fs->dblist, &childfs->dblist);
+		if (retval)
+			return retval;
+		childfs->dblist->fs = childfs;
+	}
+
+	/* icache when NULL will be rebuilt if needed */
+	childfs->icache = NULL;
+
+	childfs->clone_flags = flags;
+	childfs->parent = fs;
+	*dest = childfs;
+
+	return 0;
+}
+
+errcode_t ext2fs_merge_fs(ext2_filsys *thread_fs)
+{
+	ext2_filsys fs = *thread_fs;
+	errcode_t retval = 0;
+	ext2_filsys dest = fs->parent;
+	ext2_filsys src = fs;
+	unsigned int flags = fs->clone_flags;
+	struct ext2_inode_cache *icache;
+	io_channel dest_io;
+	io_channel dest_image_io;
+	ext2fs_inode_bitmap inode_map;
+	ext2fs_block_bitmap block_map;
+	ext2_badblocks_list badblocks;
+	ext2_dblist dblist;
+	void *priv_data;
+	int fsflags;
+
+	pthread_mutex_lock(&fs->refcount_mutex);
+	fs->refcount--;
+	assert(fs->refcount >= 0);
+	pthread_mutex_unlock(&fs->refcount_mutex);
+
+	icache = dest->icache;
+	dest_io = dest->io;
+	dest_image_io = dest->image_io;
+	inode_map = dest->inode_map;
+	block_map = dest->block_map;
+	badblocks = dest->badblocks;
+	dblist = dest->dblist;
+	priv_data = dest->priv_data;
+	fsflags = dest->flags;
+
+	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
+
+	dest->io = dest_io;
+	dest->image_io = dest_image_io;
+	dest->icache = icache;
+	dest->inode_map = inode_map;
+	dest->block_map = block_map;
+	dest->badblocks = badblocks;
+	dest->dblist = dblist;
+	dest->priv_data = priv_data;
+	if (dest->dblist)
+		dest->dblist->fs = dest;
+	dest->flags = src->flags | fsflags;
+	if (!(src->flags & EXT2_FLAG_VALID) || !(dest->flags & EXT2_FLAG_VALID))
+		ext2fs_unmark_valid(dest);
+
+	if ((flags & EXT2FS_CLONE_INODE) && src->inode_map) {
+		if (dest->inode_map == NULL) {
+			dest->inode_map = src->inode_map;
+			src->inode_map = NULL;
+		} else {
+			retval = ext2fs_merge_bitmap(src->inode_map, dest->inode_map, NULL, NULL);
+			if (retval)
+				goto out;
+		}
+		dest->inode_map->fs = dest;
+	}
+
+	if ((flags & EXT2FS_CLONE_BLOCK) && src->block_map) {
+		if (dest->block_map == NULL) {
+			dest->block_map = src->block_map;
+			src->block_map = NULL;
+		} else {
+			retval = ext2fs_merge_bitmap(src->block_map, dest->block_map, NULL, NULL);
+			if (retval)
+				goto out;
+		}
+		dest->block_map->fs = dest;
+	}
+
+	if ((flags & EXT2FS_CLONE_BADBLOCKS) && src->badblocks) {
+		if (dest->badblocks == NULL)
+			retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
+		else
+			retval = ext2fs_badblocks_merge(src->badblocks, dest->badblocks);
+		if (retval)
+			goto out;
+	}
+
+	if ((flags & EXT2FS_CLONE_DBLIST) && src->dblist) {
+		if (dest->dblist == NULL) {
+			dest->dblist = src->dblist;
+			src->dblist = NULL;
+		} else {
+			retval = ext2fs_merge_dblist(src->dblist, dest->dblist);
+			if (retval)
+				goto out;
+		}
+		dest->dblist->fs = dest;
+	}
+
+	if (src->icache) {
+		ext2fs_free_inode_cache(src->icache);
+		src->icache = NULL;
+	}
+
+out:
+	if (src->io)
+		io_channel_close(src->io);
+
+	if ((flags & EXT2FS_CLONE_INODE) && src->inode_map)
+		ext2fs_free_generic_bmap(src->inode_map);
+	if ((flags & EXT2FS_CLONE_BLOCK) && src->block_map)
+		ext2fs_free_generic_bmap(src->block_map);
+	if ((flags & EXT2FS_CLONE_BADBLOCKS) && src->badblocks)
+		ext2fs_badblocks_list_free(src->badblocks);
+	if ((flags & EXT2FS_CLONE_DBLIST) && src->dblist) {
+		ext2fs_free_dblist(src->dblist);
+		src->dblist = NULL;
+	}
+
+	ext2fs_free_mem(&src);
+	*thread_fs = NULL;
+
+	return retval;
+}
+#endif
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 139a25fc..b1505f95 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -12,6 +12,10 @@
 #ifndef _EXT2FS_EXT2FS_H
 #define _EXT2FS_EXT2FS_H
 
+#ifdef HAVE_PTHREAD_H
+#include <pthread.h>
+#endif
+
 #ifdef __GNUC__
 #define EXT2FS_ATTR(x) __attribute__(x)
 #else
@@ -331,6 +335,13 @@ struct struct_ext2_filsys {
 	struct ext2fs_hashmap* block_sha_map;
 
 	const struct ext2fs_nls_table *encoding;
+
+#ifdef HAVE_PTHREAD
+	struct struct_ext2_filsys *parent;
+	size_t refcount;
+	pthread_mutex_t refcount_mutex;
+	unsigned int clone_flags;
+#endif
 };
 
 #if EXT2_FLAT_INCLUDES
@@ -1057,6 +1068,18 @@ extern errcode_t ext2fs_move_blocks(ext2_filsys fs,
 /* check_desc.c */
 extern errcode_t ext2fs_check_desc(ext2_filsys fs);
 
+#ifdef HAVE_PTHREAD
+/* flags for ext2fs_clone_fs */
+#define EXT2FS_CLONE_BLOCK 			0x0001
+#define EXT2FS_CLONE_INODE 			0x0002
+#define EXT2FS_CLONE_BADBLOCKS 		0x0004
+#define EXT2FS_CLONE_DBLIST			0x0008
+
+extern errcode_t ext2fs_clone_fs(ext2_filsys fs, ext2_filsys *dest,
+								 unsigned int flags);
+extern errcode_t ext2fs_merge_fs(ext2_filsys *fs);
+#endif
+
 /* closefs.c */
 extern errcode_t ext2fs_close(ext2_filsys fs);
 extern errcode_t ext2fs_close2(ext2_filsys fs, int flags);
-- 
2.37.3

