Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D317159AE3
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2020 22:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgBKVCl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Feb 2020 16:02:41 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41458 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbgBKVCl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Feb 2020 16:02:41 -0500
Received: by mail-qv1-f68.google.com with SMTP id s7so5705935qvn.8
        for <linux-ext4@vger.kernel.org>; Tue, 11 Feb 2020 13:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5iQ7mIDb3ZtmXBfRff6ibh+z+Ngj3WHPuWqFV9lP1oI=;
        b=qOiriR2129sD7wIydJI73cuhFMIoh8Xj3tw817C2m+zcqUHTq1y4aFzv4PxKrZWQQO
         abtdYcnsGJK0rINUrBvKaElvHmpeiIsjfaSC8n6ozJTh+y8vjNqATGbgNQuPxIPDeD9G
         413DDJfUUf4Z9wAq0Mye8cATQzcHn1EEJCqtDl10YhxzyeYO9loDxW7LwLORWQNN24lh
         Y+3FEyuKP7ZFpxht1mobIV/UYZaWEQXrUHtrynTTojgBQkCFcn+utv0DYGiJuKi6+v2z
         l3fcGB6vBYoAG1lb4520o+RHt4FNUsO86FN0FXlyG37+zoLSrMx6VrvDzxt8XOvfs3J0
         DQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5iQ7mIDb3ZtmXBfRff6ibh+z+Ngj3WHPuWqFV9lP1oI=;
        b=H+4n6g/pcXFQ+PRjeErErcdQDNNJlvS4cXWJlWRx0crX3Q/w5qdgpnrH0dhAoJh85d
         gjKaFMhfQeVx6KsBFYSJQT+PruUz3NVgiTMGDm6W6uL/yvw68L2nT5y54NXO4o9BikEz
         D4U2Z0VHkxuOlhhPHKgldMtC9u1ukwtC4WghVepRorOjA3aDiuV91DXJoIslw6P+wsSV
         RiqsB0MkjE9vEEUvmK3jCRB5BKjaPks2vAOZ3tTuYtJ/+6BrNGNWM9yFQ/7dpMWzhGLE
         WL+aJjMH1zuCBDOu5mb2Rzo3O1JClchWlZLABv20Pi8Ypl4Tfpnbqhz3CPh204g+oiOV
         crfw==
X-Gm-Message-State: APjAAAW5Fb8sLqox7HVGqhbZ8ZiG6vq9LdaCsX0Pguqmjz347jsbkAkK
        IcXuafjbf6TDTw9fCYUBOH+nS6b1
X-Google-Smtp-Source: APXvYqzZZsjgEUv3L7qpzkde8nPc+XNh5dizPT5DKO8NgNVCIZsvYWnOcmePV0hZEb6EgVPBfnvVWA==
X-Received: by 2002:a05:6214:8cb:: with SMTP id da11mr16024712qvb.228.1581454960028;
        Tue, 11 Feb 2020 13:02:40 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id 17sm132530qkr.116.2020.02.11.13.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 13:02:39 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: remove EXT4_EOFBLOCKS_FL and associated code
Date:   Tue, 11 Feb 2020 16:02:16 -0500
Message-Id: <20200211210216.24960-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The EXT4_EOFBLOCKS_FL inode flag is used to indicate whether a file
contains unwritten blocks past i_size.  It's set when ext4_fallocate
is called with the KEEP_SIZE flag to extend a file with an unwritten
extent.  However, this flag hasn't been useful functionally since
March, 2012, when a decision was made to remove it from ext4.

