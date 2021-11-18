Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F564566C0
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 00:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhKSABb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Nov 2021 19:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhKSAB1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Nov 2021 19:01:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E8C061574
        for <linux-ext4@vger.kernel.org>; Thu, 18 Nov 2021 15:58:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A74741F47098
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637279906; bh=rR3odTmBNckbpv7LtDd+ICNinRP/Al333rsvjphRca0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vg3b0lcsGsOQt/sBkPa364rk2SPkdgafZ+1iWz8iMYGg4mgtIUR42ymvNekVTmWeR
         Kg1sV8T4aY78IDuIOfP4JIspSCCAgU38tfdJ0FhF5k7NU5yN3ghkqeSuuVU1zb1vhD
         6QaVGiDFIVnQXFCYcoh8SPSvuzDyQM6sLvKWaMbnoEvlyngs4r5KaXQGg+OHwEqMx/
         bFyVh9sbSYKUglX5okHo8t2SASy7SgWp2B+pvALVy7/S4xy061xwn/jI+0L2MPB3Xl
         gsqfjKz6yyPz+Bbi2t7f6b13qYw6PctWQ0g8JraYUnPtgM0X2GRlHPo3+Yv5c2fn7I
         7qVerwSPyrcug==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     pvorel@suse.cz, jack@suse.com, amir73il@gmail.com,
        repnop@google.com
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com,
        khazhy@google.com, ltp@lists.linux.it,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v4 9/9] syscalls/fanotify22: Test capture of multiple errors
Date:   Thu, 18 Nov 2021 18:57:44 -0500
Message-Id: <20211118235744.802584-10-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118235744.802584-1-krisman@collabora.com>
References: <20211118235744.802584-1-krisman@collabora.com>
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
 .../kernel/syscalls/fanotify/fanotify22.c     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index 9cd8c8f919b0..b42e96e8263e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
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

