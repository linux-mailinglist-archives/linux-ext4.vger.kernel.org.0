Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8AB4566BF
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 00:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhKSABZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Nov 2021 19:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhKSABX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Nov 2021 19:01:23 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C65C06174A
        for <linux-ext4@vger.kernel.org>; Thu, 18 Nov 2021 15:58:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C59161F47098
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637279902; bh=aWhpa1EEwRuPW3BfULGcgKipuwl/JVjvTOS3Grz/c3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mw8hYET2qcHvXrzh6LtV0Q9Yv71mZbcCn7Dx4KrUINFe/JBNd7socJIF8bjXY0m/U
         GyxkjTxikPms6wsUxeMDRi2tg5Nn0KsSb0BbSosyEyQ6j40OA2pBd05wEjGxaJlcWG
         qf1P4FGV1W8BFqTjBissAatQJ0g9c5Q5u9dqxdu6eX0fOsD/MWjLl0Qs2Z7hU/cqTu
         iWn5CZ1aQzYHrgZgYMY5LDin3q6vubjrq/cthrPLraa1Qo+IvWCIsXjNL3fVWSaBjk
         lgSEq+BW7G+H9ALR9EnR0yv5IpNdUYqGz0RCq/mYVi5P1h3VXfmYnN+H4Z6oACwpfs
         8DXtXdFg9p/qQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     pvorel@suse.cz, jack@suse.com, amir73il@gmail.com,
        repnop@google.com
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com,
        khazhy@google.com, ltp@lists.linux.it,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v4 8/9] syscalls/fanotify22: Test file event with broken inode
Date:   Thu, 18 Nov 2021 18:57:43 -0500
Message-Id: <20211118235744.802584-9-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118235744.802584-1-krisman@collabora.com>
References: <20211118235744.802584-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test corrupts an inode entry with an invalid mode through debugfs
and then tries to access it.  This should result in a ext4 error, which
we monitor through the fanotify group.

In order for this test to succeed, it requires a kernel fix introduced
by kernel commit 124e7c61deb2 ("ext4: fix error code saved on super
block during file system abort"), which is added to .tags.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../kernel/syscalls/fanotify/fanotify22.c     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 5d8b4eec74bd..9cd8c8f919b0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
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
@@ -251,6 +273,10 @@ static struct tst_test test = {
 	.mntpoint = MOUNT_PATH,
 	.needs_root = 1,
 	.dev_fs_type = "ext4",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "124e7c61deb2"},
+		{}
+	},
 	.needs_cmds = (const char *[]) {
 		"debugfs",
 		NULL
-- 
2.33.0

