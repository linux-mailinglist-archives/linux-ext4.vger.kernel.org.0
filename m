Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774E03A90D9
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 06:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhFPE6x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 00:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230387AbhFPE6s (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Jun 2021 00:58:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E72F0613B9
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 04:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623819403;
        bh=f/uydsNJnkUdSm/stqtJN8ssTADLGZFR6rZmK2FSZ0Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jHLwsdCcd3/6/NnPVbXDquszV/3IJyI6KVrW0Ftab0dLTqi8Fp4dB/pEIZNQNK2eH
         faI1IF/aAeILj3FlAYLHhcLcxorbOscvSdtEtQAt7VtQ9AmLUKGLXcjDO0VwxOGwZ5
         8Mi/lKB0/mSYKaz5ULJu6joJnJNce689+lvXQ1TB9/925eYbpB/NLR50j6MHgf59qX
         ouq1Txzr57uGd4y1mLWhoQml7YLipVNoHGngtYgdzGyHex0xmSV891MIHqjoaSSd0n
         yoovIPdcRBWeEsLuNKbVgBFxqIGITuZsSgQTVT2VWyy9ATDJKRZ0EsR9KnVYHeUnMf
         a7q+Eim49hEJQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 5/6] Fix -Wunused-variable warnings
Date:   Tue, 15 Jun 2021 21:53:33 -0700
Message-Id: <20210616045334.1655288-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210616045334.1655288-1-ebiggers@kernel.org>
References: <20210616045334.1655288-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fix all warnings about unused variables that were introduced since
e2fsprogs v1.45.4.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 e2fsck/extents.c       | 2 +-
 e2fsck/journal.c       | 7 +------
 e2fsck/rehash.c        | 2 +-
 lib/e2p/errcode.c      | 1 -
 lib/e2p/fgetflags.c    | 2 +-
 lib/e2p/fsetflags.c    | 1 -
 lib/ext2fs/mkjournal.c | 1 -
 misc/mke2fs.c          | 2 ++
 8 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/e2fsck/extents.c b/e2fsck/extents.c
