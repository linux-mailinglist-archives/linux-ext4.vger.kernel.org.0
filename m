Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5533C43B9D6
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 20:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhJZSq3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Oct 2021 14:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbhJZSq2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Oct 2021 14:46:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAE6C061745
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 11:44:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2579D1F43877;
        Tue, 26 Oct 2021 19:44:02 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ltp@lists.linux.it, jack@suse.com, amir73il@gmail.com
Cc:     khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 07/10] syscalls/fanotify20: Create a corrupted file
Date:   Tue, 26 Oct 2021 15:42:36 -0300
Message-Id: <20211026184239.151156-8-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026184239.151156-1-krisman@collabora.com>
References: <20211026184239.151156-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Allocate a test directory and corrupt it with debugfs.  The corruption
is done by writing an invalid inode mode.  This file can be later
looked up to trigger a corruption error.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 testcases/kernel/syscalls/fanotify/fanotify20.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 7c4b01720654..298bb303a810 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -43,9 +43,12 @@ static char event_buf[BUF_SIZE];
 int fd_notify;
 
 #define MOUNT_PATH "test_mnt"
+#define BASE_DIR "internal_dir"
+#define BAD_DIR BASE_DIR"/bad_dir"
 
 /* These expected FIDs are common to multiple tests */
 static struct fanotify_fid_t null_fid;
+static struct fanotify_fid_t bad_file_fid;
 
 static void do_debugfs_request(const char *dev, char *request)
 {
@@ -182,6 +185,18 @@ static void do_test(unsigned int i)
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
@@ -201,6 +216,8 @@ static void setup(void)
 
 	init_null_fid();
 
+	pre_corrupt_fs();
+
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 				       O_RDONLY);
 
-- 
2.33.0

