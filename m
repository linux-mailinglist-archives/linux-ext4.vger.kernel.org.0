Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F82D34A0
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2019 01:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfJJXug (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Oct 2019 19:50:36 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39442 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfJJXug (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Oct 2019 19:50:36 -0400
Received: by mail-pg1-f202.google.com with SMTP id m20so5576954pgv.6
        for <linux-ext4@vger.kernel.org>; Thu, 10 Oct 2019 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7XYBq/ZVaQ3cNSK/bYc1ZAbB1V8GrO2LKn6yNgHPOto=;
        b=erUEtfIrecHA+LlNk3yPlFLl5/CcgNS/YRSIgUQNFA66wZOb4/FcYUh7ezVBmrRNZL
         tjddU+Jkw/CB2uUAPcOQ+a++flRzw/sUFBZB5cMEhrk87+QtqhQLRrRZeJeTPIHV6QIb
         UymPtjDYEY5x52TYBJ3jycoMlpA827h3+R9hufzD+KR0kqn77140eLdNU49bJJj+GwvJ
         XPGGOYn8dytL4PoRwm5cA760/2Mu/MOp1crhz/Gv+KHXzdRHpD/AIhrahGDaEAuXUMO5
         gnn1gx9xZlLjogaVVNEWE724FdSRxo/t8YaayxIUUdgUYgpjSAkR8tQR9Auvcym7jlPH
         RKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7XYBq/ZVaQ3cNSK/bYc1ZAbB1V8GrO2LKn6yNgHPOto=;
        b=k/ZjC4YzbKijhwaG+jE1RpHgAZ6ZX4D8yL5H67Cej9Sh4ieMdnPS8cvDSyd0OD8+cj
         x/EVVvxqXcuCbsTy/sEhGVtni9dEZOUIwPQPafvk4k2fhLaAqpGILJCOecKKdWoh7FLZ
         6/0PFO1nakMfoXMT6cMMn/CviE9NEssh6b6APqez5HNlpmD3c+Z1jMXFBzZMHzXOHzU6
         7I91ZExvgIryaSKR7UmRzkO27QDWlDyooo7nOs0B0xq+DDKwetuE8Xhw2XGafkw4B/6w
         48pyAbE91eg0z41I9Isk4mOifwVmL/zpndvtdmb0e1J0ZWzfMXpbq2xmfAr2QpC5ZC6k
         7jqA==
X-Gm-Message-State: APjAAAVopXUjKEgXI1sMtV9gmsvd/+pDf1oiT0csQmbPSnlbsnUM5gSR
        WjuP0J845H0ygxwFJwiOWBP/IOY2kys=
X-Google-Smtp-Source: APXvYqwzY1PFk/dpmmqzG9XGrKzbJs1stgFEGwNVty8CRX6V5iOeC8eWSZKqgyhUkYqpoCI+Hm0xq3sqRFMc
X-Received: by 2002:a65:4846:: with SMTP id i6mr13568851pgs.243.1570751434993;
 Thu, 10 Oct 2019 16:50:34 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:50:30 -0700
Message-Id: <20191010235030.143567-1-yzaikin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH linux-kselftest/test v3] ext4: add kunit test for decoding
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
Test data is derive from the table under
Documentation/filesystems/ext4/inodes.rst Inode Timestamps.

Signed-off-by: Iurii Zaikin <yzaikin@google.com>
---
 fs/ext4/Kconfig      |  14 +++
 fs/ext4/Makefile     |   1 +
 fs/ext4/inode-test.c | 239 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 fs/ext4/inode-test.c

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index cbb5ca830e57..605c3d506934 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -106,3 +106,17 @@ config EXT4_DEBUG
 	  If you select Y here, then you will be able to turn on debugging
 	  with a command such as:
 		echo 1 > /sys/module/ext4/parameters/mballoc_debug
+
+config EXT4_KUNIT_TESTS
+	bool "KUnit test for ext4 inode"
+	depends on EXT4_FS
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
index b17ddc229ac5..a0588fd2eea6 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -13,4 +13,5 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \

 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
+ext4-$(CONFIG_EXT4_KUNIT_TESTS)	+= inode-test.o
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
new file mode 100644
index 000000000000..3b3a453ff382
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
+		"1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits.",
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits = 0,
+			.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+		"1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits.",
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 0,
+			.expected = {.tv_sec = -1LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+		"1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits.",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 0,
+			.expected = {0LL, 0L},
+		},
+
+		{
+			.test_case_name =
+		"2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits.",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 0,
+			.expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on.",
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on.",
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on.",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on.",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 1,
+			.expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on.",
+			.msb_set = true,
+			.lower_bound = true,
+			.extra_bits =  2,
+			.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on.",
+			.msb_set = true,
+			.lower_bound = false,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on.",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	  "2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on.",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 2,
+			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+"2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns bit 1.",
+			.msb_set = false,
+			.lower_bound = false,
+			.extra_bits = 6,
+			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
+		},
+
+		{
+			.test_case_name =
+"2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. ns bits 1.",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 0xFFFFFFFF,
+			.expected = {.tv_sec = 0x300000000LL,
+				     .tv_nsec = MAX_NANOSECONDS},
+		},
+
+		{
+			.test_case_name =
+	 "2378-04-22 Lower bound of 32bit >= timestamp. All extra sec bits on.",
+			.msb_set = false,
+			.lower_bound = true,
+			.extra_bits = 3,
+			.expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
+		},
+
+		{
+			.test_case_name =
+	"2446-05-10 Upper bound of 32bit >= timestamp. All extra sec bits on.",
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
2.23.0.700.g56cf767bdb-goog
