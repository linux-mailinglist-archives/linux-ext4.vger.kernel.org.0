Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7899C3DE1D0
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Aug 2021 23:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhHBVrX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Aug 2021 17:47:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38226 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhHBVrX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Aug 2021 17:47:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 60CFA1F42CCA
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ltp@lists.linux.it, jack@suse.com, amir73il@gmail.com
Cc:     linux-ext4@vger.kernel.org, khazhy@google.com,
        kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH 4/7] syscalls/fanotify20: Watch event after filesystem abort
Date:   Mon,  2 Aug 2021 17:46:42 -0400
Message-Id: <20210802214645.2633028-5-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802214645.2633028-1-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test monitors the EXT4 specific error triggered after a file system
abort.  It works by forcing a remount with the option "abort".  This is
an error not related to a file so it is reported against the superblock
with a NULL FH.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 testcases/kernel/syscalls/fanotify/fanotify20.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index d8d788ae685f..7a9601072139 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -61,6 +61,14 @@ int fd_notify;
 
 #define MOUNT_PATH "test_mnt"
 
+#define EXT4_ERR_ESHUTDOWN 16
+
+static void trigger_fs_abort(void)
+{
+	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
+		   MS_REMOUNT|MS_RDONLY, "abort");
+}
+
 static const struct test_case {
 	char *name;
 	int error;
@@ -71,6 +79,13 @@ static const struct test_case {
 	void (*trigger_error)(void);
 	void (*prepare_fs)(void);
 } testcases[] = {
+	{
+		.name = "Trigger abort",
+		.trigger_error = &trigger_fs_abort,
+		.error_count = 1,
+		.error = EXT4_ERR_ESHUTDOWN,
+		.inode = NULL
+	}
 };
 
 struct fanotify_event_info_header *get_event_info(
-- 
2.32.0

