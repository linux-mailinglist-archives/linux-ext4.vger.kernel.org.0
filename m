Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917E2D9C1D
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2019 22:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403762AbfJPU62 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Oct 2019 16:58:28 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34860 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfJPU62 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Oct 2019 16:58:28 -0400
Received: by mail-pg1-f201.google.com with SMTP id s1so117496pgm.2
        for <linux-ext4@vger.kernel.org>; Wed, 16 Oct 2019 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/EAnK9mVP5VpM5sGIwj5LYu1ZBRvQtiCnXhFbzBw3r4=;
        b=q1h7wztqPVFQlE/b5zALy/t/ZvOUBRjhRD3hrQIpz5dF+WAGbjoGCN37p6Y9eAlt8/
         TM6Gz36mlQolwokARs4gogzsAA6bGXQosPpjeymA2HrpkXvqY/LqmQ9oqwCU9rbbUqiK
         lYBDxRufOi7ZzJRR30VJznFMJHmrLSX6q2Sk2VKrpt8idaarvxJYj2+FdbzZh5NI61tD
         mFAy1BcyXf1L74ZHmCEa3WhH065ud6SqaTf5P7oSqP8ZbSuW7m6mNhmGVJLzwSWFlovJ
         7dCX6YJ5kQjLTBZMz+k3z8Lwk3r8WySydKqSvl2RnRDURszjRe0hqtS4aD3Ovv0UJfsa
         9BSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/EAnK9mVP5VpM5sGIwj5LYu1ZBRvQtiCnXhFbzBw3r4=;
        b=pqeWJxTOW7IHAjQQvNKjy7SpatKOF8Ri0SYz5ipNGc1ISfQLpGPV+BBgjTvfTg0n2b
         AmY6dAb6uFYDYpeF1+iPOMogt7PJYr7McR4BwNh1xC1Cioyah0vIdToqziRnE2fkij2R
         Y2sSMz/qqqyDwQbx+g4x5yAb5C6b0EnHCLiZPGM9bxjnhaV3qqzQrMikot7vz9rUg/qL
         1r6ympYMu51yeyjbQRMB9OAXeoPISmEu0BgfJ6SvEcleWpdJE1AknWn3dQ4Iu4kblCCo
         rXcUGv4l8glCXRbe/KvtubHnRz+FLFbLMk+ilwzCKxvnlU+B5jU9t1Mc8zGTofZT/x8u
         0nNA==
X-Gm-Message-State: APjAAAXbqFBy6z9IEPOpkmWffHvYSvTWOz2b4I/rjzVzMUrf4j3q1jRf
        T1CFru/OCIf4dI1ZlvwS5evNC30yfVg=
X-Google-Smtp-Source: APXvYqzIrNWJivMfq8gKmkBfx1cQNb5gj8aYmEoGbEgFsa0hU1gHJK/UwOqwu+w9OchkXOnViBnX4UMoMOUi
X-Received: by 2002:a63:f5a:: with SMTP id 26mr122217pgp.63.1571259504907;
 Wed, 16 Oct 2019 13:58:24 -0700 (PDT)
Date:   Wed, 16 Oct 2019 13:58:20 -0700
Message-Id: <20191016205820.164985-1-yzaikin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH linux-kselftest/test v5] ext4: add kunit test for decoding
 extended timestamps
From:   Iurii Zaikin <yzaikin@google.com>
To:     linux-kselftest@vger.kernel.org, linux-ext4@vger.kernel.org,
        skhan@linuxfoundation.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Tim.Bird@sony.com
Cc:     kunit-dev@googlegroups.com, brendanhiggins@google.com,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

