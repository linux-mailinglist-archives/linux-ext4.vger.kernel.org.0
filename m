Return-Path: <linux-ext4+bounces-11625-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E6BC3DAD1
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B1154E537B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C196319608;
	Thu,  6 Nov 2025 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6SvQL7x"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26862F5A34
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469304; cv=none; b=puFDkM1EQNta+svN2zrjMwelUcvkR/S23m+bcKUsbgJibgWsOjFww6yCmFCJC4uMERs3XBaXkE3fPy4DbKPXBrlOBh3CWWe5q5NGS2QpDIeX+WVAS5P+mXjP0OdegCt94simiHiPu2mQu+TAvgQNFHk5w2m4uKCmoFk2ZLlCHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469304; c=relaxed/simple;
	bh=/SkLeX1JZS01ZN5RS1l5f/zXYkAy68sKfgwSdrulzQc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9g+4zApDdjmW5Z7Z3LA+34DA90WdhUfW+QziECGSEQbvsXsacxlXjKuftWXViwSbhEDVoJY9EImOgc0U8LM7famTF1qsLVijrXlowh/cu3Ma0iWPDv3x9tW4sKxyN/1lVTH4cB2+egTDPgzzu6KX1AZ0yvIZ6cb9llCh3bfAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6SvQL7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC32C4CEF7;
	Thu,  6 Nov 2025 22:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469304;
	bh=/SkLeX1JZS01ZN5RS1l5f/zXYkAy68sKfgwSdrulzQc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=d6SvQL7xUosy8FZ4tCEfke3rCpNCDhr7bVf+XpcX+FX3NFuG6XBe/Dfjq5h4PHuAv
	 pCoM+gff+3PzI3CVqxe1IUAOu+JKsvXN5sj83U2cD66/MUelRdjp2OnQFc5WwSiFX+
	 8suTJ71p9GdIx+hx536InCLQiBb2ElDjprf+/Bk42tsYCYOODf4y1bT8Nr6myVGm3a
	 6UxaNeYPa+Vu05YCMVhZ8N33xDnml1V5mXU9aB84E+CLAUdVm3aRvSQI2Hg2tFXWQP
	 HK9VDWHU832Lfa/Gb9zOqjfZzwCSacxyXjrB/zonWD4ZU+IMxFozkCc9F3cz79UGZb
	 W3cdKhNU2ijYA==
