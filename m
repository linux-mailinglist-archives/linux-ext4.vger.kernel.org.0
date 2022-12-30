Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426416597EF
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Dec 2022 13:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiL3MBn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Dec 2022 07:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiL3MBn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Dec 2022 07:01:43 -0500
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1C363B2
        for <linux-ext4@vger.kernel.org>; Fri, 30 Dec 2022 04:01:41 -0800 (PST)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Nk3l90GHczDqjj
        for <linux-ext4@vger.kernel.org>; Fri, 30 Dec 2022 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1672401701; bh=xtliPJCMHqPAIlUbIZukwuMewwyGsZujBaxuqNL2ns0=;
        h=Date:From:To:Subject:From;
        b=UCPFxss3gfTodAM24J3IW2z/mq9pWQK7bld+JVxHw0NHMUf3spaCNOnvIA28S7UXX
         pL8+vxfQb++lXKHqgzfeGiIlodOF3G/kKs945ZoppjruWcmjx0VKZo4cGykQBf0InD
         7QD6BaYzOxpkhii/xFtktuNdkKomSeloB8cCtE2o=
X-Riseup-User-ID: 4F5EA29687A6C8330919EF899CD5B4F12EC5DB211821D765C9358AC3F83976F9
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4Nk3l76LJ6z1yRB
        for <linux-ext4@vger.kernel.org>; Fri, 30 Dec 2022 12:01:39 +0000 (UTC)
Date:   Fri, 30 Dec 2022 12:01:34 +0000
From:   Samanta Navarro <ferivoz@riseup.net>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] Fix typos
Message-ID: <20221230120134.3t6sk7gocdpl33uj@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Typos found with codespell.

Signed-off-by: Samanta Navarro <ferivoz@riseup.net>
---
 debugfs/debugfs.c             |  2 +-
 doc/libext2fs.texinfo         |  4 ++--
 doc/texinfo.tex               | 12 ++++++------
 e2fsck/dirinfo.c              |  2 +-
 e2fsck/dx_dirinfo.c           |  2 +-
 e2fsck/e2fsck.h               |  2 +-
 e2fsck/journal.c              |  2 +-
 e2fsck/pass1.c                |  2 +-
 e2fsck/pass2.c                |  2 +-
 ext2ed/doc/ext2ed-design.sgml |  2 +-
 lib/et/texinfo.tex            | 12 ++++++------
 lib/ext2fs/ext2fs.h           |  4 ++--
 lib/ext2fs/ext2fsP.h          |  2 +-
 lib/ext2fs/irel.h             |  2 +-
 lib/ext2fs/kernel-jbd.h       |  2 +-
 lib/ext2fs/nls_utf8.c         |  2 +-
 lib/ext2fs/sha256.c           |  2 +-
 lib/ext2fs/sha512.c           |  2 +-
 lib/support/profile.c         |  2 +-
 lib/support/quotaio_v2.c      |  2 +-
 misc/base_device.c            |  2 +-
 misc/mke2fs.c                 |  2 +-
 scrub/e2scrub.8.in            |  2 +-
 scrub/e2scrub.in              |  2 +-
 scrub/e2scrub_all.8.in        |  2 +-
 tests/README                  |  2 +-
 util/mkutf8data.c             |  2 +-
 27 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 78b93ed..9b6321d 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -50,7 +50,7 @@ int journal_enable_debug = -1;
 
 /*
  * There must be only one definition if we're hooking in extra commands or
- * chaging default prompt. Use -DSKIP_GLOBDEF for that.
+ * changing default prompt. Use -DSKIP_GLOBDEF for that.
  */
 #ifndef SKIP_GLOBDEFS
 ss_request_table *extra_cmds;
diff --git a/doc/libext2fs.texinfo b/doc/libext2fs.texinfo
index 3043398..970fca7 100644
--- a/doc/libext2fs.texinfo
+++ b/doc/libext2fs.texinfo
@@ -625,7 +625,7 @@ The @var{flags} parameter controls how the iterator will function:
 @table @samp
 
 @item BLOCK_FLAG_HOLE
