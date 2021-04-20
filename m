Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563A3365009
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Apr 2021 03:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhDTB7m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Apr 2021 21:59:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44675 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233156AbhDTB7l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Apr 2021 21:59:41 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13K1x63K001353
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 21:59:06 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 35A7115C3B0D; Mon, 19 Apr 2021 21:59:06 -0400 (EDT)
Date:   Mon, 19 Apr 2021 21:59:06 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] ext4: wipe filename upon file deletion
Message-ID: <YH41aghszkzcwdDx@mit.edu>
References: <20210419162100.1284475-1-leah.rumancik@gmail.com>
 <YH4KAHWphO+0xubA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH4KAHWphO+0xubA@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 19, 2021 at 03:53:52PM -0700, Eric Biggers wrote:
> On Mon, Apr 19, 2021 at 04:21:00PM +0000, Leah Rumancik wrote:
> > Upon file deletion, zero out all fields in ext4_dir_entry2 besides inode
> > and rec_len. In case sensitive data is stored in filenames, this ensures
> > no potentially sensitive data is left in the directory entry upon deletion.
> > Also, wipe these fields upon moving a directory entry during the conversion
> > to an htree and when splitting htree nodes.
> 
> This should include more explanation about why this is useful, and what its
> limitations are (e.g. how do the properties of the storage device affect whether
> the filename is *really* deleted)...

Well, it might be useful to talk about how this is not a complete
solution on its own (acknowledge that more changes to make sure
filenames aren't leaked in the journal will be forthcoming).

However, there is a limit to how much we can put in a commit
description, and I'd argue that the people for whom caveats about
flash devices having old copies of directory blocks which could be
extracted by a nation-state intelligence angency, etc., are not likely
going to be the people reading the git commit description.  :-)  That's
the sort of thing that is best placed in a presentation given at a
conference, or in a white paper, or in LWN article.

Commit descriptions are targetted at developers, so a note that "more
commits to follow" would be appropriate.

> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index 883e2a7cd4ab..df7809a4821f 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> > @@ -1778,6 +1778,11 @@ dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
> >  		((struct ext4_dir_entry_2 *) to)->rec_len =
> >  				ext4_rec_len_to_disk(rec_len, blocksize);
> >  		de->inode = 0;
> > +
> > +		/* wipe name_len through and name field */
> > +		memset(&de->name_len, 0, ext4_rec_len_from_disk(de->rec_len,
> > +						blocksize) - 6);
> > +

This change in dx_move_dirents() does work, but I wonder if it would
have been better / more efficient to simply zero out the last
directory entry in dx_pack_dirents() after it is done packing the
directory entries in the original directory block?


> The comment is confusing.  IMO it would make more sense to mention what is *not*
> being zeroed:
> 
> 	/* wipe the dir_entry excluding the rec_len field */

Or maybe, "wipe everything in the directory entry after the rec_len
field".

> > @@ -2492,6 +2498,11 @@ int ext4_generic_delete_entry(struct inode *dir,
> >  			else
> >  				de->inode = 0;
> >  			inode_inc_iversion(dir);
> > +
> > +			/* wipe name_len through name field */
> > +			memset(&de->name_len, 0,
> > +				ext4_rec_len_from_disk(de->rec_len, blocksize) - 6);
> > +
> >  			return 0;
> 
> And maybe here too, although here why is the condition for setting the inode to
> 0 not the same as the condition for zeroing the other fields?

I'd actually suggest wiping the directory entry *before* the "if
(pde)" statement, and yeah, it's probably best to zap the de->inode
unconditionally.

What is going on is if there is a previoud directory entry ("if (pde)
...) the the original code wasn't changing the directory entry at all,
including zero'ing the inode field, but instead simply expanding the
previous directory entry's rec_len to include the directory entry
being deleted.  So in the original code, where the goal is to make
life as easy as possible for undelete programs, skipping "de->inode =
0" when it was unnecessary was a good thing.

But given that the new design goal of the code is, "to heck with
undelete programs, we want to shred anything that's no longer needed",
clearing the inode number is fine.

In fact, what we could actually do is in the if (pde) case, we can zap
the entire directory entry, include de->rec_len.  The advantage of
doing that is it becomes a lot easier to verify that the wiping code
is working correctly.  We can simply check to make sure everything in
every directory entry after the end of the name (e.g., everything between
&de->name[de->name_pen) and ((char *) de) + de->rec_len) MUST be zero.

> Also, maybe use offsetof(struct ext4_dir_entry_2, name_len) instead of '6'...

Sure.  Someone will still need to look at the definition of struct
ext4_dir_entry_2 to understand the structure layout, but offsetof(..)
is going to be a bit more understandable than a magic constant of '6'.

   	       	     	  		      - Ted

