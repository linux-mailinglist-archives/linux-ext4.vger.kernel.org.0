Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B15E37539E
	for <lists+linux-ext4@lfdr.de>; Thu,  6 May 2021 14:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhEFMQ3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 08:16:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:37264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhEFMQ2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 6 May 2021 08:16:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85D71B1BC;
        Thu,  6 May 2021 12:15:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0D3691F2C5C; Thu,  6 May 2021 14:15:29 +0200 (CEST)
Date:   Thu, 6 May 2021 14:15:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: Fix bug on in ext4_es_cache_extent as
 ext4_split_extent_at failed
Message-ID: <20210506121529.GC22189@quack2.suse.cz>
References: <20210428085158.3728201-1-yebin10@huawei.com>
 <20210430125853.GB5315@quack2.suse.cz>
 <60921135.3030900@huawei.com>
 <20210505104105.GA29867@quack2.suse.cz>
 <6093A830.3000704@huawei.com>
 <20210506101915.GA22189@quack2.suse.cz>
 <6093D73F.70909@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6093D73F.70909@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 06-05-21 19:47:11, yebin wrote:
> 
> 
> On 2021/5/6 18:19, Jan Kara wrote:
> > On Thu 06-05-21 16:26:24, yebin wrote:
> > > Thanks for your suggesttion. If you have no objection to following
> > > modification, i will send it as V4.
> > > 
> > > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > > index 77c84d6f1af6..f9cbd11e1eae 100644
> > > --- a/fs/ext4/extents.c
> > > +++ b/fs/ext4/extents.c
> > > @@ -3206,7 +3206,10 @@ static int ext4_split_extent_at(handle_t *handle,
> > >                  ext4_ext_mark_unwritten(ex2);
> > > 
> > >          err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
> > > -       if (err == -ENOSPC && (EXT4_EXT_MAY_ZEROOUT & split_flag)) {
> > > +       if (err != -ENOSPC && err != -EDQUOT)
> > > +                goto out;
> > > +
> > > +       if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
> > You need:
> > 
> > if (err && (EXT4_EXT_MAY_ZEROOUT & split_flag))
> > 
> > there, don't you? You don't want to zero-out if there's no error.
> 
> If (err != -ENOSPC && err != -EDQUOT) already goto out, so there is needn't
> judge "err" again.

Right, my fault. I was confused.

> > > @@ -3232,22 +3235,23 @@ static int ext4_split_extent_at(handle_t *handle,
> > > ext4_ext_pblock(&orig_ex));
> > >                  }
> > > 
> > > -               if (err)
> > > -                       goto fix_extent_len;
> > > -               /* update the extent length and mark as initialized */
> > > -               ex->ee_len = cpu_to_le16(ee_len);
> > > -               ext4_ext_try_to_merge(handle, inode, path, ex);
> > > -               err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> > > -               if (err)
> > > -                       goto fix_extent_len;
> > > -
> > > -               /* update extent status tree */
> > > -               err = ext4_zeroout_es(inode, &zero_ex);
> > > -
> > > -               goto out;
> > > -       } else if (err)
> > > -               goto fix_extent_len;
> > > -
> > > +               if (!err) {
> > > +                       /* update the extent length and mark as initialized
> > > */
> > > +                        ex->ee_len = cpu_to_le16(ee_len);
> > > +                        ext4_ext_try_to_merge(handle, inode, path, ex);
> > > +                        err = ext4_ext_dirty(handle, inode, path +
> > > path->p_depth);
> > > +                        if (!err)
> > > +                               /* update extent status tree */
> > > +                                err = ext4_zeroout_es(inode, &zero_ex);
> > > +                        /* At here, ext4_ext_try_to_merge maybe already
> > > merge
> > > +                         * extent, if fix origin extent length may lead to
> > > +                         * overwritten.
> > > +                         */
> > I'd rephrase the comment as:
> > 
> > /*
> >   * If we failed at this point, we don't know in which state the extent tree
> >   * exactly is so don't try to fix length of the original extent as it may do
> >   * even more damage.
> >   */
> I will replace it with your comment.
> > 
> > > +                        goto out;
> > > +                }
> > > +       }
> > > +        if (err)
> > > +                goto fix_extent_len;
> > And you can move this if (err) before if (!err) above to make code easier
> > to read and save one indentation level.
> if (EXT4_EXT_MAY_ZEROOUT & split_flag) do zero-out,  if  failed, we don't
> need fix extent length.
> But if (!EXT4_EXT_MAY_ZEROOUT & split_flag) we need to fix extent length.
> Maybe i can move
> label "out"  behind  label "fix_extent_len", then this judement can be
> removed.
> Did i misunderstand what you meant earlier?

Thanks for the update! The diff now looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

for your next posting.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
