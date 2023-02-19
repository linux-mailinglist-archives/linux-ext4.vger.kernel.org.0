Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF1669BE65
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 04:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBSDgX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Feb 2023 22:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBSDgW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Feb 2023 22:36:22 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1D312597
        for <linux-ext4@vger.kernel.org>; Sat, 18 Feb 2023 19:36:20 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31J3ZoRG006365
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Feb 2023 22:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676777753; bh=j7YlrAfqcuFYaIgXx6zr4omh8un8x6oickF4MH1fvQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=X7tTvyLm0yAHPvVwuqnQh/LnzSDzc7v6aowX+mpgb7k35n1BMd57rtXo2Vyqj9OlQ
         YBnu+oTcmuKo5+RoG/XSUW0eZFHqQV90MQOT77kDpSlxt6ti9nY3nsuQoNWWLH/GMT
         q/qGDsJyXfhU9xd3kzEBjaYGBM9yM0mVOv5+dOsSgnA1LmozVcwSJAnfq+zXUiocyr
         siwtC6mKFGU+U9f+hCbk9/iKvRpCAs4DM3nQcTfV6oXf01fvdynCJO9Z4LBtENmXAU
         GEdQX9v4zUUViqLhR7Nf9EV3EFB0udUGF1R8+Z2BoRzEBASye6wUT0M8rMuXYNmQ/m
         GAc50WA5zNZ3w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0689815C359D; Sat, 18 Feb 2023 22:35:50 -0500 (EST)
Date:   Sat, 18 Feb 2023 22:35:49 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v4 1/2] ext4: fix inode tree inconsistency caused by
 ENOMEM in ext4_split_extent_at
Message-ID: <Y/GZFbRNBWa/1OM3@mit.edu>
References: <20230213040522.3339406-1-zhanchengbin1@huawei.com>
 <20230213040522.3339406-2-zhanchengbin1@huawei.com>
 <20230214114835.hpjr4zgofrcp7hyy@quack3>
 <a666524b-e811-c35e-3f2b-f2d63622f674@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a666524b-e811-c35e-3f2b-f2d63622f674@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 15, 2023 at 04:51:23PM +0800, zhanchengbin wrote:
> > > 
> > > 
> 
> Because failure of read_extent_tree_block indirectly leads to filesystem
> inconsistency in ext4_split_extent_at, I want the filesystem to become
> read-only after failure.

If I understand your concern correctly, the problem you're trying to
solve is that in ext4_ext_create_new_leaf() we can't easily unwind the
file system mutation in process if ext4_find_extent() fails here:

> > > ext4_split_extent_at
> > >   ext4_ext_insert_extent
> > >    ext4_ext_create_new_leaf
> > >     1)ext4_ext_split
> > >       ext4_find_extent
> > >     2)ext4_ext_grow_indepth
> > >       ext4_find_extent      <=======

Is that your concern?

If so, it seems to me that there are two reasons why
ext4_find_extent() could fail.  The first is that it could be because
there is a memory allocation failure.  The second is that there is an
I/O error when it actually tries to read the extent block.

The memory allocation failure case can be solved by passing in
EXT4_EX_NOFAIL to ext4_find_extent() in those cases where we can't
back out safely, and that certainly includes the this code path.

As far as the I/O failure, we shouldn't be forcing a file system error
in ext4_find_extent(), as you have in this patch:

> > > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > > index 9de1c9d1a13d..0f95e857089e 100644
> > > --- a/fs/ext4/extents.c
> > > +++ b/fs/ext4/extents.c
> > > @@ -935,6 +935,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
> > >   		bh = read_extent_tree_block(inode, path[ppos].p_idx, --i, flags);
> > >   		if (IS_ERR(bh)) {
> > > +			EXT4_ERROR_INODE(inode, "IO error reading extent block");

The reason for that is in the case where we are *not* modifying the
file system, and the I/O error is a transient one (for example, maybe
there is a network hiccup in an iSCSI or Fibre Channel attached disk)
we do *not* want to mark the file system as corrupted.

Now, if the *caller* of ext4_find_extent() is in the middle of making
a change to the file system, and we can't easily back out, at that
point, it's totaly fair to mark the file system as inconsistent.  In
the ideal world, we'd try to figure out a way to pre-read in the
necessary bloccks before starting the file system mutation, to reduce
the chances of failing in the middle of the update operation.

Of course, the world is not perfect, and case where we are splitting a
leaf node, and it turns out we need to grow the depth of the tree is a
relatively rare case, and if it turns out we have an unlucky read
operation right when this happens, if we need to stop the system by
calling EXT4_ERROR*, I'm OK with that.  But we should *only* be doing
this particular case, and not in other cases when we might be calling
ext4_find_extent() is a read-only operation (for example, while
looking up a logical to physical block assignment).  After, all the
*vast* majority of calls to ext4_find_extent() will be in read-only
contexts, and so calling EXT4_ERROR_INODE() any time
read_extent_tree_block() might fail is not appropriate.

Does that make sense to you?

Cheers,

						- Ted
