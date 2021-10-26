Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7C43B9DA
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhJZSqn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Oct 2021 14:46:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43314 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbhJZSql (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Oct 2021 14:46:41 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BB0151F40D7C;
        Tue, 26 Oct 2021 19:44:16 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ltp@lists.linux.it, jack@suse.com, amir73il@gmail.com
Cc:     khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 09/10] syscalls/fanotify20: Test file event with broken inode
Date:   Tue, 26 Oct 2021 15:42:38 -0300
Message-Id: <20211026184239.151156-10-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026184239.151156-1-krisman@collabora.com>
References: <20211026184239.151156-1-krisman@collabora.com>
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
 .../kernel/syscalls/fanotify/fanotify20.c     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 5c5ee3c6fb74..7bcddcaa98cb 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -38,6 +38,10 @@
 #define	FILEID_INVALID		0xff
 #endif
 
+#ifndef EFSCORRUPTED
+#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
+#endif
+
 #define BUF_SIZE 256
 static char event_buf[BUF_SIZE];
 int fd_notify;
@@ -63,6 +67,17 @@ static void trigger_fs_abort(void)
 		   MS_REMOUNT|MS_RDONLY, "abort");
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
@@ -77,6 +92,13 @@ static struct test_case {
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

