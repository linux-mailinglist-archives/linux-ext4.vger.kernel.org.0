Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AAD6F9280
	for <lists+linux-ext4@lfdr.de>; Sat,  6 May 2023 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjEFOYb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 6 May 2023 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjEFOYa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 6 May 2023 10:24:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6FB1A499
        for <linux-ext4@vger.kernel.org>; Sat,  6 May 2023 07:24:29 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 346EOOZv023026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 6 May 2023 10:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683383065; bh=DlmF5x0QEaFf8If63xdWQRV21c4PiLQHgBHXsQLF2+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LbitqXzHdin+Q2MXu+Ne8NstCfWDtiJNA4wuAKe8rnh85zFcHbdb7/Iig4hEdp4yh
         +m8sNMOOc/FySLcNBCcGFExCnt8Zc/g5TwS1Y/zf6ZyzTHcZONGHl6mEjyly08tCjW
         +hqrkWjP73hbLxwXcKZjrBpkKuT5hes1ZBoXUC6DKmRsMqBX42ujGsOIuKMrvWvcVw
         0saoJE+szb2FhzmEN6ey76GERohQaiKrBICDyo4KjPDXt2cgwii54xpVIxJjKgRivJ
         mUroGBt/oBHYIfbNGAH+UDwTgzzQlFjGo8SUe2hbF0hCFNs9wp4Ru28EaoNHg93Evi
         YXymVNX/cIVWA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F03E115C02E9; Sat,  6 May 2023 10:24:23 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] ext4: improve error recovery code paths in __ext4_remount()
Date:   Sat,  6 May 2023 10:24:19 -0400
Message-Id: <20230506142419.984260-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230506142419.984260-1-tytso@mit.edu>
References: <20230506142419.984260-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If there are failures while changing the mount options in
__ext4_remount(), we need to restore the old mount options.

This commit fixes two problem.  The first is there is a chance that we
will free the old quota file names before a potential failure leading
to a use-after-free.  The second problem addressed in this commit is
if there is a failed read/write to read-only transition, if the quota
has already been suspended, we need to renable quota handling.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 686dbd38e7c5..32784e1db6be 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6619,9 +6619,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	}
 
 #ifdef CONFIG_QUOTA
-	/* Release old quota file names */
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
-		kfree(old_opts.s_qf_names[i]);
 	if (enable_quota) {
 		if (sb_any_quota_suspended(sb))
 			dquot_resume(sb, -1);
@@ -6631,6 +6628,9 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 				goto restore_opts;
 		}
 	}
+	/* Release old quota file names */
+	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(old_opts.s_qf_names[i]);
 #endif
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
@@ -6644,6 +6644,13 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	return 0;
 
 restore_opts:
+	/*
+	 * If there was a failing r/w to ro transition, we may need to
+	 * re-enable quota
+	 */
+	if ((sb->s_flags & SB_RDONLY) && !(old_sb_flags & SB_RDONLY) &&
+	    sb_any_quota_suspended(sb))
+		dquot_resume(sb, -1);
 	sb->s_flags = old_sb_flags;
 	sbi->s_mount_opt = old_opts.s_mount_opt;
 	sbi->s_mount_opt2 = old_opts.s_mount_opt2;
-- 
2.31.0

