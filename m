Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77102254DF
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Jul 2020 02:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGTANe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Jul 2020 20:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgGTANe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Jul 2020 20:13:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B57BC0619D2;
        Sun, 19 Jul 2020 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PdaKVDLQ5KEBMPCu6gBOGAf3phFcaHFFbuJFENuyE8w=; b=Q5XZKWRwLPD/B86YayhtJipKJx
        Bm1W1FRmVm+J6BtsUr6U2TDsX2vIYtyMwU4oGNh533W4HgcX7JjhmRUJMJwnNQQYuRT6djSssyia2
        aiFq1gxwpe/gCLHF1+Tbz126U5hzKgVWPM5EmceZySweEtm8RDcQ0d11H7krDsMxpGAv9syQHDAuP
        IG+UooNc3IWJcj9+3q+KIpYaq4AJJfI+s6mHUHspSqPoNp0QDpJglnWZ4vtUQnjSSLi5rEWz1LmcH
        yBdcBW3+jU6oO9OajWNgZRxGDjK+mPfYEZkY9fFXuBayKIA1PAB0gkqrttUjc/O2GymHIBsmrxadc
        MEcYmQtA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxJQx-0003xK-55; Mon, 20 Jul 2020 00:13:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org
Subject: [PATCH] ext2: ext2.h: fix duplicated word + typos
Date:   Sun, 19 Jul 2020 17:13:27 -0700
Message-Id: <20200720001327.23603-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Change the repeated word "the" in "it the the" to "it is the".
Fix typo "recentl" to "recently".
Fix verb "give" to "gives".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org
---
 fs/ext2/ext2.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200717.orig/fs/ext2/ext2.h
+++ linux-next-20200717/fs/ext2/ext2.h
@@ -52,8 +52,8 @@ struct ext2_block_alloc_info {
 	/*
 	 * Was i_next_alloc_goal in ext2_inode_info
 	 * is the *physical* companion to i_next_alloc_block.
-	 * it the the physical block number of the block which was most-recentl
-	 * allocated to this file.  This give us the goal (target) for the next
+	 * it is the physical block number of the block which was most-recently
+	 * allocated to this file.  This gives us the goal (target) for the next
 	 * allocation when we detect linearly ascending requests.
 	 */
 	ext2_fsblk_t		last_alloc_physical_block;
