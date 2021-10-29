Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014814404C4
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Oct 2021 23:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJ2VUf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Oct 2021 17:20:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58394 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhJ2VUf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Oct 2021 17:20:35 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E8C511F45C6F;
        Fri, 29 Oct 2021 22:18:04 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com, repnop@google.com
Cc:     ltp@lists.linux.it, khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 2/9] syscalls: fanotify: Add macro to require specific events
Date:   Fri, 29 Oct 2021 18:17:25 -0300
Message-Id: <20211029211732.386127-3-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a helper for tests to fail if an event is not available in the
kernel.  Since some events only work with REPORT_FID or a specific
class, update the verifier to allow those to be specified.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - Use SAFE_FANOTIFY_INIT instead of open coding. (Amir)
  - Use FAN_CLASS_NOTIF for fanotify12 testcase. (Amir)
---
 testcases/kernel/syscalls/fanotify/fanotify.h   | 17 ++++++++++++++---
 testcases/kernel/syscalls/fanotify/fanotify03.c |  4 ++--
 testcases/kernel/syscalls/fanotify/fanotify10.c |  3 ++-
 testcases/kernel/syscalls/fanotify/fanotify12.c |  3 ++-
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index c67db3117e29..820073709571 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -266,14 +266,16 @@ static inline void require_fanotify_access_permissions_supported_by_kernel(void)
 	SAFE_CLOSE(fd);
 }
 
-static inline int fanotify_events_supported_by_kernel(uint64_t mask)
+static inline int fanotify_events_supported_by_kernel(uint64_t mask,
+						      unsigned int init_flags,
+						      unsigned int mark_flags)
 {
 	int fd;
 	int rval = 0;
 
-	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
+	fd = SAFE_FANOTIFY_INIT(init_flags, O_RDONLY);
 
-	if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
+	if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
 		if (errno == EINVAL) {
 			rval = -1;
 		} else {
@@ -378,4 +380,13 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
 				    fanotify_mark_supported_by_kernel(mark_type)); \
 } while (0)
 
+#define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
+	if (mark_type)							\
+		REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type);	\
+	if (init_flags)							\
+		REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
+	fanotify_init_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
+		fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
+} while (0)
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 26d17e64d1f5..2081f0bd1b57 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -323,8 +323,8 @@ static void setup(void)
 	require_fanotify_access_permissions_supported_by_kernel();
 
 	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
-	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM);
-
+	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM,
+								      FAN_CLASS_CONTENT, 0);
 	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 92e4d3ff3054..0fa9d1f4f7e4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -509,7 +509,8 @@ cleanup:
 
 static void setup(void)
 {
-	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
+	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
+								      FAN_CLASS_CONTENT, 0);
 	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
 	fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
 									  MOUNT_PATH);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index 76f1aca77615..c77dbfd8c23d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -222,7 +222,8 @@ cleanup:
 
 static void do_setup(void)
 {
-	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
+	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
+								      FAN_CLASS_NOTIF, 0);
 
 	sprintf(fname, "fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
-- 
2.33.0

