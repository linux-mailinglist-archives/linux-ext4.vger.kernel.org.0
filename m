Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6372827A
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jun 2023 16:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbjFHOSV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjFHOSU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 10:18:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909462D4A
        for <linux-ext4@vger.kernel.org>; Thu,  8 Jun 2023 07:18:18 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 358EI9HW005452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 10:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686233891; bh=jSoyec+gCpH/ydpZcYnudTmn09deraaUS/IBv+lGVsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eexyniHPxwfcbs9hAwRkkCa3+xb7xnODxkhccPzcSbDOsqw6GWoni6fkUjdnb3a3y
         r2q1743mg86ZWTqK7pj5M5gOPi0jxgrkJGNwlA/s/IIbXwIO7kITSDVtgPZF0EfKnA
         UoaU4/AYxD4WRr5klxk532HCv1BQ1Q7Z0zA4yBuybe7ArOQNRHNV2rWbJAc2J68Pu6
         nnJ1jjCXnDK4IKuK/QAunLEvfd1wTRC4dNv0k9n1V2ADFhTvVSjuRzICdkpCP37rN1
         ed+QSJgu3VcVPQqkaEpDjwmLJ3MAJMkbenRq8E0CeSOe/6nFcVAdbXKEk9Cmfnh4Yu
         JMvTY+2hwJGAQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D841E15C04C3; Thu,  8 Jun 2023 10:18:09 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     bagasdotme@gmail.com, nikolas.kraetzschmar@sap.com, jack@suse.cz,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] Revert "ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled"
Date:   Thu,  8 Jun 2023 10:18:04 -0400
Message-Id: <20230608141805.1434230-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230608044056.GA1418535@mit.edu>
References: <20230608044056.GA1418535@mit.edu>
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

This reverts commit a44be64bbecb15a452496f60db6eacfee2b59c79.

Link: https://lore.kernel.org/r/653b3359-2005-21b1-039d-c55ca4cffdcc@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 56a5d1c469fc..05fcecc36244 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6388,7 +6388,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
-	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -6575,7 +6574,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 			if (err)
 				goto restore_opts;
 
-			enable_rw = 1;
+			sb->s_flags &= ~SB_RDONLY;
 			if (ext4_has_feature_mmp(sb)) {
 				err = ext4_multi_mount_protect(sb,
 						le64_to_cpu(es->s_mmp_block));
@@ -6622,9 +6621,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
-	if (enable_rw)
-		sb->s_flags &= ~SB_RDONLY;
-
 	/*
 	 * Reinitialize lazy itable initialization thread based on
 	 * current settings
-- 
2.31.0

