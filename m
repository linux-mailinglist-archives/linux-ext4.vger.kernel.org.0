Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48735295F66
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899361AbgJVNJP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Oct 2020 09:09:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:45234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899358AbgJVNJP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 22 Oct 2020 09:09:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92362AF16;
        Thu, 22 Oct 2020 13:09:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 468901E1342; Thu, 22 Oct 2020 15:09:08 +0200 (CEST)
Date:   Thu, 22 Oct 2020 15:09:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v10 2/9] ext4: add fast_commit feature and handling for
 extended mount options
Message-ID: <20201022130908.GD24163@quack2.suse.cz>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-3-harshadshirwadkar@gmail.com>
 <20201021161814.GC25702@quack2.suse.cz>
 <CAD+ocbyCs4DpcCwEtrnh-aodK-p+SWybuKw+ebUrCvKS0uMDaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbyCs4DpcCwEtrnh-aodK-p+SWybuKw+ebUrCvKS0uMDaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 21-10-20 10:31:48, harshad shirwadkar wrote:
> On Wed, Oct 21, 2020 at 9:18 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 15-10-20 13:37:54, Harshad Shirwadkar wrote:
> > > We are running out of mount option bits. Add handling for using
> > > s_mount_opt2. Add ext4 and jbd2 fast commit feature flag and also add
> > > ability to turn off the fast commit feature in Ext4.
> > >
> > > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > > ---
> > >  fs/ext4/ext4.h       |  4 ++++
> > >  fs/ext4/super.c      | 27 ++++++++++++++++++++++-----
> > >  include/linux/jbd2.h |  5 ++++-
> > >  3 files changed, 30 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index 1879531a119f..02d7dc378505 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -1213,6 +1213,8 @@ struct ext4_inode_info {
> > >  #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM        0x00000008 /* User explicitly
> > >                                               specified journal checksum */
> > >
> > > +#define EXT4_MOUNT2_JOURNAL_FAST_COMMIT      0x00000010 /* Journal fast commit */
> > > +
> > >  #define clear_opt(sb, opt)           EXT4_SB(sb)->s_mount_opt &= \
> > >                                               ~EXT4_MOUNT_##opt
> > >  #define set_opt(sb, opt)             EXT4_SB(sb)->s_mount_opt |= \
> > > @@ -1813,6 +1815,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
> > >  #define EXT4_FEATURE_COMPAT_RESIZE_INODE     0x0010
> > >  #define EXT4_FEATURE_COMPAT_DIR_INDEX                0x0020
> > >  #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2    0x0200
> > > +#define EXT4_FEATURE_COMPAT_FAST_COMMIT              0x0400
> > >  #define EXT4_FEATURE_COMPAT_STABLE_INODES    0x0800
> >
> > Is fast commit really a compat feature? IMO if there are fast commits
> > stored in the journal, the filesystem is actually incompatible with the
> > old kernels because data we guranteed to be permanenly stored may be
> > invisible for the old kernel (since it won't replay fastcommit
> > transactions).
> >
> > ...
> >
> > Oh, now I see that the journal FAST_COMMIT is actually incompat. So what's
> > the point of compat ext4 feature with incompat JBD2 feature?
> So having fast commits enabled on an ext4 file system doesn't
> immediately make it incompatible with the older kernels. FS becomes
> incompatible only if there are fast commits blocks that are stored in
> the journal. So, one of the tricks that this patchset does is on a
> clean unmount, since it's guaranteed that there are no fast commit
> blocks in journal, we clear out the JBD2 incompat flag and preserve
> the compat flag in ext4. So, we can think of ext4 compat flag as "FS
> will try fast commits when possible" while jbd2 incompat flag as
> "There are fast commits blocks present in the journal". Does that make
> sense?

Yes, understood. That's clever. Thanks for explanation! But please add the
above justification to the description of EXT4_FEATURE_COMPAT_FAST_COMMIT
feature or somewhere around that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
