Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2100235919F
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 03:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhDIBsH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 21:48:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49416 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232426AbhDIBsG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 21:48:06 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1391lj2Y011058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Apr 2021 21:47:45 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 375E115C3B12; Thu,  8 Apr 2021 21:47:45 -0400 (EDT)
Date:   Thu, 8 Apr 2021 21:47:45 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     yebin <yebin10@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix bug on in ext4_es_cache_extent as
 ext4_split_extent_at failed
Message-ID: <YG+yQfmMMKw3dKl0@mit.edu>
References: <20210325022925.1769056-1-yebin10@huawei.com>
 <YGvWwx/+HMdWMJwT@mit.edu>
 <606D0DE5.8070002@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <606D0DE5.8070002@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 07, 2021 at 09:41:57AM +0800, yebin wrote:
> > > If call ext4_ext_insert_extent failed but new extent already inserted, we just
> > > update "ex->ee_len = orig_ex.ee_len", this will lead to extent overlap, then
> > > cause bug on when cache extent.
> > How did this happen in the first place?  It sounds like if the extent
> > was already inserted, that would be casue there was an on-disk file
> > system corruption, no?
> > 
> > In that case, shouldn't we call ext4_error() to declare the file
> > system has an inconsistency, so it can be fixed by fsck?
> We inject IO fault when runing  fsstress,  JBD detect IO error then trigger
> JBD abort.  At the same time,
> if ext4_ext_insert_extent already insert new exntent then call
> ext4_ext_dirty to dirty metadata , but
> JBD already aborted ,  ext4_ext_dirty will return error.
> In ext4_ext_dirty function call  ext4_ext_check_inode check extent if ok, if
> not, trigger BUG_ON and
> also print extent detail information.

In this particular case, skipping the "ex->ee_len = orig_ex.ee_len"
may avoid the BUG_ON.  But it's not clear that this is always the
right thing to do.  The fundamental question is what should we do we
run into an error while we are in the middle of making changes to
on-disk and in-memory data structures?

In the ideal world, we should undo the changes that we were in the
middle of making before we return an error.  That way, the semantics
are very clear; on success, the function has made the requested change
to the file system.  If the function returns an error, then no changes
should be made.

That was the reasoning behind resetting ex->ee_len to orig_ex.ee_len
in the fix_extent_len inside ext4_split_extent_at().  Unofrtunately,
ext4_ext_insert_extent() does *not* always follow this convention, and
that's because it would be extremely difficult for it to do so --- the
mutations that it makes can be quite complex, including potentially
increasing the height of the extent tree.

However, I don't think your fix is by any means the ideal one, because
the much more common way that ext4_ext_insert_extent() is when it
needs to insert a new leaf node, or need to increase the height of the
extent tree --- and in it returns an ENOSPC failure.  In that case, it
won't have made any changes changes in the extent tree, and so having
ext4_split_extent_at() undo the change to ex->ee_len is the right
thing to do.

Having blocks get leaked when there is an ENOSPC failure, requiring
fsck to be run --- and without giving the user any warning that this
has happened is *not* a good way to fail.  So I don't think the
proposed patch is the right way to go.

A better way to go would be to teach ext4_ext_insert_extent() so if
there is a late failure, that it unwinds the leaf node back to its
original state (at least from a semantic value).  Since the extent
leaf node could have been split, and/or adjacent extent entries may
have been merged, what it would need to do is to remember the starting
block number and length, and make whatever changes are necessaries to
the extent entries in that leaf node corresponding to that starting
block number and length.

If you don't want to do that, then a "do no harm" fix would be
something like this:

	...
	} else if (err == -EROFS) {
		return err;
	} else if (err)
		goto fix_extent_len;

So in the journal abort case, when err is set to EROFS, we don't try
to reset the length, since in theory the file system is read-only
already anyway.  However, in the ENOSPC case, we won't end up silently
leaking blocks that will be lost until the user somehow decides to run
fsck.

There are still times when this doesn't get things completely right
(e.g., what if we get a late ENOMEM error versus an early ENOMEM
failure), where the only real fix is to make ext4_ext_insert_extent()
obey the convention that if it returns an error, it must not result in
any user-visible state change.

Cheers,

						- Ted
