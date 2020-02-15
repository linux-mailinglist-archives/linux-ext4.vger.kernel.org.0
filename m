Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4391715FC03
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Feb 2020 02:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBOB1s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Feb 2020 20:27:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46512 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727639AbgBOB1s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Feb 2020 20:27:48 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01F1Rh4v021468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 20:27:44 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9C5C442032C; Fri, 14 Feb 2020 20:27:43 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH] ext4: improve explanation of a mount failure caused by a misconfigured kernel
Date:   Fri, 14 Feb 2020 20:27:38 -0500
Message-Id: <20200215012738.565735-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If CONFIG_QFMT_V2 is not enabled, but CONFIG_QUOTA is enabled, when a
user tries to mount a file system with the quota or project quota
enabled, the kernel will emit a very confusing messsage:

    EXT4-fs warning (device vdc): ext4_enable_quotas:5914: Failed to enable quota tracking (type=0, err=-3). Please run e2fsck to fix.
    EXT4-fs (vdc): mount failed

We will now report an explanatory message indicating which kernel
configuration options have to be enabled, to avoid customer/sysadmin
confusion.

Google-Bug-Id: 149093531
Fixes: 7c319d328505b778 ("ext4: make quota as first class supported feature")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/ext4/super.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b0b9150c9773..f131eaa52f22 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3009,17 +3009,11 @@ static int ext4_feature_set_ok(struct super_block *sb, int readonly)
 		return 0;
 	}
 
-#ifndef CONFIG_QUOTA
-	if (ext4_has_feature_quota(sb) && !readonly) {
+#if !defined(CONFIG_QUOTA) || !defined(CONFIG_QFMT_V2)
+	if (!readonly && (ext4_has_feature_quota(sb) ||
+			  ext4_has_feature_project(sb))) {
 		ext4_msg(sb, KERN_ERR,
-			 "Filesystem with quota feature cannot be mounted RDWR "
-			 "without CONFIG_QUOTA");
-		return 0;
-	}
-	if (ext4_has_feature_project(sb) && !readonly) {
-		ext4_msg(sb, KERN_ERR,
-			 "Filesystem with project quota feature cannot be mounted RDWR "
-			 "without CONFIG_QUOTA");
+			 "The kernel was not built with CONFIG_QUOTA and CONFIG_QFMT_V2");
 		return 0;
 	}
 #endif  /* CONFIG_QUOTA */
-- 
2.24.1

