Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9C564E5B
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiGDHJK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiGDHIw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:08:52 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E98334
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:08:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id v126so8130954pgv.11
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZgOEi4NpROOamHbjmumfavu3nkycozTSLXnJaf/zfw=;
        b=oAsnHSyk2BRDWAxWZfczzNzyryBpKOLgx0gkat6F/KD28bIvPaRPpnNBbFr+2OnQzD
         zJ2LFu2mjrz4ifQ4GICANp+rEUz4YGckJhGrYel/4JzVqDnCbRq3fMd2qTtlONduuuiY
         3LRkUISHJ/9laltxjXXP24hkQPIfw2DvY9DfIsXBB9IwVMpytpZm5W6UD0sCLX5RzNU0
         QQDaAf0fqDiUuNbG2KHH7LnWzpEapDFxmdhO3AU8M/ITIRzgms6ffWF2MW6z2gqIqoQF
         2lxjq5TQ6/7kFyFn+ziYd4QJQ77kiyC/7mBSPRn5KK9yZCCMitvq47iYPCbT/2GqoFcP
         pbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZgOEi4NpROOamHbjmumfavu3nkycozTSLXnJaf/zfw=;
        b=b4TGstbQyHsUnMJuUB+ri2pj/xGkVeXzpyRLonuTVr7WVMH+uue0EN1bhJoGO3KXaK
         FJlYCizwWarOUm/7jbiDYibev+GizLm0JmbUz9kZQ1kCE6VaHriNPcBsIhgQsjxC28ZT
         HgqlFA4ZanpPlPNhDEb9DThY6VKVXE3BqEUPLZZvfCvM4fUYXu5BSxqAR0hClK8t078O
         l9Dp6ixA7XtnpB4/m7Hu82AcZ3UmMwSq5IzewB0BTUhgJkNLbqer+unSDa302WZFKjxO
         /A/b/bx2hcjqCEreCbPGGmQEaPI0go2InbAD0HPsc2RRzp9qsv00kPv8zqGYHNopphGl
         Eo1A==
X-Gm-Message-State: AJIora/CnsghGQK7njp2wvJ3T+Nn2Q344YhUNN6QvjzTjstpUtoPWYjq
        0YlUlH7y78YYqRw2qVQHdmc=
X-Google-Smtp-Source: AGRyM1sqYQ2m6bXeF5/p2eIJA+DvsmegXgF4/NNU73dTfRkuzlMPH8UNS5X8ZMsH/PG2Uws9CHbYTg==
X-Received: by 2002:a63:551a:0:b0:412:24ed:33f1 with SMTP id j26-20020a63551a000000b0041224ed33f1mr7195229pgb.147.1656918500018;
        Mon, 04 Jul 2022 00:08:20 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b00518e1251197sm20961776pff.148.2022.07.04.00.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:08:19 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 13/13] tst_libext2fs_pthread: Add libext2fs merge/clone unit tests
Date:   Mon,  4 Jul 2022 12:37:02 +0530
Message-Id: <f2c9493c721a540d946b24b186f8bb412e75ae03.1656912918.git.ritesh.list@gmail.com>
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

This adds a unit tests for libext2fs merge/clone apis and uses pthreads
to test the functionality correctly.

TODO:
We can also add EXT2FS_CLONE_BADBLOCKS and EXT2FS_CLONE_DBLIST test as well
into it.

Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 lib/ext2fs/Makefile.in             |  17 +-
 lib/ext2fs/tst_libext2fs_pthread.c | 322 +++++++++++++++++++++++++++++
 2 files changed, 337 insertions(+), 2 deletions(-)
 create mode 100644 lib/ext2fs/tst_libext2fs_pthread.c

diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
index c0694175..5fde9900 100644
--- a/lib/ext2fs/Makefile.in
+++ b/lib/ext2fs/Makefile.in
@@ -229,6 +229,7 @@ SRCS= ext2_err.c \
 	$(srcdir)/tst_libext2fs.c \
 	$(srcdir)/tst_bitmaps_standalone.c \
 	$(srcdir)/tst_bitmaps_pthread.c \
+	$(srcdir)/tst_libext2fs_pthread.c \
 	$(DEBUG_SRCS)
 
 HFILES= bitops.h ext2fs.h ext2_io.h ext2_fs.h ext2_ext_attr.h ext3_extents.h \
