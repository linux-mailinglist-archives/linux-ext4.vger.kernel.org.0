Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674264404CA
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Oct 2021 23:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhJ2VU6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Oct 2021 17:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhJ2VUx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Oct 2021 17:20:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECADC061570
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 14:18:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3F7261F45C6F;
        Fri, 29 Oct 2021 22:18:22 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com, repnop@google.com
Cc:     ltp@lists.linux.it, khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 5/9] syscalls/fanotify21: Validate incoming FID in FAN_FS_ERROR
Date:   Fri, 29 Oct 2021 18:17:28 -0300
Message-Id: <20211029211732.386127-6-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Verify the FID provided in the event.  If the FH has size 0, this is
assumed to be a superblock error (i.e. null FH).

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Move FILEID_INVALID define to header file (Amir)
Changes since v1:
  - Move defines to header file.
  - Use 0-len FH for sb error
---
 testcases/kernel/syscalls/fanotify/fanotify.h |  9 +++
 .../kernel/syscalls/fanotify/fanotify21.c     | 60 +++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 4294799fe86d..f8c39aa490ae 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -234,6 +234,11 @@ static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
 	}
 }
 
+
+#ifndef FILEID_INVALID
+#define	FILEID_INVALID		0xff
+#endif
+
 struct fanotify_fid_t {
 	__kernel_fsid_t fsid;
 	struct file_handle handle;
@@ -424,4 +429,8 @@ struct fanotify_event_info_header *get_event_info(
 	((struct fanotify_event_info_error *)				\
 	 get_event_info((event), FAN_EVENT_INFO_TYPE_ERROR))
 
+#define get_event_info_fid(event)					\
+	((struct fanotify_event_info_fid *)				\
+	 get_event_info((event), FAN_EVENT_INFO_TYPE_FID))
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 31ad5cac0a0e..95c988821a34 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -40,6 +40,9 @@ int fd_notify;
 
 #define MOUNT_PATH "test_mnt"
 
+/* These expected FIDs are common to multiple tests */
+static struct fanotify_fid_t null_fid;
+
 static void trigger_fs_abort(void)
 {
        SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
@@ -50,6 +53,7 @@ static struct test_case {
 	char *name;
 	int error;
 	unsigned int error_count;
+	struct fanotify_fid_t *fid;
 	void (*trigger_error)(void);
 } testcases[] = {
 	{
@@ -57,9 +61,43 @@ static struct test_case {
 		.trigger_error = &trigger_fs_abort,
 		.error_count = 1,
 		.error = ESHUTDOWN,
+		.fid = &null_fid,
 	},
 };
 
+int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
+				 const struct test_case *ex)
+{
+	struct file_handle *fh = (struct file_handle *) &fid->handle;
+
+	if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
+		tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
+			ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
+			FSID_VAL_MEMBER(ex->fid->fsid, 0));
+
+		return 1;
+	}
+	if (fh->handle_type != ex->fid->handle.handle_type) {
+		tst_res(TFAIL, "%s: Received bad file_handle type (%d!=%d)",
+			ex->name, fh->handle_type, ex->fid->handle.handle_type);
+		return 1;
+	}
+
+	if (fh->handle_bytes != ex->fid->handle.handle_bytes) {
+		tst_res(TFAIL, "%s: Received bad file_handle len (%d!=%d)",
+			ex->name, fh->handle_bytes, ex->fid->handle.handle_bytes);
+		return 1;
+	}
+
+	if (memcmp(fh->f_handle, ex->fid->handle.f_handle, fh->handle_bytes)) {
+		tst_res(TFAIL, "%s: Received wrong handle. "
+			"Expected (%x...) got (%x...) ", ex->name,
+			*(int*)ex->fid->handle.f_handle, *(int*)fh->f_handle);
+		return 1;
+	}
+	return 0;
+}
+
 int check_error_event_info_error(struct fanotify_event_info_error *info_error,
 				 const struct test_case *ex)
 {
@@ -103,6 +141,7 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 	struct fanotify_event_metadata *event =
 		(struct fanotify_event_metadata *) buf;
 	struct fanotify_event_info_error *info_error;
+	struct fanotify_event_info_fid *info_fid;
 	int fail = 0;
 
 	if (len < FAN_EVENT_METADATA_LEN) {
@@ -121,6 +160,14 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 		fail++;
 	}
 
+	info_fid = get_event_info_fid(event);
+	if (info_fid)
+		fail += check_error_event_info_fid(info_fid, ex);
+	else {
+		tst_res(TFAIL, "FID record not found");
+		fail++;
+	}
+
 	if (!fail)
 		tst_res(TPASS, "Successfully received: %s", ex->name);
 }
@@ -143,12 +190,25 @@ static void do_test(unsigned int i)
 	check_event(event_buf, read_len, tcase);
 }
 
+static void init_null_fid(void)
+{
+	/* Use fanotify_save_fid to fill the fsid and overwrite the
+	 * file_handler to create a null_fid
+	 */
+	fanotify_save_fid(MOUNT_PATH, &null_fid);
+
+	null_fid.handle.handle_type = FILEID_INVALID;
+	null_fid.handle.handle_bytes = 0;
+}
+
 static void setup(void)
 {
 	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 						FAN_MARK_FILESYSTEM,
 						FAN_FS_ERROR, ".");
 
+	init_null_fid();
+
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 				       O_RDONLY);
 }
-- 
2.33.0

