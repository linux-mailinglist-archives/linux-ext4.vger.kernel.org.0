Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E45B592D
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 03:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfIRBIQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 21:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfIRBIP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 21:08:15 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48BC206C2;
        Wed, 18 Sep 2019 01:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568768892;
        bh=vrSlELtH707MeTqEoPtY5/ugKGNCX4XGuFH69I9lnRw=;
        h=From:To:Cc:Subject:Date:From;
        b=XuN/yFIMhEViHtSlh3bQPFP7FJhLH1lPO8yZ+WEI268tOFG4Kc8BQIzSXG9SCUbeK
         XAXKSV5tjslGM16tYqNlf1scjch17tvoH1cVuuyTV8cuRCR4ncd0XW0m4DlxYpENUN
         Bo6DgAKH3wYUqQpqH6ayyhdIZo0rwzaVUkloxruk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v5] e2fsck: check for consistent encryption policies
Date:   Tue, 17 Sep 2019 18:07:34 -0700
Message-Id: <20190918010734.253049-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

By design, the kernel enforces that all files in an encrypted directory
use the same encryption policy as the directory.  It's not possible to
violate this constraint using syscalls.  Lookups of files that violate
this constraint also fail, in case the disk was manipulated.

But this constraint can also be violated by accidental filesystem
corruption.  E.g., a power cut when using ext4 without a journal might
leave new files without the encryption bit and/or xattr.  Thus, it's
important that e2fsck correct this condition.

Therefore, this patch makes the following changes to e2fsck:

- During pass 1 (inode table scan), create a map from inode number to
  encryption policy for all encrypted inodes.  But it's optimized so
  that the full xattrs aren't saved but rather only 32-bit "policy IDs",
  since usually many inodes share the same encryption policy.  Also, if
  an encryption xattr is missing, offer to clear the encrypt flag.  If
  an encryption xattr is clearly corrupt, offer to clear the inode.

- During pass 2 (directory structure check), use the map to verify that
  all regular files, directories, and symlinks in encrypted directories
  use the directory's encryption policy.  Offer to clear any directory
  entries for which this isn't the case.

Add a new test "f_bad_encryption" to test the new behavior.

Due to the new checks, it was also necessary to update the existing test
"f_short_encrypted_dirent" to add an encryption xattr to the test file,
since it was missing one before, which is now considered invalid.

Google-Bug-Id: 135138675
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Changes v4 => v5:

- Handle v2 encryption policies.  (These are being added in the fscrypt
  pull request for 5.4.)

- Print the number of bytes needed when memory can't be allocated for
  the encrypted inode list.

- For PR_1_MISSING_ENCRYPTION_XATTR, use the new PROMPT_CLEAR_FLAG
  instead of PROMPT_FIX.

Changes v3 => v4:

- Save memory in common cases by storing ranges of inodes that share the
  same encryption policy.

- Rebased onto latest master branch.

Changes v2 => v3:

- Rebased onto latest master branch.

- A few minor cleanups in encrypted_files.c (no behavior changes)

Changes v1 => v2:

- For each encrypted inode, store only a 32-bit encryption policy ID,
  not the full encryption xattr.  A map from policy => policy ID,
  implemented using an rbtree, is used to assign policy IDs.

- If an inode with the encrypt bit is missing its encryption xattr, just
  clear the encrypt bit rather than clearing the whole inode.  Note that
  any encrypted directory entries that reference the inode will also be
  cleared by the encryption policy check in pass 2.

- Rename struct encrypted_files => struct encrypted_file_info.

- Make the encrypted file information structures private to
  encrypted_files.c.

- Other cleanups.
 e2fsck/Android.bp                       |   1 +
 e2fsck/Makefile.in                      |  18 +-
 e2fsck/e2fsck.c                         |   5 +-
 e2fsck/e2fsck.h                         |  22 +-
 e2fsck/encrypted_files.c                | 458 ++++++++++++++++++++++++
 e2fsck/pass1.c                          |  29 +-
 e2fsck/pass2.c                          | 106 +++++-
 e2fsck/problem.c                        |  26 +-
 e2fsck/problem.h                        |  15 +-
 po/POTFILES.in                          |   1 +
 tests/f_bad_encryption/expect.1         | 125 +++++++
 tests/f_bad_encryption/expect.2         |   7 +
 tests/f_bad_encryption/image.gz         | Bin 0 -> 2265 bytes
 tests/f_bad_encryption/mkimage.sh       | 169 +++++++++
 tests/f_bad_encryption/name             |   1 +
 tests/f_short_encrypted_dirent/expect.1 |   2 +-
 tests/f_short_encrypted_dirent/expect.2 |   2 +-
 tests/f_short_encrypted_dirent/image.gz | Bin 925 -> 1008 bytes
 18 files changed, 932 insertions(+), 55 deletions(-)
 create mode 100644 e2fsck/encrypted_files.c
 create mode 100644 tests/f_bad_encryption/expect.1
 create mode 100644 tests/f_bad_encryption/expect.2
 create mode 100644 tests/f_bad_encryption/image.gz
 create mode 100755 tests/f_bad_encryption/mkimage.sh
 create mode 100644 tests/f_bad_encryption/name

diff --git a/e2fsck/Android.bp b/e2fsck/Android.bp
index f3443127..5c802ac6 100644
--- a/e2fsck/Android.bp
+++ b/e2fsck/Android.bp
@@ -34,6 +34,7 @@ cc_defaults {
         "sigcatcher.c",
         "readahead.c",
         "extents.c",
+        "encrypted_files.c",
     ],
     cflags: [
         "-Wno-sign-compare",
diff --git a/e2fsck/Makefile.in b/e2fsck/Makefile.in
index bc7195f3..a56550ef 100644
--- a/e2fsck/Makefile.in
+++ b/e2fsck/Makefile.in
@@ -63,7 +63,7 @@ OBJS= unix.o e2fsck.o super.o pass1.o pass1b.o pass2.o \
 	dx_dirinfo.o ehandler.o problem.o message.o quota.o recovery.o \
 	region.o revoke.o ea_refcount.o rehash.o \
 	logfile.o sigcatcher.o $(MTRACE_OBJ) readahead.o \
-	extents.o
+	extents.o encrypted_files.o
 
 PROFILED_OBJS= profiled/unix.o profiled/e2fsck.o \
 	profiled/super.o profiled/pass1.o profiled/pass1b.o \
@@ -74,7 +74,8 @@ PROFILED_OBJS= profiled/unix.o profiled/e2fsck.o \
 	profiled/recovery.o profiled/region.o profiled/revoke.o \
 	profiled/ea_refcount.o profiled/rehash.o \
 	profiled/logfile.o profiled/sigcatcher.o \
-	profiled/readahead.o profiled/extents.o
+	profiled/readahead.o profiled/extents.o \
+	profiled/encrypted_files.o
 
 SRCS= $(srcdir)/e2fsck.c \
 	$(srcdir)/super.c \
@@ -103,6 +104,7 @@ SRCS= $(srcdir)/e2fsck.c \
 	$(srcdir)/logfile.c \
 	$(srcdir)/quota.c \
 	$(srcdir)/extents.c \
+	$(srcdir)/encrypted_files.c \
 	$(MTRACE_SRC)
 
 all:: profiled $(PROGS) e2fsck $(MANPAGES) $(FMANPAGES)
@@ -572,3 +574,15 @@ extents.o: $(srcdir)/extents.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/support/prof_err.h $(top_srcdir)/lib/support/quotaio.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/problem.h
+encrypted_files.o: $(srcdir)/encrypted_files.c $(top_builddir)/lib/config.h \
+ $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
+ $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
+ $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
+ $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
+ $(top_builddir)/lib/ext2fs/ext2_err.h \
+ $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
+ $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/support/profile.h \
+ $(top_builddir)/lib/support/prof_err.h $(top_srcdir)/lib/support/quotaio.h \
+ $(top_srcdir)/lib/support/dqblk_v2.h \
+ $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/problem.h \
+ $(top_srcdir)/lib/ext2fs/rbtree.h
diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index 929bd78d..d8be566f 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -138,6 +138,7 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 		ext2fs_u32_list_free(ctx->dirs_to_hash);
 		ctx->dirs_to_hash = 0;
 	}
