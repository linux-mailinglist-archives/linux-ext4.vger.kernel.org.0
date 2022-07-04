Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53613564E4C
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiGDHI0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiGDHIG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:08:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0146895A2
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:07:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b2so7789712plx.7
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QPlUiufE0YRDSo8ONY+aF6dkqDI+TIG/2Soo6iTm7c=;
        b=XBtZowNJx83BS+IFupUH2cFkTLbMlQ3g7ts++STl+8DxR2tzYfZ0aebaZbPOBuVx7y
         nhhbWyqyf0uywpzhojPg2xjar1gk6T51hEZ4XJas3fjo5cO725Z0ng6Iv2TN4iJbRs2S
         +/XHVIv5io9h98llNeh+1oB5rQ+hL1qnITmxBjkw9ZlsPwN99SXu/uQfWuNCBXQ/0UJf
         4toD3runmcKQ59xCX+EbqS+nJSgCCDHZ4dc8VpBGYXsPweWvrSTFFUEWxietb7UBcQhz
         lnjJE+EWPcLPc1JnL0v77SOJmVSd458tEtINYg0MGt+5lV3Fm/+PKzBFyR+/4XCKPnI7
         iuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QPlUiufE0YRDSo8ONY+aF6dkqDI+TIG/2Soo6iTm7c=;
        b=3R476obG+446NhFoYcM8bcyREmUqEOiZJczNtWIj7BS8V7gqFweebsmIQ90r2+X9OC
         OG5FHBX246eg8XAbQmmqcdATjj0jvgFUu6MXq9Tj21XRRoEn9JvLYz51yBxdB2W3V49u
         HZ6N+FGzk9//soSIqeBZMZvkaBtS38xV0losxTtc79Pamh+1CdEMBG2U93p2VlnRzdzQ
         xA5YAKRrRpmNvpgn1w7c3KBa+OHuSCm3aBTg3ZtjDLiTGLz9KAeCkFIJIaXIPkgh3jwd
         rNdeT30viATrVxnN6B90Bi79nrepE1iJu7bsj+qaZBgfKcwnuyFtcRbInGeHn9r4mJnJ
         wtsw==
X-Gm-Message-State: AJIora+KiuEseVRimYeXbFhchN32wTGlrbrd7+Nct9OqCaYHFm4XXMIn
        gZvhApHd0sawV+kn3QaiVfB9sd/Dg7g=
X-Google-Smtp-Source: AGRyM1vPrIsmNnJzKJtr5+SiaNnehCVG7XWbuqD/Q4xgVmntde8RT5yBy+RkGayYmPYYaQ3+htzNrw==
X-Received: by 2002:a17:90b:3784:b0:1ef:6b06:c4 with SMTP id mz4-20020a17090b378400b001ef6b0600c4mr14575655pjb.187.1656918475480;
        Mon, 04 Jul 2022 00:07:55 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902da8b00b0016be153af2bsm1711766plx.36.2022.07.04.00.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:07:55 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 08/13] tst_bitmaps_pthread: Add merge bitmaps test using pthreads
Date:   Mon,  4 Jul 2022 12:36:57 +0530
Message-Id: <89a325295a3e2916ca41af249911d5c91c33c2c6.1656912918.git.ritesh.list@gmail.com>
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

This patch adds a test to verify the core bitmaps merge APIs
for both bitarray and rbtree type.

Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
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
index 00000000..2ce389b0
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
+int bitmap_type[2] = {EXT2FS_BMAP64_BITARRAY, EXT2FS_BMAP64_RBTREE};
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
+	/* loop to test for both bitmap types */
+	for (i = 0; i < 2; i++) {
+		test_fail = 0;
+		alloc_bitmaps(i);
+		setup_bitmaps();
+		run_pthreads();
+		test_bitmaps(i);
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
2.35.3

