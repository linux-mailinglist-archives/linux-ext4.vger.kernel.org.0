Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16958884D
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 09:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiHCHy1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 03:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiHCHyZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 03:54:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E632BAF
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 00:54:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r17so289265lfm.11
        for <linux-ext4@vger.kernel.org>; Wed, 03 Aug 2022 00:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=enMkeMGVDo8ofAoWXxCojR1B2J/Euc69cmaqDsIxCAA=;
        b=boagoZD27EPz9yG2teTvCVCQ7Gb0bo4Dz7bpLWmNXXpr/x+tdKfnzIPdNgAo3Irfu4
         35oJ7Mbybuamtz86p/LcVeVVhSNyQYn6vE0wZJXyMfwi+Bubgdv7amjOQ/2fqfTMbKA5
         UTy7Cl06s4fahI6kX4HcxEsyF4I4oya/ldBnyVPyfMITVhC1ZbzVUoP/5Xg54MwxX3lV
         6N5HLf5hl5e9Enhn3Crg2GSlChhjZlf+Y0frwXYZ4cfEOfsuBLEBqsCWCNiaQlOzVaPG
         5wOgO1e+dezcJmpybXSY83xHGEkQ0QRqlOo3lWiieiA08Drt6mFOz3TyxqaUJovUG0An
         ndLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=enMkeMGVDo8ofAoWXxCojR1B2J/Euc69cmaqDsIxCAA=;
        b=acA4YoxtGtgZC6f5xMhJDk331bvNOvDD/aaJOog1+Zx1EF7fACA+6I1ur3tYiLnsnB
         2gdWsSUEyZBAEJkCUFeQ26rDi9epBJUwOXBJctdwRbCx3e1JsK5F1AKeSQqubhxUFCaW
         GsHJascLAjZ7zAgv9mcRPeVI2P+ccdK9yn/h7vA2Eqy6BTIEyMxdJSXY6rk/pnCdTaCb
         XmrmRNlzDcB6+QxAEivVW0y4P1ECLvT4yKth4eQlUHdX+z05YwntDjlg+Y5+GexS9DdU
         h/Cl6fxqyAF3uGx9QKsdh2rIlD4ttLCQ/RxtKbysyWYt+L8Hdjq2ZRR2svUZss9A+ag5
         fJKA==
X-Gm-Message-State: ACgBeo19tAUSQqc6Fh4xtHM61VDL9U+yKUmKoo5TApngOZ5fRvO56vEQ
        WEhqLkSVrURuGHeCV87IvwF6sZ/VctdUHsrQJqg=
X-Google-Smtp-Source: AA6agR7YbDAPyjiBwcV3kK8EV6Q6FlCUMd8UImfL2ZZYYkame+yYGeTFGZ1AlA4eZ8HzSuPNnKKVaw==
X-Received: by 2002:a05:6512:4026:b0:48b:e4d:6657 with SMTP id br38-20020a056512402600b0048b0e4d6657mr2033538lfb.449.1659513259304;
        Wed, 03 Aug 2022 00:54:19 -0700 (PDT)
Received: from lustre.shadowland ([46.246.86.69])
        by smtp.gmail.com with ESMTPSA id d11-20020a056512368b00b0048b12ff12e8sm397997lfs.99.2022.08.03.00.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 00:54:18 -0700 (PDT)
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Subject: [PATCH] e2fsprogs: avoid code duplication
Date:   Wed,  3 Aug 2022 10:54:07 +0300
Message-Id: <20220803075407.538398-1-alexey.lyashkov@gmail.com>
X-Mailer: git-send-email 2.31.1
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

debugfs and e2fsck have a so much code duplication in journal handing.
debugfs have lack a many journal features handing also.
Let's start code merging to avoid code duplication and lack features.

userspace buffer head emulation moved into library.

Signed-off-by: Alexey Lyashkov <alexey.lyashkov@gmail.com>
---
 debugfs/Makefile.in               |  14 +-
 debugfs/debugfs.c                 |   2 +-
 debugfs/journal.c                 | 251 ---------------------------
 debugfs/journal.h                 |   2 +-
 debugfs/logdump.c                 |   2 +-
 e2fsck/Makefile.in                |   8 +-
 e2fsck/e2fsck.c                   |   5 -
 e2fsck/e2fsck.h                   |   1 -
 e2fsck/journal.c                  | 278 ++----------------------------
 e2fsck/logfile.c                  |   2 +-
 e2fsck/recovery.c                 |   2 +-
 e2fsck/revoke.c                   |   2 +-
 e2fsck/unix.c                     |   4 +-
 e2fsck/util.c                     |   2 +-
 lib/ext2fs/Android.bp             |   1 +
 lib/ext2fs/Makefile.in            |  23 +--
 lib/ext2fs/jfs_user.c             | 255 +++++++++++++++++++++++++++
 {e2fsck => lib/ext2fs}/jfs_user.h |  55 +++---
 misc/Makefile.in                  |  10 +-
 19 files changed, 341 insertions(+), 578 deletions(-)
 create mode 100644 lib/ext2fs/jfs_user.c
 rename {e2fsck => lib/ext2fs}/jfs_user.h (89%)

diff --git a/debugfs/Makefile.in b/debugfs/Makefile.in
index ed4ea8d8..cc846cb1 100644
--- a/debugfs/Makefile.in
+++ b/debugfs/Makefile.in
@@ -49,7 +49,7 @@ STATIC_DEPLIBS= $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBSS) \
 
 # This nastiness is needed because of jfs_user.h hackery; when we finally
 # clean up this mess, we should be able to drop it
-LOCAL_CFLAGS = -I$(srcdir)/../e2fsck -DDEBUGFS
+LOCAL_CFLAGS = -DDEBUGFS
 DEPEND_CFLAGS = -I$(srcdir)
 
 .c.o:
@@ -186,7 +186,7 @@ debugfs.o: $(srcdir)/debugfs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/quotaio.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/version.h \
- $(srcdir)/../e2fsck/jfs_user.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
+ $(top_srcdir)/lib/ext2fs/jfs_user.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
  $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h $(top_srcdir)/lib/support/plausible.h
 util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
@@ -277,7 +277,7 @@ logdump.o: $(srcdir)/logdump.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(srcdir)/../misc/create_inode.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/quotaio.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
- $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/../e2fsck/jfs_user.h \
+ $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/lib/ext2fs/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h
@@ -382,7 +382,7 @@ quota.o: $(srcdir)/quota.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio_tree.h
 journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/journal.h \
- $(srcdir)/../e2fsck/jfs_user.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
+ $(top_srcdir)/lib/ext2fs/jfs_user.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
  $(top_srcdir)/lib/ext2fs/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
@@ -390,7 +390,7 @@ journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
  $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h
-revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
+revoke.o: $(srcdir)/../e2fsck/revoke.c $(top_srcdir)/lib/ext2fs/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
@@ -399,7 +399,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
  $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h
-recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
+recovery.o: $(srcdir)/../e2fsck/recovery.c $(top_srcdir)/lib/ext2fs/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
@@ -421,4 +421,4 @@ do_journal.o: $(srcdir)/do_journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
- $(srcdir)/journal.h $(srcdir)/../e2fsck/jfs_user.h
+ $(srcdir)/journal.h $(top_srcdir)/lib/ext2fs/jfs_user.h
diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index b67a88bc..28f1ddf0 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -37,7 +37,7 @@ extern char *optarg;
 #include <ext2fs/ext2_ext_attr.h>
 
 #include "../version.h"
-#include "jfs_user.h"
+#include "ext2fs/jfs_user.h"
 #include "support/plausible.h"
 
 #ifndef BUFSIZ
diff --git a/debugfs/journal.c b/debugfs/journal.c
index 095fff00..ee25419a 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -26,8 +26,6 @@
 #include "uuid/uuid.h"
 #include "journal.h"
 
-static int bh_count = 0;
-
 #if EXT2_FLAT_INCLUDES
 #include "blkid.h"
 #else
@@ -43,221 +41,6 @@ static int bh_count = 0;
  */
 #undef USE_INODE_IO
 
-/* Checksumming functions */
-static int ext2fs_journal_verify_csum_type(journal_t *j,
-					   journal_superblock_t *jsb)
-{
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 1;
-
-	return jsb->s_checksum_type == JBD2_CRC32C_CHKSUM;
-}
-
-static __u32 ext2fs_journal_sb_csum(journal_superblock_t *jsb)
-{
-	__u32 crc, old_crc;
-
-	old_crc = jsb->s_checksum;
-	jsb->s_checksum = 0;
-	crc = ext2fs_crc32c_le(~0, (unsigned char *)jsb,
-			       sizeof(journal_superblock_t));
-	jsb->s_checksum = old_crc;
-
-	return crc;
-}
-
-static int ext2fs_journal_sb_csum_verify(journal_t *j,
-					 journal_superblock_t *jsb)
-{
-	__u32 provided, calculated;
-
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 1;
-
-	provided = ext2fs_be32_to_cpu(jsb->s_checksum);
-	calculated = ext2fs_journal_sb_csum(jsb);
-
-	return provided == calculated;
-}
-
-static errcode_t ext2fs_journal_sb_csum_set(journal_t *j,
-					    journal_superblock_t *jsb)
-{
-	__u32 crc;
-
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 0;
-
-	crc = ext2fs_journal_sb_csum(jsb);
-	jsb->s_checksum = ext2fs_cpu_to_be32(crc);
-	return 0;
-}
-
-/* Kernel compatibility functions for handling the journal.  These allow us
- * to use the recovery.c file virtually unchanged from the kernel, so we
- * don't have to do much to keep kernel and user recovery in sync.
- */
-int jbd2_journal_bmap(journal_t *journal, unsigned long block,
-		      unsigned long long *phys)
-{
-#ifdef USE_INODE_IO
-	*phys = block;
-	return 0;
-#else
-	struct inode	*inode = journal->j_inode;
-	errcode_t	retval;
-	blk64_t		pblk;
-
-	if (!inode) {
-		*phys = block;
-		return 0;
-	}
-
-	retval = ext2fs_bmap2(inode->i_fs, inode->i_ino,
-			      &inode->i_ext2, NULL, 0, (blk64_t) block,
-			      0, &pblk);
-	*phys = pblk;
-	return (int) retval;
-#endif
-}
-
-struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
-			   int blocksize)
-{
-	struct buffer_head *bh;
-	int bufsize = sizeof(*bh) + kdev->k_fs->blocksize -
-		sizeof(bh->b_data);
-	errcode_t retval;
-
-	retval = ext2fs_get_memzero(bufsize, &bh);
-	if (retval)
-		return NULL;
-
-	if (journal_enable_debug >= 3)
-		bh_count++;
-	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
-		  blocknr, blocksize, bh_count);
-
-	bh->b_fs = kdev->k_fs;
-	if (kdev->k_dev == K_DEV_FS)
-		bh->b_io = kdev->k_fs->io;
-	else
-		bh->b_io = kdev->k_fs->journal_io;
-	bh->b_size = blocksize;
-	bh->b_blocknr = blocknr;
-
-	return bh;
-}
-
-int sync_blockdev(kdev_t kdev)
-{
-	io_channel	io;
-
-	if (kdev->k_dev == K_DEV_FS)
-		io = kdev->k_fs->io;
-	else
-		io = kdev->k_fs->journal_io;
-
-	return io_channel_flush(io) ? EIO : 0;
-}
-
-void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
-		 struct buffer_head *bhp[])
-{
-	errcode_t retval;
-	struct buffer_head *bh;
-
-	for (; nr > 0; --nr) {
-		bh = *bhp++;
-		if (rw == REQ_OP_READ && !bh->b_uptodate) {
-			jfs_debug(3, "reading block %llu/%p\n",
-				  bh->b_blocknr, (void *) bh);
-			retval = io_channel_read_blk64(bh->b_io,
-						     bh->b_blocknr,
-						     1, bh->b_data);
-			if (retval) {
-				com_err(bh->b_fs->device_name, retval,
-					"while reading block %llu\n",
-					bh->b_blocknr);
-				bh->b_err = (int) retval;
-				continue;
-			}
-			bh->b_uptodate = 1;
-		} else if (rw == REQ_OP_WRITE && bh->b_dirty) {
-			jfs_debug(3, "writing block %llu/%p\n",
-				  bh->b_blocknr,
-				  (void *) bh);
-			retval = io_channel_write_blk64(bh->b_io,
-						      bh->b_blocknr,
-						      1, bh->b_data);
-			if (retval) {
-				com_err(bh->b_fs->device_name, retval,
-					"while writing block %llu\n",
-					bh->b_blocknr);
-				bh->b_err = (int) retval;
-				continue;
-			}
-			bh->b_dirty = 0;
-			bh->b_uptodate = 1;
-		} else {
-			jfs_debug(3, "no-op %s for block %llu\n",
-				  rw == REQ_OP_READ ? "read" : "write",
-				  bh->b_blocknr);
-		}
-	}
-}
-
-void mark_buffer_dirty(struct buffer_head *bh)
-{
-	bh->b_dirty = 1;
-}
-
-static void mark_buffer_clean(struct buffer_head *bh)
-{
-	bh->b_dirty = 0;
-}
-
-void brelse(struct buffer_head *bh)
-{
-	if (bh->b_dirty)
-		ll_rw_block(REQ_OP_WRITE, 0, 1, &bh);
-	jfs_debug(3, "freeing block %llu/%p (total %d)\n",
-		  bh->b_blocknr, (void *) bh, --bh_count);
-	ext2fs_free_mem(&bh);
-}
-
-int buffer_uptodate(struct buffer_head *bh)
-{
-	return bh->b_uptodate;
-}
-
-void mark_buffer_uptodate(struct buffer_head *bh, int val)
-{
-	bh->b_uptodate = val;
-}
-
-void wait_on_buffer(struct buffer_head *bh)
-{
-	if (!bh->b_uptodate)
-		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
-}
-
-
-static void ext2fs_clear_recover(ext2_filsys fs, int error)
-{
-	ext2fs_clear_feature_journal_needs_recovery(fs->super);
-
-	/* if we had an error doing journal recovery, we need a full fsck */
-	if (error)
-		fs->super->s_state &= ~EXT2_VALID_FS;
-	/*
-	 * If we replayed the journal by definition the file system
-	 * was mounted since the last time it was checked
-	 */
-	if (fs->super->s_lastcheck >= fs->super->s_mtime)
-		fs->super->s_lastcheck = fs->super->s_mtime - 1;
-	ext2fs_mark_super_dirty(fs);
-}
 
 /*
  * This is a helper function to check the validity of the journal.
@@ -640,40 +423,6 @@ static errcode_t ext2fs_journal_load(journal_t *journal)
 	return 0;
 }
 
-static void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
-				   int reset, int drop)
-{
-	journal_superblock_t *jsb;
-
-	if (drop)
-		mark_buffer_clean(journal->j_sb_buffer);
-	else if (fs->flags & EXT2_FLAG_RW) {
-		jsb = journal->j_superblock;
-		jsb->s_sequence = htonl(journal->j_tail_sequence);
-		if (reset)
-			jsb->s_start = 0; /* this marks the journal as empty */
-		ext2fs_journal_sb_csum_set(journal, jsb);
-		mark_buffer_dirty(journal->j_sb_buffer);
-	}
-	brelse(journal->j_sb_buffer);
-
-	if (fs && fs->journal_io) {
-		if (fs->io != fs->journal_io)
-			io_channel_close(fs->journal_io);
-		fs->journal_io = NULL;
-		free(fs->journal_name);
-		fs->journal_name = NULL;
-	}
-
-#ifndef USE_INODE_IO
-	if (journal->j_inode)
-		ext2fs_free_mem(&journal->j_inode);
-#endif
-	if (journal->j_fs_dev)
-		ext2fs_free_mem(&journal->j_fs_dev);
-	ext2fs_free_mem(&journal);
-}
-
 /*
  * This function makes sure that the superblock fields regarding the
  * journal are consistent.
diff --git a/debugfs/journal.h b/debugfs/journal.h
index 10b638eb..44d4fa72 100644
--- a/debugfs/journal.h
+++ b/debugfs/journal.h
@@ -12,7 +12,7 @@
  * any later version.
  */
 
