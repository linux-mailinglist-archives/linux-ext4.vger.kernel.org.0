Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97501365B8B
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Apr 2021 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhDTO4R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Apr 2021 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhDTO4P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Apr 2021 10:56:15 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD850C06174A
        for <linux-ext4@vger.kernel.org>; Tue, 20 Apr 2021 07:55:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q136so18624073qka.7
        for <linux-ext4@vger.kernel.org>; Tue, 20 Apr 2021 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EMUE+7g9AAPShrFbWjl+pdzUd8O745U62ZBBqm1YZfU=;
        b=Is7DgcswnbP+glfioZdT3sxbcu49We888g/ODL6jGzFHMzvz6cw0i6WeiArNl3Uvpa
         Td268+nKwV+N3I9LoNvJicwXplBbpZQ2/jIM1iPA463REyKywciX2riF9Q5kpz8YjHPK
         +UUrzTjwGpp2p2Y4oJQN9esLyiKJWwpBPnYsGJhW+1Juymw0VEMSDz8bFdM3RjcroT6F
         mCNhXatHdKpJMzrub0C7XYFxOBEIX1O+xv8FAGa4cCaAnp+9k6a3Z7GUFhJfaZv2RVfr
         AvQHuPRWk2HXIs+UbxUriAkPRSyR5KF2pRKYQL0j7FV2HoL//H0dLeT/Cn7i67hUXZpI
         5Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EMUE+7g9AAPShrFbWjl+pdzUd8O745U62ZBBqm1YZfU=;
        b=Gx3L5IcdJgfwwwJwMJclRUTy12uv1EFPHNzvssYm8WwfXzC4dDP0czSrSDN0rzGN9i
         sF++cQR82rDwVLEXZ+V+IYn9ikm3sj5HtGjWT24tsUMBV8Hu9gmyT0ktsuCa6SLCMA+O
         0SS0QPtUgFdVJTZwC7OiWgD+zXHGYrS6NcwqMIrT8c1DNJstLQFszP5Je567z+OUcXrq
         81NiWAGcMGbVGb4pwvHIvskcuJxVtt6BEkWdalqSQANP07siT2K7gKYp5EWHUr7B//gm
         o7oOzEWwEMr8kDtde4kIBBRHt99Vm74Gg73cdrQHRFuplOMo/YSDmp+3ecxiDp5ovT3s
         Jo/g==
X-Gm-Message-State: AOAM5310L19Tmx+CGWmZDkuREboOl9oRD8u1UN0wluML/bJZ0ADr9vG6
        b2bqINqXW9+RwkSFW/oAAok=
X-Google-Smtp-Source: ABdhPJxRSL2bZyxgL686XGqd34ox7H1LseDepHOdgX3Fvo0fH6vPC63k2M6/G24hO7lppHi6GhJJJg==
X-Received: by 2002:a37:a2c2:: with SMTP id l185mr1144585qke.290.1618930542814;
        Tue, 20 Apr 2021 07:55:42 -0700 (PDT)
Received: from google.com ([2601:4c3:201:ed00:2c6e:cba3:441:d871])
        by smtp.gmail.com with ESMTPSA id h7sm10855707qka.39.2021.04.20.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 07:55:42 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:55:40 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] ext4: wipe filename upon file deletion
Message-ID: <YH7rbBTKAdZgzy9A@google.com>
References: <20210419162100.1284475-1-leah.rumancik@gmail.com>
 <YH4KAHWphO+0xubA@gmail.com>
 <YH41aghszkzcwdDx@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH41aghszkzcwdDx@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 19, 2021 at 09:59:06PM -0400, Theodore Ts'o wrote:
> On Mon, Apr 19, 2021 at 03:53:52PM -0700, Eric Biggers wrote:
> > On Mon, Apr 19, 2021 at 04:21:00PM +0000, Leah Rumancik wrote:
> > > Upon file deletion, zero out all fields in ext4_dir_entry2 besides inode
> > > and rec_len. In case sensitive data is stored in filenames, this ensures
> > > no potentially sensitive data is left in the directory entry upon deletion.
> > > Also, wipe these fields upon moving a directory entry during the conversion
> > > to an htree and when splitting htree nodes.
> > 
> > This should include more explanation about why this is useful, and what its
> > limitations are (e.g. how do the properties of the storage device affect whether
> > the filename is *really* deleted)...
> 
> Well, it might be useful to talk about how this is not a complete
> solution on its own (acknowledge that more changes to make sure
> filenames aren't leaked in the journal will be forthcoming).
> 
> However, there is a limit to how much we can put in a commit
> description, and I'd argue that the people for whom caveats about
> flash devices having old copies of directory blocks which could be
> extracted by a nation-state intelligence angency, etc., are not likely
> going to be the people reading the git commit description.  :-)  That's
> the sort of thing that is best placed in a presentation given at a
> conference, or in a white paper, or in LWN article.
> 
> Commit descriptions are targetted at developers, so a note that "more
> commits to follow" would be appropriate.