-This flag indicates that the interator function should be called on
+This flag indicates that the iterator function should be called on
 blocks where the block number is zero (also known as ``holes''.)  It is
 also known as BLOCK_FLAG_APPEND, since it is also used by functions
 such as ext2fs_expand_dir() to add a new block to an inode.
@@ -1150,7 +1150,7 @@ utility programs.
 @subsection Directory-block list management
 
 The dblist abstraction stores a list of blocks belonging to
-directories.  This list can be useful when a program needs to interate
+directories.  This list can be useful when a program needs to iterate
 over all directory entries in a filesystem; @code{e2fsck} does this in
 pass 2 of its operations, and @code{debugfs} needs to do this when it is
 trying to turn an inode number into a pathname.
diff --git a/doc/texinfo.tex b/doc/texinfo.tex
index dddd014..dd52615 100644
--- a/doc/texinfo.tex
+++ b/doc/texinfo.tex
@@ -404,7 +404,7 @@
 \def\argremovecomment#1\comment#2\ArgTerm{\argremovec #1\c\ArgTerm}
 \def\argremovec#1\c#2\ArgTerm{\argcheckspaces#1\^^M\ArgTerm}
 
-% Each occurence of `\^^M' or `<space>\^^M' is replaced by a single space.
+% Each occurrence of `\^^M' or `<space>\^^M' is replaced by a single space.
 %
 % \argremovec might leave us with trailing space, e.g.,
 %    @end itemize  @c foo
@@ -430,7 +430,7 @@
 % to get _exactly_ the rest of the line, we had to prevent such situation.
 % We prepended an \empty token at the very beginning and we expand it now,
 % just before passing the control to \next.
-% (Similarily, we have to think about #3 of \argcheckspacesY above: it is
+% (Similarly, we have to think about #3 of \argcheckspacesY above: it is
 % either the null string, or it ends with \^^M---thus there is no danger
 % that a pair of braces would be stripped.
 %
@@ -487,7 +487,7 @@
 % used to check whether the current environment is the one expected.
 %
 % Non-false conditionals (@iftex, @ifset) don't fit into this, so they
-% are not treated as enviroments; they don't open a group.  (The
+% are not treated as environments; they don't open a group.  (The
 % implementation of @end takes care not to call \endgroup in this
 % special case.)
 
@@ -510,7 +510,7 @@
   \fi
 }
 
-% Evironment mismatch, #1 expected:
+% Environment mismatch, #1 expected:
 \def\badenverr{%
   \errhelp = \EMsimple
   \errmessage{This command can appear only \inenvironment\temp,
@@ -4045,7 +4045,7 @@ where each line of input produces a line of output.}
 \chardef\maxseclevel = 3
 %
 % A numbered section within an unnumbered changes to unnumbered too.
-% To achive this, remember the "biggest" unnum. sec. we are currently in:
+% To achieve this, remember the "biggest" unnum. sec. we are currently in:
 \chardef\unmlevel = \maxseclevel
 %
 % Trace whether the current chapter is an appendix or not:
@@ -6417,7 +6417,7 @@ where each line of input produces a line of output.}
 % In case a @footnote appears in a vbox, save the footnote text and create
 % the real \insert just after the vbox finished.  Otherwise, the insertion
 % would be lost.
-% Similarily, if a @footnote appears inside an alignment, save the footnote
+% Similarly, if a @footnote appears inside an alignment, save the footnote
 % text to a box and make the \insert when a row of the table is finished.
 % And the same can be done for other insert classes.  --kasal, 16nov03.
 
diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
index 49d624c..9873e38 100644
--- a/e2fsck/dirinfo.c
+++ b/e2fsck/dirinfo.c
@@ -376,7 +376,7 @@ void e2fsck_dir_info_iter_end(e2fsck_t ctx EXT2FS_ATTR((unused)),
 }
 
 /*
- * A simple interator function
+ * A simple iterator function
  */
 struct dir_info *e2fsck_dir_info_iter(e2fsck_t ctx, struct dir_info_iter *iter)
 {
diff --git a/e2fsck/dx_dirinfo.c b/e2fsck/dx_dirinfo.c
index caca3e3..4b764b0 100644
--- a/e2fsck/dx_dirinfo.c
+++ b/e2fsck/dx_dirinfo.c
@@ -143,7 +143,7 @@ ext2_ino_t e2fsck_get_num_dx_dirinfo(e2fsck_t ctx)
 }
 
 /*
- * A simple interator function
+ * A simple iterator function
  */
 struct dx_dir_info *e2fsck_dx_dir_info_iter(e2fsck_t ctx, ext2_ino_t *control)
 {
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 252a17d..3f2dc30 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -236,7 +236,7 @@ typedef struct e2fsck_struct *e2fsck_t;
 #define MAX_EXTENT_DEPTH_COUNT 8
 
 /*
- * This strucutre is used to manage the list of extents in a file. Placing
+ * This structure is used to manage the list of extents in a file. Placing
  * it here since this is used by fast_commit.h.
  */
 struct extent_list {
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index d802c5e..ab22072 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -888,7 +888,7 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 		/*
 		 * Mark the file system to indicate it contains errors. That's
 		 * because the updates performed by fast commit replay code are
-		 * not atomic and may result in incosistent file system if it
+		 * not atomic and may result in inconsistent file system if it
 		 * crashes before the replay is complete.
 		 */
 		ctx->fs->super->s_state |= EXT2_ERROR_FS;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 73909c3..591acad 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1331,7 +1331,7 @@ void e2fsck_pass1(e2fsck_t ctx)
 		goto endit;
 	}
 	block_buf = (char *) e2fsck_allocate_memory(ctx, fs->blocksize * 3,
-						    "block interate buffer");
+						    "block iterate buffer");
 	if (EXT2_INODE_SIZE(fs->super) == EXT2_GOOD_OLD_INODE_SIZE)
 		e2fsck_use_inode_shortcuts(ctx, 1);
 	e2fsck_intercept_block_allocations(ctx);
diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index bc6ffa1..410edd1 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -1812,7 +1812,7 @@ struct del_block {
 };
 
 /*
- * This function is called to deallocate a block, and is an interator
+ * This function is called to deallocate a block, and is an iterator
  * functioned called by deallocate inode via ext2fs_iterate_block().
  */
 static int deallocate_inode_block(ext2_filsys fs,
diff --git a/ext2ed/doc/ext2ed-design.sgml b/ext2ed/doc/ext2ed-design.sgml
index e8052a9..b2cab37 100644
--- a/ext2ed/doc/ext2ed-design.sgml
+++ b/ext2ed/doc/ext2ed-design.sgml
@@ -1446,7 +1446,7 @@ specific commands, by using <Literal remap="tt">free&lowbar;struct&lowbar;descri
 <ListItem>
 
 <Para>
-	Closes the window subsystem, and deattaches EXT2ED from the ncurses
+	Closes the window subsystem, and detaches EXT2ED from the ncurses
 library, through the use of the <Literal remap="tt">close&lowbar;windows</Literal> function,
 available in <Literal remap="tt">win.c</Literal>.
 </Para>
diff --git a/lib/et/texinfo.tex b/lib/et/texinfo.tex
index dddd014..dd52615 100644
--- a/lib/et/texinfo.tex
+++ b/lib/et/texinfo.tex
@@ -404,7 +404,7 @@
 \def\argremovecomment#1\comment#2\ArgTerm{\argremovec #1\c\ArgTerm}
 \def\argremovec#1\c#2\ArgTerm{\argcheckspaces#1\^^M\ArgTerm}
 
-% Each occurence of `\^^M' or `<space>\^^M' is replaced by a single space.
+% Each occurrence of `\^^M' or `<space>\^^M' is replaced by a single space.
 %
 % \argremovec might leave us with trailing space, e.g.,
 %    @end itemize  @c foo
@@ -430,7 +430,7 @@
 % to get _exactly_ the rest of the line, we had to prevent such situation.
 % We prepended an \empty token at the very beginning and we expand it now,
 % just before passing the control to \next.
-% (Similarily, we have to think about #3 of \argcheckspacesY above: it is
+% (Similarly, we have to think about #3 of \argcheckspacesY above: it is
 % either the null string, or it ends with \^^M---thus there is no danger
 % that a pair of braces would be stripped.
 %
@@ -487,7 +487,7 @@
 % used to check whether the current environment is the one expected.
 %
 % Non-false conditionals (@iftex, @ifset) don't fit into this, so they
-% are not treated as enviroments; they don't open a group.  (The
+% are not treated as environments; they don't open a group.  (The
 % implementation of @end takes care not to call \endgroup in this
 % special case.)
 
@@ -510,7 +510,7 @@
   \fi
 }
 
-% Evironment mismatch, #1 expected:
+% Environment mismatch, #1 expected:
 \def\badenverr{%
   \errhelp = \EMsimple
   \errmessage{This command can appear only \inenvironment\temp,
@@ -4045,7 +4045,7 @@ where each line of input produces a line of output.}
 \chardef\maxseclevel = 3
 %
 % A numbered section within an unnumbered changes to unnumbered too.
-% To achive this, remember the "biggest" unnum. sec. we are currently in:
+% To achieve this, remember the "biggest" unnum. sec. we are currently in:
 \chardef\unmlevel = \maxseclevel
 %
 % Trace whether the current chapter is an appendix or not:
@@ -6417,7 +6417,7 @@ where each line of input produces a line of output.}
 % In case a @footnote appears in a vbox, save the footnote text and create
 % the real \insert just after the vbox finished.  Otherwise, the insertion
 % would be lost.
-% Similarily, if a @footnote appears inside an alignment, save the footnote
+% Similarly, if a @footnote appears inside an alignment, save the footnote
 % text to a box and make the \insert when a row of the table is finished.
 % And the same can be done for other insert classes.  --kasal, 16nov03.
 
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 9cc994b..8020687 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -355,9 +355,9 @@ struct struct_ext2_filsys {
 #define BLOCK_INLINE_DATA_CHANGED	8
 
 /*
- * Block interate flags
+ * Block iterate flags
  *
- * BLOCK_FLAG_APPEND, or BLOCK_FLAG_HOLE, indicates that the interator
+ * BLOCK_FLAG_APPEND, or BLOCK_FLAG_HOLE, indicates that the iterator
  * function should be called on blocks where the block number is zero.
  * This is used by ext2fs_expand_dir() to be able to add a new block
  * to an inode.  It can also be used for programs that want to be able
diff --git a/lib/ext2fs/ext2fsP.h b/lib/ext2fs/ext2fsP.h
index a20a050..0687384 100644
--- a/lib/ext2fs/ext2fsP.h
+++ b/lib/ext2fs/ext2fsP.h
@@ -93,7 +93,7 @@ struct ext2_inode_cache_ent {
 };
 
 /*
- * NLS defintions
+ * NLS definitions
  */
 struct ext2fs_nls_table {
 	int version;
diff --git a/lib/ext2fs/irel.h b/lib/ext2fs/irel.h
index 8aaa2d2..23741ba 100644
--- a/lib/ext2fs/irel.h
+++ b/lib/ext2fs/irel.h
@@ -73,7 +73,7 @@ struct ext2_inode_relocation_table {
 
 	/*
 	 * The iterator function for the inode references for an
-	 * inode.  The references for only one inode can be interator
+	 * inode.  The references for only one inode can be iterator
 	 * over at a time, as the iterator state is stored in ext2_irel.
 	 */
 	errcode_t (*next_ref)(ext2_irel irel,
diff --git a/lib/ext2fs/kernel-jbd.h b/lib/ext2fs/kernel-jbd.h
index 2811957..e569500 100644
--- a/lib/ext2fs/kernel-jbd.h
+++ b/lib/ext2fs/kernel-jbd.h
@@ -444,7 +444,7 @@ extern int journal_blocks_per_page(struct inode *inode);
 #define BJ_SyncData	1	/* Normal data: flush before commit */
 #define BJ_AsyncData	2	/* writepage data: wait on it before commit */
 #define BJ_Metadata	3	/* Normal journaled metadata */
-#define BJ_Forget	4	/* Buffer superceded by this transaction */
+#define BJ_Forget	4	/* Buffer superseded by this transaction */
 #define BJ_IO		5	/* Buffer is for temporary IO use */
 #define BJ_Shadow	6	/* Buffer contents being shadowed to the log */
 #define BJ_LogCtl	7	/* Buffer contains log descriptors */
diff --git a/lib/ext2fs/nls_utf8.c b/lib/ext2fs/nls_utf8.c
index 43bab9a..b07e66e 100644
--- a/lib/ext2fs/nls_utf8.c
+++ b/lib/ext2fs/nls_utf8.c
@@ -709,7 +709,7 @@ static int utf8cursor(struct utf8cursor *u8c, const struct utf8data *data,
 /*
  * Get one byte from the normalized form of the string described by u8c.
  *
- * Returns the byte cast to an unsigned char on succes, and -1 on failure.
+ * Returns the byte cast to an unsigned char on success, and -1 on failure.
  *
  * The cursor keeps track of the location in the string in u8c->s.
  * When a character is decomposed, the current location is stored in
diff --git a/lib/ext2fs/sha256.c b/lib/ext2fs/sha256.c
index f67848d..b1506e2 100644
--- a/lib/ext2fs/sha256.c
+++ b/lib/ext2fs/sha256.c
@@ -180,7 +180,7 @@ static void sha256_done(struct hash_state * md, unsigned char *out)
         md->sha256.curlen = 0;
     }
 
-    /* pad upto 56 bytes of zeroes */
+    /* pad up to 56 bytes of zeroes */
     while (md->sha256.curlen < 56) {
         md->sha256.buf[md->sha256.curlen++] = (unsigned char)0;
     }
diff --git a/lib/ext2fs/sha512.c b/lib/ext2fs/sha512.c
index fe2dd52..f246afb 100644
--- a/lib/ext2fs/sha512.c
+++ b/lib/ext2fs/sha512.c
@@ -185,7 +185,7 @@ static void sha512_done(struct hash_state * md, unsigned char *out)
 		md->sha512.curlen = 0;
 	}
 
-	/* pad upto 120 bytes of zeroes note: that from 112 to 120 is the 64 MSB
+	/* pad up to 120 bytes of zeroes note: that from 112 to 120 is the 64 MSB
 	 * of the length. We assume that you won't hash > 2^64 bits of data. */
 	while (md->sha512.curlen < 120) {
 		md->sha512.buf[md->sha512.curlen++] = (unsigned char)0;
diff --git a/lib/support/profile.c b/lib/support/profile.c
index f54739e..bdb14b1 100644
--- a/lib/support/profile.c
+++ b/lib/support/profile.c
@@ -1191,7 +1191,7 @@ errcode_t profile_add_node(struct profile_node *section, const char *name,
 
 /*
  * Iterate through the section, returning the nodes which match
- * the given name.  If name is NULL, then interate through all the
+ * the given name.  If name is NULL, then iterate through all the
  * nodes in the section.  If section_flag is non-zero, only return the
  * section which matches the name; don't return relations.  If value
  * is non-NULL, then only return relations which match the requested
diff --git a/lib/support/quotaio_v2.c b/lib/support/quotaio_v2.c
index a49aa6a..d09294b 100644
--- a/lib/support/quotaio_v2.c
+++ b/lib/support/quotaio_v2.c
@@ -223,7 +223,7 @@ static int v2_check_file(struct quota_handle *h, int type, int fmt)
 
 	be_magic = ext2fs_be32_to_cpu((__force __be32)dqh.dqh_magic);
 	if (be_magic == file_magics[type]) {
-		log_err("Your quota file is stored in wrong endianity");
+		log_err("Your quota file is stored in wrong endianness");
 		return 0;
 	}
 	if (V2_VERSION_R0 != ext2fs_le32_to_cpu(dqh.dqh_version) &&
diff --git a/misc/base_device.c b/misc/base_device.c
index d1c1cd9..814a479 100644
--- a/misc/base_device.c
+++ b/misc/base_device.c
@@ -33,7 +33,7 @@
 
 /*
  * Required for the uber-silly devfs /dev/ide/host1/bus2/target3/lun3
- * pathames.
+ * pathnames.
  */
 static const char *devfs_hier[] = {
 	"host", "bus", "target", "lun", 0
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index bde1e58..6c13bd6 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -1506,7 +1506,7 @@ extern const char *mke2fs_default_profile;
 static const char *default_files[] = { "<default>", 0 };
 
 struct device_param {
-	unsigned long min_io;		/* prefered minimum IO size */
+	unsigned long min_io;		/* preferred minimum IO size */
 	unsigned long opt_io;		/* optimal IO size */
 	unsigned long alignment_offset;	/* alignment offset wrt physical block size */
 	unsigned int dax:1;		/* supports dax? */
diff --git a/scrub/e2scrub.8.in b/scrub/e2scrub.8.in
index cfc2331..3d27751 100644
--- a/scrub/e2scrub.8.in
+++ b/scrub/e2scrub.8.in
@@ -1,7 +1,7 @@
 .TH E2SCRUB 8 "@E2FSPROGS_MONTH@ @E2FSPROGS_YEAR@" "E2fsprogs version @E2FSPROGS_VERSION@"
 .SH NAME
 e2scrub - check the contents of a mounted ext[234] file system
-.SH SYNOPSYS
+.SH SYNOPSIS
 .B
 e2scrub [OPTION] MOUNTPOINT | DEVICE
 .SH DESCRIPTION
diff --git a/scrub/e2scrub.in b/scrub/e2scrub.in
index 30ab7cb..7ed57f2 100644
--- a/scrub/e2scrub.in
+++ b/scrub/e2scrub.in
@@ -164,7 +164,7 @@ lvm_vars="$(lvs --nameprefixes -o name,vgname,lv_role --noheadings "${dev}" 2> /
 eval "${lvm_vars}"
 if [ -z "${LVM2_VG_NAME}" ] || [ -z "${LVM2_LV_NAME}" ] ||
    echo "${LVM2_LV_ROLE}" | grep -q "snapshot"; then
-	echo "${arg}: Not connnected to an LVM logical volume."
+	echo "${arg}: Not connected to an LVM logical volume."
 	print_help
 	exitcode 16
 fi
diff --git a/scrub/e2scrub_all.8.in b/scrub/e2scrub_all.8.in
index c33c18f..99bdc0d 100644
--- a/scrub/e2scrub_all.8.in
+++ b/scrub/e2scrub_all.8.in
@@ -1,7 +1,7 @@
 .TH E2SCRUB 8 "@E2FSPROGS_MONTH@ @E2FSPROGS_YEAR@" "E2fsprogs version @E2FSPROGS_VERSION@"
 .SH NAME
 e2scrub_all - check all mounted ext[234] file systems for errors.
-.SH SYNOPSYS
+.SH SYNOPSIS
 .B
 e2scrub_all [OPTION]
 .SH DESCRIPTION
diff --git a/tests/README b/tests/README
index d075db5..d9d2437 100644
--- a/tests/README
+++ b/tests/README
@@ -31,7 +31,7 @@ filesystems against the original e2fsck, you will have to inspect the
 test_script.log file manually.
 
 --------------------------------------------------------------
-Here's a one-line descriptons of the various test images in this
+Here's a one-line descriptions of the various test images in this
 directory:
 
 baddir.img		Filesystem with a corrupted directory
diff --git a/util/mkutf8data.c b/util/mkutf8data.c
index 49bb0e1..2af25ac 100644
--- a/util/mkutf8data.c
+++ b/util/mkutf8data.c
@@ -3003,7 +3003,7 @@ int utf8cursor(struct utf8cursor *u8c, struct tree *tree, const char *s)
 /*
  * Get one byte from the normalized form of the string described by u8c.
  *
- * Returns the byte cast to an unsigned char on succes, and -1 on failure.
+ * Returns the byte cast to an unsigned char on success, and -1 on failure.
  *
  * The cursor keeps track of the location in the string in u8c->s.
  * When a character is decomposed, the current location is stored in
-- 
2.39.0

