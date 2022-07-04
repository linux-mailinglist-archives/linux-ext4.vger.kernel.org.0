Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B432564E55
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiGDHIG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiGDHHz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:07:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362247663
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:07:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m14so7802034plg.5
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D7hsX2DsmXYOz9s9ls3nii2cmhk82eZNYmUg1ZliQuI=;
        b=GXE3a8D0BhLnN3q5lzqEJMXBbRNlzuUwuV9Xb1Ctd4YeDHjaDrRuvWffzL3SpGGxxp
         yMLSo3mGjvKzn0U/h22RDwfzOLqYVzAGjQst0YjO+eGdQwPnR1fk7ctzTMM1r8bL99yy
         QtxA9Xc2zrjBlEIx7xgMM0+y/2tYoSITxOjAzO70woCZEJNYIu9ikOG5fMXyM1ql9mkh
         PGk8DvTRnPYZDFx/VaRFBP7I2epVlCtcommIic3hZVVN5HaaHLPTFTdPRUOmpqIfVEL+
         N0pyBSQZJkgwDAuWQ6ePW+gFdqt+vua9lxAheJ+8pxBoY3XgOcRDyjUYYh7euWfP7U+n
         I55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D7hsX2DsmXYOz9s9ls3nii2cmhk82eZNYmUg1ZliQuI=;
        b=mm2tA1zpn949nsGBoh/yZqZRKKcWLGFiGfc+FJzk1ydtt1T0XPGSBjWtomwr/fyFN+
         2Wicn1UgAM6I99uBoKG0V333v9eIvWJeax+fQfXJ+gShJ4w0PYplDCdSTjGHzlk+RHLz
         SZO2NJA8XGOb1IPTPGKMV1XWDRqpzCq4Zr2dIU2FLBscv2rjGUFv21U58r02NPLVy6t9
         CPKLtTaFXbojGbwy2hSLGUMGhZFr2Co18HoU0E6FkDqbaz51fLS5tM6usim7a4gkcXpU
         D5en5SkTEqiCDY+qeoK0lxVtjy/YhzjY/Xsy5uICwZted14ImpswB7e1NpkxQknfQtE2
         a2oQ==
X-Gm-Message-State: AJIora+3wTilg67T2lLvQof0qgwCS4KJksqT4EaaMl4UVXLO9lj3b1Xf
        gv923jzGKeHasJiYBoTSx+Q=
X-Google-Smtp-Source: AGRyM1t4wWZUWZl4ZzDI02YMbzbYhLcc110BvMnFNo6esN6l5lwzXvGGw6yF+NpMA5NqSS8zTLBs2g==
X-Received: by 2002:a17:903:2444:b0:16b:917e:3b04 with SMTP id l4-20020a170903244400b0016b917e3b04mr32392331pls.145.1656918470618;
        Mon, 04 Jul 2022 00:07:50 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id lp11-20020a17090b4a8b00b001ef82d23125sm2429778pjb.25.2022.07.04.00.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:07:50 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 07/13] tst_bitmaps_standalone: Add copy and merge bitmaps test
Date:   Mon,  4 Jul 2022 12:36:56 +0530
Message-Id: <6abd6d01ab11f862b2ff5b31664292718a77d8e8.1656912918.git.ritesh.list@gmail.com>
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

This adds a basic copy and merge api test for both bitmap types
(i.e. rbtree and bitarray)

Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 lib/ext2fs/Makefile.in              |  25 +++-
 lib/ext2fs/tst_bitmaps_standalone.c | 173 ++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+), 6 deletions(-)
 create mode 100644 lib/ext2fs/tst_bitmaps_standalone.c

diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
index f6a050a2..1692500e 100644
--- a/lib/ext2fs/Makefile.in
+++ b/lib/ext2fs/Makefile.in
@@ -227,6 +227,7 @@ SRCS= ext2_err.c \
 	$(srcdir)/write_bb_file.c \
 	$(srcdir)/rbtree.c \
 	$(srcdir)/tst_libext2fs.c \