+	destroy_encrypted_file_info(ctx);
 
 	/*
 	 * Clear the array of invalid meta-data flags
@@ -154,10 +155,6 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 		ext2fs_free_mem(&ctx->invalid_inode_table_flag);
 		ctx->invalid_inode_table_flag = 0;
 	}
-	if (ctx->encrypted_dirs) {
-		ext2fs_u32_list_free(ctx->encrypted_dirs);
-		ctx->encrypted_dirs = 0;
-	}
 	if (ctx->inode_count) {
 		ext2fs_free_icount(ctx->inode_count);
 		ctx->inode_count = 0;
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index fc0e5c8b..954bc982 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -135,6 +135,8 @@ struct dx_dirblock_info {
 #define DX_FLAG_FIRST		4
 #define DX_FLAG_LAST		8
 
+struct encrypted_file_info;
+
 #define RESOURCE_TRACK
 
 #ifdef RESOURCE_TRACK
@@ -328,6 +330,11 @@ struct e2fsck_struct {
 	 */
 	ext2_u32_list	dirs_to_hash;
 
+	/*
+	 * Encrypted file information
+	 */
+	struct encrypted_file_info *encrypted_files;
+
 	/*
 	 * Tuning parameters
 	 */
@@ -390,7 +397,6 @@ struct e2fsck_struct {
 	int ext_attr_ver;
 	profile_t	profile;
 	int blocks_per_page;
-	ext2_u32_list encrypted_dirs;
 
 	/* Reserve blocks for root and l+f re-creation */
 	blk64_t root_repair_block, lnf_repair_block;
@@ -505,8 +511,20 @@ extern ea_key_t ea_refcount_intr_next(ext2_refcount_t refcount,
 extern const char *ehandler_operation(const char *op);
 extern void ehandler_init(io_channel channel);
 
-/* extents.c */
+/* encrypted_files.c */
+
 struct problem_context;
+int add_encrypted_file(e2fsck_t ctx, struct problem_context *pctx);
+
+#define NO_ENCRYPTION_POLICY		((__u32)-1)
+#define CORRUPT_ENCRYPTION_POLICY	((__u32)-2)
+#define UNRECOGNIZED_ENCRYPTION_POLICY	((__u32)-3)
+__u32 find_encryption_policy(e2fsck_t ctx, ext2_ino_t ino);
+
+void destroy_encryption_policy_map(e2fsck_t ctx);
+void destroy_encrypted_file_info(e2fsck_t ctx);
+
+/* extents.c */
 errcode_t e2fsck_rebuild_extents_later(e2fsck_t ctx, ext2_ino_t ino);
 int e2fsck_ino_will_be_rebuilt(e2fsck_t ctx, ext2_ino_t ino);
 void e2fsck_pass1e(e2fsck_t ctx);
diff --git a/e2fsck/encrypted_files.c b/e2fsck/encrypted_files.c
new file mode 100644
index 00000000..16be2d6d
--- /dev/null
+++ b/e2fsck/encrypted_files.c
@@ -0,0 +1,458 @@
+/*
+ * encrypted_files.c --- save information about encrypted files
+ *
+ * Copyright 2019 Google LLC
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ * %End-Header%
+ */
+
+/*
+ * e2fsck pass 1 (inode table scan) creates a map from inode number to
+ * encryption policy for all encrypted inodes.  But it's optimized so that the
+ * full xattrs aren't saved but rather only 32-bit "policy IDs", since usually
+ * many inodes share the same encryption policy.  This requires also maintaining
+ * a second map, from policy to policy ID.  See add_encrypted_file().
+ *
+ * We also use run-length encoding to save memory when many adjacent inodes
+ * share the same encryption policy, which is often the case too.
+ *
+ * e2fsck pass 2 (directory structure check) uses the inode => policy ID map to
+ * verify that all regular files, directories, and symlinks in encrypted
+ * directories use the directory's encryption policy.
+ */
+
+#include "config.h"
+
+#include "e2fsck.h"
+#include "problem.h"
+#include "ext2fs/rbtree.h"
+
+#define FSCRYPT_KEY_DESCRIPTOR_SIZE	8
+#define FSCRYPT_KEY_IDENTIFIER_SIZE	16
+#define FS_KEY_DERIVATION_NONCE_SIZE	16
+
+struct fscrypt_context_v1 {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+	__u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE];
+};
+
+struct fscrypt_context_v2 {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 __reserved[4];
+	__u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+	__u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE];
+};
+
+/* On-disk format of encryption xattr */
+union fscrypt_context {
+	__u8 version;
+	struct fscrypt_context_v1 v1;
+	struct fscrypt_context_v2 v2;
+};
+
+struct fscrypt_policy_v1 {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+};
+
+struct fscrypt_policy_v2 {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 __reserved[4];
+	__u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+};
+
+/* The encryption "policy" is the fscrypt_context excluding the nonce. */
+union fscrypt_policy {
+	__u8 version;
+	struct fscrypt_policy_v1 v1;
+	struct fscrypt_policy_v2 v2;
+};
+
+/* A range of inodes which share the same encryption policy */
+struct encrypted_file_range {
+	ext2_ino_t		first_ino;
+	ext2_ino_t		last_ino;
+	__u32			policy_id;
+};
+
+/* Information about the encrypted files which have been seen so far */
+struct encrypted_file_info {
+	/*
+	 * Map from inode number to encryption policy ID, implemented as a
+	 * sorted array of inode ranges, each of which shares the same policy.
+	 * Inodes are added in order of increasing inode number.
+	 *
+	 * Freed after pass 2.
+	 */
+	struct encrypted_file_range	*file_ranges;
+	size_t				file_ranges_count;
+	size_t				file_ranges_capacity;
+
+	/*
+	 * Map from encryption policy to encryption policy ID, for the unique
+	 * encryption policies that have been seen so far.  next_policy_id is
+	 * the next available ID, starting at 0.
+	 *
+	 * Freed after pass 1.
+	 */
+	struct rb_root		policies;
+	__u32			next_policy_id;
+};
+
+/* Entry in encrypted_file_info::policies */
+struct policy_map_entry {
+	union fscrypt_policy	policy;
+	__u32			policy_id;
+	struct rb_node		node;
+};
+
+static int cmp_fscrypt_policies(e2fsck_t ctx, const union fscrypt_policy *a,
+				const union fscrypt_policy *b)
+{
+	if (a->version != b->version)
+		return (int)a->version - (int)b->version;
+
+	switch (a->version) {
+	case 1:
+		return memcmp(a, b, sizeof(a->v1));
+	case 2:
+		return memcmp(a, b, sizeof(a->v2));
+	}
+	fatal_error(ctx, "Unhandled encryption policy version");
+	return 0;
+}
+
+/* Read an inode's encryption xattr. */
+static errcode_t read_encryption_xattr(e2fsck_t ctx, ext2_ino_t ino,
+				       void **value, size_t *value_len)
+{
+	struct ext2_xattr_handle *h;
+	errcode_t retval;
+
+	retval = ext2fs_xattrs_open(ctx->fs, ino, &h);
+	if (retval)
+		return retval;
+
+	retval = ext2fs_xattrs_read(h);
+	if (retval == 0)
+		retval = ext2fs_xattr_get(h, "c", value, value_len);
+
+	ext2fs_xattrs_close(&h);
+	return retval;
+}
+
+/*
+ * Convert an fscrypt_context to an fscrypt_policy.  Returns 0,
+ * CORRUPT_ENCRYPTION_POLICY, or UNRECOGNIZED_ENCRYPTION_POLICY.
+ */
+static __u32 fscrypt_context_to_policy(const void *xattr, size_t xattr_size,
+				       union fscrypt_policy *policy_u)
+{
+	const union fscrypt_context *ctx_u = xattr;
+
+	if (xattr_size < 1)
+		return CORRUPT_ENCRYPTION_POLICY;
+	switch (ctx_u->version) {
+	case 0:
+		return CORRUPT_ENCRYPTION_POLICY;
+	case 1: {
+		struct fscrypt_policy_v1 *policy = &policy_u->v1;
+		const struct fscrypt_context_v1 *ctx = &ctx_u->v1;
+
+		if (xattr_size != sizeof(*ctx))
+			return CORRUPT_ENCRYPTION_POLICY;
+		policy->version = ctx->version;
+		policy->contents_encryption_mode =
+			ctx->contents_encryption_mode;
+		policy->filenames_encryption_mode =
+			ctx->filenames_encryption_mode;
+		policy->flags = ctx->flags;
+		memcpy(policy->master_key_descriptor,
+		       ctx->master_key_descriptor,
+		       sizeof(policy->master_key_descriptor));
+		return 0;
+	}
+	case 2: {
+		struct fscrypt_policy_v2 *policy = &policy_u->v2;
+		const struct fscrypt_context_v2 *ctx = &ctx_u->v2;
+
+		if (xattr_size != sizeof(*ctx))
+			return CORRUPT_ENCRYPTION_POLICY;
+		policy->version = ctx->version;
+		policy->contents_encryption_mode =
+			ctx->contents_encryption_mode;
+		policy->filenames_encryption_mode =
+			ctx->filenames_encryption_mode;
+		policy->flags = ctx->flags;
+		memcpy(policy->__reserved, ctx->__reserved,
+		       sizeof(policy->__reserved));
+		memcpy(policy->master_key_identifier,
+		       ctx->master_key_identifier,
+		       sizeof(policy->master_key_identifier));
+		return 0;
+	}
+	}
+	return UNRECOGNIZED_ENCRYPTION_POLICY;
+}
+
+/*
+ * Read an inode's encryption xattr and get/allocate its encryption policy ID,
+ * or alternatively use one of the special IDs NO_ENCRYPTION_POLICY,
+ * CORRUPT_ENCRYPTION_POLICY, or UNRECOGNIZED_ENCRYPTION_POLICY.
+ *
+ * Returns nonzero only if out of memory.
+ */
+static errcode_t get_encryption_policy_id(e2fsck_t ctx, ext2_ino_t ino,
+					  __u32 *policy_id_ret)
+{
+	struct encrypted_file_info *info = ctx->encrypted_files;
+	struct rb_node **new = &info->policies.rb_node;
+	struct rb_node *parent = NULL;
+	void *xattr;
+	size_t xattr_size;
+	union fscrypt_policy policy;
+	__u32 policy_id;
+	struct policy_map_entry *entry;
+	errcode_t retval;
+
+	retval = read_encryption_xattr(ctx, ino, &xattr, &xattr_size);
+	if (retval == EXT2_ET_NO_MEMORY)
+		return retval;
+	if (retval) {
+		*policy_id_ret = NO_ENCRYPTION_POLICY;
+		return 0;
+	}
+
+	/* Translate the xattr to an fscrypt_policy, if possible. */
+	policy_id = fscrypt_context_to_policy(xattr, xattr_size, &policy);
+	ext2fs_free_mem(&xattr);
+	if (policy_id != 0)
+		goto out;
+
+	/* Check if the policy was already seen. */
+	while (*new) {
+		int res;
+
+		parent = *new;
+		entry = ext2fs_rb_entry(parent, struct policy_map_entry, node);
+		res = cmp_fscrypt_policies(ctx, &policy, &entry->policy);
+		if (res < 0) {
+			new = &parent->rb_left;
+		} else if (res > 0) {
+			new = &parent->rb_right;
+		} else {
+			/* Policy already seen.  Use existing ID. */
+			policy_id = entry->policy_id;
+			goto out;
+		}
+	}
+
+	/* First time seeing this policy.  Allocate a new policy ID. */
+	retval = ext2fs_get_mem(sizeof(*entry), &entry);
+	if (retval)
+		goto out;
+	policy_id = info->next_policy_id++;
+	entry->policy_id = policy_id;
+	entry->policy = policy;
+	ext2fs_rb_link_node(&entry->node, parent, new);
+	ext2fs_rb_insert_color(&entry->node, &info->policies);
+out:
+	*policy_id_ret = policy_id;
+	return retval;
+}
+
+static int handle_nomem(e2fsck_t ctx, struct problem_context *pctx,
+			size_t size_needed)
+{
+	pctx->num = size_needed;
+	fix_problem(ctx, PR_1_ALLOCATE_ENCRYPTED_INODE_LIST, pctx);
+	/* Should never get here */
+	ctx->flags |= E2F_FLAG_ABORT;
+	return 0;
+}
+
+static int append_ino_and_policy_id(e2fsck_t ctx, struct problem_context *pctx,
+				    ext2_ino_t ino, __u32 policy_id)
+{
+	struct encrypted_file_info *info = ctx->encrypted_files;
+	struct encrypted_file_range *range;
+
+	/* See if we can just extend the last range. */
+	if (info->file_ranges_count > 0) {
+		range = &info->file_ranges[info->file_ranges_count - 1];
+
+		if (ino <= range->last_ino) {
+			/* Should never get here */
+			fatal_error(ctx,
+				    "Encrypted inodes processed out of order");
+		}
+
+		if (ino == range->last_ino + 1 &&
+		    policy_id == range->policy_id) {
+			range->last_ino++;
+			return 0;
+		}
+	}
+	/* Nope, a new range is needed. */
+
+	if (info->file_ranges_count == info->file_ranges_capacity) {
+		/* Double the capacity by default. */
+		size_t new_capacity = info->file_ranges_capacity * 2;
+
+		/* ... but go from 0 to 128 right away. */
+		if (new_capacity < 128)
+			new_capacity = 128;
+
+		/* We won't need more than the filesystem's inode count. */
+		if (new_capacity > ctx->fs->super->s_inodes_count)
+			new_capacity = ctx->fs->super->s_inodes_count;
+
+		/* To be safe, ensure the capacity really increases. */
+		if (new_capacity < info->file_ranges_capacity + 1)
+			new_capacity = info->file_ranges_capacity + 1;
+
+		if (ext2fs_resize_mem(info->file_ranges_capacity *
+					sizeof(*range),
+				      new_capacity * sizeof(*range),
+				      &info->file_ranges) != 0)
+			return handle_nomem(ctx, pctx,
+					    new_capacity * sizeof(*range));
+
+		info->file_ranges_capacity = new_capacity;
+	}
+	range = &info->file_ranges[info->file_ranges_count++];
+	range->first_ino = ino;
+	range->last_ino = ino;
+	range->policy_id = policy_id;
+	return 0;
+}
+
+/*
+ * Handle an inode that has EXT4_ENCRYPT_FL set during pass 1.  Normally this
+ * just finds the unique ID that identifies the inode's encryption policy
+ * (allocating a new ID if needed), and adds the inode number and its policy ID
+ * to the encrypted_file_info so that it's available in pass 2.
+ *
+ * But this also handles:
+ * - If the inode doesn't have an encryption xattr at all, offer to clear the
+ *   encrypt flag.
+ * - If the encryption xattr is clearly corrupt, tell the caller that the whole
+ *   inode should be cleared.
+ * - To be future-proof: if the encryption xattr has an unrecognized version
+ *   number, it *might* be valid, so we don't consider it invalid.  But we can't
+ *   do much with it, so give all such policies the same ID,
+ *   UNRECOGNIZED_ENCRYPTION_POLICY.
+ *
+ * Returns -1 if the inode should be cleared, otherwise 0.
+ */
+int add_encrypted_file(e2fsck_t ctx, struct problem_context *pctx)
+{
+	struct encrypted_file_info *info = ctx->encrypted_files;
+	ext2_ino_t ino = pctx->ino;
+	__u32 policy_id;
+
+	/* Allocate the encrypted_file_info if needed. */
+	if (info == NULL) {
+		if (ext2fs_get_memzero(sizeof(*info), &info) != 0)
+			return handle_nomem(ctx, pctx, sizeof(*info));
+		ctx->encrypted_files = info;
+	}
+
+	/* Get a unique ID for this inode's encryption policy. */
+	if (get_encryption_policy_id(ctx, ino, &policy_id) != 0)
+		return handle_nomem(ctx, pctx, 0 /* unknown size */);
+	if (policy_id == NO_ENCRYPTION_POLICY) {
+		if (fix_problem(ctx, PR_1_MISSING_ENCRYPTION_XATTR, pctx)) {
+			pctx->inode->i_flags &= ~EXT4_ENCRYPT_FL;
+			e2fsck_write_inode(ctx, ino, pctx->inode, "pass1");
+		}
+		return 0;
+	} else if (policy_id == CORRUPT_ENCRYPTION_POLICY) {
+		if (fix_problem(ctx, PR_1_CORRUPT_ENCRYPTION_XATTR, pctx))
+			return -1;
+		return 0;
+	}
+
+	/* Store this ino => policy_id mapping in the encrypted_file_info. */
+	return append_ino_and_policy_id(ctx, pctx, ino, policy_id);
+}
+
+/*
+ * Find the ID of an inode's encryption policy, using the information saved
+ * earlier.
+ *
+ * If the inode is encrypted, returns the policy ID or
+ * UNRECOGNIZED_ENCRYPTION_POLICY.  Else, returns NO_ENCRYPTION_POLICY.
+ */
+__u32 find_encryption_policy(e2fsck_t ctx, ext2_ino_t ino)
+{
+	const struct encrypted_file_info *info = ctx->encrypted_files;
+	size_t l, r;
+
+	if (info == NULL)
+		return NO_ENCRYPTION_POLICY;
+	l = 0;
+	r = info->file_ranges_count;
+	while (l < r) {
+		size_t m = l + (r - l) / 2;
+		const struct encrypted_file_range *range =
+			&info->file_ranges[m];
+
+		if (ino < range->first_ino)
+			r = m;
+		else if (ino > range->last_ino)
+			l = m + 1;
+		else
+			return range->policy_id;
+	}
+	return NO_ENCRYPTION_POLICY;
+}
+
+/* Destroy ctx->encrypted_files->policies */
+void destroy_encryption_policy_map(e2fsck_t ctx)
+{
+	struct encrypted_file_info *info = ctx->encrypted_files;
+
+	if (info) {
+		struct rb_root *policies = &info->policies;
+
+		while (!ext2fs_rb_empty_root(policies)) {
+			struct policy_map_entry *entry;
+
+			entry = ext2fs_rb_entry(policies->rb_node,
+						struct policy_map_entry, node);
+			ext2fs_rb_erase(&entry->node, policies);
+			ext2fs_free_mem(&entry);
+		}
+		info->next_policy_id = 0;
+	}
+}
+
+/* Destroy ctx->encrypted_files */
+void destroy_encrypted_file_info(e2fsck_t ctx)
+{
+	struct encrypted_file_info *info = ctx->encrypted_files;
+
+	if (info) {
+		destroy_encryption_policy_map(ctx);
+		ext2fs_free_mem(&info->file_ranges);
+		ext2fs_free_mem(&info);
+		ctx->encrypted_files = NULL;
+	}
+}
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 7018f154..14adba95 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -27,6 +27,7 @@
  * 	- A bitmap of which blocks are in use by two inodes	(block_dup_map)
  * 	- The data blocks of the directory inodes.	(dir_map)
  * 	- Ref counts for ea_inodes.			(ea_inode_refs)