index 4e6e2611..0274e053 100644
--- a/e2fsck/extents.c
+++ b/e2fsck/extents.c
@@ -203,7 +203,7 @@ errcode_t rewrite_extent_replay(e2fsck_t ctx, struct extent_list *list,
 	ext2_extent_handle_t	handle;
 	unsigned int		i, ext_written;
 	struct ext2fs_extent	*ex, extent;
-	blk64_t			start_val, delta, blkcount;
+	blk64_t			start_val, delta;
 
 	/* Reset extent tree */
 	inode->i_flags &= ~EXT4_EXTENTS_FL;
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 5a06e26e..0aeaf416 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -442,7 +442,6 @@ static int ex_len_compar(const void *arg1, const void *arg2)
 
 static void ex_sort_and_merge(struct extent_list *list)
 {
-	blk64_t ex_end;
 	int i, j;
 
 	if (list->count < 2)
@@ -490,7 +489,7 @@ static int ext4_modify_extent_list(e2fsck_t ctx, struct extent_list *list,
 {
 	int ret;
 	int i, offset;
-	struct ext2fs_extent add_ex = *ex, add_ex2;
+	struct ext2fs_extent add_ex = *ex;
 
 	/* First let's create a hole from ex->e_lblk of length ex->e_len */
 	for (i = 0; i < list->count; i++) {
@@ -634,9 +633,7 @@ static inline void tl_to_darg(struct dentry_info_args *darg,
 
 static int ext4_fc_handle_unlink(e2fsck_t ctx, struct ext4_fc_tl *tl)
 {
-	struct ext2_inode inode;
 	struct dentry_info_args darg;
-	ext2_filsys fs = ctx->fs;
 	int ret;
 
 	tl_to_darg(&darg, tl);
@@ -724,7 +721,6 @@ static void ext4_fc_replay_fixup_iblocks(struct ext2_inode_large *ondisk_inode,
 
 static int ext4_fc_handle_inode(e2fsck_t ctx, struct ext4_fc_tl *tl)
 {
-	struct e2fsck_fc_replay_state *state = &ctx->fc_replay_state;
 	int ino, inode_len = EXT2_GOOD_OLD_INODE_SIZE;
 	struct ext2_inode_large *inode = NULL, *fc_inode = NULL;
 	struct ext4_fc_inode *fc_inode_val;
@@ -790,7 +786,6 @@ static int ext4_fc_handle_add_extent(e2fsck_t ctx, struct ext4_fc_tl *tl)
 {
 	struct ext2fs_extent extent;
 	struct ext4_fc_add_range *add_range;
-	struct ext4_fc_del_range *del_range;
 	int ret = 0, ino;
 
 	add_range = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
index 204ff7de..7d30ff00 100644
--- a/e2fsck/rehash.c
+++ b/e2fsck/rehash.c
@@ -287,7 +287,7 @@ static EXT2_QSORT_TYPE name_cf_cmp(const struct name_cmp_ctx *ctx,
 {
 	const struct hash_entry *he_a = (const struct hash_entry *) a;
 	const struct hash_entry *he_b = (const struct hash_entry *) b;
-	unsigned int he_a_len, he_b_len, min_len;
+	unsigned int he_a_len, he_b_len;
 	int ret;
 
 	he_a_len = ext2fs_dirent_name_len(he_a->dir);
diff --git a/lib/e2p/errcode.c b/lib/e2p/errcode.c
index 27d4b15f..7e426553 100644
--- a/lib/e2p/errcode.c
+++ b/lib/e2p/errcode.c
@@ -34,7 +34,6 @@ static const char *err_string[] = {
 /* Return the name of an encoding or NULL */
 const char *e2p_errcode2str(int err)
 {
-	unsigned int i;
 	static char buf[32];
 
 	if (err < ARRAY_SIZE(err_string))
diff --git a/lib/e2p/fgetflags.c b/lib/e2p/fgetflags.c
index 0f1a059e..93e130c6 100644
--- a/lib/e2p/fgetflags.c
+++ b/lib/e2p/fgetflags.c
@@ -50,8 +50,8 @@
 
 int fgetflags (const char * name, unsigned long * flags)
 {
-	struct stat buf;
 #if HAVE_STAT_FLAGS && !(APPLE_DARWIN && HAVE_EXT2_IOCTLS)
+	struct stat buf;
 
 	if (stat (name, &buf) == -1)
 		return -1;
diff --git a/lib/e2p/fsetflags.c b/lib/e2p/fsetflags.c
index 28515547..6455e386 100644
--- a/lib/e2p/fsetflags.c
+++ b/lib/e2p/fsetflags.c
@@ -81,7 +81,6 @@ int fsetflags (const char * name, unsigned long flags)
 	return syscall(SYS_fsctl, name, EXT2_IOC_SETFLAGS, &f, 0);
 #elif HAVE_EXT2_IOCTLS
 	int fd, r, f, save_errno = 0;
-	struct stat buf;
 
 	fd = open(name, OPEN_FLAGS);
 	if (fd == -1) {
diff --git a/lib/ext2fs/mkjournal.c b/lib/ext2fs/mkjournal.c
index bc8c57bf..11d73e30 100644
--- a/lib/ext2fs/mkjournal.c
+++ b/lib/ext2fs/mkjournal.c
@@ -604,7 +604,6 @@ errcode_t ext2fs_add_journal_inode2(ext2_filsys fs, blk_t num_blocks,
 				    blk64_t goal, int flags)
 {
 	struct ext2fs_journal_params jparams;
-	errcode_t ret;
 
 	jparams.num_journal_blocks = num_blocks;
 	jparams.num_fc_blocks = 0;
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index d5ab334e..54aa340a 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -1577,7 +1577,9 @@ static void PRS(int argc, char *argv[])
 	int		use_bsize;
 	char		*newpath;
 	int		pathlen = sizeof(PATH_SET) + 1;
+#ifdef HAVE_BLKID_PROBE_GET_TOPOLOGY
 	struct device_param dev_param;
+#endif
 
 	if (oldpath)
 		pathlen += strlen(oldpath);
-- 
2.32.0.272.g935e593368-goog

