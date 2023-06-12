Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CDF72B5A5
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 05:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjFLDFL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Jun 2023 23:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFLDE4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Jun 2023 23:04:56 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD13E57
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 20:04:53 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35C345NX024321
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jun 2023 23:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686539052; bh=kXrdjaB3gEy9FozO0/lGi0YnzWuroW0s5T/31XAqNOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=loJOo3ZdYyhD/Z7WMDtJFnxtS0wup/ql9Rf0otdYdqjDjM/hasA/CwSS0qZQzXu/H
         MNFMrZN3xbLIj7XOoQIkXV47ja8O37n9ZJ6ZPZJUwEWR2OESF4srfmS+w751CyZVS6
         655weYHSanYuyu/Sb4v2WM1VTJTYTDFkf+b5RELbQtE4t3tRARkVduSiVZ6HblmcMf
         Ry25KPu+LcbptAj//TrytLU/jDYg2yNK3Jgkz3TSYrTTzkhSQrJF7rasT1DtBlQZXl
         QgR6zIqGmhKqDA5NHe6JfhggUwkxzwsFeYvJa7tSr0xnQZzkwUgWb4yMePVrgdhSf9
         FJQyu5XS0SJPw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9CD9F15C00B0; Sun, 11 Jun 2023 23:04:05 -0400 (EDT)
Date:   Sun, 11 Jun 2023 23:04:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 10/12] ext4: make ext4_es_insert_delayed_block()
 return void
Message-ID: <20230612030405.GH1436857@mit.edu>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-11-libaokun1@huawei.com>
 <20230610190319.GB1436857@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610190319.GB1436857@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jun 10, 2023 at 03:03:19PM -0400, Theodore Ts'o wrote:
> Unforuntately, the changes to ext4_insert_delayed_block() in this
> patch were buggy, and were causing tests to hang when running
> ext4/encrypt, ext4/bigalloc_4k, and ext4/bigalloc_1k test scenarios.
> A bisect using "gce-xfstests -c ext4/bigalloc_4k -C 5 generic/579"
> pinpointed the problem.
> 
> The problem is that ext4_clu_mapped can return a positive value, and
> so there are times when we do need to release the space even though
> there are no errors.
> 
> So I've fixed up your commit with the following changes.  With this
> change, the test regressions go away.

It turns out my fix was not correct, because I misread the fundamental
problem with the patch.  The issue was in the last patch hunk:
 
-	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
-	if (ret && reserved)
-		ext4_da_release_space(inode, 1);
-
+	ext4_es_insert_delayed_block(inode, lblk, allocated);
 errout:
 	return ret;
 }

The problem is that entering this code hunk, ret could be non-zero.
But when we made ext4_es_insert_delayed_block() to return void.  So
the changes to fs/ext4/inode.c needed to be replaced by this:

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 129b9af53d62..7700db1782dd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1630,7 +1630,6 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret;
 	bool allocated = false;
-	bool reserved = false;
 
 	/*
 	 * If the cluster containing lblk is shared with a delayed,
@@ -1646,8 +1645,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	if (sbi->s_cluster_ratio == 1) {
 		ret = ext4_da_reserve_space(inode);
 		if (ret != 0)   /* ENOSPC */
-			goto errout;
-		reserved = true;
+			return ret;
 	} else {   /* bigalloc */
 		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
 			if (!ext4_es_scan_clu(inode,
@@ -1655,12 +1653,11 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 				ret = ext4_clu_mapped(inode,
 						      EXT4_B2C(sbi, lblk));
 				if (ret < 0)
-					goto errout;
+					return ret;
 				if (ret == 0) {
 					ret = ext4_da_reserve_space(inode);
 					if (ret != 0)   /* ENOSPC */
-						goto errout;
-					reserved = true;
+						return ret;
 				} else {
 					allocated = true;
 				}
@@ -1670,12 +1667,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		}
 	}
 
-	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
-	if (ret && reserved)
-		ext4_da_release_space(inode, 1);
-
-errout:
-	return ret;
+	ext4_es_insert_delayed_block(inode, lblk, allocated);
+	return 0;
 }
 
 /*

						- Ted
