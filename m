Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B793573176B
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 13:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344383AbjFOLmp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 07:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344316AbjFOLlv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 07:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2CE4224;
        Thu, 15 Jun 2023 04:39:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0720361BB8;
        Thu, 15 Jun 2023 11:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1162C433C9;
        Thu, 15 Jun 2023 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829177;
        bh=kLiqI+b0n2DC0TEbl309BNDc/DO41bW96DH678FNX4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=io/P+V93NK8C64S4n87PltDb1fI8PJynwOFExMboPEMYfHr+UngH4M6Vxa4iUGSkZ
         2MYeDuOirI7unZ9AZRu3VgcnaJlXFLPFBJjIVvkGygbISziJ/QUccEohjRy+QvV+vb
         CH74lwi374EURudECb5bGttkxGK5HkOfzonbNC3hBI4ZS20H0kXE7cS1jkh2ag9llS
         GoZMwG+22s8PmRA7PN6AFUY9eYUk5n8eZeWoWwRsRYdksUOizsJxjFoMsqizN4q90q
         mjL3g6NssvyEIHKdMFNqXGLV/TyebS55ySuICCQSI5x12o4HhiPqlfKaw/52+7F4VT
         0FlqqnhzR13QQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 9/9] ext4: enable the lazy init thread when remounting read/write
Date:   Thu, 15 Jun 2023 07:39:17 -0400
Message-Id: <20230615113917.649505-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113917.649505-1-sashal@kernel.org>
References: <20230615113917.649505-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.184
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit eb1f822c76beeaa76ab8b6737ab9dc9f9798408c ]

In commit a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting
r/w until quota is re-enabled") we defer clearing tyhe SB_RDONLY flag
in struct super.  However, we didn't defer when we checked sb_rdonly()
to determine the lazy itable init thread should be enabled, with the
next result that the lazy inode table initialization would not be
properly started.  This can cause generic/231 to fail in ext4's
nojournal mode.

Fix this by moving when we decide to start or stop the lazy itable
init thread to after we clear the SB_RDONLY flag when we are
remounting the file system read/write.

Fixes a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting r/w until...")

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20230527035729.1001605-1-tytso@mit.edu
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d89750e90bc4b..f72896384dbc9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6005,18 +6005,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 
-	/*
-	 * Reinitialize lazy itable initialization thread based on
-	 * current settings
-	 */
-	if (sb_rdonly(sb) || !test_opt(sb, INIT_INODE_TABLE))
-		ext4_unregister_li_request(sb);
-	else {
-		ext4_group_t first_not_zeroed;
-		first_not_zeroed = ext4_has_uninit_itable(sb);
-		ext4_register_li_request(sb, first_not_zeroed);
-	}
-
 	/*
 	 * Handle creation of system zone data early because it can fail.
 	 * Releasing of existing data is done when we are sure remount will
@@ -6054,6 +6042,18 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	if (enable_rw)
 		sb->s_flags &= ~SB_RDONLY;
 
+	/*
+	 * Reinitialize lazy itable initialization thread based on
+	 * current settings
+	 */
+	if (sb_rdonly(sb) || !test_opt(sb, INIT_INODE_TABLE))
+		ext4_unregister_li_request(sb);
+	else {
+		ext4_group_t first_not_zeroed;
+		first_not_zeroed = ext4_has_uninit_itable(sb);
+		ext4_register_li_request(sb, first_not_zeroed);
+	}
+
 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
 		ext4_stop_mmpd(sbi);
 
-- 
2.39.2