Date: Thu, 06 Nov 2025 14:48:23 -0800
Subject: [PATCH 20/23] fuse4fs: add cache to track open files
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795926.2864310.2733967505111151716.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
References: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add our own inode cache so that we can track open files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    7 +++
 fuse4fs/Makefile.in |    3 +
 fuse4fs/fuse4fs.c   |  132 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 1 deletion(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index c7c8298c115d50..71fb9762f97866 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -6,6 +6,13 @@
 #ifndef __CACHE_H__
 #define __CACHE_H__
 
+/*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
+#define GOLDEN_RATIO_PRIME	0x9e37fffffffc0001UL
+#ifndef CACHE_LINE_SIZE
+/* if the system didn't tell us, guess something reasonable */
+#define CACHE_LINE_SIZE		64
+#endif
+
 /*
  * initialisation flags
  */
diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
index 6b41d1dd5ffe8d..9f3547c271638f 100644
--- a/fuse4fs/Makefile.in
+++ b/fuse4fs/Makefile.in
@@ -146,7 +146,8 @@ fuse4fs.o: $(srcdir)/fuse4fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
- $(top_srcdir)/lib/e2p/e2p.h
+ $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h
 journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
  $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 7585f1ff346d84..038d6126dbfde1 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -26,6 +26,7 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 #include <ctype.h>
+#include <assert.h>
 #define FUSE_DARWIN_ENABLE_EXTENSIONS 0
 #ifdef __SET_FOB_FOR_FUSE
 # error Do not set magic value __SET_FOB_FOR_FUSE!!!!
@@ -49,6 +50,8 @@
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fsP.h"
 #include "support/bthread.h"
+#include "support/list.h"
+#include "support/cache.h"
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -206,6 +209,7 @@ int journal_enable_debug = -1;
 #define FUSE4FS_FILE_MAGIC	(0xEF53DEAFUL)
 struct fuse4fs_file_handle {
 	unsigned long magic;
+	struct fuse4fs_inode *fi;
 	ext2_ino_t ino;
 	int open_flags;
 	int check_flags;
@@ -261,6 +265,7 @@ struct fuse4fs {
 	int timing;
 #endif
 	struct fuse_session *fuse;
+	struct cache inodes;
 };
 
 #define FUSE4FS_CHECK_HANDLE(req, fh) \
@@ -353,6 +358,115 @@ static inline int u_log2(unsigned int arg)
 	return l;
 }
 
+struct fuse4fs_inode {
+	struct cache_node	i_cnode;
+	ext2_ino_t		i_ino;
+	unsigned int		i_open_count;
+};
+
+struct fuse4fs_ikey {
+	ext2_ino_t		i_ino;
+};
+
+#define ICKEY(key)	((struct fuse4fs_ikey *)(key))
+#define ICNODE(node)	(container_of((node), struct fuse4fs_inode, i_cnode))
+
+static unsigned int
+icache_hash(cache_key_t key, unsigned int hashsize, unsigned int hashshift)
+{
+	uint64_t	hashval = ICKEY(key)->i_ino;
+	uint64_t	tmp;
+
+	tmp = hashval ^ (GOLDEN_RATIO_PRIME + hashval) / CACHE_LINE_SIZE;
+	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> hashshift);
+	return tmp % hashsize;
+}
+
+static int icache_compare(struct cache_node *node, cache_key_t key)
+{
+	struct fuse4fs_inode *fi = ICNODE(node);
+	struct fuse4fs_ikey *ikey = ICKEY(key);
+
+	if (fi->i_ino == ikey->i_ino)
+		return CACHE_HIT;
+
+	return CACHE_MISS;
+}
+
+static struct cache_node *icache_alloc(struct cache *c, cache_key_t key)
+{
+	struct fuse4fs_ikey *ikey = ICKEY(key);
+	struct fuse4fs_inode *fi;
+
+	fi = calloc(1, sizeof(struct fuse4fs_inode));
+	if (!fi)
+		return NULL;
+
+	fi->i_ino = ikey->i_ino;
+	return &fi->i_cnode;
+}
+
+static bool icache_flush(struct cache *c, struct cache_node *node)
+{
+	return false;
+}
+
+static void icache_relse(struct cache *c, struct cache_node *node)
+{
+	struct fuse4fs_inode *fi = ICNODE(node);
+
+	assert(fi->i_open_count == 0);
+	free(fi);
+}
+
+static unsigned int icache_bulkrelse(struct cache *cache,
+				     struct list_head *list)
+{
+	struct cache_node *cn, *n;
+	int count = 0;
+
+	if (list_empty(list))
+		return 0;
+
+	list_for_each_entry_safe(cn, n, list, cn_mru) {
+		icache_relse(cache, cn);
+		count++;
+	}
+
+	return count;
+}
+
+static const struct cache_operations icache_ops = {
+	.hash		= icache_hash,
+	.alloc		= icache_alloc,
+	.flush		= icache_flush,
+	.relse		= icache_relse,
+	.compare	= icache_compare,
+	.bulkrelse	= icache_bulkrelse,
+	.resize		= cache_gradual_resize,
+};
+
+static errcode_t fuse4fs_iget(struct fuse4fs *ff, ext2_ino_t ino,
+			      struct fuse4fs_inode **fip)
+{
+	struct fuse4fs_ikey ikey = {
+		.i_ino = ino,
+	};
+	struct cache_node *node = NULL;
+
+	cache_node_get(&ff->inodes, &ikey, 0, &node);
+	if (!node)
+		return ENOMEM;
+
+	*fip = ICNODE(node);
+	return 0;
+}
+
+static void fuse4fs_iput(struct fuse4fs *ff, struct fuse4fs_inode *fi)
+{
+	cache_node_put(&ff->inodes, &fi->i_cnode);
+}
+
 static inline blk64_t FUSE4FS_B_TO_FSBT(const struct fuse4fs *ff, off_t pos)
 {
 	return pos >> ff->blocklog;
@@ -1137,6 +1251,11 @@ static void fuse4fs_unmount(struct fuse4fs *ff)
 	errcode_t err;
 
 	if (ff->fs) {
+		if (cache_initialized(&ff->inodes)) {
+			cache_purge(&ff->inodes);
+			cache_destroy(&ff->inodes);
+		}
+
 		uuid_unparse(ff->fs->super->s_uuid, uuid);
 		err = ext2fs_close_free(&ff->fs);
 		if (err)
@@ -1268,6 +1387,10 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
 	}
 
+	err = cache_init(CACHE_AUTO_SHRINK, 1U << 10, &icache_ops, &ff->inodes);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
 	ff->fs->priv_data = ff;
 	ff->blocklog = u_log2(ff->fs->blocksize);
 	ff->blockmask = ff->fs->blocksize - 1;
@@ -2326,6 +2449,7 @@ static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
 	if (inode.i_links_count)
 		goto write_out;
 
+
 	if (ext2fs_has_feature_ea_inode(fs->super)) {
 		ret = fuse4fs_remove_ea_inodes(ff, ino, &inode);
 		if (ret)
@@ -3282,6 +3406,13 @@ static int fuse4fs_open_file(struct fuse4fs *ff, const struct fuse_ctx *ctxt,
 			goto out;
 	}
 
+	err = fuse4fs_iget(ff, file->ino, &file->fi);
+	if (err) {
+		ret = translate_error(fs, 0, err);
+		goto out;
+	}
+	file->fi->i_open_count++;
+
 	file->check_flags = check;
 	fuse4fs_set_handle(fp, file);
 
@@ -3470,6 +3601,7 @@ static void op_release(fuse_req_t req, fuse_ino_t fino EXT2FS_ATTR((unused)),
 			ret = translate_error(fs, fh->ino, err);
 	}
 
+	fuse4fs_iput(ff, fh->fi);
 	fp->fh = 0;
 	fuse4fs_finish(ff, ret);
 


