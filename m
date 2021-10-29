Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6397D4404CE
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Oct 2021 23:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhJ2VVL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Oct 2021 17:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhJ2VVL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Oct 2021 17:21:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ED4C061570
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 14:18:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id ADE581F45C6F;
        Fri, 29 Oct 2021 22:18:40 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com, repnop@google.com
Cc:     ltp@lists.linux.it, khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 8/9] syscalls/fanotify21: Test file event with broken inode
Date:   Fri, 29 Oct 2021 18:17:31 -0300
Message-Id: <20211029211732.386127-9-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test corrupts an inode entry with an invalid mode through debugfs
and then tries to access it.  This should result in a ext4 error, which
we monitor through the fanotify group.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../kernel/syscalls/fanotify/fanotify21.c     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 3e4ac2eb2e5b..e463365dd69d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -34,6 +34,10 @@
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
 
+#ifndef EFSCORRUPTED
+#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
+#endif
+
 #define BUF_SIZE 256
 static char event_buf[BUF_SIZE];
 int fd_notify;
@@ -59,6 +63,17 @@ static void do_debugfs_request(const char *dev, char *request)
 	SAFE_CMD(cmd, NULL, NULL);
 }
 
+static void tcase2_trigger_lookup(void)
+{
+	int ret;
+
+	/* SAFE_OPEN cannot be used here because we expect it to fail. */
+	ret = open(MOUNT_PATH"/"BAD_DIR, O_RDONLY, 0);
+	if (ret != -1 && errno != EUCLEAN)
+		tst_res(TFAIL, "Unexpected lookup result(%d) of %s (%d!=%d)",
+			ret, BAD_DIR, errno, EUCLEAN);
+}
+
 static struct test_case {
 	char *name;
 	int error;
@@ -73,6 +88,13 @@ static struct test_case {
 		.error = ESHUTDOWN,
 		.fid = &null_fid,
 	},
+	{
+		.name = "Lookup of inode with invalid mode",
+		.trigger_error = &tcase2_trigger_lookup,
+		.error_count = 1,
+		.error = EFSCORRUPTED,
+		.fid = &bad_file_fid,
+	},
 };
 
 int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
-- 
2.33.0

