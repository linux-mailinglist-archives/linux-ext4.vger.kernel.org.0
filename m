Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4097A564E67
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiGDHJJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiGDHIh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:08:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A7A1B3
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:08:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id r1so7782544plo.10
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OdDJ8Ll6jnmyqNdDp5R05dgXG5b+P+Hxpz6eY0JP2E=;
        b=QZzBsBPhjVTooozwl9TsDpu7iDyYLqXm5MvOhdVfDF23/oAcC+DUn+CxKtaVvBbez9
         UHWH1f6Ci9ZhXwaDDxJZrRtSOL+Ynmxq9o8hLbvA6e3zVI+QI7JraTIXk8e4HTroZVRt
         BeMYL/nFLz3mb2w6CoqJw1iTNJRWJ7LGUDSyNEIZNfZTxnXB0hSamzTyvOU7Gy35NQBa
         8hKj4+l+WqK5hYhEGSvJCoBNyVK4o4TdVlJURTOT7M2GkyTdwGyYd7M2Yb1ynTW99mAx
         VAq/xqNV5ZLu70gF+0Yx0fJw6fURaFyJUekK4IoY73o1okybSJXNuV1SecaTWtV2DkrZ
         U00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OdDJ8Ll6jnmyqNdDp5R05dgXG5b+P+Hxpz6eY0JP2E=;
        b=70NFfBH8jze3Q4GYQRDSNnNdiI5ndz8ogJ0xMLKfOwWCpTViLNdyX5n1vkuCWwNJEE
         /kDYPRYdqYWc7cF2Sb2EjpvcSOVofymlvZjkG76FEjNGfz/0PznLXq2lPkfLZk/rbOOy
         o1pCB1v81Rj2GvZArFYXtxInhxFCe8Mt1iKF6n8SB8s9q+8OTTWlzCNSJhlhGcgGuEgV
         00e9SNZqsi2NS+tNA+JRL37A4N2onWfI8+nqGNHLhOqnRutFKDHQNAvUXZG2MqEpcXGY
         PK30Z9JpfYopglw343yPEMEDVdwJQTD87g6P/xoktSrI+oFkWsAn5BQYnNasOFozKgKX
         HMLQ==
X-Gm-Message-State: AJIora8OuPHghmABXSZ6AYe3lFmAnUVWiIg/rrC+aWvuf9PN9BELyg3c
        7/oLzzFnuUNSpeisDdF7/6c=
X-Google-Smtp-Source: AGRyM1ubtYwureZopdoXNzbrt1EixJssNE62Y4nAWqmKSo5HgghcNda5qCmE/pTkKjLx7A2DMT8Cxw==
X-Received: by 2002:a17:90b:4ac3:b0:1ef:66b4:9e with SMTP id mh3-20020a17090b4ac300b001ef66b4009emr15264673pjb.92.1656918495042;
        Mon, 04 Jul 2022 00:08:15 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709027c0a00b0016a6caacaefsm19770124pll.103.2022.07.04.00.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:08:14 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Saranya Muruganandam <saranyamohan@google.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 12/13] libext2fs: dupfs: Add fs clone & merge api
Date:   Mon,  4 Jul 2022 12:37:01 +0530
Message-Id: <f1cbf256269cda5dfd489da677015b504a46341d.1656912918.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656912918.git.ritesh.list@gmail.com>
References: <cover.1656912918.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Review couple of todos within the patch.
1. I think we don't need refcount here.
2. For io_channel_close(), I think that might be required here (even though
   earlier I thought it should be done by the caller), before freeing childfs.

Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
[added todos, modified naming, used #ifdef HAVE_PTHREAD, small bug fix in
calling io_channel_close(), later added a test case against this patch]
Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 lib/ext2fs/dupfs.c  | 149 ++++++++++++++++++++++++++++++++++++++++++++
 lib/ext2fs/ext2fs.h |  24 +++++++
 2 files changed, 173 insertions(+)

diff --git a/lib/ext2fs/dupfs.c b/lib/ext2fs/dupfs.c
index 02721e1a..8500a82c 100644
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
@@ -120,3 +124,148 @@ errout:

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
+errcode_t ext2fs_merge_fs(ext2_filsys fs)
+{
+	errcode_t retval = 0;
+	ext2_filsys dest = fs->parent;
+	ext2_filsys src = fs;
+	unsigned int flags = fs->clone_flags;
+
+	pthread_mutex_lock(&fs->refcount_mutex);
+	fs->refcount--;
+	assert(fs->refcount >= 0);
+	pthread_mutex_unlock(&fs->refcount_mutex);
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
+	dest->flags |= src->flags;
+	if (!(dest->flags & EXT2_FLAG_VALID))
+		ext2fs_unmark_valid(dest);
+
+	if (src->icache) {
+		ext2fs_free_inode_cache(src->icache);
+		src->icache = NULL;
+	}
+
+out:
+	/* TODO check if io_channel_close is called correctly here? */
+	if (src->io)
+		io_channel_close(src->io);
+
+	if ((flags & EXT2FS_CLONE_INODE) && src->inode_map)
+		ext2fs_free_generic_bmap(src->inode_map);
+	if ((flags & EXT2FS_CLONE_BLOCK) && src->block_map)
+		ext2fs_free_generic_bmap(src->block_map);
+	if ((flags & EXT2FS_CLONE_BADBLOCKS) && src->badblocks)
+		ext2fs_badblocks_list_free(src->badblocks);
+	if ((flags & EXT2FS_CLONE_DBLIST) && src->dblist)
+		ext2fs_free_dblist(src->dblist);
+
+	ext2fs_free_mem(&src);
+
+	return retval;
+}
+#endif
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 29e7be9f..6daa7832 100644
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
@@ -330,6 +334,14 @@ struct struct_ext2_filsys {
 	struct ext2fs_hashmap* block_sha_map;

 	const struct ext2fs_nls_table *encoding;
+
+#ifdef HAVE_PTHREAD
+	struct struct_ext2_filsys *parent;
+	/* TODO do we need refcount? */
+	size_t refcount;
+	pthread_mutex_t refcount_mutex;
+	unsigned int clone_flags;
+#endif
 };

 #if EXT2_FLAT_INCLUDES
@@ -1056,6 +1068,18 @@ extern errcode_t ext2fs_move_blocks(ext2_filsys fs,
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
+extern errcode_t ext2fs_merge_fs(ext2_filsys fs);
+#endif
+
 /* closefs.c */
 extern errcode_t ext2fs_close(ext2_filsys fs);
 extern errcode_t ext2fs_close2(ext2_filsys fs, int flags);
--
2.35.3