All traces of EXT4_EOFBLOCKS_FL were removed from e2fsprogs version
1.42.2 by commit 010dc7b90d97 ("e2fsck: remove EXT4_EOFBLOCKS_FL flag
handling") at that time.  Now that enough time has passed to make
e2fsprogs versions containing this modification common, this patch now
removes the code associated with EXT4_EOFBLOCKS_FL from the kernel as
well.

This change has two implications.  First, because pre-1.42.2 e2fsck
versions only look for a problem if EXT4_EOFBLOCKS_FL is set, and
because that bit will never be set by newer kernels containing this
patch, old versions of e2fsck won't have a compatibility problem with
files created by newer kernels.

Second, newer kernels will not clear EXT4_EOFBLOCKS_FL inode flag bits
belonging to a file written by an older kernel.  If set, it will remain
in that state until the file is deleted.  Because e2fsck versions since
1.42.2 don't check the flag at all, no adverse effect is expected.
However, pre-1.42.2 e2fsck versions that do check the flag may report
that it is set when it ought not to be after a file has been truncated
or had its unwritten blocks written.  In this case, the old version of
e2fsck will offer to clear the flag.  No adverse effect would then
occur whether the user chooses to clear the flag or not.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/ext4.h    |  5 ++-
 fs/ext4/extents.c | 92 +++++--------------------------------------------------
 fs/ext4/inode.c   |  2 --
 fs/ext4/ioctl.c   | 12 --------
 4 files changed, 9 insertions(+), 102 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9a2ee2428ecc..d8a79ddebce6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -414,7 +414,7 @@ struct flex_groups {
 #define EXT4_EXTENTS_FL			0x00080000 /* Inode uses extents */
 #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
 #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
-#define EXT4_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
+/* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
 #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
 #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
@@ -487,7 +487,7 @@ enum {
 	EXT4_INODE_EXTENTS	= 19,	/* Inode uses extents */
 	EXT4_INODE_VERITY	= 20,	/* Verity protected inode */
 	EXT4_INODE_EA_INODE	= 21,	/* Inode used for large EA */
-	EXT4_INODE_EOFBLOCKS	= 22,	/* Blocks allocated beyond EOF */
+/* 22 was formerly EXT4_INODE_EOFBLOCKS */
 	EXT4_INODE_INLINE_DATA	= 28,	/* Data in inode. */
 	EXT4_INODE_PROJINHERIT	= 29,	/* Create with parents projid */
 	EXT4_INODE_RESERVED	= 31,	/* reserved for ext4 lib */
@@ -533,7 +533,6 @@ static inline void ext4_check_flag_values(void)
 	CHECK_FLAG_VALUE(EXTENTS);
 	CHECK_FLAG_VALUE(VERITY);
 	CHECK_FLAG_VALUE(EA_INODE);
-	CHECK_FLAG_VALUE(EOFBLOCKS);
 	CHECK_FLAG_VALUE(INLINE_DATA);
 	CHECK_FLAG_VALUE(PROJINHERIT);
 	CHECK_FLAG_VALUE(RESERVED);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 954013d6076b..89aa9c7ae293 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3874,59 +3874,6 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 	return err;
 }
 
-/*
- * Handle EOFBLOCKS_FL flag, clearing it if necessary
- */
-static int check_eofblocks_fl(handle_t *handle, struct inode *inode,
-			      ext4_lblk_t lblk,
-			      struct ext4_ext_path *path,
-			      unsigned int len)
-{
-	int i, depth;
-	struct ext4_extent_header *eh;
-	struct ext4_extent *last_ex;
-
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EOFBLOCKS))
-		return 0;
-
-	depth = ext_depth(inode);
-	eh = path[depth].p_hdr;
-
-	/*
-	 * We're going to remove EOFBLOCKS_FL entirely in future so we
-	 * do not care for this case anymore. Simply remove the flag
-	 * if there are no extents.
-	 */
-	if (unlikely(!eh->eh_entries))
-		goto out;
-	last_ex = EXT_LAST_EXTENT(eh);
-	/*
-	 * We should clear the EOFBLOCKS_FL flag if we are writing the
-	 * last block in the last extent in the file.  We test this by
-	 * first checking to see if the caller to
-	 * ext4_ext_get_blocks() was interested in the last block (or
-	 * a block beyond the last block) in the current extent.  If
-	 * this turns out to be false, we can bail out from this
-	 * function immediately.
-	 */
-	if (lblk + len < le32_to_cpu(last_ex->ee_block) +
-	    ext4_ext_get_actual_len(last_ex))
-		return 0;
-	/*
-	 * If the caller does appear to be planning to write at or
-	 * beyond the end of the current extent, we then test to see
-	 * if the current extent is the last extent in the file, by
-	 * checking to make sure it was reached via the rightmost node
-	 * at each level of the tree.
-	 */
-	for (i = depth-1; i >= 0; i--)
-		if (path[i].p_idx != EXT_LAST_INDEX(path[i].p_hdr))
-			return 0;
-out:
-	ext4_clear_inode_flag(inode, EXT4_INODE_EOFBLOCKS);
-	return ext4_mark_inode_dirty(handle, inode);
-}
-
 static int
 convert_initialized_extent(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map,
@@ -3991,9 +3938,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	ext4_ext_show_leaf(inode, path);
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
-	err = check_eofblocks_fl(handle, inode, map->m_lblk, path, map->m_len);
-	if (err)
-		return err;
+
 	map->m_flags |= EXT4_MAP_UNWRITTEN;
 	if (allocated > map->m_len)
 		allocated = map->m_len;
@@ -4007,7 +3952,9 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 			struct ext4_ext_path **ppath, int flags,
 			unsigned int allocated, ext4_fsblk_t newblock)
 {
+#ifdef EXT_DEBUG
 	struct ext4_ext_path *path = *ppath;
+#endif
 	int ret = 0;
 	int err = 0;
 
@@ -4047,11 +3994,9 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 		}
 		ret = ext4_convert_unwritten_extents_endio(handle, inode, map,
 							   ppath);
