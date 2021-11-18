Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08874566BD
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 00:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhKSABT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Nov 2021 19:01:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39800 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbhKSABT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Nov 2021 19:01:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C77F51F47098
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637279898; bh=AMEWurQydOhlrkam7tWoA2YxYk8g84h/9nWOOD1niKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQTOYubV3sJj0NfeB6mNscv4HVzgadJYwxrFWy6xVm30NO13cF85tMXbZDHUqET8q
         1qdN5knpN3mzINJ9EfnE82+uEg1ulJXE1PFWBY/e5qeApzyBUGv1G8ECQAWdy2u9P1
         ABsQeOeN7hYYLugT++og3jrz1y7G66h+nbhIieq1X89ln3raxuKzsTmFMo9SHz6sWV
         h3GgLotnj/LPOwQvmgOjkrP80pFH8kJRGL5thcAbk0z24RiRSrUYyS705+XKO8rINO
         UpFFuW/7CZHkq6kgWWmLkXpJ0GBp5Bjx0hadrZzLs4dR1P6mfzyJ7MJUS1+vMyYf7I
         pyWjWtysvQuqA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     pvorel@suse.cz, jack@suse.com, amir73il@gmail.com,
        repnop@google.com
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com,
        khazhy@google.com, ltp@lists.linux.it,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v4 7/9] syscalls/fanotify22: Create a corrupted file
Date:   Thu, 18 Nov 2021 18:57:42 -0500
Message-Id: <20211118235744.802584-8-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118235744.802584-1-krisman@collabora.com>
References: <20211118235744.802584-1-krisman@collabora.com>
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
 testcases/kernel/syscalls/fanotify/fanotify22.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index bb44ed55e96e..5d8b4eec74bd 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
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
@@ -213,6 +228,7 @@ static void setup(void)
 	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 						FAN_MARK_FILESYSTEM,
 						FAN_FS_ERROR, ".");
+	pre_corrupt_fs();
 
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
 				       O_RDONLY);
-- 
2.33.0

