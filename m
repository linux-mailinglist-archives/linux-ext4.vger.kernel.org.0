Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82D372AE3F
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Jun 2023 21:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjFJTD7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 10 Jun 2023 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFJTD6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 10 Jun 2023 15:03:58 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5F41988
        for <linux-ext4@vger.kernel.org>; Sat, 10 Jun 2023 12:03:57 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35AJ3JH6017346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Jun 2023 15:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686423802; bh=MRdeAGoLLRE9sWdpvf4/E+OTq0FKZdr66bFJsrMBcXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=JEmc+TjEsuJn4N5+H7u0TN06G5VZPCbOXaQERpP7qT/lkbaoKishMEOEXhmghSSAt
         gtst/EV8bANNtRJM6MdEohh4nY92iGJSbGgE40ZPAMsE22tEtUCzzPv6nHflf+Fmgx
         nn7OkQ9aDq3UeOAUBKVhCPDBLGuOUouo2r0EhkV7ZeB5W4pTKDjWTX/kKahEcLZUne
         Nwh8ZB+JlssLV3A2XwoOa7IzF5Q3G/+8jEvpfXrpqVJI1vRcbyorVr3T/g3HIY69qO
         u5eAcvxDa6c8fjO7GqJdL2aSqQj4AT7OiNP+AsrwB1wTd4ur2ZRWjcCpI1Sjjy5hkp
         kEgzlhpM8HGtQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A24E115C00B0; Sat, 10 Jun 2023 15:03:19 -0400 (EDT)
Date:   Sat, 10 Jun 2023 15:03:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 10/12] ext4: make ext4_es_insert_delayed_block()
 return void
Message-ID: <20230610190319.GB1436857@mit.edu>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-11-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424033846.4732-11-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 24, 2023 at 11:38:44AM +0800, Baokun Li wrote:
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index a0bfe77d5537..4221b2dafeb5 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1641,9 +1641,8 @@ static void ext4_print_free_blocks(struct inode *inode)
>  static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> -	int ret;
> +	int ret = 0;
>  	bool allocated = false;
> -	bool reserved = false;
>  
>  	/*
>  	 * If the cluster containing lblk is shared with a delayed,

Unforuntately, the changes to ext4_insert_delayed_block() in this
patch were buggy, and were causing tests to hang when running
ext4/encrypt, ext4/bigalloc_4k, and ext4/bigalloc_1k test scenarios.
A bisect using "gce-xfstests -c ext4/bigalloc_4k -C 5 generic/579"
pinpointed the problem.

The problem is that ext4_clu_mapped can return a positive value, and
so there are times when we do need to release the space even though
there are no errors.

So I've fixed up your commit with the following changes.  With this
change, the test regressions go away.

Cheers,

						- Ted

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa38092ef868..3a10427240cb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1630,6 +1630,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret = 0;
 	bool allocated = false;
+	bool reserved = false;
 
 	/*
 	 * If the cluster containing lblk is shared with a delayed,
@@ -1646,6 +1647,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		ret = ext4_da_reserve_space(inode);
 		if (ret != 0)   /* ENOSPC */
 			goto errout;
+		reserved = true;
 	} else {   /* bigalloc */
 		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
 			if (!ext4_es_scan_clu(inode,
@@ -1658,6 +1660,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 					ret = ext4_da_reserve_space(inode);
 					if (ret != 0)   /* ENOSPC */
 						goto errout;
+					reserved = true;
 				} else {
 					allocated = true;
 				}
@@ -1668,6 +1671,9 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	}
 
 	ext4_es_insert_delayed_block(inode, lblk, allocated);
+	if (ret && reserved)
+		ext4_da_release_space(inode, 1);
+
 errout:
 	return ret;
 }
