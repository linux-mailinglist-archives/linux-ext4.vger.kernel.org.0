Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2C0197F18
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Mar 2020 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgC3Ozd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Mar 2020 10:55:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgC3Ozd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Mar 2020 10:55:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3B051ADC9;
        Mon, 30 Mar 2020 14:55:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B72AF1E11AF; Mon, 30 Mar 2020 16:55:31 +0200 (CEST)
Date:   Mon, 30 Mar 2020 16:55:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] ext2fs: Fix off-by-one in dx_grow_tree()
Message-ID: <20200330145531.GF26544@quack2.suse.cz>
References: <20200330090932.29445-1-jack@suse.cz>
 <20200330090932.29445-3-jack@suse.cz>
 <20200330132712.ckevhpof4vrsx5rw@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330132712.ckevhpof4vrsx5rw@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 30-03-20 15:27:12, Lukas Czerner wrote:
> On Mon, Mar 30, 2020 at 11:09:32AM +0200, Jan Kara wrote:
> > There is an off-by-one error in dx_grow_tree() when checking whether we
> > can add another level to the tree. Thus we can grow tree too much
> > leading to possible crashes in the library or corrupted filesystem. Fix
> > the bug.
> 
> Looks good, thanks
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> 
> Don't we have basically the same off-by-one in
> e2fsck/pass1.c handle_htree() ?
> 
>        if ((root->indirect_levels > ext2_dir_htree_level(fs)) &&
>            fix_problem(ctx, PR_1_HTREE_DEPTH, pctx))

I don't think so. It is indeed correct for root->indirect_levels to be
equal to ext2_dir_htree_level(). However dx_grow_tree() is going to
increase root->indirect_levels by 1 which is where tree would become
invalid...

								Honza

> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  lib/ext2fs/link.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/ext2fs/link.c b/lib/ext2fs/link.c
> > index 7b5bb022117c..469eea8cd06d 100644
> > --- a/lib/ext2fs/link.c
> > +++ b/lib/ext2fs/link.c
> > @@ -473,7 +473,7 @@ static errcode_t dx_grow_tree(ext2_filsys fs, ext2_ino_t dir,
> >  		    ext2fs_le16_to_cpu(info->frames[i].head->limit))
> >  			break;
> >  	/* Need to grow tree depth? */
> > -	if (i < 0 && info->levels > ext2_dir_htree_level(fs))
> > +	if (i < 0 && info->levels >= ext2_dir_htree_level(fs))
> >  		return EXT2_ET_DIR_NO_SPACE;
> >  	lblk = size / fs->blocksize;
> >  	size += fs->blocksize;
> > -- 
> > 2.16.4
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
