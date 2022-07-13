Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250E3572DBA
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jul 2022 07:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiGMFy3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jul 2022 01:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbiGMFyD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jul 2022 01:54:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCCB31233;
        Tue, 12 Jul 2022 22:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bjngWu2+fy+EhLHzFfowceaR1j/UA31xrrxHhRbbPPo=; b=eK7l6IZou/+UiLWuRhRJW2kUNF
        RpfKvThqfwsyR+cMUx8PBvIbgU01gZ0oWI9XpdINo2jgH3dSHI1lEPGQmlTEgoPYTMOYbr16595A3
        MFz2oVSMmjvNoyPs1BGlO4XvDNzM48KTWLf3Bq7fJFTwhw+/LCG88jGR8AtzHLYtERIhWYGenwnL/
        6CU15IsolJQgPTYsk278i56pFs5cTzgQETWdjwZTez1Gqm8nU+YCZmIAsZ63Vidzj/Gu7//ryo9h9
        9He+NBNWjW6V4elzAZic6h5Ntm+w7m8ATCSfAU2++U3Wc9+GDrzV9dI6n3kVsckgX5IOjbRGaLv3F
        fjyauc/Q==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVJf-000NXh-F4; Wed, 13 Jul 2022 05:53:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Song Liu <song@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH 8/9] ext4: only initialize mmp_bdevname once
Date:   Wed, 13 Jul 2022 07:53:16 +0200
Message-Id: <20220713055317.1888500-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713055317.1888500-1-hch@lst.de>
References: <20220713055317.1888500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

mmp_bdevname is currently both initialized nested inside the kthread_run
call in ext4_multi_mount_protect and in the kmmpd thread started by it.

Lift the initiaization out of the kthread_run call in
ext4_multi_mount_protect, move the BUILD_BUG_ON next to it and remove
the duplicate assignment inside of kmmpd.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/mmp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 79d05e464c432..b7a850b0070b8 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -150,8 +150,6 @@ static int kmmpd(void *data)
 	mmp_check_interval = max(EXT4_MMP_CHECK_MULT * mmp_update_interval,
 				 EXT4_MMP_MIN_CHECK_INTERVAL);
 	mmp->mmp_check_interval = cpu_to_le16(mmp_check_interval);
-	BUILD_BUG_ON(sizeof(mmp->mmp_bdevname) < BDEVNAME_SIZE);
-	bdevname(bh->b_bdev, mmp->mmp_bdevname);
 
 	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
 	       sizeof(mmp->mmp_nodename));
@@ -372,13 +370,15 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 	EXT4_SB(sb)->s_mmp_bh = bh;
 
+	BUILD_BUG_ON(sizeof(mmp->mmp_bdevname) < BDEVNAME_SIZE);
+	bdevname(bh->b_bdev, mmp->mmp_bdevname);
+
 	/*
 	 * Start a kernel thread to update the MMP block periodically.
 	 */
 	EXT4_SB(sb)->s_mmp_tsk = kthread_run(kmmpd, sb, "kmmpd-%.*s",
 					     (int)sizeof(mmp->mmp_bdevname),
-					     bdevname(bh->b_bdev,
-						      mmp->mmp_bdevname));
+					     mmp->mmp_bdevname);
 	if (IS_ERR(EXT4_SB(sb)->s_mmp_tsk)) {
 		EXT4_SB(sb)->s_mmp_tsk = NULL;
 		ext4_warning(sb, "Unable to create kmmpd thread for %s.",
-- 
2.30.2

