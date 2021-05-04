Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC23E3724A8
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 05:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhEDDL2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 May 2021 23:11:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52424 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229687AbhEDDL1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 May 2021 23:11:27 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1443AT4p024598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 May 2021 23:10:30 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 701E115C39C6; Mon,  3 May 2021 23:10:29 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     harshads@google.com, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] e2fsck: fix portability problems caused by unaligned accesses
Date:   Mon,  3 May 2021 23:10:24 -0400
Message-Id: <20210504031024.3888676-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The on-disk format for the ext4 journal can have unaigned 32-bit
integers.  This can happen when replaying a journal using a obsolete
checksum format (which was never popularly used, since the v3 format
replaced v2 while the metadata checksum feature was being stablized),
and in the fast commit feature (which landed in the 5.10 kernel,
although it is not enabled by default).

This commit fixes the following regression tests on some platforms
(such as running 32-bit arm architectures on a 64-bit arm kernel):
j_recover_csum2_32bit, j_recover_csum2_64bit, j_recover_fast_commit.

https://github.com/tytso/e2fsprogs/issues/65

Addresses-Debian-Bug: #987641
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/journal.c                   | 41 ++++++++++++++++++++---------
 e2fsck/recovery.c                  | 42 +++++++++++++++++++++++++-----
 tests/j_recover_fast_commit/script |  1 -
 3 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index a425bbd1..2231b811 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -278,6 +278,23 @@ static int process_journal_block(ext2_filsys fs,
 	return 0;
 }
 
+/*
+ * This function works on unaligned 32-bit pointers, which is needed
+ * since fast_commit's on-disk format does not guarantee that pointers
+ * are 32-bit aligned.
+ */
+static __u32 get_le32(__le32 *p)
+{
+	unsigned char *cp = (unsigned char *) p;
+	__u32 ret;
+
+	ret = (__u32) *cp++;
+	ret = ret | ((__u32) *cp++ << 8);
+	ret = ret | ((__u32) *cp++ << 16);
+	ret = ret | ((__u32) *cp++ << 24);
+	return ret;
+}
+
 static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 				int off, tid_t expected_tid)
 {
@@ -344,10 +361,10 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 						offsetof(struct ext4_fc_tail,
 						fc_crc));
 			jbd_debug(1, "tail tid %d, expected %d\n",
-					le32_to_cpu(tail->fc_tid),
+					get_le32(&tail->fc_tid),
 					expected_tid);
