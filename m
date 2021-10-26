Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB40D43B9D0
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 20:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbhJZSqD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Oct 2021 14:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbhJZSqD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Oct 2021 14:46:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590B7C061745
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 11:43:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CDB761F43877;
        Tue, 26 Oct 2021 19:43:37 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ltp@lists.linux.it, jack@suse.com, amir73il@gmail.com
Cc:     khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 04/10] syscalls/fanotify20: Validate the generic error info
Date:   Tue, 26 Oct 2021 15:42:33 -0300
Message-Id: <20211026184239.151156-5-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026184239.151156-1-krisman@collabora.com>
References: <20211026184239.151156-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Implement some validation for the generic error info record emitted by
the kernel.  The error number is fs-specific but, well, we only support
ext4 for now anyway.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - Move defines to header file.
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 32 +++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify20.c     | 35 ++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 8828b53532a2..58e30aaf00bc 100644
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
@@ -403,4 +414,25 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
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
diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 7a522aad4386..6074d449ae63 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -42,10 +42,32 @@ int fd_notify;
 
 static struct test_case {
 	char *name;
+	int error;
+	unsigned int error_count;
 	void (*trigger_error)(void);
 } testcases[] = {
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
@@ -68,6 +90,8 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 {
 	struct fanotify_event_metadata *event =
 		(struct fanotify_event_metadata *) buf;
+	struct fanotify_event_info_error *info_error;
+	int fail = 0;
 
 	if (len < FAN_EVENT_METADATA_LEN) {
 		tst_res(TFAIL, "No event metadata found");
@@ -77,7 +101,16 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
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