KUnit tests for decoding extended 64 bit timestamps
that verify the seconds part of [a/c/m]
timestamps in ext4 inode structs are decoded correctly.
KUnit tests, which run on boot and output
the results to the debug log in TAP format (http://testanything.org/).
are only useful for kernel devs running KUnit test harness. Not for
inclusion into a production build.
Test data is derived from the table under
Documentation/filesystems/ext4/inodes.rst Inode Timestamps.

Signed-off-by: Iurii Zaikin <yzaikin@google.com>
---
 fs/ext4/Kconfig      |  14 +++
 fs/ext4/Makefile     |   1 +
 fs/ext4/inode-test.c | 239 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 fs/ext4/inode-test.c

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index cbb5ca830e57..f13dde8ed92b 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -106,3 +106,17 @@ config EXT4_DEBUG
 	  If you select Y here, then you will be able to turn on debugging
 	  with a command such as:
 		echo 1 > /sys/module/ext4/parameters/mballoc_debug
+
+config EXT4_KUNIT_TESTS
+	bool "KUnit tests for ext4"
+	select EXT4_FS
+	depends on KUNIT
+	help
+	  This builds the ext4 KUnit tests, which run on boot and output
+	  the results to the debug log in TAP format (http://testanything.org/).
+	  Only useful for kernel devs running KUnit test harness. Not for
+	  inclusion into a production build.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index b17ddc229ac5..840b91d040f1 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -13,4 +13,5 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \

 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
+ext4-$(CONFIG_EXT4_KUNIT_TESTS)		+= inode-test.o
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
new file mode 100644
index 000000000000..1f2c486bc1c2
--- /dev/null
+++ b/fs/ext4/inode-test.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test of ext4 inode that verify the seconds part of [a/c/m]
+ * timestamps in ext4 inode structs are decoded correctly.
+ */
+
+#include <kunit/test.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+
+#include "ext4.h"
+
+/* binary: 00000000 00000000 00000000 00000000 */
+#define LOWER_MSB_0 0L
+/* binary: 01111111 11111111 11111111 11111111 */
+#define UPPER_MSB_0 0x7fffffffL
+/* binary: 10000000 00000000 00000000 00000000 */
+#define LOWER_MSB_1 (-0x80000000L)
+/* binary: 11111111 11111111 11111111 11111111 */
+#define UPPER_MSB_1 (-1L)
+/* binary: 00111111 11111111 11111111 11111111 */
+#define MAX_NANOSECONDS ((1L << 30) - 1)
+
+#define CASE_NAME_FORMAT "%s: msb:%x lower_bound:%x extra_bits: %x"
+
+struct timestamp_expectation {
+	const char *test_case_name;
+	struct timespec64 expected;
+	u32 extra_bits;
+	bool msb_set;
+	bool lower_bound;
+};
+
+static time64_t get_32bit_time(const struct timestamp_expectation * const test)
+{
+	if (test->msb_set) {
+		if (test->lower_bound)
+			return LOWER_MSB_1;
+
+		return UPPER_MSB_1;
+	}
+
+	if (test->lower_bound)
+		return LOWER_MSB_0;
+	return UPPER_MSB_0;
+}
+
+
+/*
+ * These tests are derived from the table under
+ * Documentation/filesystems/ext4/inodes.rst Inode Timestamps
+ */
+static void inode_test_xtimestamp_decoding(struct kunit *test)
+{
+	const struct timestamp_expectation test_data[] = {
+		{
+			.test_case_name =
+		"1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits",
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits = 0,
+			.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+		"1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits",
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 0,
+			.expected = {.tv_sec = -1LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+		"1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 0,
+			.expected = {0LL, 0L},
+		},
+
+		{
+			.test_case_name =
+		"2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 0,
+			.expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on",
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on",
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on",
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits =  2,
+			.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on",
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+"2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns bit 1",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 6,
+			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
+		},
+
+		{
+			.test_case_name =
+"2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. ns bits 1",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 0xFFFFFFFF,
+			.expected = {.tv_sec = 0x300000000LL,
+				     .tv_nsec = MAX_NANOSECONDS},
+		},
+
+		{
+			.test_case_name =
+	 "2378-04-22 Lower bound of 32bit >= timestamp. All extra sec bits on",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 3,
+			.expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2446-05-10 Upper bound of 32bit >= timestamp. All extra sec bits on",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 3,
+			.expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
+		}
+	};
+
+	struct timespec64 timestamp;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
+		timestamp.tv_sec = get_32bit_time(&test_data[i]);
+		ext4_decode_extra_time(&timestamp,
+				       cpu_to_le32(test_data[i].extra_bits));
+
+		KUNIT_EXPECT_EQ_MSG(test,
+				    test_data[i].expected.tv_sec,
+				    timestamp.tv_sec,
+				    CASE_NAME_FORMAT,
+				    test_data[i].test_case_name,
+				    test_data[i].msb_set,
+				    test_data[i].lower_bound,
+				    test_data[i].extra_bits);
+		KUNIT_EXPECT_EQ_MSG(test,
+				    test_data[i].expected.tv_nsec,
+				    timestamp.tv_nsec,
+				    CASE_NAME_FORMAT,
+				    test_data[i].test_case_name,
+				    test_data[i].msb_set,
+				    test_data[i].lower_bound,
+				    test_data[i].extra_bits);
+	}
+}
+
+static struct kunit_case ext4_inode_test_cases[] = {
+	KUNIT_CASE(inode_test_xtimestamp_decoding),
+	{}
+};
+
+static struct kunit_suite ext4_inode_test_suite = {
+	.name = "ext4_inode_test",
+	.test_cases = ext4_inode_test_cases,
+};
+
+kunit_test_suite(ext4_inode_test_suite);
--
2.23.0.866.gb869b98d4c-goog
