Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BDC43B9DC
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 20:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbhJZSqx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Oct 2021 14:46:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43326 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbhJZSqu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Oct 2021 14:46:50 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 73BB11F40D7C;
        Tue, 26 Oct 2021 19:44:24 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ltp@lists.linux.it, jack@suse.com, amir73il@gmail.com
Cc:     khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 10/10] syscalls/fanotify20: Test capture of multiple errors
Date:   Tue, 26 Oct 2021 15:42:39 -0300
Message-Id: <20211026184239.151156-11-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026184239.151156-1-krisman@collabora.com>
References: <20211026184239.151156-1-krisman@collabora.com>
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
 .../kernel/syscalls/fanotify/fanotify20.c     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 7bcddcaa98cb..0083a018f2c6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -78,6 +78,18 @@ static void tcase2_trigger_lookup(void)
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
@@ -99,6 +111,20 @@ static struct test_case {
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

