Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 632E15D8BA
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 02:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfGCA1m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jul 2019 20:27:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32964 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726291AbfGCA1m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jul 2019 20:27:42 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x62K4xws015816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Jul 2019 16:05:00 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6E45542002E; Tue,  2 Jul 2019 16:04:59 -0400 (EDT)
Date:   Tue, 2 Jul 2019 16:04:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        stable@kernel.org
Subject: Re: [PATCH] ext4: allow directory holes
Message-ID: <20190702200459.GF3032@mit.edu>
References: <20190621041039.25337-1-tytso@mit.edu>
 <962DF4E5-4D71-45BD-A41F-05BDB0A2B599@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962DF4E5-4D71-45BD-A41F-05BDB0A2B599@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 23, 2019 at 09:52:15PM -0600, Andreas Dilger wrote:
> > @@ -179,13 +178,6 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
> > 		}
> > 
> > 		if (!bh) {
> > -			if (!dir_has_error) {
> > -				EXT4_ERROR_FILE(file, 0,
> > -						"directory contains a "
> > -						"hole at offset %llu",
> > -					   (unsigned long long) ctx->pos);
> > -				dir_has_error = 1;
> > -			}
> 
> > 			/* corrupt size?  Maybe no more blocks to read */
> > 			if (ctx->pos > inode->i_blocks << 9)
> > 				break;
> >                         ctx->pos += sb->s_blocksize - offset;
> 
> It seems that ext4_map_blocks() will return m_len with the length of the hole,
> so it would make sense to skip all of the blocks in the hole rather than trying
> to read all of them, in case the directory is mostly sparse.  This could avoid
> a bunch of kernel spinning.
> 
> Also, there is a separate question of whether ext4_map_blocks() will return 0
> in the case of a hole, according to the function comment:
> 
>  * It returns 0 if plain look up failed (blocks have not been allocated), in
>  * that case, @map is returned as unmapped but we still do fill map->m_len to
>  * indicate the length of a hole starting at map->m_lblk.
> 
> in which case "bh" is not reset from the previous loop?

Good catch!  This is a pre-existing bug which you've spotted, and
which we'll want to fix regardless of whether or not the largedir
patch is applied.  I suspect we'll probably need to manually apply
this patch to older kernels, but fortunately directory holes are rare,
and the worst that we will happen is we'll send some duplicate
directory entries to userspace.

> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index 4909ced4e672..f3140ff330c6 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> > @@ -83,7 +83,7 @@ static int ext4_dx_csum_verify(struct inode *inode,
> > 			       struct ext4_dir_entry *dirent);
> > 
> > typedef enum {
> > -	EITHER, INDEX, DIRENT
> > +	EITHER, INDEX, DIRENT, DIRENT_HTREE
> 
> It would be useful to put these one-per-line with a comment explaining each.

What I've done instead is to add a much longer comment explaining why
these directory block types are getting are getting passed to
ext4_read_dirblcok() in the first place.  A comment saying "this is
expected to be an index block" doesn't actually add that much value,
but you're absolutely right that we should have better documentation
here.

						- Ted