-#include "jfs_user.h"
+#include "ext2fs/jfs_user.h"
 
 /* journal.c */
 errcode_t ext2fs_open_journal(ext2_filsys fs, journal_t **j);
diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index 4154ef2a..99934077 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -32,7 +32,7 @@ extern char *optarg;
 
 #include "debugfs.h"
 #include "blkid/blkid.h"
-#include "jfs_user.h"
+#include "ext2fs/jfs_user.h"
 #if __GNUC_PREREQ (4, 6)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wunused-function"
diff --git a/e2fsck/Makefile.in b/e2fsck/Makefile.in
index 71ac3cf5..fb8b2b71 100644
--- a/e2fsck/Makefile.in
+++ b/e2fsck/Makefile.in
@@ -383,7 +383,7 @@ pass5.o: $(srcdir)/pass5.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h
 journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
- $(top_builddir)/lib/dirpaths.h $(srcdir)/jfs_user.h $(srcdir)/e2fsck.h \
+ $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/jfs_user.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
@@ -396,7 +396,7 @@ journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(srcdir)/problem.h
-recovery.o: $(srcdir)/recovery.c $(srcdir)/jfs_user.h \
+recovery.o: $(srcdir)/recovery.c $(top_srcdir)/lib/ext2fs/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
@@ -410,7 +410,7 @@ recovery.o: $(srcdir)/recovery.c $(srcdir)/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
-revoke.o: $(srcdir)/revoke.c $(srcdir)/jfs_user.h \
+revoke.o: $(srcdir)/revoke.c $(top_srcdir)/lib/ext2fs/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
@@ -464,7 +464,7 @@ unix.o: $(srcdir)/unix.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
- $(srcdir)/problem.h $(srcdir)/jfs_user.h \
+ $(srcdir)/problem.h $(top_srcdir)/lib/ext2fs/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/version.h
 dirinfo.o: $(srcdir)/dirinfo.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index 1e295e3e..0ea1e0df 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -83,11 +83,6 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 		ext2fs_free_icount(ctx->inode_link_info);
 		ctx->inode_link_info = 0;
 	}
