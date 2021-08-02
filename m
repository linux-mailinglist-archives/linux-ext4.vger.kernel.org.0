Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07AC3DE1D2
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Aug 2021 23:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhHBVre (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Aug 2021 17:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhHBVrd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Aug 2021 17:47:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2991FC061764
        for <linux-ext4@vger.kernel.org>; Mon,  2 Aug 2021 14:47:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C78EC1F42CCA
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ltp@lists.linux.it, jack@suse.com, amir73il@gmail.com
Cc:     linux-ext4@vger.kernel.org, khazhy@google.com,
        kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH 6/7] syscalls/fanotify20: Test file event with broken inode
Date:   Mon,  2 Aug 2021 17:46:44 -0400
Message-Id: <20210802214645.2633028-7-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802214645.2633028-1-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test corrupts an inode entry with an invalid mode through debugfs
and then tries to access it.  This should result in a ext4 error, which
we monitor through the fanotify group.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../kernel/syscalls/fanotify/fanotify20.c     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index e7ced28eb61d..0c63e90edc3a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -76,6 +76,36 @@ static void trigger_fs_abort(void)
 		   MS_REMOUNT|MS_RDONLY, "abort");
 }
 
+#define TCASE2_BASEDIR "tcase2"
+#define TCASE2_BAD_DIR TCASE2_BASEDIR"/bad_dir"
+
+static unsigned int tcase2_bad_ino;
+static void tcase2_prepare_fs(void)
+{
+	struct stat stat;
+
+	SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BASEDIR, 0777);
+	SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BAD_DIR, 0777);
+
+	SAFE_STAT(MOUNT_PATH"/"TCASE2_BAD_DIR, &stat);
+	tcase2_bad_ino = stat.st_ino;
+
+	SAFE_UMOUNT(MOUNT_PATH);
+	do_debugfs_request(tst_device->dev, "sif " TCASE2_BAD_DIR " mode 0xff");
+	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
+}
+
+static void tcase2_trigger_lookup(void)
+{
+	int ret;
+
+	/* SAFE_OPEN cannot be used here because we expect it to fail. */
+	ret = open(MOUNT_PATH"/"TCASE2_BAD_DIR, O_RDONLY, 0);
+	if (ret != -1 && errno != EUCLEAN)
+		tst_res(TFAIL, "Unexpected lookup result(%d) of %s (%d!=%d)",
+			ret, TCASE2_BAD_DIR, errno, EUCLEAN);
+}
+
 static const struct test_case {
 	char *name;
 	int error;
@@ -92,6 +122,14 @@ static const struct test_case {
 		.error_count = 1,
 		.error = EXT4_ERR_ESHUTDOWN,
 		.inode = NULL
+	},
+	{
+		.name = "Lookup of inode with invalid mode",
+		.prepare_fs = tcase2_prepare_fs,
+		.trigger_error = &tcase2_trigger_lookup,
+		.error_count = 1,
+		.error = 0,
+		.inode = &tcase2_bad_ino,
 	}
 };
 
-- 
2.32.0

