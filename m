Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DBF6AFDC0
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 05:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCHENY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 23:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCHENX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 23:13:23 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1054E2ED69
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 20:13:20 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3284CrIN013130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 23:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678248774; bh=VGjkpxfGkbQyIgMVSqr1tL9qWwI57H3pwg1+SKgSuBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=P9nESfTldufA08q8I39Vh+TsNF+nJKQEAPvYTNVai0Kv+MuEHXyhlJaheyiWZZu4b
         DDw1ysAUK4HFYqsroDpxMF2pBDz62iJBxBzjkjaG/KQYQlW65dC2H4kiGoRRaPGqFn
         nfTD/RCr2bPOU8m2BLcCLdzaiepkGAyp8xAcin/+3abdqprtkYgQm10AfZYdyihFOI
         fBg4hJNHKulfswWkARPE8V7wdPT1YHW7lzHsaviFMSzKMH0weZH/F1Em2DW5ONoklV
         aXheSXb1Ans1mUgznLRUDYrmQwRYpGUcHxs9Z5jMRFvyU5l8PckOsRMisfv6NMTRDX
         GTyTFLQJpsjig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E0F9E15C3441; Tue,  7 Mar 2023 23:12:52 -0500 (EST)
Date:   Tue, 7 Mar 2023 23:12:52 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     bugzilla-daemon@kernel.org
Cc:     linux-ext4@vger.kernel.org, chengzhihao1@huawei.com
Subject: [PATCH] ext4: swap i_disksize when swaping the boot loader inode
Message-ID: <20230308041252.GC860405@mit.edu>
References: <bug-217159-13602@https.bugzilla.kernel.org/>
 <bug-217159-13602-BE3LDOwNA7@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-217159-13602-BE3LDOwNA7@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following patch fixes the reported issue.

From f4e156cef119f3ffcc56874da4fb9299cc14f68e Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 7 Mar 2023 23:06:59 -0500
Subject: [PATCH] ext4: swap i_disksize when swaping the boot loader inode

Normally well-behaved of EXT4_IOC_SWAP_BOOT won't actually try to
write to the either inode after using the ioctl, but if they do, the
fact that we're not swapping ei->i_disksize as well as inode->i_size
can trigger warnings.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217159
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ioctl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 2e8c34036313..e552c5db0c95 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -329,9 +329,13 @@ static void swap_inode_data(struct inode *inode1, struct inode *inode2)
 	ext4_es_remove_extent(inode1, 0, EXT_MAX_BLOCKS);
 	ext4_es_remove_extent(inode2, 0, EXT_MAX_BLOCKS);
 
-	isize = i_size_read(inode1);
-	i_size_write(inode1, i_size_read(inode2));
-	i_size_write(inode2, isize);
+	/*
+	 * Both inodes are locked, so we don't need to fool around
+	 * with i_size_read() and i_size_write().
+	 */
+	isize = inode1->i_size;
+	inode1->i_size = ei1->i_disksize = inode2->i_size;
+	inode2->i_size = ei2->i_disksize = isize;
 }
 
 void ext4_reset_inode_seed(struct inode *inode)
-- 
2.31.0