+ * 	- The encryption policy ID of each encrypted inode. (encrypted_files)
  *
  * Pass 1 is designed to stash away enough information so that the
  * other passes should not need to read in the inode information
@@ -78,7 +79,6 @@ static void mark_table_blocks(e2fsck_t ctx);
 static void alloc_bb_map(e2fsck_t ctx);
 static void alloc_imagic_map(e2fsck_t ctx);
 static void mark_inode_bad(e2fsck_t ctx, ino_t ino);
-static void add_encrypted_dir(e2fsck_t ctx, ino_t ino);
 static void handle_fs_bad_blocks(e2fsck_t ctx);
 static void process_inodes(e2fsck_t ctx, char *block_buf);
 static EXT2_QSORT_TYPE process_inode_cmp(const void *a, const void *b);
@@ -1883,12 +1883,14 @@ void e2fsck_pass1(e2fsck_t ctx)
 			failed_csum = 0;
 		}
 
+		if ((inode->i_flags & EXT4_ENCRYPT_FL) &&
+		    add_encrypted_file(ctx, &pctx) < 0)
+			goto clear_inode;
+
 		if (LINUX_S_ISDIR(inode->i_mode)) {
 			ext2fs_mark_inode_bitmap2(ctx->inode_dir_map, ino);
 			e2fsck_add_dir_info(ctx, ino, 0);
 			ctx->fs_directory_count++;
-			if (inode->i_flags & EXT4_ENCRYPT_FL)
-				add_encrypted_dir(ctx, ino);
 		} else if (LINUX_S_ISREG (inode->i_mode)) {
 			ext2fs_mark_inode_bitmap2(ctx->inode_reg_map, ino);
 			ctx->fs_regular_count++;
@@ -2017,6 +2019,9 @@ void e2fsck_pass1(e2fsck_t ctx)
 		ctx->block_ea_map = 0;
 	}
 
