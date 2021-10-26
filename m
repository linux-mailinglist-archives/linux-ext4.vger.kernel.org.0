Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9743B9CF
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 20:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbhJZSp5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Oct 2021 14:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbhJZSp5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Oct 2021 14:45:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C7DC061745
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 11:43:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 484C31F43877;
        Tue, 26 Oct 2021 19:43:31 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ltp@lists.linux.it, jack@suse.com, amir73il@gmail.com
Cc:     khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 03/10] syscalls/fanotify20: Introduce helpers for FAN_FS_ERROR test
Date:   Tue, 26 Oct 2021 15:42:32 -0300
Message-Id: <20211026184239.151156-4-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026184239.151156-1-krisman@collabora.com>
References: <20211026184239.151156-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

fanotify20 is a new test validating the FAN_FS_ERROR file system error
event.  This adds some basic structure for the next patches.

The strategy for error reporting testing in fanotify20 goes like this:

  - Generate a broken filesystem
  - Start FAN_FS_ERROR monitoring group
  - Make the file system  notice the error through ordinary operations
  - Observe the event generated

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - Move defines to header file.
---
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |   3 +
 .../kernel/syscalls/fanotify/fanotify20.c     | 128 ++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify20.c

diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index 9554b16b196e..c99e6fff76d6 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -17,4 +17,5 @@
 /fanotify17
 /fanotify18
 /fanotify19
+/fanotify20
 /fanotify_child
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index b2b56466d028..8828b53532a2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -124,6 +124,9 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #ifndef FAN_OPEN_EXEC_PERM
 #define FAN_OPEN_EXEC_PERM	0x00040000
 #endif
+#ifndef FAN_FS_ERROR
+#define FAN_FS_ERROR		0x00008000
+#endif
 
 /* Flags required for unprivileged user group */
 #define FANOTIFY_REQUIRED_USER_INIT_FLAGS    (FAN_REPORT_FID)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
new file mode 100644
index 000000000000..7a522aad4386
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Collabora Ltd.
+ *
+ * Author: Gabriel Krisman Bertazi <gabriel@krisman.be>
+ * Based on previous work by Amir Goldstein <amir73il@gmail.com>
+ */
+
+/*\
+ * [Description]
+ * Check fanotify FAN_ERROR_FS events triggered by intentionally
+ * corrupted filesystems:
+ *
+ * - Generate a broken filesystem
+ * - Start FAN_FS_ERROR monitoring group
+ * - Make the file system notice the error through ordinary operations
+ * - Observe the event generated
+ */
+
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <stdio.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/syscall.h>
+#include "tst_test.h"
+#include <sys/fanotify.h>
+#include <sys/types.h>
+#include <fcntl.h>
+
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
+
+#define BUF_SIZE 256
+static char event_buf[BUF_SIZE];
+int fd_notify;
+
+#define MOUNT_PATH "test_mnt"
+
+static struct test_case {
+	char *name;
+	void (*trigger_error)(void);
+} testcases[] = {
+};
+
+int check_error_event_metadata(struct fanotify_event_metadata *event)
+{
+	int fail = 0;
+
+	if (event->mask != FAN_FS_ERROR) {
+		fail++;
+		tst_res(TFAIL, "got unexpected event %llx",
+			(unsigned long long)event->mask);
+	}
+
+	if (event->fd != FAN_NOFD) {
+		fail++;
+		tst_res(TFAIL, "Weird FAN_FD %llx",
+			(unsigned long long)event->mask);
+	}
+	return fail;
+}
+
+void check_event(char *buf, size_t len, const struct test_case *ex)
+{
+	struct fanotify_event_metadata *event =
+		(struct fanotify_event_metadata *) buf;
+
+	if (len < FAN_EVENT_METADATA_LEN) {
+		tst_res(TFAIL, "No event metadata found");
+		return;
+	}
+
+	if (check_error_event_metadata(event))
+		return;
+
+	tst_res(TPASS, "Successfully received: %s", ex->name);
+}
+
+static void do_test(unsigned int i)
+{
+	const struct test_case *tcase = &testcases[i];
+	size_t read_len;
+
+	tcase->trigger_error();
+
+	read_len = SAFE_READ(0, fd_notify, event_buf, BUF_SIZE);
+
+	check_event(event_buf, read_len, tcase);
+}
+
+static void setup(void)
+{
+	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
+						FAN_MARK_FILESYSTEM,
+						FAN_FS_ERROR, ".");
+
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
+				       O_RDONLY);
+
+	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
+			   FAN_FS_ERROR, AT_FDCWD, MOUNT_PATH);
+}
+
+static void cleanup(void)
+{
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
+}
+
+static struct tst_test test = {
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(testcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.mount_device = 1,
+	.mntpoint = MOUNT_PATH,
+	.all_filesystems = 0,
+	.needs_root = 1,
+	.dev_fs_type = "ext4"
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
-- 
2.33.0

