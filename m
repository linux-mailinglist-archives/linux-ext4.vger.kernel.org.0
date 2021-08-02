Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8EA3DE1D1
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Aug 2021 23:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhHBVr1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Aug 2021 17:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhHBVr1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Aug 2021 17:47:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA0EC06175F
        for <linux-ext4@vger.kernel.org>; Mon,  2 Aug 2021 14:47:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 50E791F42CCA
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ltp@lists.linux.it, jack@suse.com, amir73il@gmail.com
Cc:     linux-ext4@vger.kernel.org, khazhy@google.com,
        kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH 5/7] syscalls/fanotify20: Support submission of debugfs commands
Date:   Mon,  2 Aug 2021 17:46:43 -0400
Message-Id: <20210802214645.2633028-6-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802214645.2633028-1-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In order to test FAN_FS_ERROR, we want to corrupt the filesystem.  The
easiest way to do it is by using debugfs.  Add a small helper to issue
debugfs requests.  Since most likely this will be the only testcase to
need this, don't bother making it a proper helper for now.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 testcases/kernel/syscalls/fanotify/fanotify20.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 7a9601072139..e7ced28eb61d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -63,6 +63,13 @@ int fd_notify;
 
 #define EXT4_ERR_ESHUTDOWN 16
 
+static void do_debugfs_request(const char *dev, char *request)
+{
+	char *cmd[] = {"debugfs", "-w", dev, "-R", request, NULL};
+
+	SAFE_CMD(cmd, NULL, NULL);
+}
+
 static void trigger_fs_abort(void)
 {
 	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
-- 
2.32.0

