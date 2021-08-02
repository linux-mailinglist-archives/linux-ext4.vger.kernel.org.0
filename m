Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2169A3DE1D3
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Aug 2021 23:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhHBVrg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Aug 2021 17:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhHBVrf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Aug 2021 17:47:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2406C06175F
        for <linux-ext4@vger.kernel.org>; Mon,  2 Aug 2021 14:47:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 03A671F42CCA
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ltp@lists.linux.it, jack@suse.com, amir73il@gmail.com
Cc:     linux-ext4@vger.kernel.org, khazhy@google.com,
        kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH 7/7] syscalls/fanotify20: Test capture of multiple errors
Date:   Mon,  2 Aug 2021 17:46:45 -0400
Message-Id: <20210802214645.2633028-8-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802214645.2633028-1-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When multiple FS errors occur, only the first is stored.  This testcase
validates this behavior by issuing two different errors and making sure
only the first is stored, while the second is simply accumulated in
error_count.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../kernel/syscalls/fanotify/fanotify20.c     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 0c63e90edc3a..07040cb7fa7c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -106,6 +106,18 @@ static void tcase2_trigger_lookup(void)
 			ret, TCASE2_BAD_DIR, errno, EUCLEAN);
 }
 
+static void tcase3_trigger(void)
+{
+	trigger_fs_abort();
+	tcase2_trigger_lookup();
+}
+
+static void tcase4_trigger(void)
+{
+	tcase2_trigger_lookup();
+	trigger_fs_abort();
+}
+
 static const struct test_case {
 	char *name;
 	int error;
@@ -130,6 +142,19 @@ static const struct test_case {
 		.error_count = 1,
 		.error = 0,
 		.inode = &tcase2_bad_ino,
+	},
+	{
+		.name = "Multiple error submission",
+		.trigger_error = &tcase3_trigger,
+		.error_count = 2,
+		.error = EXT4_ERR_ESHUTDOWN,
+	},
+	{
+		.name = "Multiple error submission 2",
+		.trigger_error = &tcase4_trigger,
+		.error_count = 2,
+		.error = 0,
+		.inode = &tcase2_bad_ino,
 	}
 };
 
-- 
2.32.0