+	/* We don't need the encryption policy => ID map any more */
+	destroy_encryption_policy_map(ctx);
+
 	if (ctx->flags & E2F_FLAG_RESIZE_INODE) {
 		clear_problem_context(&pctx);
 		pctx.errcode = ext2fs_create_resize_inode(fs);
@@ -2201,24 +2206,6 @@ static void mark_inode_bad(e2fsck_t ctx, ino_t ino)
 	ext2fs_mark_inode_bitmap2(ctx->inode_bad_map, ino);
 }
 
-static void add_encrypted_dir(e2fsck_t ctx, ino_t ino)
-{
-	struct		problem_context pctx;
-
-	if (!ctx->encrypted_dirs) {
-		pctx.errcode = ext2fs_u32_list_create(&ctx->encrypted_dirs, 0);
-		if (pctx.errcode)
-			goto error;
-	}
-	pctx.errcode = ext2fs_u32_list_add(ctx->encrypted_dirs, ino);
-	if (pctx.errcode == 0)
-		return;
-error:
-	fix_problem(ctx, PR_1_ALLOCATE_ENCRYPTED_DIRLIST, &pctx);
-	/* Should never get here */
-	ctx->flags |= E2F_FLAG_ABORT;
-}
-
 /*
  * This procedure will allocate the inode "bb" (badblock) map table
  */
diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index 8b40e93d..306373bf 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -35,10 +35,12 @@
  * 	- The inode_used_map bitmap
  * 	- The inode_bad_map bitmap
  * 	- The inode_dir_map bitmap
+ * 	- The encrypted_file_info
  *
  * Pass 2 frees the following data structures
  * 	- The inode_bad_map bitmap
  * 	- The inode_reg_map bitmap
+ * 	- The encrypted_file_info
  */
 
 #define _GNU_SOURCE 1 /* get strnlen() */