@@ -374,6 +375,11 @@ tst_bitmaps_pthread: tst_bitmaps_pthread.o $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCO
 	$(Q) $(CC) -o tst_bitmaps_pthread tst_bitmaps_pthread.o $(ALL_LDFLAGS) \
 		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
+tst_libext2fs_pthread: tst_libext2fs_pthread.o $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+	$(E) "	LD $@"
+	$(Q) $(CC) -o tst_libext2fs_pthread tst_libext2fs_pthread.o $(ALL_LDFLAGS) \
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
+
 ext2_tdbtool: tdbtool.o
 	$(E) "	LD $@"
 	$(Q) $(CC) -o ext2_tdbtool tdbtool.o tdb.o $(ALL_LDFLAGS) $(SYSLIBS)
@@ -546,7 +552,7 @@ fullcheck check:: tst_bitops tst_badblocks tst_iscan tst_types tst_icount \
     tst_super_size tst_types tst_inode_size tst_csum tst_crc32c tst_bitmaps \
     tst_inline tst_inline_data tst_libext2fs tst_sha256 tst_sha512 \
     tst_digest_encode tst_getsize tst_getsectsize tst_bitmaps_standalone \
-	tst_bitmaps_pthread
+	tst_bitmaps_pthread tst_libext2fs_pthread
 	$(TESTENV) ./tst_bitops
 	$(TESTENV) ./tst_badblocks
 	$(TESTENV) ./tst_iscan
@@ -571,6 +577,7 @@ fullcheck check:: tst_bitops tst_badblocks tst_iscan tst_types tst_icount \
 	$(TESTENV) ./tst_digest_encode
 	$(TESTENV) ./tst_bitmaps_standalone
 	$(TESTENV) ./tst_bitmaps_pthread
+	$(TESTENV) ./tst_libext2fs_pthread
 
 installdirs::
 	$(E) "	MKDIR_P $(libdir) $(includedir)/ext2fs"
@@ -606,7 +613,7 @@ clean::
 		tst_bitmaps tst_bitmaps_out tst_extents tst_inline \
 		tst_inline_data tst_inode_size tst_bitmaps_cmd.c \
 		tst_digest_encode tst_sha256 tst_sha512  tst_bitmaps_standalone \
-		tst_bitmaps_pthread \
+		tst_bitmaps_pthread tst_libext2fs_pthread \
 		ext2_tdbtool mkjournal debug_cmds.c tst_cmds.c extent_cmds.c \
 		../libext2fs.a ../libext2fs_p.a ../libext2fs_chk.a \
 		crc32c_table.h gen_crc32ctable tst_crc32c tst_libext2fs \
@@ -1184,6 +1191,12 @@ tst_bitmaps_pthread.o: $(srcdir)/tst_bitmaps_pthread.c $(top_builddir)/lib/confi
  $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
+tst_libext2fs_pthread.o: $(srcdir)/tst_libext2fs_pthread.c $(top_builddir)/lib/config.h \
+ $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
+ $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
+ $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
+ $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
+ $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
 undo_io.o: $(srcdir)/undo_io.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
