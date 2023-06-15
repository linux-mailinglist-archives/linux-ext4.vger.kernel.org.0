Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221C2731705
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 13:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbjFOLjU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 07:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343929AbjFOLiz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 07:38:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8943530EF;
        Thu, 15 Jun 2023 04:38:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2622663982;
        Thu, 15 Jun 2023 11:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A2CC433CB;
        Thu, 15 Jun 2023 11:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829093;
        bh=rSYJn7uFvO1S/3zp4tOAZ+Np0SpUYA9Ry549bEzkfWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAA9WU4wYJgEbgpLji7CRv7OLIXF4Khpi/F12J6PQ0BksOslcT+BW/pldq+1wPgNl
         HpPyLXZAyXrPiG6j6IeZJ/igkEtBgWilOOIZZLOHL53ZeiY09F6TQKBXFBRxg32RaV
         BDjyf5dOQ8AQow/yYtzc0hkbOzIygwxBNybsuoit9978vfT1Cdo5jNxmLE8MSFN6bk
         L/6CXXLp0MHcd6DjGNtwppmCeHjESi2S0OGYjsjuFhk5h/bPBkT7oITNbWbux+H+JP
         +ckhvt8duw2xX4Yf3c/51kgStd6bprFdmjiIKZoNy0lTs/a5pe7Q3gmHqSiUh9FQl/
         pbg9mGe52KNQw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 18/19] ext4: enable the lazy init thread when remounting read/write
Date:   Thu, 15 Jun 2023 07:37:18 -0400
Message-Id: <20230615113719.648862-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113719.648862-1-sashal@kernel.org>
References: <20230615113719.648862-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index d34afa8e0c158..1f222c396932e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6554,18 +6554,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
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
@@ -6603,6 +6591,18 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
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

