Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62764404C8
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Oct 2021 23:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhJ2VUs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Oct 2021 17:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhJ2VUr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Oct 2021 17:20:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E7EC061570
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 14:18:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C15AD1F45C6F;
        Fri, 29 Oct 2021 22:18:16 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com, repnop@google.com
Cc:     ltp@lists.linux.it, khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 4/9] syscalls/fanotify21: Validate the generic error info
Date:   Fri, 29 Oct 2021 18:17:27 -0300
Message-Id: <20211029211732.386127-5-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Implement some validation for the generic error info record emitted by
the kernel.  The error number is fs-specific but, well, we only support
ext4 for now anyway.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - check for error record type in autotools (Amir)
Changes since v1:
  - Move defines to header file.
---
 configure.ac                                  |  3 +-
 testcases/kernel/syscalls/fanotify/fanotify.h | 32 ++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify21.c     | 37 ++++++++++++++++++-
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5bf3c52ec161..9efd5b33430f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -159,7 +159,8 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
-AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
+AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
+		struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])
 AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct file_handle],,,[
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 99b898554ede..4294799fe86d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -167,6 +167,9 @@ typedef struct {
 #ifndef FAN_EVENT_INFO_TYPE_DFID
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #endif
+#ifndef FAN_EVENT_INFO_TYPE_ERROR
+#define FAN_EVENT_INFO_TYPE_ERROR	5
+#endif
 
 #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
 struct fanotify_event_info_header {
@@ -184,6 +187,14 @@ struct fanotify_event_info_fid {
 };
 #endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
 
+#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	__s32 error;
+	__u32 error_count;
+};
+#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR */
+
 /* NOTE: only for struct fanotify_event_info_fid */
 #ifdef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL
 # define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
@@ -392,4 +403,25 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
 		fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
 } while (0)
 
+struct fanotify_event_info_header *get_event_info(
+					struct fanotify_event_metadata *event,
+					int info_type)
+{
+	struct fanotify_event_info_header *hdr = NULL;
+	char *start = (char *) event;
+	int off;
+
+	for (off = event->metadata_len; (off+sizeof(*hdr)) < event->event_len;
+	     off += hdr->len) {
+		hdr = (struct fanotify_event_info_header *) &(start[off]);
+		if (hdr->info_type == info_type)
+			return hdr;
+	}
+	return NULL;
+}
+
+#define get_event_info_error(event)					\
+	((struct fanotify_event_info_error *)				\
+	 get_event_info((event), FAN_EVENT_INFO_TYPE_ERROR))
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 9ef687442b7c..31ad5cac0a0e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -48,14 +48,38 @@ static void trigger_fs_abort(void)
 
 static struct test_case {
 	char *name;
+	int error;
+	unsigned int error_count;
 	void (*trigger_error)(void);
 } testcases[] = {
 	{
 		.name = "Trigger abort",
 		.trigger_error = &trigger_fs_abort,
+		.error_count = 1,
+		.error = ESHUTDOWN,
 	},
 };
 
+int check_error_event_info_error(struct fanotify_event_info_error *info_error,
+				 const struct test_case *ex)
+{
+	int fail = 0;
+
+	if (info_error->error_count != ex->error_count) {
+		tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d)",
+			ex->name, info_error->error_count, ex->error_count);
+		fail++;
+	}
+
+	if (info_error->error != ex->error) {
+		tst_res(TFAIL, "%s: Unexpected error code value (%d!=%d)",
+			ex->name, info_error->error, ex->error);
+		fail++;
+	}
+
+	return fail;
+}
+
 int check_error_event_metadata(struct fanotify_event_metadata *event)
 {
 	int fail = 0;
@@ -78,6 +102,8 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 {
 	struct fanotify_event_metadata *event =
 		(struct fanotify_event_metadata *) buf;
+	struct fanotify_event_info_error *info_error;
+	int fail = 0;
 
 	if (len < FAN_EVENT_METADATA_LEN) {
 		tst_res(TFAIL, "No event metadata found");
@@ -87,7 +113,16 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 	if (check_error_event_metadata(event))
 		return;
 
-	tst_res(TPASS, "Successfully received: %s", ex->name);
+	info_error = get_event_info_error(event);
+	if (info_error)
+		fail += check_error_event_info_error(info_error, ex);
+	else {
+		tst_res(TFAIL, "Generic error record not found");
+		fail++;
+	}
+
+	if (!fail)
+		tst_res(TPASS, "Successfully received: %s", ex->name);
 }
 
 static void do_test(unsigned int i)
-- 
2.33.0

