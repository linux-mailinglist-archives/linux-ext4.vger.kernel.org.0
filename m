Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DC755F4B2
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 06:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiF2EA4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 00:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiF2EAo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 00:00:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F068621246
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jun 2022 21:00:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25T40T0R011608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 00:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656475230; bh=s0628K9p7eGhy7ZWq38IIDt3zOoxkb8lIjnRoryiQsA=;
        h=From:To:Cc:Subject:Date;
        b=hptR2O8lGcT2JZLh/GJEDJbfAzFviNr29hGtNKBAYvNMqwU/V6oo5nqey0kosgjqJ
         hg9fYkwaHwK3vEG4TnK3AIhu2Lelxh0hb3wXCxLICml2GzBgr/TajPintRnsImsRWp
         pZwdwKvVWZnqqgTJC6UnJtHUFAehvqM0PFwWjHez7BgrWi2s4pmATfwswnfpIx6pht
         wRPUI7ED4lwhaJVmIsZom17DE8r8K14jJon6mIudByJuJ+cgz6LJCL40YjDjT0XVSD
         deh6R72aUuxwiBSS7V3bXggAJxVRVbIZoe0n2QH5YV3e8aBronRB6dRn0xeZ9iEM2z
         w5Xs0sk3mLqmw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4FDBB15C3E94; Wed, 29 Jun 2022 00:00:29 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 1/2] ext4: update s_overhead_clusters in the superblock during an on-line resize
Date:   Wed, 29 Jun 2022 00:00:25 -0400
Message-Id: <20220629040026.112371-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
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

When doing an online resize, the on-disk superblock on-disk wasn't
updated.  This means that when the file system is unmounted and
remounted, and the on-disk overhead value is non-zero, this would
result in the results of statfs(2) to be incorrect.

This was partially fixed by Commits 10b01ee92df5 ("ext4: fix overhead
calculation to account for the reserved gdt blocks"), 85d825dbf489
("ext4: force overhead calculation if the s_overhead_cluster makes no
sense"), and eb7054212eac ("ext4: update the cached overhead value in
the superblock").

However, since it was too expensive to forcibly recalculate the
overhead for bigalloc file systems at every mount, this didn't fix the
problem for bigalloc file systems.  This commit should address the
problem when resizing file systems with the bigalloc feature enabled.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/ext4/resize.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 8b70a4701293..e5c2713aa11a 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1484,6 +1484,7 @@ static void ext4_update_super(struct super_block *sb,
 	 * Update the fs overhead information
 	 */
 	ext4_calculate_overhead(sb);
+	es->s_overhead_clusters = cpu_to_le32(sbi->s_overhead);
 
 	if (test_opt(sb, DEBUG))
 		printk(KERN_DEBUG "EXT4-fs: added group %u:"
-- 
2.31.0