+	$(srcdir)/tst_bitmaps_standalone.c \
 	$(DEBUG_SRCS)
 
 HFILES= bitops.h ext2fs.h ext2_io.h ext2_fs.h ext2_ext_attr.h ext3_extents.h \
@@ -328,9 +329,9 @@ tst_getsectsize: tst_getsectsize.o getsectsize.o $(STATIC_LIBEXT2FS) \
 		$(ALL_LDFLAGS) $(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) \
 		$(SYSLIBS)
 
-tst_types.o: $(srcdir)/tst_types.c ext2_types.h 
+tst_types.o: $(srcdir)/tst_types.c ext2_types.h
 
-tst_types: tst_types.o ext2_types.h 
+tst_types: tst_types.o ext2_types.h
 	$(E) "	LD $@"
 	$(Q) $(CC) -o tst_types tst_types.o $(ALL_LDFLAGS) $(SYSLIBS)
 
@@ -362,6 +363,11 @@ tst_sha512: $(srcdir)/sha512.c $(srcdir)/ext2_fs.h
 	$(Q) $(CC) $(ALL_LDFLAGS) $(ALL_CFLAGS) -o tst_sha512 \
 		$(srcdir)/sha512.c -DUNITTEST $(SYSLIBS)
 
+tst_bitmaps_standalone: tst_bitmaps_standalone.o $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+	$(E) "	LD $@"
+	$(Q) $(CC) -o tst_bitmaps_standalone tst_bitmaps_standalone.o $(ALL_LDFLAGS) \
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
+
 ext2_tdbtool: tdbtool.o
 	$(E) "	LD $@"
 	$(Q) $(CC) -o ext2_tdbtool tdbtool.o tdb.o $(ALL_LDFLAGS) $(SYSLIBS)
@@ -533,7 +539,7 @@ mkjournal: mkjournal.c $(STATIC_LIBEXT2FS) $(DEPLIBCOM_ERR)
 fullcheck check:: tst_bitops tst_badblocks tst_iscan tst_types tst_icount \
     tst_super_size tst_types tst_inode_size tst_csum tst_crc32c tst_bitmaps \
     tst_inline tst_inline_data tst_libext2fs tst_sha256 tst_sha512 \
-    tst_digest_encode tst_getsize tst_getsectsize
+    tst_digest_encode tst_getsize tst_getsectsize tst_bitmaps_standalone
 	$(TESTENV) ./tst_bitops
 	$(TESTENV) ./tst_badblocks
 	$(TESTENV) ./tst_iscan
@@ -556,6 +562,7 @@ fullcheck check:: tst_bitops tst_badblocks tst_iscan tst_types tst_icount \
 	$(TESTENV) ./tst_bitmaps -l -f $(srcdir)/tst_bitmaps_cmds > tst_bitmaps_out
 	diff $(srcdir)/tst_bitmaps_exp tst_bitmaps_out
 	$(TESTENV) ./tst_digest_encode
+	$(TESTENV) ./tst_bitmaps_standalone
 
 installdirs::
 	$(E) "	MKDIR_P $(libdir) $(includedir)/ext2fs"
@@ -581,7 +588,7 @@ install:: all $(HFILES) $(HFILES_IN) installdirs ext2fs.pc
 uninstall::
 	$(RM) -f $(DESTDIR)$(libdir)/libext2fs.a \
 		$(DESTDIR)$(pkgconfigdir)/ext2fs.pc
-	$(RM) -rf $(DESTDIR)$(includedir)/ext2fs 
+	$(RM) -rf $(DESTDIR)$(includedir)/ext2fs
 
 clean::
 	$(RM) -f \#* *.s *.o *.a *~ *.bak core profiled/* \
@@ -590,7 +597,7 @@ clean::
 		tst_bitops tst_types tst_icount tst_super_size tst_csum \
 		tst_bitmaps tst_bitmaps_out tst_extents tst_inline \
 		tst_inline_data tst_inode_size tst_bitmaps_cmd.c \
