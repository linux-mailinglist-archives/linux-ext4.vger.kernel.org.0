Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B612143B9D9
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 20:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbhJZSqh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Oct 2021 14:46:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43310 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhJZSqg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Oct 2021 14:46:36 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 965631F40D7C;
        Tue, 26 Oct 2021 19:44:09 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ltp@lists.linux.it, jack@suse.com, amir73il@gmail.com
Cc:     khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 08/10] syscalls/fanotify20: Test event after filesystem abort
Date:   Tue, 26 Oct 2021 15:42:37 -0300
Message-Id: <20211026184239.151156-9-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026184239.151156-1-krisman@collabora.com>
References: <20211026184239.151156-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test monitors the error triggered after a file system abort.  It
works by forcing a remount with the option "abort".  This is an error
not related to a file so it is reported against the superblock with a
zero size fh.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 testcases/kernel/syscalls/fanotify/fanotify20.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 298bb303a810..5c5ee3c6fb74 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -57,6 +57,12 @@ static void do_debugfs_request(const char *dev, char *request)
 	SAFE_CMD(cmd, NULL, NULL);
 }
 
+static void trigger_fs_abort(void)
+{
+	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
+		   MS_REMOUNT|MS_RDONLY, "abort");
+}
+
 static struct test_case {
 	char *name;
 	int error;
@@ -64,6 +70,13 @@ static struct test_case {
 	struct fanotify_fid_t *fid;
 	void (*trigger_error)(void);
 } testcases[] = {
+	{
+		.name = "Trigger abort",
+		.trigger_error = &trigger_fs_abort,
+		.error_count = 1,
+		.error = ESHUTDOWN,
+		.fid = &null_fid,
+	},
 };
 
 int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
-- 
2.33.0

