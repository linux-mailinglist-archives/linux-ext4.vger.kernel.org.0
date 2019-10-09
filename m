Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A92DD058F
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2019 04:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfJICmo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Oct 2019 22:42:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42796 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJICmo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Oct 2019 22:42:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id f16so835007qkl.9
        for <linux-ext4@vger.kernel.org>; Tue, 08 Oct 2019 19:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=o11X3jQOdAg7GU0NKo+NL/9277taGfyioI1ZvF1fdf8=;
        b=jUsRgzdlQTXaOALVWTVkL0xRNJaAFWMBj/X2Fni5Oe5hkDxLeSEVZG1Sl7NCjImaGC
         rb/EwiDg4+JkFashyoKZLbphWaIlQyrsw8UUAyp8/lKfnxB7nx82AzPvsk1YVY/5vyl2
         kms830gGyYbVv3znChAWuFRADOmwxJ4F9XVe0yxs6sarYIarZyblUS9Gh1Z0Fgdsq3zC
         ERU+R/SDwnzflnToG8kxDYM/q8BRTOL9j4n1NH47vI3OIj3A6N7w6/iu/hhR8BojF4pe
         1vB2FporCviknLgitQFSq7/CEDFXnsBD17LGPdqQ4pOxkmdVAHcBAGs0G6Azwow4MUHU
         RLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=o11X3jQOdAg7GU0NKo+NL/9277taGfyioI1ZvF1fdf8=;
        b=LGpWzG27V5WLBgB+RE4YFAwXU+XRynkPaO7Mltpg6mCbqMiU2OutXG1V4agaMaEgyv
         MJ+q36m8UXIShyzRY8topJpubLKyUOGvuLopJ/lfaGlm3n/TJ1tef0I5WvhPVimWyW1g
         xQ9YHDI6QwWa7iEqdkjAV6XvnRJnK//81rPAPs1b8mEdro9Crwz1WO3SbswbWXKhxtd0
         HRw5lOMO3EvAaLdBsUbpXqfDGOWB75N1tCv7cNNAc8Xmb80xmgfQCAx7ScCCrqOCs4n0
         Z0w+I6LdW+NWfOkzGtQP388yCz9iLtNsO++iEkvzCpzvXO7sjPc4+6UpLp0Q/yYGwp8T
         gjDA==
X-Gm-Message-State: APjAAAXPFAR68HBbDTun31A9YzGYJw4jd9XxEwnugj+k0o0xTIYDl9xy
        lgy5OtHX5TjSQ7NCB2raeXGZ5S8JCJy5U2ot2dBo
X-Google-Smtp-Source: APXvYqxeXb8QNtuVzu/XmEO1Q5zkgvIfrZ7QWvobPXDkVR0RfTFaLJnYCxKEPExM8U0b4HLDbdFeAl3u3LeILJqRt2A=
X-Received: by 2002:a37:a1c7:: with SMTP id k190mr1433960qke.289.1570588962459;
 Tue, 08 Oct 2019 19:42:42 -0700 (PDT)
MIME-Version: 1.0
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Tue, 8 Oct 2019 19:42:05 -0700
Message-ID: <CAAXuY3rcz78vxvXbvg+wjFBFonmOx9dfweo3od6U6TaT8JVHsQ@mail.gmail.com>
Subject: [PATCH v1] fs/ext4/inode-test: KUnit test for ext4 inode.
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        skhan@linuxfoundation.org, "Theodore Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca
Cc:     kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Note: this patch is intended to be applied against kselftest/test branch:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test

KUnit tests for decoding extended 64 bit timestamps.

Signed-off-by: Iurii Zaikin <yzaikin@google.com>
---
 fs/ext4/Kconfig      |  12 +++
 fs/ext4/Makefile     |   1 +
 fs/ext4/inode-test.c | 217 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 fs/ext4/inode-test.c

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index cbb5ca830e57..72c26abbce4c 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -106,3 +106,15 @@ config EXT4_DEBUG
   If you select Y here, then you will be able to turn on debugging
   with a command such as:
  echo 1 > /sys/module/ext4/parameters/mballoc_debug
+
+config EXT4_INODE_KUNIT_TEST
+ bool "KUnit test for ext4 inode"
+ depends on EXT4_FS
+ depends on KUNIT
+ help
+  This builds the ext4 inode sysctl unit test, which runs on boot.
+  Tests the encoding correctness of ext4 inode.
+  For more information on KUnit and unit tests in general please refer
+  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+  If unsure, say N.
diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index b17ddc229ac5..1eeb8b449255 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -13,4 +13,5 @@ ext4-y := balloc.o bitmap.o block_validity.o dir.o
ext4_jbd2.o extents.o \

 ext4-$(CONFIG_EXT4_FS_POSIX_ACL) += acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY) += xattr_security.o
+ext4-$(CONFIG_EXT4_INODE_KUNIT_TEST) += inode-test.o
 ext4-$(CONFIG_FS_VERITY) += verity.o
diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
new file mode 100644
index 000000000000..0ecb8dd5e0c5
--- /dev/null
+++ b/fs/ext4/inode-test.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test of ext4 inode.
+ */
+
+#include <kunit/test.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+
+#include "ext4.h"
+
+// binary: 00000000 00000000 00000000 00000000
+#define LOWER_MSB_0 0L
+// binary: 01111111 11111111 11111111 11111111
+#define UPPER_MSB_0 0x7fffffffL
+// binary: 10000000 00000000 00000000 00000000
+#define LOWER_MSB_1 (-0x80000000L)
+// binary: 11111111 11111111 11111111 11111111
+#define UPPER_MSB_1 (-1L)
+
+#define CASE_NAME_FORMAT "%s: msb:%x lower_bound:%x extra_bits: %x"
+
+struct timestamp_expectation {
+ const char *test_case_name;
+ struct timespec64 expected;
+ u32 extra_bits;
+ bool msb_set;
+ bool lower_bound;
+};
+
+static time64_t get_32bit_time(const struct timestamp_expectation * const test)
+{
+ if (test->msb_set) {
+ if (test->lower_bound)
+ return LOWER_MSB_1;
+
+ return UPPER_MSB_1;
+ }
+
+ if (test->lower_bound)
+ return LOWER_MSB_0;
+ return UPPER_MSB_0;
+}
+
+
+static void inode_test_xtimestamp_decoding(struct kunit *test)
+{
+ const struct timestamp_expectation test_data[] = {
+ {
+ .test_case_name = "1901-12-13",
+ .msb_set = true,
+ .lower_bound = true,
+ .extra_bits = 0,
+ .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
+ },
+
+ {
+ .test_case_name = "1969-12-31",
+ .msb_set = true,
+ .lower_bound = false,
+ .extra_bits = 0,
+ .expected = {.tv_sec = -1LL, .tv_nsec = 0L},
+ },
+
+ {
+ .test_case_name = "1970-01-01",
+ .msb_set = false,
+ .lower_bound = true,
+ .extra_bits = 0,
+ .expected = {0LL, 0L},
+ },
+
+ {
+ .test_case_name = "2038-01-19",
+ .msb_set = false,
+ .lower_bound = false,
+ .extra_bits = 0,
+ .expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
+ },
+
+ {
+ .test_case_name = "2038-01-19",
+ .msb_set = true,
+ .lower_bound = true,
+ .extra_bits = 1,
+ .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
+ },
+
+ {
+ .test_case_name = "2106-02-07",
+ .msb_set = true,
+ .lower_bound = false,
+ .extra_bits = 1,
+ .expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
+ },
+
+ {
+ .test_case_name = "2106-02-07",
+ .msb_set = false,
+ .lower_bound = true,
+ .extra_bits = 1,
+ .expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0LL},
+ },
+
+ {
+ .test_case_name = "2174-02-25",
+ .msb_set = false,
+ .lower_bound = false,
+ .extra_bits = 1,
+ .expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
+ },
+
+ {
+ .test_case_name = "2174-02-25",
+ .msb_set = true,
+ .lower_bound = true,
+ .extra_bits =  2,
+ .expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
+ },
+
+ {
+ .test_case_name = "2242-03-16",
+ .msb_set = true,
+ .lower_bound = false,
+ .extra_bits = 2,
+ .expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
+ },
+
+ {
+ .test_case_name = "2242-03-16",
+ .msb_set = false,
+ .lower_bound = true,
+ .extra_bits = 2,
+ .expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
+ },
+
+ {
+ .test_case_name = " 2310-04-04",
+ .msb_set = false,
+ .lower_bound = false,
+ .extra_bits = 2,
+ .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
+ },
+
+ /* TODO: enable when legacy encoding in ext4.h is disabled.
+ *{
+ * .test_case_name = "2310-04-04",
+ * .msb_set = true,
+ * .lower_bound = true,
+ * .extra_bits = 3,
+ * .expected = {.tv_sec = 0x280000000LL, .tv_nsec = 0L},
+ *},
+ *
+ *{
+ * .test_case_name = "2378-04-22",
+ * .msb_set = true,
+ * .lower_bound = false,
+ * .extra_bits = 3,
+ * .expected = {.tv_sec = 0x2ffffffffLL, .tv_nsec = 0L},
+ * },
+ */
+
+ {
+ .test_case_name = "2378-04-22",
+ .msb_set = false,
+ .lower_bound = true,
+ .extra_bits = 3,
+ .expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
+ },
+
+ {
+ .test_case_name = "2446-05-10",
+ .msb_set = false,
+ .lower_bound = false,
+ .extra_bits = 3,
+ .expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
+ }
+ };
+
+ struct timespec64 timestamp;
+ int i;
+
+ for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
+ timestamp.tv_sec = get_32bit_time(&test_data[i]);
+ ext4_decode_extra_time(&timestamp,
+       cpu_to_le32(test_data[i].extra_bits));
+
+ KUNIT_EXPECT_EQ_MSG(test,
+    test_data[i].expected.tv_sec,
+    timestamp.tv_sec,
+    CASE_NAME_FORMAT,
+    test_data[i].test_case_name,
+    test_data[i].msb_set,
+    test_data[i].lower_bound,
+    test_data[i].extra_bits);
+ KUNIT_EXPECT_EQ_MSG(test,
+    test_data[i].expected.tv_nsec,
+    timestamp.tv_nsec,
+    CASE_NAME_FORMAT,
+    test_data[i].test_case_name,
+    test_data[i].msb_set,
+    test_data[i].lower_bound,
+    test_data[i].extra_bits);
+ }
+}
+
+static struct kunit_case ext4_inode_test_cases[] = {
+ KUNIT_CASE(inode_test_xtimestamp_decoding),
+ {}
+};
+
+static struct kunit_suite ext4_inode_test_suite = {
+ .name = "ext4_inode_test",
+ .test_cases = ext4_inode_test_cases,
+};
+
+kunit_test_suite(ext4_inode_test_suite);
--
2.23.0.700.g56cf767bdb-goog
