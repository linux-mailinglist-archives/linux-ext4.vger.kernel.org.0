Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34711732E77
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 12:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbjFPKco (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345124AbjFPKcJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 06:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E12A5269;
        Fri, 16 Jun 2023 03:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3DC36362E;
        Fri, 16 Jun 2023 10:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763A7C433C9;
        Fri, 16 Jun 2023 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911267;
        bh=l05rld8D3PITTefsXnd6Na23gFNBdOJ//xz6k0qL18o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+9jy2hbj5wp8MOvFNwr2YzKYCCjoANSL+zAToYfquUJXHag/mrnX+edLlwwwVBd2
         QPXFX0oYPyOYFnz8T2a9O1zprMedJrdUHPT2dTXPSvntd0p+d9Y73ZCZ2hxei5ptRa
         5Y6N1g4J1gVUh5gQrGX3/opS6qKs9TBJr8b5x3k1S9lje41/NuflveR+NSeXd5MX8d
         owhE32yUU4kziPuhJLSMDFDFmYFogr+Tnxmw28UBWmJ13+7DTTBgoZpI8jjcYZIuPr
         eCn4SIz4f/9CjyC1QyuLKJYogSafnb9eWadVL7XqD+f1jDNlIooue9bc0CmKD6+3aL
         2brjDXCtV8Ylg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/16] Revert "ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled"
Date:   Fri, 16 Jun 2023 06:27:16 -0400
Message-Id: <20230616102721.673775-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102721.673775-1-sashal@kernel.org>
References: <20230616102721.673775-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.117
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

[ Upstream commit 1b29243933098cdbc31b579b5616e183b4275e2f ]

This reverts commit a44be64bbecb15a452496f60db6eacfee2b59c79.

Link: https://lore.kernel.org/r/653b3359-2005-21b1-039d-c55ca4cffdcc@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ebe2abc064e7b..acbecefae3164 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5748,7 +5748,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
-	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -5949,7 +5948,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			if (err)
 				goto restore_opts;
 
-			enable_rw = 1;
+			sb->s_flags &= ~SB_RDONLY;
 			if (ext4_has_feature_mmp(sb)) {
 				err = ext4_multi_mount_protect(sb,
 						le64_to_cpu(es->s_mmp_block));
@@ -5996,9 +5995,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
-	if (enable_rw)
-		sb->s_flags &= ~SB_RDONLY;
-
 	/*
 	 * Reinitialize lazy itable initialization thread based on
 	 * current settings
-- 
2.39.2