@@ -284,10 +286,7 @@ void e2fsck_pass2(e2fsck_t ctx)
 		ext2fs_free_inode_bitmap(ctx->inode_reg_map);
 		ctx->inode_reg_map = 0;
 	}
-	if (ctx->encrypted_dirs) {
-		ext2fs_u32_list_free(ctx->encrypted_dirs);
-		ctx->encrypted_dirs = 0;
-	}
+	destroy_encrypted_file_info(ctx);
 
 	clear_problem_context(&pctx);
 	if (ctx->large_files) {
@@ -504,14 +503,12 @@ static int check_name(e2fsck_t ctx,
 }
 
 static int encrypted_check_name(e2fsck_t ctx,
-				struct ext2_dir_entry *dirent,
+				const struct ext2_dir_entry *dirent,
 				struct problem_context *pctx)
 {
 	if (ext2fs_dirent_name_len(dirent) < EXT4_CRYPTO_BLOCK_SIZE) {
-		if (fix_problem(ctx, PR_2_BAD_ENCRYPTED_NAME, pctx)) {
-			dirent->inode = 0;
+		if (fix_problem(ctx, PR_2_BAD_ENCRYPTED_NAME, pctx))
 			return 1;
-		}
 		ext2fs_unmark_valid(ctx->fs);
 	}
 	return 0;
@@ -877,6 +874,71 @@ err:
 	return retval;
 }
 
+/* Return true if this type of file needs encryption */
+static int needs_encryption(e2fsck_t ctx, const struct ext2_dir_entry *dirent)
+{
+	int filetype = ext2fs_dirent_file_type(dirent);
+	ext2_ino_t ino = dirent->inode;
+	struct ext2_inode inode;
+
+	if (filetype != EXT2_FT_UNKNOWN)
+		return filetype == EXT2_FT_REG_FILE ||
+		       filetype == EXT2_FT_DIR ||
+		       filetype == EXT2_FT_SYMLINK;
+
+	if (ext2fs_test_inode_bitmap2(ctx->inode_reg_map, ino) ||
+	    ext2fs_test_inode_bitmap2(ctx->inode_dir_map, ino))
+		return 1;
+
+	e2fsck_read_inode(ctx, ino, &inode, "check_encryption_policy");
+	return LINUX_S_ISREG(inode.i_mode) ||
+	       LINUX_S_ISDIR(inode.i_mode) ||
+	       LINUX_S_ISLNK(inode.i_mode);
+}
+
+/*
+ * All regular files, directories, and symlinks in encrypted directories must be
+ * encrypted using the same encryption policy as their directory.
+ *
+ * Returns 1 if the dirent should be cleared, otherwise 0.
+ */
+static int check_encryption_policy(e2fsck_t ctx,
+				   const struct ext2_dir_entry *dirent,
+				   __u32 dir_encpolicy_id,
+				   struct problem_context *pctx)
+{
+	__u32 file_encpolicy_id = find_encryption_policy(ctx, dirent->inode);
+
+	/* Same policy or both UNRECOGNIZED_ENCRYPTION_POLICY? */
+	if (file_encpolicy_id == dir_encpolicy_id)
+		return 0;
+
+	if (file_encpolicy_id == NO_ENCRYPTION_POLICY) {
+		if (!needs_encryption(ctx, dirent))
+			return 0;
+		return fix_problem(ctx, PR_2_UNENCRYPTED_FILE, pctx);
+	}
+
+	return fix_problem(ctx, PR_2_INCONSISTENT_ENCRYPTION_POLICY, pctx);
+}
+
+/*
+ * Check an encrypted directory entry.
+ *
+ * Returns 1 if the dirent should be cleared, otherwise 0.
+ */
+static int check_encrypted_dirent(e2fsck_t ctx,
+				  const struct ext2_dir_entry *dirent,
+				  __u32 dir_encpolicy_id,
+				  struct problem_context *pctx)
+{
+	if (encrypted_check_name(ctx, dirent, pctx))
+		return 1;
+	if (check_encryption_policy(ctx, dirent, dir_encpolicy_id, pctx))
+		return 1;
+	return 0;
+}
+
 static int check_dir_block2(ext2_filsys fs,
 			   struct ext2_db_entry2 *db,
 			   void *priv_data)
@@ -931,7 +993,7 @@ static int check_dir_block(ext2_filsys fs,
 	int	is_leaf = 1;
 	size_t	inline_data_size = 0;
 	int	filetype = 0;
-	int	encrypted = 0;
+	__u32   dir_encpolicy_id = NO_ENCRYPTION_POLICY;
 	size_t	max_block_size;
 	int	hash_flags = 0;
 
@@ -1150,8 +1212,7 @@ skip_checksum:
 	} else
 		max_block_size = fs->blocksize - de_csum_size;
 
-	if (ctx->encrypted_dirs)
-		encrypted = ext2fs_u32_list_test(ctx->encrypted_dirs, ino);
+	dir_encpolicy_id = find_encryption_policy(ctx, ino);
 
 	dict_init(&de_dict, DICTCOUNT_T_MAX, dict_de_cmp);
 	prev = 0;
@@ -1415,18 +1476,25 @@ skip_checksum:
 			}
 		}
 
-		if (!encrypted && check_name(ctx, dirent, &cd->pctx))
+		if (check_filetype(ctx, dirent, ino, &cd->pctx))
 			dir_modified++;
 
