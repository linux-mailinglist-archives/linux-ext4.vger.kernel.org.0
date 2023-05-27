Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846EF71325D
	for <lists+linux-ext4@lfdr.de>; Sat, 27 May 2023 05:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjE0D6m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 May 2023 23:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbjE0D6S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 May 2023 23:58:18 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD532E4D
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 20:57:48 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34R3vcxE032032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 23:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685159859; bh=Drf/qZYK6+21wQ/l/zM59ct4VdC06QU9OmnuReEJONk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=G/vK9A6bzrvQC+rDdOSs5qTP56sHZo1V/9OwLbPbbsdCTbAWVEjrCmF9odbltOScx
         3YNgUueG/a6vB2nT6iJpgVmqSRo1gIPM4LF78Xn3mtx/iIowT08K/eiR/Lh+xDbmV4
         IHlOacA5vXvYexAvGKnGVJbe4uI2FORVnNcJ2+dLzaKRtO4IbqGWcQei1/oqACg1CN
         tub6IDsDKTIQ53OtrB/OcID0KJoBGdIjntXQcdGbQWI6xbiRNXM0pf/cD/7iABDBS1
         pPTy9AgtXePyN5LvyIFluE9Y5ZqmH5w+Mc0pY5qSP+QtFEP7lbWcKqf8aMElDaW7BJ
         2ZiHX34ju2Mng==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CBCEE15C02DC; Fri, 26 May 2023 23:57:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: enable the lazy init thread when remounting read/write
Date:   Fri, 26 May 2023 23:57:29 -0400
Message-Id: <20230527035729.1001605-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <ZGPDX3pMMa3yg4yg@debian-BULLSEYE-live-builder-AMD64>
References: <ZGPDX3pMMa3yg4yg@debian-BULLSEYE-live-builder-AMD64>
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
---
 fs/ext4/super.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9680fe753e59..56a5d1c469fc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6588,18 +6588,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
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
@@ -6637,6 +6625,18 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
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
2.31.0

