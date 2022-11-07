Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3394661F2EB
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiKGMX7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiKGMX5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:23:57 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11D1B78D
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:23:54 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k15so10456602pfg.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mn1lRc0cP2jFlAAalzrANSO9b0KSj41EtzHe7T6nSJg=;
        b=BPBcZDLDBLoJsxLMHKXQlNUlf1aRgCgy0M9pSyoXyEOuy5Qo26tqVAoI+CDz8nYj8T
         y0/YbQ5wtJzwhbPOVJn3O8f546//pk0Qs6UZAZ8/CvVtUqehG122cpy9F0QluZHdK7Fy
         hwBrOWRjRXYGrEdF0OERcpt/DDu4JI2TOvTw/Q2qC1ePap9e717ugjMoEAZYM+jKKhWs
         cBOZMy0z9RJ5iQiHUTyfesEEMmApnXyIKTrznCjDNHtaMsdX0s0HS4COhL9OJMTwVgVg
         IjEAOGpmFdJKRcib2lJjK7/D1mVpT6lBOvQVvRUVpVgPCU+2fg1ucKB3bSEgVOy5yqyQ
         /Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mn1lRc0cP2jFlAAalzrANSO9b0KSj41EtzHe7T6nSJg=;
        b=u3BPAWz2RhRTrGn3zIu4V/Tijv6WNQRcSZ3e1LhofmTIDgtvW7cCdolbtXZqcy4Oxz
         dq0cYCHB7Hh4xn2xSsp9IGrqKxDk8bDjntzsAfGV5h4YBiEu//CT6oVcrLJovnv+jnUJ
         cx4LLDNClM0IxKNMk1tc40qMEU9/txu0gA8izAa/X+vpe6cUZ4cs0fUjlqNxin5vimKB
         B5b7PynyenDk64Ryp2Xm712ekpqUalyjo0bcgfbixZN30bq0fMrJKZOHfN05IdrUBbzl
         LQoC8LoAeeSaIYg99LlwVELDgL39peui9uy0M8Ne9MySUoXC+q6T/VndFndNnHc8xale
         xgMQ==
X-Gm-Message-State: ACrzQf0RuZMnuKKyJhKVJvVXLJQc7bv6NFQeEqeYyzX0/oQCtWPLcMxo
        NwM2ShpiW8XsJRWOjLzfYpg=
X-Google-Smtp-Source: AMsMyM7rUY1YQGqPRnvlSrFd3THVdgoLiBKiHirpWqGqPfDqi2fFEI2Ug/ort5PFbdjez7FLhtbxzw==
X-Received: by 2002:a63:6a48:0:b0:43a:18ce:4e08 with SMTP id f69-20020a636a48000000b0043a18ce4e08mr43954917pgc.432.1667823833835;
        Mon, 07 Nov 2022 04:23:53 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b001785a72d285sm4930509plh.48.2022.11.07.04.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:23:53 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 15/72] tst_bitmaps_pthread: Add merge bitmaps test using pthreads
Date:   Mon,  7 Nov 2022 17:51:03 +0530
Message-Id: <c66b3b734a5a98297728786df5fca21a234d5872.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
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

This patch adds a test to verify the core bitmaps merge APIs
for rbtree bitmap type.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/Makefile.in           |  17 ++-
 lib/ext2fs/tst_bitmaps_pthread.c | 247 +++++++++++++++++++++++++++++++
 2 files changed, 263 insertions(+), 1 deletion(-)
 create mode 100644 lib/ext2fs/tst_bitmaps_pthread.c

diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
index 1692500e..c0694175 100644
--- a/lib/ext2fs/Makefile.in
+++ b/lib/ext2fs/Makefile.in
@@ -228,6 +228,7 @@ SRCS= ext2_err.c \
 	$(srcdir)/rbtree.c \
 	$(srcdir)/tst_libext2fs.c \
 	$(srcdir)/tst_bitmaps_standalone.c \
+	$(srcdir)/tst_bitmaps_pthread.c \
 	$(DEBUG_SRCS)
 
 HFILES= bitops.h ext2fs.h ext2_io.h ext2_fs.h ext2_ext_attr.h ext3_extents.h \