-			if (le32_to_cpu(tail->fc_tid) == expected_tid &&
-				le32_to_cpu(tail->fc_crc) == state->fc_crc) {
+			if (get_le32(&tail->fc_tid) == expected_tid &&
+				get_le32(&tail->fc_crc) == state->fc_crc) {
 				state->fc_replay_num_tags = state->fc_cur_tag;
 			} else {
 				ret = state->fc_replay_num_tags ?
@@ -357,12 +374,12 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 			break;
 		case EXT4_FC_TAG_HEAD:
 			head = (struct ext4_fc_head *)ext4_fc_tag_val(tl);
-			if (le32_to_cpu(head->fc_features) &
+			if (get_le32(&head->fc_features) &
 				~EXT4_FC_SUPPORTED_FEATURES) {
 				ret = -EOPNOTSUPP;
 				break;
 			}
-			if (le32_to_cpu(head->fc_tid) != expected_tid) {
+			if (get_le32(&head->fc_tid) != expected_tid) {
 				ret = -EINVAL;
 				break;
 			}
@@ -620,8 +637,8 @@ static inline void tl_to_darg(struct dentry_info_args *darg,
 
 	fcd = (struct ext4_fc_dentry_info *)ext4_fc_tag_val(tl);
 
-	darg->parent_ino = le32_to_cpu(fcd->fc_parent_ino);
-	darg->ino = le32_to_cpu(fcd->fc_ino);
+	darg->parent_ino = get_le32(&fcd->fc_parent_ino);
+	darg->ino = get_le32(&fcd->fc_ino);
 	darg->dname = (char *) fcd->fc_dname;
 	darg->dname_len = ext4_fc_tag_len(tl) -
 			sizeof(struct ext4_fc_dentry_info);
@@ -735,7 +752,7 @@ static int ext4_fc_handle_inode(e2fsck_t ctx, struct ext4_fc_tl *tl)
 	blk64_t blks;
 
 	fc_inode_val = (struct ext4_fc_inode *)ext4_fc_tag_val(tl);
-	ino = le32_to_cpu(fc_inode_val->fc_ino);
+	ino = get_le32(&fc_inode_val->fc_ino);
 
 	if (EXT2_INODE_SIZE(ctx->fs->super) > EXT2_GOOD_OLD_INODE_SIZE)
 		inode_len += ext2fs_le16_to_cpu(
@@ -797,7 +814,7 @@ static int ext4_fc_handle_add_extent(e2fsck_t ctx, struct ext4_fc_tl *tl)
 	int ret = 0, ino;
 
 	add_range = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
-	ino = le32_to_cpu(add_range->fc_ino);
+	ino = get_le32(&add_range->fc_ino);
 	ext4_fc_flush_extents(ctx, ino);
 
 	ret = ext4_fc_read_extents(ctx, ino);
@@ -823,12 +840,12 @@ static int ext4_fc_handle_del_range(e2fsck_t ctx, struct ext4_fc_tl *tl)
 	int ret, ino;
 
 	del_range = (struct ext4_fc_del_range *)ext4_fc_tag_val(tl);
-	ino = le32_to_cpu(del_range->fc_ino);
+	ino = get_le32(&del_range->fc_ino);
 	ext4_fc_flush_extents(ctx, ino);
 
 	memset(&extent, 0, sizeof(extent));
-	extent.e_lblk = ext2fs_le32_to_cpu(del_range->fc_lblk);
-	extent.e_len = ext2fs_le32_to_cpu(del_range->fc_len);
+	extent.e_lblk = get_le32(&del_range->fc_lblk);
+	extent.e_len = get_le32(&del_range->fc_len);
 	ret = ext4_fc_read_extents(ctx, ino);
 	if (ret)
 		return ret;
diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index dc0694fc..920c3dab 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -121,6 +121,36 @@ failed:
 #endif /* __KERNEL__ */
 
 
+/*
+ * This function works on unaligned 32-bit pointers, which is needed for
+ * an obsolete jbd2 checksum variant.
+ */
+static inline __u32 get_be32(__be32 *p)
+{
+	unsigned char *cp = (unsigned char *) p;
+	__u32 ret;
+
+	ret = *cp++;
+	ret = (ret << 8) + *cp++;
+	ret = (ret << 8) + *cp++;
+	ret = (ret << 8) + *cp++;
+	return ret;
+}
+
+/*
+ * This function works on unaligned 16-bit pointers, which is needed for
+ * an obsolete jbd2 checksum variant.
+ */
+static inline __u16 get_be16(__be16 *p)
+{
+	unsigned char *cp = (unsigned char *) p;
+	__u16 ret;
+
+	ret = *cp++;
+	ret = (ret << 8) + *cp++;
+	return ret;
+}
+
 /*
  * Read a block from the journal
  */
@@ -210,10 +240,10 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 
 		nr++;
 		tagp += tag_bytes;
-		if (!(tag->t_flags & cpu_to_be16(JBD2_FLAG_SAME_UUID)))
+		if (!(get_be16(&tag->t_flags) & JBD2_FLAG_SAME_UUID))
 			tagp += 16;
 
-		if (tag->t_flags & cpu_to_be16(JBD2_FLAG_LAST_TAG))
+		if (get_be16(&tag->t_flags) & JBD2_FLAG_LAST_TAG)
 			break;
 	}
 
@@ -377,9 +407,9 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 static inline unsigned long long read_tag_block(journal_t *journal,
 						journal_block_tag_t *tag)
 {
-	unsigned long long block = be32_to_cpu(tag->t_blocknr);
+	unsigned long long block = get_be32(&tag->t_blocknr);
 	if (jbd2_has_feature_64bit(journal))
-		block |= (u64)be32_to_cpu(tag->t_blocknr_high) << 32;
+		block |= (u64)get_be32(&tag->t_blocknr_high) << 32;
 	return block;
 }
 
@@ -450,7 +480,7 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
 	if (jbd2_has_feature_csum3(j))
 		return tag3->t_checksum == cpu_to_be32(csum32);
 	else
-		return tag->t_checksum == cpu_to_be16(csum32);
+		return get_be16(&tag->t_checksum) == csum32;
 }
 
 static int do_one_pass(journal_t *journal,
@@ -615,7 +645,7 @@ static int do_one_pass(journal_t *journal,
 				unsigned long io_block;
 
 				tag = (journal_block_tag_t *) tagp;
-				flags = be16_to_cpu(tag->t_flags);
+				flags = get_be16(&tag->t_flags);
 
 				io_block = next_log_block++;
 				wrap(journal, next_log_block);
diff --git a/tests/j_recover_fast_commit/script b/tests/j_recover_fast_commit/script
index 22ef6325..05c40cc5 100755
--- a/tests/j_recover_fast_commit/script
+++ b/tests/j_recover_fast_commit/script
@@ -10,7 +10,6 @@ gunzip < $IMAGE > $TMPFILE
 EXP=$test_dir/expect
 OUT=$test_name.log
 
-cp $TMPFILE /tmp/debugthis
 $FSCK $FSCK_OPT -E journal_only -N test_filesys $TMPFILE 2>/dev/null | head -n 1000 | tail -n +2 > $OUT
 echo "Exit status is $?" >> $OUT
 
-- 
2.31.0

