Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E809F4EB51E
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Mar 2022 23:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiC2VTM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Mar 2022 17:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiC2VTM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Mar 2022 17:19:12 -0400
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278801E377C
        for <linux-ext4@vger.kernel.org>; Tue, 29 Mar 2022 14:17:27 -0700 (PDT)
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
        by cmsmtp with ESMTP
        id ZD2FnWOcR43SgZJDSn5yxy; Tue, 29 Mar 2022 21:17:26 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id ZJDSn3yyqqyysZJDSnsDY5; Tue, 29 Mar 2022 21:17:26 +0000
X-Authority-Analysis: v=2.4 cv=Y6brDzSN c=1 sm=1 tr=0 ts=62437766
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=ySfo2T4IAAAA:8
 a=3KqSEalB3fScOfQquZEA:9 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH] misc: use ext2_ino_t instead of ino_t
Date:   Tue, 29 Mar 2022 15:17:12 -0600
Message-Id: <20220329211712.25506-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfE/Ke/Ch7yUZ+ET8SLw5m/SZWHYLYl4xFPtpPWRp7XkQxLqcuI46i3Yj4tlvqbQ8hsTVH9vZDgU5GXNQ7LSdjMZ+S2S/SAX1ou0rtPmn14t8GEU8ICQs
 H8pvEYSw90ORGC+VNX8yYCRwe+WSjIDOmDwb0L8qnEYphQvCU2QOVRtfAXDy2J78lF8flzM6JQ7ps0h33eHu3YdiaGKjXWLuRmFAvxEXj6uSD2RJIWCZ7zaF
 8UwGvIV7OHyin/n2EWEP5w==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Some of the new fastcommit and casefold changes used the system
"ino_t" instead of "ext2_ino_t" for handling filesystem inodes.
This causes printf warnings if "ino_t" is of a different size.
Use the library "ext2_ino_t" for consistency.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
---
 e2fsck/journal.c       | 16 ++++++++--------
 e2fsck/pass1.c         |  8 ++++----
 e2fsck/rehash.c        |  6 +++---
 lib/ext2fs/badblocks.c |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 2e867234..f77dc1ab 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -578,7 +578,7 @@ static int ext4_del_extent_from_list(e2fsck_t ctx, struct extent_list *list,
 	return ext4_modify_extent_list(ctx, list, ex, 1 /* delete */);
 }
 
-static int ext4_fc_read_extents(e2fsck_t ctx, ino_t ino)
+static int ext4_fc_read_extents(e2fsck_t ctx, ext2_ino_t ino)
 {
 	struct extent_list *extent_list = &ctx->fc_replay_state.fc_extent_list;
 
@@ -597,7 +597,7 @@ static int ext4_fc_read_extents(e2fsck_t ctx, ino_t ino)
  * for the inode so that we can flush all of them at once and it also saves us
  * from continuously growing and shrinking the extent tree.
  */
-static void ext4_fc_flush_extents(e2fsck_t ctx, ino_t ino)
+static void ext4_fc_flush_extents(e2fsck_t ctx, ext2_ino_t ino)
 {
 	struct extent_list *extent_list = &ctx->fc_replay_state.fc_extent_list;
 
@@ -610,10 +610,10 @@ static void ext4_fc_flush_extents(e2fsck_t ctx, ino_t ino)
 
 /* Helper struct for dentry replay routines */
 struct dentry_info_args {
-	ino_t parent_ino;
-	int dname_len;
-	ino_t ino;
-	char *dname;
+	ext2_ino_t	parent_ino;
+	ext2_ino_t	ino;
+	int		dname_len;
+	char		*dname;
 };
 
 static inline int tl_to_darg(struct dentry_info_args *darg,
@@ -635,7 +635,7 @@ static inline int tl_to_darg(struct dentry_info_args *darg,
 	       val + sizeof(struct ext4_fc_dentry_info),
 	       darg->dname_len);
 	darg->dname[darg->dname_len] = 0;
-	jbd_debug(1, "%s: %s, ino %lu, parent %lu\n",
+	jbd_debug(1, "%s: %s, ino %u, parent %u\n",
 		tag == EXT4_FC_TAG_CREAT ? "create" :
 		(tag == EXT4_FC_TAG_LINK ? "link" :
 		(tag == EXT4_FC_TAG_UNLINK ? "unlink" : "error")),
@@ -800,7 +800,7 @@ static int ext4_fc_handle_add_extent(e2fsck_t ctx, __u8 *val)
 {
 	struct ext2fs_extent extent;
 	struct ext4_fc_add_range add_range;
-	ino_t ino;
+	ext2_ino_t ino;
 	int ret = 0;
 
 	memcpy(&add_range, val, sizeof(add_range));
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index dde862a8..2897b0e7 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -79,8 +79,8 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 static void mark_table_blocks(e2fsck_t ctx);
 static void alloc_bb_map(e2fsck_t ctx);
 static void alloc_imagic_map(e2fsck_t ctx);
-static void mark_inode_bad(e2fsck_t ctx, ino_t ino);
-static void add_casefolded_dir(e2fsck_t ctx, ino_t ino);
+static void mark_inode_bad(e2fsck_t ctx, ext2_ino_t ino);
+static void add_casefolded_dir(e2fsck_t ctx, ext2_ino_t ino);
 static void handle_fs_bad_blocks(e2fsck_t ctx);
 static void process_inodes(e2fsck_t ctx, char *block_buf);
 static EXT2_QSORT_TYPE process_inode_cmp(const void *a, const void *b);
@@ -2202,7 +2202,7 @@ static EXT2_QSORT_TYPE process_inode_cmp(const void *a, const void *b)
 /*
  * Mark an inode as being bad in some what
  */
-static void mark_inode_bad(e2fsck_t ctx, ino_t ino)
+static void mark_inode_bad(e2fsck_t ctx, ext2_ino_t ino)
 {
 	struct		problem_context pctx;
 
@@ -2223,7 +2223,7 @@ static void mark_inode_bad(e2fsck_t ctx, ino_t ino)
 	ext2fs_mark_inode_bitmap2(ctx->inode_bad_map, ino);
 }
 
-static void add_casefolded_dir(e2fsck_t ctx, ino_t ino)
+static void add_casefolded_dir(e2fsck_t ctx, ext2_ino_t ino)
 {
 	struct		problem_context pctx;
 
diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
index 8cc36f24..f9af0329 100644
--- a/e2fsck/rehash.c
+++ b/e2fsck/rehash.c
@@ -89,9 +89,9 @@ struct fill_dir_struct {
 };
 
 struct hash_entry {
-	ext2_dirhash_t	hash;
-	ext2_dirhash_t	minor_hash;
-	ino_t		ino;
+	ext2_dirhash_t		hash;
+	ext2_dirhash_t		minor_hash;
+	ext2_ino_t		ino;
 	struct ext2_dir_entry	*dir;
 };
 
diff --git a/lib/ext2fs/badblocks.c b/lib/ext2fs/badblocks.c
index 0f23983b..a306bc06 100644
--- a/lib/ext2fs/badblocks.c
+++ b/lib/ext2fs/badblocks.c
@@ -103,7 +103,7 @@ errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
 
 
 /*
- * This procedure adds a block to a badblocks list.
+ * This procedure adds an item to a tracking list (e.g. badblocks or casefold).
  */
 errcode_t ext2fs_u32_list_add(ext2_u32_list bb, __u32 blk)
 {
-- 
2.25.1