-		tst_digest_encode tst_sha256 tst_sha512 \
+		tst_digest_encode tst_sha256 tst_sha512  tst_bitmaps_standalone \
 		ext2_tdbtool mkjournal debug_cmds.c tst_cmds.c extent_cmds.c \
 		../libext2fs.a ../libext2fs_p.a ../libext2fs_chk.a \
 		crc32c_table.h gen_crc32ctable tst_crc32c tst_libext2fs \
@@ -646,7 +653,7 @@ windows_io.o: $(srcdir)/windows_io.c $(top_builddir)/lib/config.h \
  $(srcdir)/ext2_ext_attr.h $(srcdir)/bitops.h $(srcdir)/ext2fsP.h
 
 # +++ Dependency line eater +++
-# 
+#
 # Makefile dependencies follow.  This must be the last section in
 # the Makefile.in file
 #
@@ -1156,6 +1163,12 @@ tst_iscan.o: $(srcdir)/tst_iscan.c $(top_builddir)/lib/config.h \
  $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
+tst_bitmaps_standalone.o: $(srcdir)/tst_bitmaps_standalone.c $(top_builddir)/lib/config.h \
+ $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
+ $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
+ $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
+ $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
+ $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
 undo_io.o: $(srcdir)/undo_io.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
diff --git a/lib/ext2fs/tst_bitmaps_standalone.c b/lib/ext2fs/tst_bitmaps_standalone.c
new file mode 100644
index 00000000..325398f8
--- /dev/null
+++ b/lib/ext2fs/tst_bitmaps_standalone.c
@@ -0,0 +1,173 @@
+#include "config.h"
+#include <stdio.h>
+#include <string.h>
+#include <assert.h>
+#if HAVE_UNISTD_H
+#include <unistd.h>
+#endif
+#include <fcntl.h>
+#include <time.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#if HAVE_ERRNO_H
+#include <errno.h>
+#endif
+
+#include "ext2_fs.h"
+#include "ext2fs.h"
+#include "bmap64.h"
+
+ext2_filsys test_fs;
+ext2fs_block_bitmap block_map_1;
+ext2fs_block_bitmap block_map_2;
+ext2fs_block_bitmap block_map;
+
+static int test_fail = 0;
+
+void dump_bitmap(ext2fs_generic_bitmap bmap, unsigned int start, unsigned num)
+{
+	unsigned char	*buf;
+	errcode_t	retval;
+	int	i, len = (num - start + 7) / 8;
+
+	buf = malloc(len);
+	if (!buf) {
+		com_err("dump_bitmap", 0, "couldn't allocate buffer");
+		return;
+	}
+	memset(buf, 0, len);
+	retval = ext2fs_get_generic_bmap_range(bmap, (__u64) start, num, buf);
+	if (retval) {
+		com_err("dump_bitmap", retval,
+			"while calling ext2fs_generic_bmap_range");
+		free(buf);
+		return;
+	}
+	for (i=len-1; i >= 0; i--)
+		printf("%02x ", buf[i]);
+	printf("\n");
+	printf("bits set: %u\n", ext2fs_bitcount(buf, len));
+	free(buf);
+}
+
+static void test_copy_run()
+{
+	int blocks[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 23, 26, 29, 33, 37, 38};
+	errcode_t ret;
+	char *buf_map = NULL;
+	char *buf_copy_map = NULL;
+
+	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap", &block_map_1) == 0);
+
+	for (int i = 0; i < sizeof(blocks)/sizeof(blocks[0]); i++) {
+		ext2fs_mark_block_bitmap2(block_map_1, blocks[i]);
+	}
+
+	assert(ext2fs_copy_bitmap(block_map_1, &block_map) == 0);
+
+	if (ext2fs_compare_block_bitmap(block_map_1, block_map) != 0) {
+		printf("block bitmap copy test failed\n");
+		test_fail++;
+
+		dump_bitmap(block_map_1, test_fs->super->s_first_data_block,
+				test_fs->super->s_blocks_count);
+
+		dump_bitmap(block_map, test_fs->super->s_first_data_block,
+				test_fs->super->s_blocks_count);
+	}
+
+	ext2fs_free_block_bitmap(block_map_1);
+	ext2fs_free_block_bitmap(block_map);
+}
+
+void test_merge_run()
+{
+	int blocks_odd[] = {1, 3, 5, 7, 9, 21, 23, 29, 33, 37};
+	int blocks_even[] = {2, 4, 6, 8, 10, 26, 38};
+	ext2fs_generic_bitmap_64 tmp_map;
+
+	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap 1", &block_map_1) == 0);
+	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap 2", &block_map_2) == 0);
+	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap 2", &block_map) == 0);
+
+	for (int i = 0; i < sizeof(blocks_odd) / sizeof(blocks_odd[0]); i++) {
+		ext2fs_mark_block_bitmap2(block_map_1, blocks_odd[i]);
+		ext2fs_mark_block_bitmap2(block_map, blocks_odd[i]);
+	}
+
+	for (int i = 0; i < sizeof(blocks_even) / sizeof(blocks_even[0]); i++) {
+		ext2fs_mark_block_bitmap2(block_map_2, blocks_even[i]);
+		ext2fs_mark_block_bitmap2(block_map, blocks_even[i]);
+	}
+
+	assert(ext2fs_merge_bitmap(block_map_2, block_map_1, NULL, NULL) == 0);
+	if (ext2fs_compare_block_bitmap(block_map_1, block_map) != 0) {
+		printf("block bitmap merge test failed\n");
+		test_fail++;
+
+		dump_bitmap(block_map_1, test_fs->super->s_first_data_block,
+				test_fs->super->s_blocks_count);
+
+		dump_bitmap(block_map, test_fs->super->s_first_data_block,
+				test_fs->super->s_blocks_count);
+	}
+
+	ext2fs_free_block_bitmap(block_map_1);
+	ext2fs_free_block_bitmap(block_map_2);
+	ext2fs_free_block_bitmap(block_map);
+}
+
+static void setup_filesystem(const char *name, unsigned int blocks,
+							 unsigned int inodes, unsigned int type,
+							 unsigned int flags)
+{
+	struct ext2_super_block param;
+	errcode_t ret;
+
+	memset(&param, 0, sizeof(param));
+	ext2fs_blocks_count_set(&param, blocks);
+	param.s_inodes_count = inodes;
+
+	ret = ext2fs_initialize(name, flags, &param, test_io_manager,
+							&test_fs);
+	if (ret) {
+		com_err(name, ret, "while initializing filesystem");
+		return;
+	}
+
+	test_fs->default_bitmap_type = type;
+
+	ext2fs_free_block_bitmap(test_fs->block_map);
+	ext2fs_free_block_bitmap(test_fs->inode_map);
+
+	return;
+errout:
+	ext2fs_close_free(&test_fs);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned int blocks = 127;
+	unsigned int inodes = 0;
+	unsigned int type = EXT2FS_BMAP64_RBTREE;
+	unsigned int flags = EXT2_FLAG_64BITS;
+	char *buf = NULL;
+
+	setup_filesystem(argv[0], blocks, inodes, type, flags);
+
+	/* test for EXT2FS_BMAP64_RBTREE */
+	test_copy_run();
+	test_merge_run();
+
+	/* test for EXT2FS_BMAP64_BITARRAY */
+	test_fs->default_bitmap_type = EXT2FS_BMAP64_BITARRAY;
+	test_copy_run();
+	test_merge_run();
+
+	if (test_fail)
+		printf("%s: Test copy & merge bitmaps -- NOT OK\n", argv[0]);
+	else
+		printf("%s: Test copy & merge bitmaps -- OK\n", argv[0]);
+
+	return test_fail;
+}
-- 
2.35.3