I'll add a bit more to the description to help clarify some more.

> 
> > > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > > index 883e2a7cd4ab..df7809a4821f 100644
> > > --- a/fs/ext4/namei.c
> > > +++ b/fs/ext4/namei.c
> > > @@ -1778,6 +1778,11 @@ dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
> > >  		((struct ext4_dir_entry_2 *) to)->rec_len =
> > >  				ext4_rec_len_to_disk(rec_len, blocksize);
> > >  		de->inode = 0;
> > > +
> > > +		/* wipe name_len through and name field */
> > > +		memset(&de->name_len, 0, ext4_rec_len_from_disk(de->rec_len,
> > > +						blocksize) - 6);
> > > +
> 
> This change in dx_move_dirents() does work, but I wonder if it would
> have been better / more efficient to simply zero out the last
> directory entry in dx_pack_dirents() after it is done packing the
> directory entries in the original directory block?
> 
> 

Hmm, I was basing it on the fact that it felt more logical to put it with
the code that actually moves the entry in case move_dirents() is ever called
without a packing after. But I see that move_dirents() and pack_dirents()
are each only called once in do_split() so perhaps moving it to
pack_dirents() would be best.

> > The comment is confusing.  IMO it would make more sense to mention what is *not*
> > being zeroed:
> > 
> > 	/* wipe the dir_entry excluding the rec_len field */
> 
> Or maybe, "wipe everything in the directory entry after the rec_len
> field".

Thanks for the suggestion, I was having a hard time coming up with something
understandable.

> 
> > > @@ -2492,6 +2498,11 @@ int ext4_generic_delete_entry(struct inode *dir,
> > >  			else
> > >  				de->inode = 0;
> > >  			inode_inc_iversion(dir);
> > > +
> > > +			/* wipe name_len through name field */
> > > +			memset(&de->name_len, 0,
> > > +				ext4_rec_len_from_disk(de->rec_len, blocksize) - 6);
> > > +
> > >  			return 0;
> > 
> > And maybe here too, although here why is the condition for setting the inode to
> > 0 not the same as the condition for zeroing the other fields?
> 
> I'd actually suggest wiping the directory entry *before* the "if
> (pde)" statement, and yeah, it's probably best to zap the de->inode
> unconditionally.
> 
> What is going on is if there is a previoud directory entry ("if (pde)
> ...) the the original code wasn't changing the directory entry at all,
> including zero'ing the inode field, but instead simply expanding the
> previous directory entry's rec_len to include the directory entry
> being deleted.  So in the original code, where the goal is to make
> life as easy as possible for undelete programs, skipping "de->inode =
> 0" when it was unnecessary was a good thing.
> 
> But given that the new design goal of the code is, "to heck with
> undelete programs, we want to shred anything that's no longer needed",
> clearing the inode number is fine.
> 
> In fact, what we could actually do is in the if (pde) case, we can zap
> the entire directory entry, include de->rec_len.  The advantage of
> doing that is it becomes a lot easier to verify that the wiping code
> is working correctly.  We can simply check to make sure everything in
> every directory entry after the end of the name (e.g., everything between
> &de->name[de->name_pen) and ((char *) de) + de->rec_len) MUST be zero.
> 

Yes this all makes sense, I'll update it. I'll also add a test similar to what
you described in the fstest I'm working on.

> > Also, maybe use offsetof(struct ext4_dir_entry_2, name_len) instead of '6'...
> 
> Sure.  Someone will still need to look at the definition of struct
> ext4_dir_entry_2 to understand the structure layout, but offsetof(..)
> is going to be a bit more understandable than a magic constant of '6'.
> 

Sounds good to me.

>    	       	     	  		      - Ted
> 

Thanks for the comments,
Leah