diff --git a/lib/ext2fs/tst_libext2fs_pthread.c b/lib/ext2fs/tst_libext2fs_pthread.c
new file mode 100644
index 00000000..f13bf611
--- /dev/null
+++ b/lib/ext2fs/tst_libext2fs_pthread.c
@@ -0,0 +1,322 @@
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
+#if HAVE_PTHREAD
+#include <pthread.h>
+#endif
+
+#include "ext2_fs.h"
+#include "ext2fs.h"
+
+int test_fail = 0;
+ext2_filsys testfs;
+ext2fs_inode_bitmap	inode_used_map;
+ext2fs_block_bitmap block_used_map;
+ext2_filsys childfs[2];
+pthread_t pthread_infos[2];
+
+#define nr_bits 16384
+int nr_threads = 2;
+
+int should_mark_bit()
+{
+	return rand() % 2 == 0;
+}
+
+void setupfs()
+{
+	errcode_t retval;
+	struct ext2_super_block param;
+
+	initialize_ext2_error_table();
+
+	memset(&param, 0, sizeof(param));
+	ext2fs_blocks_count_set(&param, nr_bits);
+	retval = ext2fs_initialize("test fs", EXT2_FLAG_64BITS, &param,
+							   test_io_manager, &testfs);
+	if (retval) {
+		com_err("setup", retval, "while initializing filesystem");
+		exit(1);
+	}
+
+	retval = ext2fs_allocate_tables(testfs);
+	if (retval) {
+		com_err("setup", retval, "while allocating tables for testfs");
+		exit(1);
+	}
+}
+
+void setup_used_bitmaps()
+{
+	int saved_type = testfs->default_bitmap_type;
+	ext2_inode_scan scan;
+	struct ext2_inode inode;
+	ext2_ino_t ino;
+	errcode_t retval;
+	int i;
+
+	testfs->default_bitmap_type = EXT2FS_BMAP64_BITARRAY;
+
+	/* allocate block and inode used bitmaps */
+	retval = ext2fs_allocate_block_bitmap(testfs, "block used map", &block_used_map);
+	if (retval)
+		goto out;
+
+	retval = ext2fs_allocate_inode_bitmap(testfs, "inode used map", &inode_used_map);
+	if (retval)
+		goto out;
+
+	/* setup block and inode used bitmaps */
+	for (i = 1; i < nr_bits; i++) {
+		/*
+		 * we check for testfs->block_map as well since there could be some
+		 * blocks already set as part of the FS metadata.
+		 */
+		if (should_mark_bit() || ext2fs_test_block_bitmap2(testfs->block_map, i)) {
+			ext2fs_mark_block_bitmap2(block_used_map, i);
+		}
+	}
+
+	retval = ext2fs_open_inode_scan(testfs, 8, &scan);
+	if (retval) {
+		com_err("setup_inode_map", retval, "while open inode scan");
+		exit(1);
+	}
+
+	retval = ext2fs_get_next_inode(scan, &ino, &inode);
+	if (retval) {
+		com_err("setup_inode_map", retval, "while getting next inode");
+		exit(1);
+	}
+
+	while (ino) {
+		if (should_mark_bit())
+			ext2fs_mark_inode_bitmap2(inode_used_map, ino);
+
+		retval = ext2fs_get_next_inode(scan, &ino, &inode);
+		if (retval) {
+			com_err("setup_inode_map", retval, "while getting next inode");
+			exit(1);
+		}
+	}
+	ext2fs_close_inode_scan(scan);
+
+	testfs->default_bitmap_type = saved_type;
+	return;
+out:
+	com_err("setup_used_bitmaps", retval, "while setting up bitmaps\n");
+	exit(1);
+}
+
+void setup_childfs()
+{
+	errcode_t retval;
+	int i;
+
+	for (i = 0; i < nr_threads; i++) {
+		retval = ext2fs_clone_fs(testfs, &childfs[i], EXT2FS_CLONE_INODE | EXT2FS_CLONE_BLOCK);
+		if (retval) {
+			com_err("setup_childfs", retval, "while clone testfs for childfs");
+			exit(1);
+		}
+
+		retval = childfs[i]->io->manager->open(childfs[i]->device_name,
+											IO_FLAG_THREADS | IO_FLAG_NOCACHE, &childfs[i]->io);
+		if (retval) {
+			com_err("setup_pthread", retval, "while opening childfs");
+			exit(1);
+		}
+		assert(childfs[i]->parent == testfs);
+	}
+}
+
+void free_childfs()
+{
+	int i;
+
+	for (i = 0; i < nr_threads; i++){
+		ext2fs_free(childfs[i]);
+	}
+}
+
+
+static errcode_t scan_callback(ext2_filsys fs,
+			       ext2_inode_scan scan EXT2FS_ATTR((unused)),
+			       dgrp_t group, void *priv_data)
+{
+	pthread_t id = *((pthread_t *)priv_data);
+
+	printf("%s: Called for group %d via thread %d\n", __func__, group,
+			pthread_equal(pthread_infos[1], id));
+	if (pthread_equal(pthread_infos[0], id)) {
+		if (group >= fs->group_desc_count / 2 - 1)
+			return 1;
+	}
+	return 0;
+}
+
+static void *run_pthread(void *arg)
+{
+	errcode_t retval = 0;
+	int i = 0, start, end;
+	ext2fs_block_bitmap test_block_bitmap;
+	ext2fs_inode_bitmap test_inode_bitmap;
+	ext2_inode_scan scan;
+	struct ext2_inode inode;
+	ext2_ino_t ino;
+	pthread_t id = pthread_self();
+
+	if (pthread_equal(pthread_infos[0], id)) {
+		start = 1;
+		end = nr_bits/2;
+		test_block_bitmap = childfs[0]->block_map;
+		test_inode_bitmap = childfs[0]->inode_map;
+
+		retval = ext2fs_open_inode_scan(childfs[0], 8, &scan);
+		if (retval) {
+			com_err("setup_inode_map", retval, "while open inode scan");
+			exit(1);
+		}
+
+	} else {
+		start = nr_bits / 2 + 1;;
+		end = nr_bits - 1;
+		test_block_bitmap = childfs[1]->block_map;
+		test_inode_bitmap = childfs[1]->inode_map;
+
+		retval = ext2fs_open_inode_scan(childfs[1], 8, &scan);
+		if (retval) {
+			com_err("setup_inode_map", retval, "while open inode scan");
+			exit(1);
+		}
+		ext2fs_inode_scan_goto_blockgroup(scan, testfs->group_desc_count/2);
+	}
+
+	ext2fs_set_inode_callback(scan, scan_callback, &id);
+
+	/* blocks scan */
+	for (i = start; i <= end; i++) {
+		if (ext2fs_test_block_bitmap2(block_used_map, i)) {
+			ext2fs_mark_block_bitmap2(test_block_bitmap, i);
+		}
+	}
+
+	/* inodes scan */
+	retval = ext2fs_get_next_inode(scan, &ino, &inode);
+	if (retval) {
+		com_err("setup_inode_map", retval, "while getting next inode");
+		exit(1);
+	}
+
+	while (ino) {
+		if (ext2fs_test_inode_bitmap2(inode_used_map, ino)) {
+			ext2fs_mark_inode_bitmap2(test_inode_bitmap, ino);
+		}
+
+		retval = ext2fs_get_next_inode(scan, &ino, &inode);
+		if (retval)
+			break;
+	}
+	ext2fs_close_inode_scan(scan);
+	return NULL;
+}
+
+void run_pthreads()
+{
+	errcode_t retval;
+	int i;
+
+	for (i = 0; i < nr_threads; i++) {
+		printf("Starting thread (%d)\n", i);
+		retval = pthread_create(&pthread_infos[i], NULL, &run_pthread, NULL);
+		if (retval) {
+			com_err("run_pthreads", retval, "while pthread_create");
+			exit(1);
+		}
+	}
+
+	for (i = 0; i < nr_threads; i++) {
+		void *status;
+		int ret;
+		retval = pthread_join(pthread_infos[i], &status);
+		if (retval) {
+			com_err("run_pthreads", retval, "while joining pthreads");
+			exit(1);
+
+		}
+		ret = status == NULL ? 0 : *(int*)status;
+		if (ret) {
+			com_err("run_pthreads", ret, "pthread returned error");
+			test_fail++;
+		}
+
+		printf("Closing thread (%d), ret(%d)\n", i, ret);
+	}
+
+	assert(ext2fs_merge_fs(childfs[0]) == 0);
+	assert(ext2fs_merge_fs(childfs[1]) == 0);
+}
+
+void test_bitmaps()
+{
+	errcode_t retval;
+	retval = ext2fs_compare_block_bitmap(testfs->block_map, block_used_map);
+	if (retval) {
+		printf("Block bitmap compare -- NOT OK!! (%ld)\n", retval);
+		test_fail++;
+	}
+
+	printf("Block compare bitmap  -- OK!!\n");
+	retval = ext2fs_compare_inode_bitmap(testfs->inode_map, inode_used_map);
+	if (retval) {
+		printf("Inode bitmap compare -- NOT OK!! (%ld)\n", retval);
+		test_fail++;
+	}
+	printf("Inode compare bitmap  -- OK!!\n");
+}
+
+void free_used_bitmaps()
+{
+	ext2fs_free_block_bitmap(block_used_map);
+	ext2fs_free_inode_bitmap(inode_used_map);
+}
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+#ifndef HAVE_PTHREAD
+	printf("No PTHREAD support, exiting...\n");
+	return 0;
+#endif
+
+	srand(time(0));
+
+	setupfs();
+	setup_used_bitmaps();
+
+	setup_childfs();
+	run_pthreads();
+	test_bitmaps(i);
+
+	if (test_fail)
+		printf("%s: Test libext2fs clone/merge with pthreads NOT OK!!\n", argv[0]);
+	else
+		printf("%s: Test libext2fs clone/merge with pthreads OK!!\n", argv[0]);
+	free_used_bitmaps();
+	free_childfs();
+	ext2fs_free(testfs);
+
+	return test_fail;
+}
-- 
2.35.3

