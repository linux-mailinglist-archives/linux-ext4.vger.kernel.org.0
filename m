Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6A9197F1A
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Mar 2020 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgC3Ozy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Mar 2020 10:55:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgC3Ozy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Mar 2020 10:55:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 61A4FAC66;
        Mon, 30 Mar 2020 14:55:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B72471E11AF; Mon, 30 Mar 2020 16:55:52 +0200 (CEST)
Date:   Mon, 30 Mar 2020 16:55:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] ext2fs: Fix error checking in dx_link()
Message-ID: <20200330145552.GG26544@quack2.suse.cz>
References: <20200330090932.29445-1-jack@suse.cz>
 <20200330090932.29445-2-jack@suse.cz>
 <20200330132440.4kwdwhgsrsnif6ju@work>
 <20200330134853.3icodnii6knomwch@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330134853.3icodnii6knomwch@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 30-03-20 15:48:53, Lukas Czerner wrote:
> On Mon, Mar 30, 2020 at 03:24:40PM +0200, Lukas Czerner wrote:
> > On Mon, Mar 30, 2020 at 11:09:31AM +0200, Jan Kara wrote:
> > > dx_lookup() uses errcode_t return values. As such anything non-zero is
> > > an error, not values less than zero. Fix the error checking to avoid
> > > crashes on corrupted filesystems.
> > 
> > Looks good, thanks.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> 
> of course that should be
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks for review!

								Honza


> 
> -Lukas
> 
> 
> > 
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  lib/ext2fs/link.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/ext2fs/link.c b/lib/ext2fs/link.c
> > > index 6f523aee718c..7b5bb022117c 100644
> > > --- a/lib/ext2fs/link.c
> > > +++ b/lib/ext2fs/link.c
> > > @@ -571,7 +571,7 @@ static errcode_t dx_link(ext2_filsys fs, ext2_ino_t dir,
> > >  	dx_info.namelen = strlen(name);
> > >  again:
> > >  	retval = dx_lookup(fs, dir, diri, &dx_info);
> > > -	if (retval < 0)
> > > +	if (retval)
> > >  		goto free_buf;
> > >  
> > >  	retval = add_dirent_to_buf(fs,
> > > -- 
> > > 2.16.4
> > > 
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
