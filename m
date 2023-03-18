Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259C56BF756
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Mar 2023 03:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjCRCH7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 22:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRCH7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 22:07:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E33574DF
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 19:07:56 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32I27hPR014331
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 22:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679105265; bh=k8qLgf6Cw3s7LDvzTCnWXsnwAnee0SEfvv3sO096Sls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=a4o//qngWjcH7c0r9Id22PeRaJGITgw4KgCuv+dyd/dr+kDlK5RXoRsmqLoPeCSYC
         aHL6ZHG7DpSDg6m2TSGIhdUfGL95rVxC3Ri2WlolufvJCWc6o68nB9FRycyL2TM/oX
         tnPcTmDiSklIhwxYEpXT7UtSIbFNjHwYCfec8Yu7rHHjNBq5xZXGRfbp/dfYTEYLcB
         rh0/7unMrQ/hgaoJ6UufYCVZn2f4FhHqghBBXgeGHawZzUzos9jMiAeO7ovxDAQo0n
         vJXgfERA0rtsRRIG9pjHrcxsGFNhwtSABTHw9vmFx1LnqY0yyQlxYcZ1aIQN5lYxQJ
         1q9YRGPc6KOMw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 97B9F15C33A7; Fri, 17 Mar 2023 22:07:43 -0400 (EDT)
Date:   Fri, 17 Mar 2023 22:07:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Dan Carpenter <error27@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [bug report] ext4: Fix possible corruption when moving a
 directory
Message-ID: <20230318020743.GO860405@mit.edu>
References: <5efbe1b9-ad8b-4a4f-b422-24824d2b775c@kili.mountain>
 <ZAeOFzbhCNvskQ6b@gmail.com>
 <20230308104234.z7vmgmjz2smepwlg@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308104234.z7vmgmjz2smepwlg@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 08, 2023 at 11:42:34AM +0100, Jan Kara wrote:
> > That analysis looks correct.  FYI, I think this is the same as the syzbot report
> > "[ext4?] WARNING: bad unlock balance in ext4_rename2"
> > (https://lore.kernel.org/linux-ext4/000000000000435c6905f639ae8e@google.com).
> 
> Good spotting! This should be fixed (along with the lock ordering problem)
> by 3c92792da8506 ("ext4: Fix deadlock during directory rename") Ted has
> just merged couple hours ago.

Unfortunately, the Syzkaller report is still triggering after the
merge and commit 3c92792da8506.  The double unlock is still there, and
so the following fix is still needed (which I will be sending to Linus).

       		     	      	     	    - Ted

From 70e42feab2e20618ddd0cbfc4ab4b08628236ecd Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 17 Mar 2023 21:53:52 -0400
Subject: [PATCH] ext4: fix possible double unlock when moving a directory

Fixes: 0813299c586b ("ext4: Fix possible corruption when moving a directory")
Link: https://lore.kernel.org/r/5efbe1b9-ad8b-4a4f-b422-24824d2b775c@kili.mountain
Reported-by: Dan Carpenter <error27@gmail.com>
Reported-by: syzbot+0c73d1d8b952c5f3d714@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/namei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 31e21de56432..a5010b5b8a8c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3884,10 +3884,8 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 				goto end_rename;
 		}
 		retval = ext4_rename_dir_prepare(handle, &old);
-		if (retval) {
-			inode_unlock(old.inode);
+		if (retval)
 			goto end_rename;
-		}
 	}
 	/*
 	 * If we're renaming a file within an inline_data dir and adding or
-- 
2.31.0