-	if (ctx->journal_io) {
-		if (ctx->fs && ctx->fs->io != ctx->journal_io)
-			io_channel_close(ctx->journal_io);
-		ctx->journal_io = 0;
-	}
 	if (ctx->fs && ctx->fs->dblist) {
 		ext2fs_free_dblist(ctx->fs->dblist);
 		ctx->fs->dblist = 0;
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 2db216f5..33334781 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -380,7 +380,6 @@ struct e2fsck_struct {
 	/*
 	 * ext3 journal support
 	 */
-	io_channel	journal_io;
 	char	*journal_name;
 
 	/*
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 2e867234..39d545a3 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -23,12 +23,11 @@
 #endif
 
 #define E2FSCK_INCLUDE_INLINE_FUNCS
-#include "jfs_user.h"
+#include "ext2fs/jfs_user.h"
+#include "e2fsck.h"
 #include "problem.h"
 #include "uuid/uuid.h"
 
-static int bh_count = 0;
-
 /*
  * Define USE_INODE_IO to use the inode_io.c / fileio.c codepaths.
  * This creates a larger static binary, and a smaller binary using
@@ -38,215 +37,6 @@ static int bh_count = 0;
  */
 #undef USE_INODE_IO
 
-/* Checksumming functions */
-static int e2fsck_journal_verify_csum_type(journal_t *j,
-					   journal_superblock_t *jsb)
-{
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 1;
-
-	return jsb->s_checksum_type == JBD2_CRC32C_CHKSUM;
-}
-
-static __u32 e2fsck_journal_sb_csum(journal_superblock_t *jsb)
-{
-	__u32 crc, old_crc;
-
-	old_crc = jsb->s_checksum;
-	jsb->s_checksum = 0;
-	crc = ext2fs_crc32c_le(~0, (unsigned char *)jsb,
-			       sizeof(journal_superblock_t));
-	jsb->s_checksum = old_crc;
-
-	return crc;
-}
-
-static int e2fsck_journal_sb_csum_verify(journal_t *j,
-					 journal_superblock_t *jsb)
-{
-	__u32 provided, calculated;
-
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 1;
-
-	provided = ext2fs_be32_to_cpu(jsb->s_checksum);
-	calculated = e2fsck_journal_sb_csum(jsb);
-
-	return provided == calculated;
-}
-
-static errcode_t e2fsck_journal_sb_csum_set(journal_t *j,
-					    journal_superblock_t *jsb)
-{
-	__u32 crc;
-
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 0;
-
-	crc = e2fsck_journal_sb_csum(jsb);
-	jsb->s_checksum = ext2fs_cpu_to_be32(crc);
-	return 0;
-}
-
-/* Kernel compatibility functions for handling the journal.  These allow us
- * to use the recovery.c file virtually unchanged from the kernel, so we
- * don't have to do much to keep kernel and user recovery in sync.
- */
-int jbd2_journal_bmap(journal_t *journal, unsigned long block,
-		      unsigned long long *phys)
-{
-#ifdef USE_INODE_IO
-	*phys = block;
-	return 0;
-#else
-	struct inode 	*inode = journal->j_inode;
-	errcode_t	retval;
-	blk64_t		pblk;
-
-	if (!inode) {
-		*phys = block;
-		return 0;
-	}
-
-	retval= ext2fs_bmap2(inode->i_ctx->fs, inode->i_ino,
-			     &inode->i_ext2, NULL, 0, (blk64_t) block,
-			     0, &pblk);
-	*phys = pblk;
-	return -1 * ((int) retval);
-#endif
-}
-
-struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
-			   int blocksize)
-{
-	struct buffer_head *bh;
-	int bufsize = sizeof(*bh) + kdev->k_ctx->fs->blocksize -
-		sizeof(bh->b_data);
-
-	bh = e2fsck_allocate_memory(kdev->k_ctx, bufsize, "block buffer");
-	if (!bh)
-		return NULL;
-
-	if (journal_enable_debug >= 3)
-		bh_count++;
-	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
-		  blocknr, blocksize, bh_count);
-
-	bh->b_ctx = kdev->k_ctx;
-	if (kdev->k_dev == K_DEV_FS)
-		bh->b_io = kdev->k_ctx->fs->io;
-	else
-		bh->b_io = kdev->k_ctx->journal_io;
-	bh->b_size = blocksize;
-	bh->b_blocknr = blocknr;
-
-	return bh;
-}
-
-int sync_blockdev(kdev_t kdev)
-{
-	io_channel	io;
-
-	if (kdev->k_dev == K_DEV_FS)
-		io = kdev->k_ctx->fs->io;
-	else
-		io = kdev->k_ctx->journal_io;
-
-	return io_channel_flush(io) ? -EIO : 0;
-}
-
-void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
-		 struct buffer_head *bhp[])
-{
-	errcode_t retval;
-	struct buffer_head *bh;
-
-	for (; nr > 0; --nr) {
-		bh = *bhp++;
-		if (rw == REQ_OP_READ && !bh->b_uptodate) {
-			jfs_debug(3, "reading block %llu/%p\n",
-				  bh->b_blocknr, (void *) bh);
-			retval = io_channel_read_blk64(bh->b_io,
-						     bh->b_blocknr,
-						     1, bh->b_data);
-			if (retval) {
-				com_err(bh->b_ctx->device_name, retval,
-					"while reading block %llu\n",
-					bh->b_blocknr);
-				bh->b_err = (int) retval;
-				continue;
-			}
-			bh->b_uptodate = 1;
-		} else if (rw == REQ_OP_WRITE && bh->b_dirty) {
-			jfs_debug(3, "writing block %llu/%p\n",
-				  bh->b_blocknr,
-				  (void *) bh);
-			retval = io_channel_write_blk64(bh->b_io,
-						      bh->b_blocknr,
-						      1, bh->b_data);
-			if (retval) {
-				com_err(bh->b_ctx->device_name, retval,
-					"while writing block %llu\n",
-					bh->b_blocknr);
-				bh->b_err = (int) retval;
-				continue;
-			}
-			bh->b_dirty = 0;
-			bh->b_uptodate = 1;
-		} else {
-			jfs_debug(3, "no-op %s for block %llu\n",
-				  rw == REQ_OP_READ ? "read" : "write",
-				  bh->b_blocknr);
-		}
-	}
-}
-
-void mark_buffer_dirty(struct buffer_head *bh)
-{
-	bh->b_dirty = 1;
-}
-
-static void mark_buffer_clean(struct buffer_head * bh)
-{
-	bh->b_dirty = 0;
-}
-
-void brelse(struct buffer_head *bh)
-{
-	if (bh->b_dirty)
-		ll_rw_block(REQ_OP_WRITE, 0, 1, &bh);
-	jfs_debug(3, "freeing block %llu/%p (total %d)\n",
-		  bh->b_blocknr, (void *) bh, --bh_count);
-	ext2fs_free_mem(&bh);
-}
-
-int buffer_uptodate(struct buffer_head *bh)
-{
-	return bh->b_uptodate;
-}
-
-void mark_buffer_uptodate(struct buffer_head *bh, int val)
-{
-	bh->b_uptodate = val;
-}
-
-void wait_on_buffer(struct buffer_head *bh)
-{
-	if (!bh->b_uptodate)
-		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
-}
-
-
-static void e2fsck_clear_recover(e2fsck_t ctx, int error)
-{
-	ext2fs_clear_feature_journal_needs_recovery(ctx->fs->super);
-
-	/* if we had an error doing journal recovery, we need a full fsck */
-	if (error)
-		ctx->fs->super->s_state &= ~EXT2_VALID_FS;
-	ext2fs_mark_super_dirty(ctx->fs);
-}
-
 /*
  * This is a helper function to check the validity of the journal.
  */
@@ -980,6 +770,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 	dev_journal = dev_fs+1;
 
 	dev_fs->k_ctx = dev_journal->k_ctx = ctx;
+	dev_fs->k_fs = dev_journal->k_fs = ctx->fs;
 	dev_fs->k_dev = K_DEV_FS;
 	dev_journal->k_dev = K_DEV_JOURNAL;
 
@@ -1001,6 +792,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 		}
 
 		j_inode->i_ctx = ctx;
