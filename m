Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716F15020C5
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Apr 2022 04:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348839AbiDOC51 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Apr 2022 22:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiDOC5Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Apr 2022 22:57:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C717533E98
        for <linux-ext4@vger.kernel.org>; Thu, 14 Apr 2022 19:54:58 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23F2sjlt023991
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 22:54:45 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 10A6015C3EB3; Thu, 14 Apr 2022 22:54:45 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Fariya F <fariya.fatima03@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 2/3] ext4: force overhead calculation if the s_overhead_cluster makes no sense
Date:   Thu, 14 Apr 2022 22:54:39 -0400
Message-Id: <20220415025440.2342107-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220415025440.2342107-1-tytso@mit.edu>
References: <CACA3K+iNFkLLuXJ7W5N70sVC+RVVszx-xVQojNUE8NqfWFuSVg@mail.gmail.com>
 <20220415025440.2342107-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the file system does not use bigalloc, calculating the overhead is
cheap, so force the recalculation of the overhead so we don't have to
trust the precalculated overhead in the superblock.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/ext4/super.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 23a9b2c086ed..d08820fdfdee 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5289,9 +5289,18 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * Get the # of file system overhead blocks from the
 	 * superblock if present.
 	 */
-	if (es->s_overhead_clusters)
-		sbi->s_overhead = le32_to_cpu(es->s_overhead_clusters);
-	else {
+	sbi->s_overhead = le32_to_cpu(es->s_overhead_clusters);
+	/* ignore the precalculated value if it is ridiculous */
+	if (sbi->s_overhead > ext4_blocks_count(es))
+		sbi->s_overhead = 0;
+	/*
+	 * If the bigalloc feature is not enabled recalculating the
+	 * overhead doesn't take long, so we might as well just redo
+	 * it to make sure we are using the correct value.
+	 */
+	if (!ext4_has_feature_bigalloc(sb))
+		sbi->s_overhead = 0;
+	if (sbi->s_overhead == 0) {
 		err = ext4_calculate_overhead(sb);
 		if (err)
 			goto failed_mount_wq;
-- 
2.31.0

