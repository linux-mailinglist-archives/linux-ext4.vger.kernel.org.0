Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEC94404D2
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Oct 2021 23:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhJ2VVf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Oct 2021 17:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhJ2VVZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Oct 2021 17:21:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49051C061570
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 14:18:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 67D011F45C6F;
        Fri, 29 Oct 2021 22:18:46 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com, repnop@google.com
Cc:     ltp@lists.linux.it, khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 9/9] syscalls/fanotify21: Test capture of multiple errors
Date:   Fri, 29 Oct 2021 18:17:32 -0300
Message-Id: <20211029211732.386127-10-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When multiple FS errors occur, only the first is stored.  This testcase
validates this behavior by issuing two different errors and making sure
only the first is stored, while the second is simply accumulated in
error_count.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../kernel/syscalls/fanotify/fanotify21.c     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index e463365dd69d..7f0154da5eeb 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -74,6 +74,18 @@ static void tcase2_trigger_lookup(void)
 			ret, BAD_DIR, errno, EUCLEAN);
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
 static struct test_case {
 	char *name;
 	int error;
@@ -95,6 +107,20 @@ static struct test_case {
 		.error = EFSCORRUPTED,
 		.fid = &bad_file_fid,
 	},
+	{
+		.name = "Multiple error submission",
+		.trigger_error = &tcase3_trigger,
+		.error_count = 2,
+		.error = ESHUTDOWN,
+		.fid = &null_fid,
+	},
+	{
+		.name = "Multiple error submission 2",
+		.trigger_error = &tcase4_trigger,
+		.error_count = 2,
+		.error = EFSCORRUPTED,
+		.fid = &bad_file_fid,
+	}
 };
 
 int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
-- 
2.33.0