-		if (ret >= 0) {
+		if (ret >= 0)
 			ext4_update_inode_fsync_trans(handle, inode, 1);
-			err = check_eofblocks_fl(handle, inode, map->m_lblk,
-						 path, map->m_len);
-		} else
+		else
 			err = ret;
 		map->m_flags |= EXT4_MAP_MAPPED;
 		map->m_pblk = newblock;
@@ -4100,12 +4045,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 
 map_out:
 	map->m_flags |= EXT4_MAP_MAPPED;
-	if ((flags & EXT4_GET_BLOCKS_KEEP_SIZE) == 0) {
-		err = check_eofblocks_fl(handle, inode, map->m_lblk, path,
-					 map->m_len);
-		if (err < 0)
-			goto out2;
-	}
 out1:
 	if (allocated > map->m_len)
 		allocated = map->m_len;
@@ -4459,12 +4398,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	}
 
 	err = 0;
-	if ((flags & EXT4_GET_BLOCKS_KEEP_SIZE) == 0)
-		err = check_eofblocks_fl(handle, inode, map->m_lblk,
-					 path, ar.len);
-	if (!err)
-		err = ext4_ext_insert_extent(handle, inode, &path,
-					     &newex, flags);
+	err = ext4_ext_insert_extent(handle, inode, &path, &newex, flags);
 
 	if (err && free_on_err) {
 		int fb_flags = flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE ?
@@ -4645,10 +4579,6 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 				epos = new_size;
 			if (ext4_update_inode_size(inode, epos) & 0x1)
 				inode->i_mtime = inode->i_ctime;
-		} else {
-			if (epos > inode->i_size)
-				ext4_set_inode_flag(inode,
-						    EXT4_INODE_EOFBLOCKS);
 		}
 		ext4_mark_inode_dirty(handle, inode);
 		ext4_update_inode_fsync_trans(handle, inode, 1);
@@ -4802,16 +4732,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	}
 
 	inode->i_mtime = inode->i_ctime = current_time(inode);
-	if (new_size) {
+	if (new_size)
 		ext4_update_inode_size(inode, new_size);
-	} else {
-		/*
-		* Mark that we allocate beyond EOF so the subsequent truncate
-		* can proceed even if the new size is the same as i_size.
-		*/
-		if (offset + len > inode->i_size)
-			ext4_set_inode_flag(inode, EXT4_INODE_EOFBLOCKS);
-	}
 	ext4_mark_inode_dirty(handle, inode);
 
 	/* Zero out partial block at the edges of the range */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3313168b680f..bd968f85031e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4144,8 +4144,6 @@ int ext4_truncate(struct inode *inode)
 	if (!ext4_can_truncate(inode))
 		return 0;
 
-	ext4_clear_inode_flag(inode, EXT4_INODE_EOFBLOCKS);
-
 	if (inode->i_size == 0 && !test_opt(inode->i_sb, NO_AUTO_DA_ALLOC))
 		ext4_set_inode_state(inode, EXT4_STATE_DA_ALLOC_CLOSE);
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a0ec750018dd..d0b00fab0531 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -327,18 +327,6 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	if ((flags ^ oldflags) & EXT4_EXTENTS_FL)
 		migrate = 1;
 
-	if (flags & EXT4_EOFBLOCKS_FL) {
-		/* we don't support adding EOFBLOCKS flag */
-		if (!(oldflags & EXT4_EOFBLOCKS_FL)) {
-			err = -EOPNOTSUPP;
-			goto flags_out;
-		}
-	} else if (oldflags & EXT4_EOFBLOCKS_FL) {
-		err = ext4_truncate(inode);
-		if (err)
-			goto flags_out;
-	}
-
 	if ((flags ^ oldflags) & EXT4_CASEFOLD_FL) {
 		if (!ext4_has_feature_casefold(sb)) {
 			err = -EOPNOTSUPP;
-- 
2.11.0

