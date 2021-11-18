Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EC04566BC
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 00:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhKSABS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Nov 2021 19:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbhKSABQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Nov 2021 19:01:16 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5E7C061756
        for <linux-ext4@vger.kernel.org>; Thu, 18 Nov 2021 15:58:15 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 599B41F47098
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637279894; bh=mwgQRcAPY0UhabSUmUkf3+MRuf8WSxV9z4jkotD/HZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqdoJgHiyJ7s4GJhgdAHy6SB0/sIJA9kEwf6LF2DTA3nWRmeztPUtyFRk1sEx88TP
         DPX1Vn7wBXrhHfyTjQQtGEMAndFRxbZ3lpRjWV9FxS6HiQu1jM+PmWMDo8pTinHOl9
         lvyzb1RJuswTdG/4Cvs2tdjAYPuWzIBHkpExJQ1QT21nK2QBWIWL5n2pVIBvVVcvHk
         xB5xsgBf0IlGsZFb9OWRTo3SRbmykOdQCLBfePZ9rNcLTqrRTlM5EFmTk4inU9dyyi
         Cn7Oprmo4CgdnkYt2LeSBgdTnLFzkOLFYUNSCIZstUUY0KWFjJhr5rnblcBIvntXDh
         0vVfHx6wgWGPA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     pvorel@suse.cz, jack@suse.com, amir73il@gmail.com,
        repnop@google.com
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com,
        khazhy@google.com, ltp@lists.linux.it,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v4 6/9] syscalls/fanotify22: Support submission of debugfs commands
Date:   Thu, 18 Nov 2021 18:57:41 -0500
Message-Id: <20211118235744.802584-7-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118235744.802584-1-krisman@collabora.com>
References: <20211118235744.802584-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In order to test FAN_FS_ERROR, we want to corrupt the filesystem.  The
easiest way to do it is by using debugfs.  Add a small helper to issue
debugfs requests.  Since most likely this will be the only testcase to
need this, don't bother making it a proper helper for now.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
changes since v1:
  - Add .needs_cmds to require debugfs
---
 testcases/kernel/syscalls/fanotify/fanotify22.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
index eeee582f1268..bb44ed55e96e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify22.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
@@ -49,6 +49,13 @@ static void trigger_fs_abort(void)
 		   MS_REMOUNT|MS_RDONLY, "abort");
 }
 
+static void do_debugfs_request(const char *dev, char *request)
+{
+	const char *cmd[] = {"debugfs", "-w", dev, "-R", request, NULL};
+
+	SAFE_CMD(cmd, NULL, NULL);
+}
+
 static struct test_case {
 	char *name;
 	int error;
@@ -227,7 +234,11 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 	.needs_root = 1,
-	.dev_fs_type = "ext4"
+	.dev_fs_type = "ext4",
+	.needs_cmds = (const char *[]) {
+		"debugfs",
+		NULL
+	}
 };
 
 #else
-- 
2.33.0