@@ -368,6 +369,11 @@ tst_bitmaps_standalone: tst_bitmaps_standalone.o $(STATIC_LIBEXT2FS) $(DEPSTATIC
 	$(Q) $(CC) -o tst_bitmaps_standalone tst_bitmaps_standalone.o $(ALL_LDFLAGS) \
 		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
 
+tst_bitmaps_pthread: tst_bitmaps_pthread.o $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
+	$(E) "	LD $@"
+	$(Q) $(CC) -o tst_bitmaps_pthread tst_bitmaps_pthread.o $(ALL_LDFLAGS) \
+		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
+
 ext2_tdbtool: tdbtool.o
 	$(E) "	LD $@"
 	$(Q) $(CC) -o ext2_tdbtool tdbtool.o tdb.o $(ALL_LDFLAGS) $(SYSLIBS)
@@ -539,7 +545,8 @@ mkjournal: mkjournal.c $(STATIC_LIBEXT2FS) $(DEPLIBCOM_ERR)
 fullcheck check:: tst_bitops tst_badblocks tst_iscan tst_types tst_icount \
     tst_super_size tst_types tst_inode_size tst_csum tst_crc32c tst_bitmaps \
     tst_inline tst_inline_data tst_libext2fs tst_sha256 tst_sha512 \
-    tst_digest_encode tst_getsize tst_getsectsize tst_bitmaps_standalone
+    tst_digest_encode tst_getsize tst_getsectsize tst_bitmaps_standalone \
+	tst_bitmaps_pthread
 	$(TESTENV) ./tst_bitops
 	$(TESTENV) ./tst_badblocks
 	$(TESTENV) ./tst_iscan
@@ -563,6 +570,7 @@ fullcheck check:: tst_bitops tst_badblocks tst_iscan tst_types tst_icount \
 	diff $(srcdir)/tst_bitmaps_exp tst_bitmaps_out
 	$(TESTENV) ./tst_digest_encode
 	$(TESTENV) ./tst_bitmaps_standalone
+	$(TESTENV) ./tst_bitmaps_pthread
 
 installdirs::
 	$(E) "	MKDIR_P $(libdir) $(includedir)/ext2fs"
@@ -598,6 +606,7 @@ clean::
 		tst_bitmaps tst_bitmaps_out tst_extents tst_inline \
 		tst_inline_data tst_inode_size tst_bitmaps_cmd.c \
 		tst_digest_encode tst_sha256 tst_sha512  tst_bitmaps_standalone \
+		tst_bitmaps_pthread \
 		ext2_tdbtool mkjournal debug_cmds.c tst_cmds.c extent_cmds.c \
 		../libext2fs.a ../libext2fs_p.a ../libext2fs_chk.a \
 		crc32c_table.h gen_crc32ctable tst_crc32c tst_libext2fs \
@@ -1169,6 +1178,12 @@ tst_bitmaps_standalone.o: $(srcdir)/tst_bitmaps_standalone.c $(top_builddir)/lib
  $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
+tst_bitmaps_pthread.o: $(srcdir)/tst_bitmaps_pthread.c $(top_builddir)/lib/config.h \
+ $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
+ $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
+ $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
+ $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
+ $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
 undo_io.o: $(srcdir)/undo_io.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
diff --git a/lib/ext2fs/tst_bitmaps_pthread.c b/lib/ext2fs/tst_bitmaps_pthread.c
new file mode 100644
index 00000000..243810ca
--- /dev/null
+++ b/lib/ext2fs/tst_bitmaps_pthread.c
@@ -0,0 +1,247 @@
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
+/*
+ * In this test we first setup used_bitmap by setting some random bits.
+ * This used_bitmap is then scanned in parallel by two threads, each scanning
+ * upto nr_bits/2 and setting their respective child_bitmap.
+ * Then once both threads finishes, we merge the child_bitmap_1/2 into
+ * parent_bitmap which then is used to compare against used_bitmap.
+ * In the end used_bitmap bits should match with parent_bitmap.
+ *
+ * Note we use EXT2FS_BMAP64_BITARRAY always for used_bitmap, this is because
+ * EXT2FS_BMAP64_RBTREE does not support parallel scan due to rcursor
+ * optimization.
+ */
+
+int test_fail = 0;
+ext2fs_generic_bitmap child_bitmap1, child_bitmap2, parent_bitmap;
+ext2fs_generic_bitmap used_bitmap;
+pthread_t pthread_infos[2];
+
+#define nr_bits 8192
+int nr_threads = 2;
+int bitmap_type[1] = {EXT2FS_BMAP64_RBTREE};
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
+int should_mark_bit()
+{
+	return rand() % 2 == 0;
+}
+
+void alloc_bitmaps(int type)
+{
+	errcode_t retval;
+
+	retval = ext2fs_alloc_generic_bmap(NULL, EXT2_ET_MAGIC_GENERIC_BITMAP64,
+							  type, 0, nr_bits, nr_bits,
+							  "child bitmap1", &child_bitmap1);
+	if (retval)
+		goto out;
+
+	retval = ext2fs_alloc_generic_bmap(NULL, EXT2_ET_MAGIC_GENERIC_BITMAP64,
+							  type, 0, nr_bits, nr_bits,
+							  "child bitmap2", &child_bitmap2);
+	if (retval)
+		goto out;
+
+	retval = ext2fs_alloc_generic_bmap(NULL, EXT2_ET_MAGIC_GENERIC_BITMAP64,
+							  type, 0, nr_bits, nr_bits,
+							  "parent bitmap", &parent_bitmap);
+	if (retval)
+		goto out;
+
+	/*
+	 * Note that EXT2FS_BMAP64_RBTREE doesn't support parallel read.
+	 * this is due to a optimization of maintaining a read cursor within
+	 * rbtree bitmap implementation.
+	 */
+	retval = ext2fs_alloc_generic_bmap(NULL, EXT2_ET_MAGIC_GENERIC_BITMAP64,
+							  EXT2FS_BMAP64_BITARRAY, 0, nr_bits, nr_bits,
+							  "used bitmap", &used_bitmap);
+	if (retval)
+		goto out;
+
+	return;
+out:
+	com_err("alloc_bitmaps", retval, "while allocating bitmaps\n");
+	exit(1);
+}
+
+void setup_bitmaps()
+{
+	int i = 0;
+	errcode_t retval;
+
+	/*
+	 * Note we cannot setup used_bitmap in parallel w/o locking.
+	 * Hence setting up the used_bitmap (random bits) here before
+	 * starting pthreads.
+	 */
+	for (i = 0; i < nr_bits; i++) {
+		if (should_mark_bit())
+			ext2fs_mark_generic_bmap(used_bitmap, i);
+	}
+}
+
+static void *run_pthread(void *arg)
+{
+	int i = 0, j = 0, start, end;
+	ext2fs_generic_bitmap test_bitmap;
+	errcode_t retval = 0;
+	pthread_t id = pthread_self();
+
+	if (pthread_equal(pthread_infos[0], id)) {
+		start = 0;
+		end = nr_bits/2;
+		test_bitmap = child_bitmap1;
+	} else {
+		start = nr_bits / 2 + 1;;
+		end = nr_bits - 1;
+		test_bitmap = child_bitmap2;
+	}
+
+	for (i = start; i <= end; i++) {
+		if (ext2fs_test_generic_bmap(used_bitmap, i)) {
+			retval = ext2fs_mark_generic_bmap(test_bitmap, i);
+			if (retval) {
+				com_err("run_pthread", retval, "while marking child bitmaps %d\n", i);
+				test_fail++;
+				pthread_exit(&retval);
+			}
+		}
+	}
+	return NULL;
+}
+
+void run_pthreads()
+{
+	errcode_t retval;
+	void *retp[2];
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
+	assert(ext2fs_merge_bitmap(child_bitmap1, parent_bitmap, NULL, NULL) == 0);
+	assert(ext2fs_merge_bitmap(child_bitmap2, parent_bitmap, NULL, NULL) == 0);
+}
+
+void test_bitmaps(int type)
+{
+	errcode_t retval;
+	retval = ext2fs_compare_generic_bmap(EXT2_ET_NEQ_BLOCK_BITMAP, parent_bitmap,
+				used_bitmap);
+	if (retval) {
+		test_fail++;
+		printf("Bitmaps compare failed for bitmap type %d err %ld\n", type, retval);
+		dump_bitmap(parent_bitmap, 0, nr_bits);
+		dump_bitmap(used_bitmap, 0, nr_bits);
+	}
+}
+
+void free_bitmaps()
+{
+	ext2fs_free_generic_bmap(child_bitmap1);
+	ext2fs_free_generic_bmap(child_bitmap2);
+	ext2fs_free_generic_bmap(parent_bitmap);
+	ext2fs_free_generic_bmap(used_bitmap);
+}
+
+int main(int argc, char *argv[])
+{
+	int i;
+	int ret = 0;
+
+#ifndef HAVE_PTHREAD
+	printf("No PTHREAD support, exiting...\n");
+	return ret;
+#endif
+
+	srand(time(0));
+
+	/* loop to test for bitmap types */
+	for (i = 0; i < 1; i++) {
+		test_fail = 0;
+		alloc_bitmaps(bitmap_type[i]);
+		setup_bitmaps();
+		run_pthreads();
+		test_bitmaps(bitmap_type[i]);
+		free_bitmaps();
+
+		if (test_fail)
+			printf("%s: Test with bitmap (%d) NOT OK!!\n", argv[0], bitmap_type[i]);
+		else
+			printf("%s: Test with bitmap (%d) OK!!\n", argv[0], bitmap_type[i]);
+		ret |= test_fail;
+	}
+
+	return ret;
+}
-- 
2.37.3

