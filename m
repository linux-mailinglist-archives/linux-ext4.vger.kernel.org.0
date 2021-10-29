Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACFD4404CC
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Oct 2021 23:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJ2VVG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Oct 2021 17:21:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58444 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhJ2VVF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Oct 2021 17:21:05 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 406171F45C6F;
        Fri, 29 Oct 2021 22:18:34 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com, repnop@google.com
Cc:     ltp@lists.linux.it, khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 7/9] syscalls/fanotify21: Create a corrupted file
Date:   Fri, 29 Oct 2021 18:17:30 -0300
Message-Id: <20211029211732.386127-8-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Allocate a test directory and corrupt it with debugfs.  The corruption
is done by writing an invalid inode mode.  This file can be later
looked up to trigger a corruption error.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 testcases/kernel/syscalls/fanotify/fanotify21.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 43e606c27372..3e4ac2eb2e5b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -39,9 +39,12 @@ static char event_buf[BUF_SIZE];
 int fd_notify;
 
 #define MOUNT_PATH "test_mnt"
+#define BASE_DIR "internal_dir"
+#define BAD_DIR BASE_DIR"/bad_dir"
 
 /* These expected FIDs are common to multiple tests */
 static struct fanotify_fid_t null_fid;
+static struct fanotify_fid_t bad_file_fid;
 
 static void trigger_fs_abort(void)
 {
@@ -197,6 +200,18 @@ static void do_test(unsigned int i)
 	check_event(event_buf, read_len, tcase);
 }
 
+static void pre_corrupt_fs(void)
+{
+	SAFE_MKDIR(MOUNT_PATH"/"BASE_DIR, 0777);
+	SAFE_MKDIR(MOUNT_PATH"/"BAD_DIR, 0777);
+
+	fanotify_save_fid(MOUNT_PATH"/"BAD_DIR, &bad_file_fid);
+
+	SAFE_UMOUNT(MOUNT_PATH);
+	do_debugfs_request(tst_device->dev, "sif " BAD_DIR " mode 0xff");
+	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
+}
+
 static void init_null_fid(void)
 {
 	/* Use fanotify_save_fid to fill the fsid and overwrite the
@@ -216,6 +231,8 @@ static void setup(void)
 
 	init_null_fid();
 
+	pre_corrupt_fs();
+
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 				       O_RDONLY);
 }
-- 
2.33.0

