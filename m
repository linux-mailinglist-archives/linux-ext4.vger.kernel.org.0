Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20EA4566B4
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 00:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhKSABC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Nov 2021 19:01:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39736 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhKSABB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Nov 2021 19:01:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8EE8B1F47098
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637279879; bh=rwtNSWvQX+7xmt4GpPOTiL9OPrYhl410OyKlms/69DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lczo/mflAaBuy9MpBNjiu1SuW4YKg7VGHA/bCkH9Vys8R37xu7W3qcTj2F/iEDNdO
         17v1fmFGUNlVtm5S/hsnXfG5oAFf61SrA3csMsiRwgJsDHYC3o0Pk/Ggz5B7wb4lw8
         qyR45NZfZKBw3aVElhADXqKyG3nfXo3/IUbc7D1EkkmR7mx/4+VBsFVvADOXXy/9TJ
         uuRZkia7WI8pBPBmbmx79lewEY4CLFG83mToVT9KAb37eb+o8sQTV4lFRZ0dfFtWzP
         Ak/W9uR332SSRUpETuWb5++pozDBHWeXAnMcWqPj07njWDdSkB0+88JVmADS6mt6KH
         CY1Jt2QbmF1lQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     pvorel@suse.cz, jack@suse.com, amir73il@gmail.com,
        repnop@google.com
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com,
        khazhy@google.com, ltp@lists.linux.it,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v4 2/9] syscalls: fanotify: Add macro to require specific events
Date:   Thu, 18 Nov 2021 18:57:37 -0500
Message-Id: <20211118235744.802584-3-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118235744.802584-1-krisman@collabora.com>
References: <20211118235744.802584-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a helper for tests to fail if an event is not available in the
kernel.  Since some events only work with REPORT_FID or a specific
class, update the verifier to allow those to be specified.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Matthew Bobrowski <repnop@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
If I understand correctly, the decision was to leave fanotify10
unchanged and this is what I've done here.

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
index b9f430fe0c35..242245826004 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -287,14 +287,16 @@ static inline void require_fanotify_access_permissions_supported_by_kernel(void)
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
@@ -404,4 +406,13 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
 				    fanotify_mark_supported_by_kernel(mark_type)); \
 } while (0)
 
+#define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
+	if (mark_type)							\
+		REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL(mark_type);	\
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

