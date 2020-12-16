Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273812DBE95
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 11:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgLPKYn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 05:24:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:52708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgLPKYn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 05:24:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 455BBAC91;
        Wed, 16 Dec 2020 10:24:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D28F91E135E; Wed, 16 Dec 2020 11:24:00 +0100 (CET)
Date:   Wed, 16 Dec 2020 11:24:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 08/12] ext4: Combine ext4_handle_error() and
 save_error_info()
Message-ID: <20201216102400.GD21258@quack2.suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-9-jack@suse.cz>
 <CAD+ocbwLVsjrB1HRsOm-mD6zm+1Et1C5FcwcGvNmt-AkuZo4Uw@mail.gmail.com>
 <20201216101147.GB21258@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216101147.GB21258@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 16-12-20 11:11:47, Jan Kara wrote:
> On Mon 14-12-20 11:23:04, harshad shirwadkar wrote:
> > On Fri, Nov 27, 2020 at 3:38 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > save_error_info() is always called together with ext4_handle_error().
> > > Combine them into a single call and move unconditional bits out of
> > > save_error_info() into ext4_handle_error().
> > >
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/ext4/super.c | 31 +++++++++++++++----------------
> > >  1 file changed, 15 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index 2d7dc0908cdd..73a09b73fc11 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -592,9 +592,6 @@ static void __save_error_info(struct super_block *sb, int error,
> > >  {
> > >         struct ext4_sb_info *sbi = EXT4_SB(sb);
> > >
> > > -       EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
> > > -       if (bdev_read_only(sb->s_bdev))
> > > -               return;
> > >         /* We default to EFSCORRUPTED error... */
> > >         if (error == 0)
> > >                 error = EFSCORRUPTED;
> 
> ...
> 
> > > @@ -944,13 +943,13 @@ __acquires(bitlock)
> > >         if (test_opt(sb, ERRORS_CONT)) {
> > >                 if (test_opt(sb, WARN_ON_ERROR))
> > >                         WARN_ON_ONCE(1);
> > > +               EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
> > Since you moved the bdev_read_only() check from __save_error_info to
> > ext4_handle_error(), should we add that check here?
> 
> Thanks for the review! Now that I'm looking at it, you're probably right it
> would be safer.  That being said I don't think it really matters:
> a) Because I don't think this function can get called on read-only bdev
> b) Because functions processing the work item will find out the sb is
>    read-only and won't do anything. But it's really wasted work.
> 
> I can see Ted didn't merge this patch yet. So I'll resend the series from
> this patch because after fixing this it required a bit of rebasing. Also I
> have two more additional fixes in the series based on Andreas' feedback.
> 
> Thanks again for looking into the series!

OK, fixed up patches sent:

https://lore.kernel.org/linux-ext4/20201216101844.22917-1-jack@suse.cz

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