+		j_inode->i_fs = ctx->fs;
 		j_inode->i_ino = sb->s_journal_inum;
 
 		if ((retval = ext2fs_read_inode(ctx->fs,
@@ -1061,7 +853,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 		io_ptr = inode_io_manager;
 #else
 		journal->j_inode = j_inode;
-		ctx->journal_io = ctx->fs->io;
+		ctx->fs->journal_io = ctx->fs->io;
 		if ((ret = jbd2_journal_bmap(journal, 0, &start)) != 0) {
 			retval = (errcode_t) (-1 * ret);
 			goto errout;
@@ -1108,12 +900,12 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 
 
 		retval = io_ptr->open(journal_name, flags,
-				      &ctx->journal_io);
+				      &ctx->fs->journal_io);
 	}
 	if (retval)
 		goto errout;
 
-	io_channel_set_blksize(ctx->journal_io, ctx->fs->blocksize);
+	io_channel_set_blksize(ctx->fs->journal_io, ctx->fs->blocksize);
 
 	if (ext_journal) {
 		blk64_t maxlen;
@@ -1226,13 +1018,13 @@ static errcode_t e2fsck_journal_fix_bad_inode(e2fsck_t ctx,
 			memset(sb->s_jnl_blocks, 0, sizeof(sb->s_jnl_blocks));
 			ctx->flags |= E2F_FLAG_JOURNAL_INODE;
 			ctx->fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
-			e2fsck_clear_recover(ctx, 1);
+			ext2fs_clear_recover(ctx->fs, 1);
 			return 0;
 		}
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 	} else if (recover) {
 		if (fix_problem(ctx, PR_0_JOURNAL_RECOVER_SET, pctx)) {
-			e2fsck_clear_recover(ctx, 1);
+			ext2fs_clear_recover(ctx->fs, 1);
 			return 0;
 		}
 		return EXT2_ET_UNSUPP_FEATURE;
@@ -1330,8 +1122,8 @@ static errcode_t e2fsck_journal_load(journal_t *journal)
 	    jbd2_has_feature_checksum(journal))
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 
-	if (!e2fsck_journal_verify_csum_type(journal, jsb) ||
-	    !e2fsck_journal_sb_csum_verify(journal, jsb))
+	if (!ext2fs_journal_verify_csum_type(journal, jsb) ||
+	    !ext2fs_journal_sb_csum_verify(journal, jsb))
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 
 	if (jbd2_journal_has_csum_v2or3(journal))
@@ -1419,7 +1211,7 @@ static void e2fsck_journal_reset_super(e2fsck_t ctx, journal_superblock_t *jsb,
 	for (i = 0; i < 4; i ++)
 		new_seq ^= u.val[i];
 	jsb->s_sequence = htonl(new_seq);
-	e2fsck_journal_sb_csum_set(journal, jsb);
+	ext2fs_journal_sb_csum_set(journal, jsb);
 
 	mark_buffer_dirty(journal->j_sb_buffer);
 	ll_rw_block(REQ_OP_WRITE, 0, 1, &journal->j_sb_buffer);
@@ -1437,7 +1229,7 @@ static errcode_t e2fsck_journal_fix_corrupt_super(e2fsck_t ctx,
 			e2fsck_journal_reset_super(ctx, journal->j_superblock,
 						   journal);
 			journal->j_transaction_sequence = 1;
-			e2fsck_clear_recover(ctx, recover);
+			ext2fs_clear_recover(ctx->fs, recover);
 			return 0;
 		}
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
@@ -1447,38 +1239,6 @@ static errcode_t e2fsck_journal_fix_corrupt_super(e2fsck_t ctx,
 	return 0;
 }
 
-static void e2fsck_journal_release(e2fsck_t ctx, journal_t *journal,
-				   int reset, int drop)
-{
-	journal_superblock_t *jsb;
-
-	if (drop)
-		mark_buffer_clean(journal->j_sb_buffer);
-	else if (!(ctx->options & E2F_OPT_READONLY)) {
-		jsb = journal->j_superblock;
-		jsb->s_sequence = htonl(journal->j_tail_sequence);
-		if (reset)
-			jsb->s_start = 0; /* this marks the journal as empty */
-		e2fsck_journal_sb_csum_set(journal, jsb);
-		mark_buffer_dirty(journal->j_sb_buffer);
-	}
-	brelse(journal->j_sb_buffer);
-
-	if (ctx->journal_io) {
-		if (ctx->fs && ctx->fs->io != ctx->journal_io)
-			io_channel_close(ctx->journal_io);
-		ctx->journal_io = 0;
-	}
-
-#ifndef USE_INODE_IO
-	if (journal->j_inode)
-		ext2fs_free_mem(&journal->j_inode);
-#endif
-	if (journal->j_fs_dev)
-		ext2fs_free_mem(&journal->j_fs_dev);
-	ext2fs_free_mem(&journal);
-}
-
 /*
  * This function makes sure that the superblock fields regarding the
  * journal are consistent.
@@ -1525,7 +1285,7 @@ errcode_t e2fsck_check_ext3_journal(e2fsck_t ctx)
 		    (!fix_problem(ctx, PR_0_JOURNAL_UNSUPP_VERSION, &pctx))))
 			retval = e2fsck_journal_fix_corrupt_super(ctx, journal,
 								  &pctx);
-		e2fsck_journal_release(ctx, journal, 0, 1);
+		ext2fs_journal_release(ctx->fs, journal, 0, 1);
 		return retval;
 	}
 
@@ -1552,7 +1312,7 @@ no_has_journal:
 			sb->s_journal_dev = 0;
 			memset(sb->s_journal_uuid, 0,
 			       sizeof(sb->s_journal_uuid));
-			e2fsck_clear_recover(ctx, force_fsck);
+			ext2fs_clear_recover(ctx->fs, force_fsck);
 		} else if (!(ctx->options & E2F_OPT_READONLY)) {
 			ext2fs_set_feature_journal(sb);
 			ctx->fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
@@ -1602,11 +1362,11 @@ no_has_journal:
 		ctx->fs->super->s_state |= EXT2_ERROR_FS;
 		ext2fs_mark_super_dirty(ctx->fs);
 		journal->j_superblock->s_errno = 0;
-		e2fsck_journal_sb_csum_set(journal, journal->j_superblock);
+		ext2fs_journal_sb_csum_set(journal, journal->j_superblock);
 		mark_buffer_dirty(journal->j_sb_buffer);
 	}
 
-	e2fsck_journal_release(ctx, journal, reset, 0);
+	ext2fs_journal_release(ctx->fs, journal, reset, 0);
 	return retval;
 }
 
@@ -1655,7 +1415,7 @@ errout:
 	jbd2_journal_destroy_revoke(journal);
 	jbd2_journal_destroy_revoke_record_cache();
 	jbd2_journal_destroy_revoke_table_cache();
-	e2fsck_journal_release(ctx, journal, 1, 0);
+	ext2fs_journal_release(ctx->fs, journal, 1, 0);
 	return retval;
 }
 
@@ -1706,7 +1466,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
 	ctx->fs->super->s_kbytes_written += kbytes_written;
 
 	/* Set the superblock flags */
-	e2fsck_clear_recover(ctx, recover_retval != 0);
+	ext2fs_clear_recover(ctx->fs, recover_retval != 0);
 
 	/*
 	 * Do one last sanity check, and propagate journal->s_errno to
diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index 63e9a12f..2b92ecd7 100644
--- a/e2fsck/logfile.c
+++ b/e2fsck/logfile.c
@@ -20,7 +20,7 @@
 #include "e2fsck.h"
 #include <pwd.h>
 
-extern e2fsck_t e2fsck_global_ctx;   /* Try your very best not to use this! */
+extern struct e2fsck_struct *e2fsck_global_ctx;   /* Try your very best not to use this! */
 
 struct string {
 	char	*s;
diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index 8ca35271..92d35426 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -11,7 +11,7 @@
  */
 
 #ifndef __KERNEL__
-#include "jfs_user.h"
+#include "ext2fs/jfs_user.h"
 #else
 #include <linux/time.h>
 #include <linux/fs.h>
diff --git a/e2fsck/revoke.c b/e2fsck/revoke.c
index fa608788..8bb97c2f 100644
--- a/e2fsck/revoke.c
+++ b/e2fsck/revoke.c
@@ -78,7 +78,7 @@
  */
 
 #ifndef __KERNEL__
-#include "jfs_user.h"
+#include "ext2fs/jfs_user.h"
 #else
 #include <linux/time.h>
 #include <linux/fs.h>
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index ae231f93..92fadda9 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -54,7 +54,7 @@ extern int optind;
 #include "support/plausible.h"
 #include "e2fsck.h"
 #include "problem.h"
-#include "jfs_user.h"
+#include "ext2fs/jfs_user.h"
 #include "../version.h"
 
 /* Command line options */
@@ -66,7 +66,7 @@ static int replace_bad_blocks;
 static int keep_bad_blocks;
 static char *bad_blocks_file;
 
-e2fsck_t e2fsck_global_ctx;	/* Try your very best not to use this! */
+struct e2fsck_struct *e2fsck_global_ctx;	/* Try your very best not to use this! */
 
 #ifdef CONFIG_JBD_DEBUG		/* Enabled by configure --enable-jbd-debug */
 int journal_enable_debug = -1;
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 3fe3c988..7b8e2267 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -39,7 +39,7 @@
 
 #include "e2fsck.h"
 
-extern e2fsck_t e2fsck_global_ctx;   /* Try your very best not to use this! */
+extern struct e2fsck_struct *e2fsck_global_ctx;   /* Try your very best not to use this! */
 
 #include <stdarg.h>
 #include <time.h>
diff --git a/lib/ext2fs/Android.bp b/lib/ext2fs/Android.bp
index 919adb13..37d9174d 100644
--- a/lib/ext2fs/Android.bp
+++ b/lib/ext2fs/Android.bp
@@ -81,6 +81,7 @@ cc_library {
         "mmp.c",
         "mkdir.c",
         "mkjournal.c",
+        "jfs_user.c",
         "namei.c",
         "native.c",
         "newdir.c",
diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
index f6a050a2..b3fc1ba9 100644
--- a/lib/ext2fs/Makefile.in
+++ b/lib/ext2fs/Makefile.in
@@ -5,10 +5,8 @@ top_builddir = ../..
 my_dir = lib/ext2fs
 INSTALL = @INSTALL@
 MKDIR_P = @MKDIR_P@
-DEPEND_CFLAGS = -I$(top_srcdir)/debugfs -I$(srcdir)/../../e2fsck -DDEBUGFS
-# This nastiness is needed because of jfs_user.h hackery; when we finally
-# clean up this mess, we should be able to drop it
-DEBUGFS_CFLAGS = -I$(srcdir)/../../e2fsck $(ALL_CFLAGS) -DDEBUGFS
+DEPEND_CFLAGS = -I$(top_srcdir)/debugfs -DDEBUGFS
+DEBUGFS_CFLAGS = $(ALL_CFLAGS) -DDEBUGFS
 
 @MCONFIG@
 
@@ -109,6 +107,7 @@ OBJS= $(DEBUGFS_LIB_OBJS) $(RESIZE_LIB_OBJS) $(E2IMAGE_LIB_OBJS) \
 	lookup.o \
 	mkdir.o \
 	mkjournal.o \
+	jfs_user.o \
 	mmp.o \
 	namei.o \
 	native.o \
@@ -193,6 +192,7 @@ SRCS= ext2_err.c \
 	$(srcdir)/lookup.c \
 	$(srcdir)/mkdir.c \
 	$(srcdir)/mkjournal.c \
+	$(srcdir)/jfs_user.c \
 	$(srcdir)/mmp.c	\
 	$(srcdir)/namei.c \
 	$(srcdir)/native.c \
@@ -1010,6 +1010,9 @@ mkjournal.o: $(srcdir)/mkjournal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h $(srcdir)/ext2_ext_attr.h \
  $(srcdir)/hashmap.h $(srcdir)/bitops.h $(srcdir)/kernel-jbd.h \
  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h
+jfs_user.o: $(srcdir)/jfs_user.c $(top_builddir)/lib/config.h \
+  $(srcdir)/jfs_user.h \
+  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h
 mmp.o: $(srcdir)/mmp.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
@@ -1231,7 +1234,7 @@ debugfs.o: $(top_srcdir)/debugfs/debugfs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/debugfs/../misc/create_inode.h $(top_srcdir)/lib/e2p/e2p.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/debugfs/../version.h \
- $(srcdir)/../../e2fsck/jfs_user.h $(srcdir)/kernel-jbd.h \
+ $(srcdir)/jfs_user.h $(srcdir)/kernel-jbd.h \
  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
  $(top_srcdir)/lib/support/plausible.h
 util.o: $(top_srcdir)/debugfs/util.c $(top_builddir)/lib/config.h \
@@ -1321,7 +1324,7 @@ logdump.o: $(top_srcdir)/debugfs/logdump.c $(top_builddir)/lib/config.h \
  $(srcdir)/hashmap.h $(srcdir)/bitops.h \
  $(top_srcdir)/debugfs/../misc/create_inode.h $(top_srcdir)/lib/e2p/e2p.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
- $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/../../e2fsck/jfs_user.h \
+ $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/jfs_user.h \
  $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h \
  $(srcdir)/compiler.h $(srcdir)/fast_commit.h
 htree.o: $(top_srcdir)/debugfs/htree.c $(top_builddir)/lib/config.h \
@@ -1422,20 +1425,20 @@ create_inode.o: $(top_srcdir)/misc/create_inode.c \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/nls-enable.h
 journal.o: $(top_srcdir)/debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/debugfs/journal.h \
- $(srcdir)/../../e2fsck/jfs_user.h $(srcdir)/ext2_fs.h \
+ $(srcdir)/jfs_user.h $(srcdir)/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
  $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h $(srcdir)/ext2_io.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h $(srcdir)/ext2_ext_attr.h \
  $(srcdir)/hashmap.h $(srcdir)/bitops.h $(srcdir)/kernel-jbd.h \
  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h
-revoke.o: $(top_srcdir)/e2fsck/revoke.c $(top_srcdir)/e2fsck/jfs_user.h \
+revoke.o: $(top_srcdir)/e2fsck/revoke.c $(srcdir)/jfs_user.h \
  $(srcdir)/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h \
  $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h \
  $(srcdir)/compiler.h
-recovery.o: $(top_srcdir)/e2fsck/recovery.c $(top_srcdir)/e2fsck/jfs_user.h \
+recovery.o: $(top_srcdir)/e2fsck/recovery.c $(srcdir)/jfs_user.h \
  $(srcdir)/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
@@ -1454,4 +1457,4 @@ do_journal.o: $(top_srcdir)/debugfs/do_journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/kernel-jbd.h \
  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
- $(top_srcdir)/debugfs/journal.h $(srcdir)/../../e2fsck/jfs_user.h
+ $(top_srcdir)/debugfs/journal.h $(srcdir)/jfs_user.h
diff --git a/lib/ext2fs/jfs_user.c b/lib/ext2fs/jfs_user.c
new file mode 100644
index 00000000..b6ae0229
--- /dev/null
+++ b/lib/ext2fs/jfs_user.c
@@ -0,0 +1,255 @@
+#include <jfs_user.h>
+
+static int bh_count = 0;
+
+void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
+		 struct buffer_head *bhp[])
+{
+	errcode_t retval;
+	struct buffer_head *bh;
+
+	for (; nr > 0; --nr) {
+		bh = *bhp++;
+		if (rw == REQ_OP_READ && !bh->b_uptodate) {
+			jfs_debug(3, "reading block %llu/%p\n",
+				  bh->b_blocknr, (void *) bh);
+			retval = io_channel_read_blk64(bh->b_io,
+						     bh->b_blocknr,
+						     1, bh->b_data);
+			if (retval) {
+				com_err(bh->b_fs->device_name, retval,
+					"while reading block %llu\n",
+					bh->b_blocknr);
+				bh->b_err = (int) retval;
+				continue;
+			}
+			bh->b_uptodate = 1;
+		} else if (rw == REQ_OP_WRITE && bh->b_dirty) {
+			jfs_debug(3, "writing block %llu/%p\n",
+				  bh->b_blocknr,
+				  (void *) bh);
+			retval = io_channel_write_blk64(bh->b_io,
+						      bh->b_blocknr,
+						      1, bh->b_data);
+			if (retval) {
+				com_err(bh->b_fs->device_name, retval,
+					"while writing block %llu\n",
+					bh->b_blocknr);
+				bh->b_err = (int) retval;
+				continue;
+			}
+			bh->b_dirty = 0;
+			bh->b_uptodate = 1;
+		} else {
+			jfs_debug(3, "no-op %s for block %llu\n",
+				  rw == REQ_OP_READ ? "read" : "write",
+				  bh->b_blocknr);
+		}
+	}
+}
+
+void mark_buffer_dirty(struct buffer_head *bh)
+{
+	bh->b_dirty = 1;
+}
+
+void mark_buffer_clean(struct buffer_head * bh)
+{
+	bh->b_dirty = 0;
+}
+
+int sync_blockdev(kdev_t kdev)
+{
+	io_channel	io;
+
+	if (kdev->k_dev == K_DEV_FS)
+		io = kdev->k_fs->io;
+	else
+		io = kdev->k_fs->journal_io;
+
+	return io_channel_flush(io) ? EIO : 0;
+}
+
+int buffer_uptodate(struct buffer_head *bh)
+{
+	return bh->b_uptodate;
+}
+
+void mark_buffer_uptodate(struct buffer_head *bh, int val)
+{
+	bh->b_uptodate = val;
+}
+
+void wait_on_buffer(struct buffer_head *bh)
+{
+	if (!bh->b_uptodate)
+		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
+}
+
+
+struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
+			   int blocksize)
+{
+	struct buffer_head *bh;
+	int bufsize = sizeof(*bh) + kdev->k_fs->blocksize -
+		sizeof(bh->b_data);
+	errcode_t retval;
+
+	retval = ext2fs_get_memzero(bufsize, &bh);
+	if (retval)
+		return NULL;
+
+	if (journal_enable_debug >= 3)
+		bh_count++;
+	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
+		  blocknr, blocksize, bh_count);
+
+	bh->b_fs = kdev->k_fs;
+	bh->b_ctx = kdev->k_ctx;
+	if (kdev->k_dev == K_DEV_FS)
+		bh->b_io = kdev->k_fs->io;
+	else
+		bh->b_io = kdev->k_fs->journal_io;
+	bh->b_size = blocksize;
+	bh->b_blocknr = blocknr;
+
+	return bh;
+}
+
+
+void brelse(struct buffer_head *bh)
+{
+	if (bh->b_dirty)
+		ll_rw_block(REQ_OP_WRITE, 0, 1, &bh);
+	jfs_debug(3, "freeing block %llu/%p (total %d)\n",
+		  bh->b_blocknr, (void *) bh, --bh_count);
+	ext2fs_free_mem(&bh);
+}
+
+/* Kernel compatibility functions for handling the journal.  These allow us
+ * to use the recovery.c file virtually unchanged from the kernel, so we
+ * don't have to do much to keep kernel and user recovery in sync.
+ */
+int jbd2_journal_bmap(journal_t *journal, unsigned long block,
+		      unsigned long long *phys)
+{
+#ifdef USE_INODE_IO
+	*phys = block;
+	return 0;
+#else
+	struct inode	*inode = journal->j_inode;
+	errcode_t	retval;
+	blk64_t		pblk;
+
+	if (!inode) {
+		*phys = block;
+		return 0;
+	}
+
+	retval = ext2fs_bmap2(inode->i_fs, inode->i_ino,
+			      &inode->i_ext2, NULL, 0, (blk64_t) block,
+			      0, &pblk);
+	*phys = pblk;
+	return (int) retval;
+#endif
+}
+
+static __u32 ext2fs_journal_sb_csum(journal_superblock_t *jsb)
+{
+	__u32 crc, old_crc;
+
+	old_crc = jsb->s_checksum;
+	jsb->s_checksum = 0;
+	crc = ext2fs_crc32c_le(~0, (unsigned char *)jsb,
+			       sizeof(journal_superblock_t));
+	jsb->s_checksum = old_crc;
+
+	return crc;
+}
+
+int ext2fs_journal_sb_csum_verify(journal_t *j,
+				  journal_superblock_t *jsb)
+{
+	__u32 provided, calculated;
+
+	if (!jbd2_journal_has_csum_v2or3(j))
+		return 1;
+
+	provided = ext2fs_be32_to_cpu(jsb->s_checksum);
+	calculated = ext2fs_journal_sb_csum(jsb);
+
+	return provided == calculated;
+}
+
+errcode_t ext2fs_journal_sb_csum_set(journal_t *j,
+				     journal_superblock_t *jsb)
+{
+	__u32 crc;
+
+	if (!jbd2_journal_has_csum_v2or3(j))
+		return 0;
+
+	crc = ext2fs_journal_sb_csum(jsb);
+	jsb->s_checksum = ext2fs_cpu_to_be32(crc);
+	return 0;
+}
+
+/* Checksumming functions */
+int ext2fs_journal_verify_csum_type(journal_t *j,
+				    journal_superblock_t *jsb)
+{
+	if (!jbd2_journal_has_csum_v2or3(j))
+		return 1;
+
+	return jsb->s_checksum_type == JBD2_CRC32C_CHKSUM;
+}
+
+void ext2fs_clear_recover(ext2_filsys fs, int error)
+{
+	ext2fs_clear_feature_journal_needs_recovery(fs->super);
+
+	/* if we had an error doing journal recovery, we need a full fsck */
+	if (error)
+		fs->super->s_state &= ~EXT2_VALID_FS;
+	/*
+	 * If we replayed the journal by definition the file system
+	 * was mounted since the last time it was checked
+	 */
+	if (fs->super->s_lastcheck >= fs->super->s_mtime)
+		fs->super->s_lastcheck = fs->super->s_mtime - 1;
+	ext2fs_mark_super_dirty(fs);
+}
+
+void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
+				   int reset, int drop)
+{
+	journal_superblock_t *jsb;
+
+	if (drop)
+		mark_buffer_clean(journal->j_sb_buffer);
+	else if (fs->flags & EXT2_FLAG_RW) {
+		jsb = journal->j_superblock;
+		jsb->s_sequence = htonl(journal->j_tail_sequence);
+		if (reset)
+			jsb->s_start = 0; /* this marks the journal as empty */
+		ext2fs_journal_sb_csum_set(journal, jsb);
+		mark_buffer_dirty(journal->j_sb_buffer);
+	}
+	brelse(journal->j_sb_buffer);
+
+	if (fs && fs->journal_io) {
+		if (fs->io != fs->journal_io)
+			io_channel_close(fs->journal_io);
+		fs->journal_io = NULL;
+		free(fs->journal_name);
+		fs->journal_name = NULL;
+	}
+
+#ifndef USE_INODE_IO
+	if (journal->j_inode)
+		ext2fs_free_mem(&journal->j_inode);
+#endif
+	if (journal->j_fs_dev)
+		ext2fs_free_mem(&journal->j_fs_dev);
+	ext2fs_free_mem(&journal);
+}
diff --git a/e2fsck/jfs_user.h b/lib/ext2fs/jfs_user.h
similarity index 89%
rename from e2fsck/jfs_user.h
rename to lib/ext2fs/jfs_user.h
index 4ad2005a..ed75c4a5 100644
--- a/e2fsck/jfs_user.h
+++ b/lib/ext2fs/jfs_user.h
@@ -11,7 +11,6 @@
 #ifndef _JFS_USER_H
 #define _JFS_USER_H
 
-#ifdef DEBUGFS
 #include <stdio.h>
 #include <stdlib.h>
 #if EXT2_FLAT_INCLUDES
@@ -23,13 +22,8 @@
 #include "ext2fs/ext2fs.h"
 #include "blkid/blkid.h"
 #endif
-#else
-/*
- * Pull in the definition of the e2fsck context structure
- */
-#include "config.h"
-#include "e2fsck.h"
-#endif
+
+struct e2fsck_struct;
 
 #if __STDC_VERSION__ < 199901L
 # if __GNUC__ >= 2 || _MSC_VER >= 1300
@@ -40,11 +34,8 @@
 #endif
 
 struct buffer_head {
-#ifdef DEBUGFS
 	ext2_filsys	b_fs;
-#else
-	e2fsck_t	b_ctx;
-#endif
+	struct e2fsck_struct *b_ctx;
 	io_channel	b_io;
 	int		b_size;
 	int		b_err;
@@ -55,21 +46,15 @@ struct buffer_head {
 };
 
 struct inode {
-#ifdef DEBUGFS
 	ext2_filsys	i_fs;
-#else
-	e2fsck_t	i_ctx;
-#endif
+	struct e2fsck_struct *i_ctx;
 	ext2_ino_t	i_ino;
 	struct ext2_inode i_ext2;
 };
 
 struct kdev_s {
-#ifdef DEBUGFS
 	ext2_filsys	k_fs;
-#else
-	e2fsck_t	k_ctx;
-#endif
+	struct e2fsck_struct *k_ctx;
 	int		k_dev;
 };
 
@@ -223,27 +208,41 @@ int sync_blockdev(kdev_t kdev);
 void ll_rw_block(int rw, int op_flags, int nr, struct buffer_head *bh[]);
 void mark_buffer_dirty(struct buffer_head *bh);
 void mark_buffer_uptodate(struct buffer_head *bh, int val);
+void mark_buffer_clean(struct buffer_head * bh);
 void brelse(struct buffer_head *bh);
 int buffer_uptodate(struct buffer_head *bh);
 void wait_on_buffer(struct buffer_head *bh);
 
+int ext2fs_journal_verify_csum_type(journal_t *j,
+				    journal_superblock_t *jsb);
+int ext2fs_journal_sb_csum_verify(journal_t *j,
+				  journal_superblock_t *jsb);
+errcode_t ext2fs_journal_sb_csum_set(journal_t *j,
+				     journal_superblock_t *jsb);
+
+void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
+			    int reset, int drop);
+void ext2fs_clear_recover(ext2_filsys fs, int error);
+
+
 /*
  * Define newer 2.5 interfaces
  */
 #define __getblk(dev, blocknr, blocksize) getblk(dev, blocknr, blocksize)
 #define set_buffer_uptodate(bh) mark_buffer_uptodate(bh, 1)
 
-#ifdef DEBUGFS
-#include <assert.h>
-#undef J_ASSERT
-#define J_ASSERT(x)	assert(x)
-
 #define JSB_HAS_INCOMPAT_FEATURE(jsb, mask)				\
 	((jsb)->s_header.h_blocktype == ext2fs_cpu_to_be32(JBD2_SUPERBLOCK_V2) &&	\
 	 ((jsb)->s_feature_incompat & ext2fs_cpu_to_be32((mask))))
-#else  /* !DEBUGFS */
 
-extern e2fsck_t e2fsck_global_ctx;  /* Try your very best not to use this! */
+#ifdef DEBUGFS
+#include <assert.h>
+#undef J_ASSERT
+#define J_ASSERT(x)    assert(x)
+#else
+
+extern struct e2fsck_struct *e2fsck_global_ctx;  /* Try your very best not to use this! */
+extern void fatal_error(struct e2fsck_struct * ctx, const char * fmt_string);
 
 #define J_ASSERT(assert)						\
 	do { if (!(assert)) {						\
@@ -279,4 +278,6 @@ extern int	jbd2_journal_set_revoke(journal_t *, unsigned long long, tid_t);
 extern int	jbd2_journal_test_revoke(journal_t *, unsigned long long, tid_t);
 extern void	jbd2_journal_clear_revoke(journal_t *);
 
+
+
 #endif /* _JFS_USER_H */
diff --git a/misc/Makefile.in b/misc/Makefile.in
index 4db59cdf..6f863773 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -126,8 +126,8 @@ COMPILE_ET=	_ET_DIR_OVERRIDE=$(srcdir)/../lib/et/et ../lib/et/compile_et
 
 # This nastiness is needed because of jfs_user.h hackery; when we finally
 # clean up this mess, we should be able to drop it
-JOURNAL_CFLAGS = -I$(srcdir)/../e2fsck $(ALL_CFLAGS) -DDEBUGFS
-DEPEND_CFLAGS = -I$(top_srcdir)/e2fsck
+JOURNAL_CFLAGS = $(ALL_CFLAGS) -DDEBUGFS
+DEPEND_CFLAGS = 
 
 .c.o:
 	$(E) "	CC $<"
@@ -878,7 +878,7 @@ check_fuzzer.o: $(srcdir)/check_fuzzer.c $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_srcdir)/lib/ext2fs/bitops.h
 journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
- $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
+ $(top_srcdir)/lib/ext2fs/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
@@ -891,7 +891,7 @@ journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
-revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
+revoke.o: $(srcdir)/../e2fsck/revoke.c $(top_srcdir)/lib/ext2fs/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
@@ -905,7 +905,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
-recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
+recovery.o: $(srcdir)/../e2fsck/recovery.c $(top_srcdir)/lib/ext2fs/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
-- 
2.31.1