-		if (encrypted && (dot_state) > 1 &&
-		    encrypted_check_name(ctx, dirent, &cd->pctx)) {
-			dir_modified++;
-			goto next;
+		if (dir_encpolicy_id == NO_ENCRYPTION_POLICY) {
+			/* Unencrypted directory */
+			if (check_name(ctx, dirent, &cd->pctx))
+				dir_modified++;
+		} else {
+			/* Encrypted directory */
+			if (dot_state > 1 &&
+			    check_encrypted_dirent(ctx, dirent,
+						   dir_encpolicy_id,
+						   &cd->pctx)) {
+				dirent->inode = 0;
+				dir_modified++;
+				goto next;
+			}
 		}
 
-		if (check_filetype(ctx, dirent, ino, &cd->pctx))
-			dir_modified++;
-
 		if (dx_db) {
 			if (dx_dir->casefolded_hash)
 				hash_flags = EXT4_CASEFOLD_FL;
diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index 27c69575..c7c0ba98 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -1199,9 +1199,9 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("@i %i has a duplicate @x mapping\n\t(logical @b %c, @n physical @b %b, len %N)\n"),
 	  PROMPT_CLEAR, 0, 0, 0, 0 },
 
-	/* Error allocating memory for encrypted directory list */
-	{ PR_1_ALLOCATE_ENCRYPTED_DIRLIST,
-	  N_("@A memory for encrypted @d list\n"),
+	/* Error allocating memory for encrypted inode list */
+	{ PR_1_ALLOCATE_ENCRYPTED_INODE_LIST,
+	  N_("@A %N bytes of memory for encrypted @i list\n"),
 	  PROMPT_NONE, PR_FATAL, 0, 0, 0 },
 
 	/* Inode extent tree could be more shallow */
@@ -1259,6 +1259,16 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("@d %p has the casefold flag, but the\ncasefold feature is not enabled.  "),
 	  PROMPT_CLEAR_FLAG, 0, 0, 0, 0 },
 
+	/* Inode has encrypt flag but no encryption extended attribute */
+	{ PR_1_MISSING_ENCRYPTION_XATTR,
+	  N_("@i %i has encrypt flag but no encryption @a.\n"),
+	  PROMPT_CLEAR_FLAG, 0, 0, 0, 0 },
+
+	/* Encrypted inode has corrupt encryption extended attribute */
+	{ PR_1_CORRUPT_ENCRYPTION_XATTR,
+	  N_("Encrypted @i %i has corrupt encryption @a.\n"),
+	  PROMPT_CLEAR_INODE, 0, 0, 0, 0 },
+
 	/* Pass 1b errors */
 
 	/* Pass 1B: Rescan for duplicate/bad blocks */
@@ -1785,6 +1795,16 @@ static struct e2fsck_problem problem_table[] = {
 	  N_("Encrypted @E is too short.\n"),
 	  PROMPT_CLEAR, 0, 0, 0, 0 },
 
+	/* Encrypted directory contains unencrypted file */
+	{ PR_2_UNENCRYPTED_FILE,
+	  N_("Encrypted @E references unencrypted @i %Di.\n"),
+	  PROMPT_CLEAR, 0, 0, 0, 0 },
+
+	/* Encrypted directory contains file with different encryption policy */
+	{ PR_2_INCONSISTENT_ENCRYPTION_POLICY,
+	  N_("Encrypted @E references @i %Di, which has a different encryption policy.\n"),
+	  PROMPT_CLEAR, 0, 0, 0, 0 },
+
 	/* Pass 3 errors */
 
 	/* Pass 3: Checking directory connectivity */
diff --git a/e2fsck/problem.h b/e2fsck/problem.h
index 5cc89249..c7f65f6d 100644
--- a/e2fsck/problem.h
+++ b/e2fsck/problem.h
@@ -667,8 +667,8 @@ struct problem_context {
 /* Inode leaf has a duplicate extent mapping */
 #define PR_1_EXTENT_COLLISION			0x01007D
 
-/* Error allocating memory for encrypted directory list */
-#define PR_1_ALLOCATE_ENCRYPTED_DIRLIST		0x01007E
+/* Error allocating memory for encrypted inode list */
+#define PR_1_ALLOCATE_ENCRYPTED_INODE_LIST	0x01007E
 
 /* Inode extent tree could be more shallow */
 #define PR_1_EXTENT_BAD_MAX_DEPTH		0x01007F
@@ -701,6 +701,11 @@ struct problem_context {
 /* Casefold flag set, but file system is missing the casefold feature */
 #define PR_1_CASEFOLD_FEATURE			0x010089
 
+/* Inode has encrypt flag but no encryption extended attribute */
+#define PR_1_MISSING_ENCRYPTION_XATTR		0x01008A
+
+/* Encrypted inode has corrupt encryption extended attribute */
+#define PR_1_CORRUPT_ENCRYPTION_XATTR		0x01008B
 
 /*
  * Pass 1b errors
@@ -1017,6 +1022,12 @@ struct problem_context {
 /* Encrypted directory entry is too short */
 #define PR_2_BAD_ENCRYPTED_NAME		0x020050
 
+/* Encrypted directory contains unencrypted file */
+#define PR_2_UNENCRYPTED_FILE		0x020051
+
+/* Encrypted directory contains file with different encryption policy */
+#define PR_2_INCONSISTENT_ENCRYPTION_POLICY	0x020052
+
 /*
  * Pass 3 errors
  */
diff --git a/po/POTFILES.in b/po/POTFILES.in
index d6b4f433..f5b5936e 100644
--- a/po/POTFILES.in
+++ b/po/POTFILES.in
@@ -5,6 +5,7 @@ e2fsck/e2fsck.c
 e2fsck/ea_refcount.c
 e2fsck/ehandler.c
 e2fsck/emptydir.c
+e2fsck/encrypted_files.c
 e2fsck/extend.c
 e2fsck/extents.c
 e2fsck/flushb.c
diff --git a/tests/f_bad_encryption/expect.1 b/tests/f_bad_encryption/expect.1
new file mode 100644
index 00000000..d743e66f
--- /dev/null
+++ b/tests/f_bad_encryption/expect.1
@@ -0,0 +1,125 @@
+Pass 1: Checking inodes, blocks, and sizes
+Inode 17 has encrypt flag but no encryption extended attribute.
+Clear flag? yes
+
+Inode 18 has encrypt flag but no encryption extended attribute.
+Clear flag? yes
+
+Encrypted inode 19 has corrupt encryption extended attribute.
+Clear inode? yes
+
+Encrypted inode 20 has corrupt encryption extended attribute.
+Clear inode? yes
+
+Encrypted inode 21 has corrupt encryption extended attribute.
+Clear inode? yes
+
+Encrypted inode 22 has corrupt encryption extended attribute.
+Clear inode? yes
+
+Pass 2: Checking directory structure
+Encrypted entry 'd6M->'M-#I^VM-^KM-F~^WSJ+M-uM-zM-zXM-^' in /edir (12) references unencrypted inode 17.
+Clear? yes
+
+Encrypted entry '\M-!M-Y%DhM-OM-VM-zM-CM-gVM-R3M-^RM-IkE^JM-^S' in /edir (12) references unencrypted inode 18.
+Clear? yes
+
+Entry 'M-{^Qp-M-sM-U7eM-^C^L^PG^ZM-FM-,M-B' in /edir (12) has deleted/unused inode 19.  Clear? yes
+
+Entry 'M-f0M-f3/M-NM-GM-:M-^YM-jM-XM-91DM-^_M-V' in /edir (12) has deleted/unused inode 20.  Clear? yes
+
+Entry '^M-R"M-^K^P7M-'M-EM-C}^MM-yM-^LwM-^N^Z' in /edir (12) has deleted/unused inode 21.  Clear? yes
+
+Entry 'M-s^J_;uIvM-^Z[M-nIM-5vM-^AcM-o' in /edir (12) has deleted/unused inode 22.  Clear? yes
+
+Encrypted entry 'kK=,M-bM-^AM-{M-YM-^J6M-hM-y^XM-^W}M-M' in /edir (12) references unencrypted inode 23.
+Clear? yes
+
+Encrypted entry 'M-VM-cxM-jM-zM-b^WM-o*M-jM-uM-,R^PM-hM-2' in /edir (12) references unencrypted inode 24.
+Clear? yes
+
+Encrypted entry 'UqM-AM-#KM-^PM-_^kM-9P0M-^FM-_^@;A^J"R' in /edir (12) references unencrypted inode 25.
+Clear? yes
+
+Encrypted entry 'M-TM-N8^[M-3M-( M-[A^FR}^ZhkM-^?=M-c^Mo' in /edir (12) references inode 26, which has a different encryption policy.
+Clear? yes
+
+Encrypted entry 'M--aM-^?~M-^\M-u^FM-/!^YM-OZM-^LM-)M-p1' in /edir (12) references inode 27, which has a different encryption policy.
+Clear? yes
+
+Encrypted entry '(M-8RKM-LM-eM-^W^[M-'M-SM-@uM-^VM-|M-GiM-^JbM-nM-z' in /edir (12) references inode 28, which has a different encryption policy.
+Clear? yes
+
+Encrypted entry '\M-ggCeM-/?M-^BM-{(M-^OM-9M-^QQAM-^N=M-c^Mo' in /edir (12) references inode 29, which has a different encryption policy.
+Clear? yes
+
+Pass 3: Checking directory connectivity
+Unconnected directory inode 18 (/edir/???)
+Connect to /lost+found? yes
+
+Unconnected directory inode 24 (/edir/???)
+Connect to /lost+found? yes
+
+Unconnected directory inode 27 (/edir/???)
+Connect to /lost+found? yes
+
+Pass 4: Checking reference counts
+Unattached inode 17
+Connect to /lost+found? yes
+
+Inode 17 ref count is 2, should be 1.  Fix? yes
+
+Inode 18 ref count is 3, should be 2.  Fix? yes
+
+Unattached inode 23
+Connect to /lost+found? yes
+
+Inode 23 ref count is 2, should be 1.  Fix? yes
+
+Inode 24 ref count is 3, should be 2.  Fix? yes
+
+Unattached inode 25
+Connect to /lost+found? yes
+
+Inode 25 ref count is 2, should be 1.  Fix? yes
+
+Unattached inode 26
+Connect to /lost+found? yes
+
+Inode 26 ref count is 2, should be 1.  Fix? yes
+
+Inode 27 ref count is 3, should be 2.  Fix? yes
+
+Unattached inode 28
+Connect to /lost+found? yes
+
+Inode 28 ref count is 2, should be 1.  Fix? yes
+
+Unattached inode 29
+Connect to /lost+found? yes
+
+Inode 29 ref count is 2, should be 1.  Fix? yes
+
+Pass 5: Checking group summary information
+Block bitmap differences:  -(25--32)
+Fix? yes
+
+Free blocks count wrong for group #0 (75, counted=83).
+Fix? yes
+
+Free blocks count wrong (75, counted=83).
+Fix? yes
+
+Inode bitmap differences:  -(19--22)
+Fix? yes
+
+Free inodes count wrong for group #0 (95, counted=99).
+Fix? yes
+
+Free inodes count wrong (95, counted=99).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 29/128 files (0.0% non-contiguous), 45/128 blocks
+Exit status is 1
diff --git a/tests/f_bad_encryption/expect.2 b/tests/f_bad_encryption/expect.2
new file mode 100644
index 00000000..fcfabdbd
--- /dev/null
+++ b/tests/f_bad_encryption/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 29/128 files (0.0% non-contiguous), 45/128 blocks
+Exit status is 0
diff --git a/tests/f_bad_encryption/image.gz b/tests/f_bad_encryption/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..64b59b78b8da9496a9473b50b12a841fe0fc8a2f
GIT binary patch
literal 2265
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
DaJ>8o

literal 0
HcmV?d00001

diff --git a/tests/f_bad_encryption/mkimage.sh b/tests/f_bad_encryption/mkimage.sh
new file mode 100755
index 00000000..e58395df
--- /dev/null
+++ b/tests/f_bad_encryption/mkimage.sh
@@ -0,0 +1,169 @@
+#!/bin/bash
+#
+# This is the script that was used to create the image.gz in this directory.
+#
+# This requires a patched version of debugfs that understands the "fscrypt."
+# xattr name prefix, so that the encryption xattrs can be manipulated.
+
+set -e -u
+umask 0022
+
+do_debugfs() {
+	umount mnt
+	debugfs -w "$@" image
+	mount image mnt
+}
+
+create_encrypted_file() {
+	local file=$1
+	local ino
+
+	echo foo > "$file"
+
+	# not needed, but makes image more compressible
+	ino=$(stat -c %i "$file")
+	do_debugfs -R "zap_block -f <$ino> 0"
+}
+
+set_encryption_xattr() {
+	local file=$1
+	local value=$2
+	local ino
+
+	ino=$(stat -c %i "$file")
+	do_debugfs -R "ea_set <$ino> fscrypt.c $value"
+}
+
+rm_encryption_xattr() {
+	local file=$1
+	local ino
+
+	ino=$(stat -c %i "$file")
+	do_debugfs -R "ea_rm <$ino> fscrypt.c"
+}
+
+clear_encrypt_flag() {
+	local file=$1
+	local ino
+
+	ino=$(stat -c %i "$file")
+	do_debugfs -R "set_inode_field <$ino> flags 0"
+}
+
+clear_encryption() {
+	local file=$1
+	local ino
+	local is_symlink=false
+
+	if [ -L "$file" ]; then
+		is_symlink=true
+	fi
+	ino=$(stat -c %i "$file")
+
+	do_debugfs -R "ea_rm <$ino> fscrypt.c"
+	do_debugfs -R "set_inode_field <$ino> flags 0"
+	if $is_symlink; then
+		do_debugfs -R "set_inode_field <$ino> block[0] 0xAAAAAAAA"
+		do_debugfs -R "set_inode_field <$ino> block[1] 0"
+		do_debugfs -R "set_inode_field <$ino> size 4"
+	fi
+}
+
+mkdir -p mnt
+umount mnt &> /dev/null || true
+
+dd if=/dev/zero of=image bs=4096 count=128
+mke2fs -O encrypt -b 4096 -N 128 image
+mount image mnt
+
+# Create an encrypted directory (ino 12)
+dir=mnt/edir
+mkdir $dir
+echo password | e4crypt add_key $dir
+
+# Control cases: valid encrypted regular file, dir, and symlink (ino 13-15)
+create_encrypted_file $dir/encrypted_file
+mkdir $dir/encrypted_dir
+ln -s target $dir/encrypted_symlink
+
+# Control case: file type that is never encrypted (ino 16)
+mkfifo $dir/fifo
+
+# Inodes with missing encryption xattr (ino 17-18).
+# e2fsck should offer to clear the encrypt flag on these inodes.
+
+create_encrypted_file $dir/missing_xattr_file
+rm_encryption_xattr $dir/missing_xattr_file
+
+mkdir $dir/missing_xattr_dir
+rm_encryption_xattr $dir/missing_xattr_dir
+
+# Inodes with corrupt encryption xattr (ino 19-22).
+# e2fsck should offer to clear these inodes.
+
+create_encrypted_file $dir/corrupt_xattr_1
+set_encryption_xattr $dir/corrupt_xattr_1 '\0'
+
+create_encrypted_file $dir/corrupt_xattr_2
+set_encryption_xattr $dir/corrupt_xattr_2 \
+	'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'
+
+create_encrypted_file $dir/corrupt_xattr_3
+set_encryption_xattr $dir/corrupt_xattr_3 '\1'
+
+create_encrypted_file $dir/corrupt_xattr_4
+set_encryption_xattr $dir/corrupt_xattr_4 '\2'
+
+# Unencrypted inodes in encrypted directory (ino 23-25).
+# e2fsck should offer to clear these directory entries.
+
+create_encrypted_file $dir/unencrypted_file
+clear_encryption $dir/unencrypted_file
+
+mkdir $dir/unencrypted_dir
+clear_encryption $dir/unencrypted_dir
+
+ln -s target $dir/unencrypted_symlink
+clear_encryption $dir/unencrypted_symlink
+
+# Inodes with different encryption policy in encrypted directory (ino 26-29).
+# e2fsck should offer to clear these directory entries.
+
+xattr='\1\1\4\0AAAAAAAABBBBBBBBBBBBBBBB'
+
+create_encrypted_file $dir/inconsistent_file_1
+set_encryption_xattr $dir/inconsistent_file_1 $xattr
+
+mkdir $dir/inconsistent_dir
+set_encryption_xattr $dir/inconsistent_dir $xattr
+
+ln -s target $dir/inconsistent_symlink
+set_encryption_xattr $dir/inconsistent_symlink $xattr
+
+xattr='\2\1\4\0\0\0\0\0AAAAAAAAAAAAAAAABBBBBBBBBBBBBBBB'
+create_encrypted_file $dir/inconsistent_file_2
+set_encryption_xattr $dir/inconsistent_file_2 $xattr
+
+# Encrypted file and directory with valid v2 encryption policy (ino 30-31).
+# e2fsck shouldn't change these.
+dir2=mnt/edir2
+mkdir $dir2
+echo password | e4crypt add_key $dir2
+xattr='\2\1\4\0\0\0\0\0AAAAAAAAAAAAAAAABBBBBBBBBBBBBBBB'
+create_encrypted_file $dir2/file
+set_encryption_xattr $dir2/file $xattr
+set_encryption_xattr $dir2 $xattr
+
+# Encrypted file and directory with unrecognized encryption policy version
+# (ino 32-33).  e2fsck shouldn't change these.
+dir3=mnt/edir3
+mkdir $dir3
+echo password | e4crypt add_key $dir3
+xattr='\3'
+create_encrypted_file $dir3/file
+set_encryption_xattr $dir3/file $xattr
+set_encryption_xattr $dir3 $xattr
+
+umount mnt
+rmdir mnt
+gzip -9 -f image
diff --git a/tests/f_bad_encryption/name b/tests/f_bad_encryption/name
new file mode 100644
index 00000000..85b19eda
--- /dev/null
+++ b/tests/f_bad_encryption/name
@@ -0,0 +1 @@
+missing, corrupt, and inconsistent encryption policies
diff --git a/tests/f_short_encrypted_dirent/expect.1 b/tests/f_short_encrypted_dirent/expect.1
index bc649222..29e1625c 100644
--- a/tests/f_short_encrypted_dirent/expect.1
+++ b/tests/f_short_encrypted_dirent/expect.1
@@ -13,5 +13,5 @@ Inode 13 ref count is 2, should be 1.  Fix? yes
 Pass 5: Checking group summary information
 
 test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
-test_filesys: 13/16 files (0.0% non-contiguous), 23/100 blocks
+test_filesys: 13/16 files (0.0% non-contiguous), 24/100 blocks
 Exit status is 1
diff --git a/tests/f_short_encrypted_dirent/expect.2 b/tests/f_short_encrypted_dirent/expect.2
index 636c6e9e..1ebd598e 100644
--- a/tests/f_short_encrypted_dirent/expect.2
+++ b/tests/f_short_encrypted_dirent/expect.2
@@ -3,5 +3,5 @@ Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-test_filesys: 13/16 files (0.0% non-contiguous), 23/100 blocks
+test_filesys: 13/16 files (0.0% non-contiguous), 24/100 blocks
 Exit status is 0
diff --git a/tests/f_short_encrypted_dirent/image.gz b/tests/f_short_encrypted_dirent/image.gz
index a35bfb23b51aee75da142886a39380915d629f8e..7eb1c951f4e747c72a8245e5ca040ab07828a632 100644
GIT binary patch
delta 967
zcmV;&133Jh2k-}fABzYG?<+1{0t0DnVP|Ck?c7ah9Ay{);F--9>b8|y<Ih3b(Sj|p
zCOrrhD$<C>OK72OkorU2>`s!Qo85GGVjHd4A_(e5JxI@@w&2f65ig>mQt=`RrJ@!O
zT0|_i=t0yHXE#Z$HdVCZHp%nAo6OF9Gw(Ma-}_An>;wUSFkdarqMXHoEc&wO$Ra$u
zK{Odlr#^<)ci$TX6BAp%4_oby<PP;uH=RCjQ5O5MxH*e=a$&GD9|TW~{PNm{XEt=c
zwD;q?uKJ|w&34@D#w&Myw6|yD@>f>%jf_8aU}qR?2o_HrJNrKVOW_Rr^4ZR1b9hdL
zd37}#Jbmqd^Xr=Ret8xvTlL@3s{f|9N1uG4BY6D5^PPKO>8{U=Ak1zP6D!U<1Am$T
z=964j_ltut*PZ>I+|K2?yC?sK?+gmLO0ALJFjyO_mV?$hak!(98;a8%jp1579Ur%V
z!Yq{4^0B+`yKZdJpX&dcj>-B5=63x*^5N@;n%h5rb{G$sZ}orr=Yf0FKd65|{R8SB
zQ2&7X2h=~H{sHw5sDEH~);}<B*MS+o|F<OD{=6d}j?~h!QG&Vm{QvUAyV1l7-+_kt
zs<3T1jz;UXp?Yzo5hc}9Wvm>Rquoh59HrTz+v9<xSdH%3)Zf#WRLAy2jqyerk3_|K
z91Yfg<2Y*62GiZyr}c$q^LS6Olt$&Gk=B!eu{5bwqcpB(S01d@qqtZap3c>}Ksj!d
zvUXX%q}t3@NUG)J{-iustVDxJC2n>o>KSX)dm6)8`<`;G)YH{ds*R4<lcC|XyHGf%
zd!^b)c3P|Zy|-=M+}FQtW8d~@)8^>T-Yr{ydN*y`z9vd*(PUTCxSAG5v+gBnn)P8|
zJSvWkR+3V2pb|%w;_mK(=LB<I?%U=&>YB0l;KPsY`EK<WXCDnO`KtBb!E2_Dmkb!p
zDq)xpx{iK&c+Jt1$5x~-uWzh+|M=;32cJE)@OYQe0RR910000000000fQ#Re+@bz|
z>G;2LzPKX@PV{CQ`I++PTkj(Yf`zT0g&)FZvopfU(=N!PzqWVGSFUbv{{1(#H-GO3
z?ahDkjUd>!KigQF&!0R0!m0W9?_Ksc$A?~M@BP2Juf6%xhuWL}y(K~LR&)JXJJb4;
z3$Ff)^{4sXqy-n4f7z|SuYX@>d8cD7I)5wQ!t<|x%l<*GD`wbt<1In(TsHrgXBRt_
p<(-Z{&j0i0@4UeKKX9q%E|XycFOzTs4-8yPeggtG1iAo_0RSAO3C;ij

delta 884
zcmV-)1B?9d2b~9hABzY8%mk=a0t4;bO^6#+902giN1>#x)^$-&b+8Ae>ZS(|f*@V7
zh_G&<?NX{j%_g(EL$k>?nb@vWXc4@4Q4s0DqsodOCq?uiA_|HiqEL{EcoDo56+QUL
z`jYI{YPSlm7`OZT!9RJEc{Bev!~4I<C5a+nz1kY07Ggtxh<id5Lgdcx5cgy2(&pWT
zg^4IyT-^6{uGjB$zPsJGeB7oGCqmpB;_ZAcI$VsR$7X+ib=On7hF?7X@x51nvg6G`
zT<h+uj(l{yynEZr*N@H4KXK}CF4`4sUfOs5b^M!hD|}WA9}Zo@b1GL<S8Kt6PoICf
zTkltf*xsvu|3a_+yT)#Q{Gmeh#*Y^}_N6C}oN)(XZChNt{M<9}hecpL$%ne%9Od#O
z;l1C^=SN2R-{FU&Qoi17XE#nYJB?b@TPNNtl=9O_cBnnmY-RKF7EoA&LM?xO-vifm
zHvOsozbf?WAGoyZ|B(+~Tj;jGFSsAD-s=C?pC<2rSO1{?0rd~4e?a{M>K{=5fcgj2
zKcN1BwORkbx?KlW{QcjS(EhAY%*{5ln!5y--t+&9v+u-<*ZK`KtXHM|Gf6zxYEHK*
zv+X!-RO_8uQj3qK*-V^;U3VsvX{8b0H9k=uOB<bIaeKa<C9`p*mBdr6B#GP2sqARj
zx~<fI?VcQ~RI|92wzF0`*~!voBhHdmIP+Aq6(^PI%yO>Y32I5Z8v2ENX``F1ls0PV
zgK4c(smD`kJ?Rc8E_d3ka(gE9FV~vY@{V$~IXB-*r)RQ}Qt5)>RhzTnu-@=T@7T9z
zY-0cJv4ipWp7_A%-o2ya`w!j}XU(`j)GTR#WTm+<yfn+g7$)cA%G_K%tyU)MNnEcS
z9VvNE000000000000000001x;r}GOF%kf|3eBn?OogEF0;!638z5gSLqK&=R(s#LT
zw{vp+!&c?dUj}>6x8E?>{3mZ2Z2r;r2b=$!*Q4mf$<WwYEM7SOa!d2?pS$93_D?@q
zH`wcc<-}m~XAciH|GQhF=&kPhvvZ~OCm&t&7wb>=f0H(>GXK!+zpsB^hP=zMoWD2!
zHeP)F8(L-l51);qXTtp77EbnU$h#bWoc|ZkKfKEPr!Mo{1(UG@Gn2pr3Jrk&livXD
KpmHz(kO2TCINj?2

-- 
2.23.0.237.gc6a4ce50a0-goog

