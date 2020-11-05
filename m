Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623402A7EDD
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Nov 2020 13:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgKEMoZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 07:44:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:34180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730439AbgKEMoY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 5 Nov 2020 07:44:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C44A5ABAE;
        Thu,  5 Nov 2020 12:44:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7F6C41E130F; Thu,  5 Nov 2020 13:44:22 +0100 (CET)
Date:   Thu, 5 Nov 2020 13:44:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 04/10] ext4: clean up the JBD2 API that initializes fast
 commits
Message-ID: <20201105124422.GC32718@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-5-harshadshirwadkar@gmail.com>
 <20201103162943.GH3440@quack2.suse.cz>
 <CAD+ocbykJ61MmkLqq78p=AOT0f_6j066J3ivNHjXJVbtLEvNag@mail.gmail.com>
 <20201105103024.GA32718@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105103024.GA32718@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 05-11-20 11:30:24, Jan Kara wrote:
> On Wed 04-11-20 11:52:24, harshad shirwadkar wrote:
> > On Tue, Nov 3, 2020 at 8:29 AM Jan Kara <jack@suse.cz> wrote:
> > > > -int jbd2_fc_init(journal_t *journal, int num_fc_blks)
> > > > +int jbd2_fc_init(journal_t *journal)
> > > >  {
> > > > -     journal->j_fc_wbufsize = num_fc_blks;
> > > > -     journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > > > -                             sizeof(struct buffer_head *), GFP_KERNEL);
> > > > -     if (!journal->j_fc_wbuf)
> > > > -             return -ENOMEM;
> > > > +     /*
> > > > +      * Only set j_fc_wbufsize here to indicate that the client file
> > > > +      * system is interested in using fast commits. The actual number of
> > > > +      * fast commit blocks is found inside jbd2_superblock and is only
> > > > +      * valid if j_fc_wbufsize is non-zero. The real value of j_fc_wbufsize
> > > > +      * gets set in journal_reset().
> > > > +      */
> > > > +     journal->j_fc_wbufsize = JBD2_MIN_FC_BLOCKS;
> > > >       return 0;
> > > >  }
> > >
> > > When looking at this, is there a reason why jbd2_fc_init() still exists?  I
> > > mean why not just make the rule that the journal has FC block number set
> > > iff FC gets enabled? Anything else seems a bit confusing to me and also
> > > dangerous - imagine we have fs with FC running, we write some FCs and then
> > > crash. Then on system recovery we mount with no_fc mount option. We have
> > > just lost data on the filesystem AFAIU... So I'd just remove all the mount
> > > options related to fastcommits and leave everything to the journal setup
> > > (which can be modified with e2fsprogs if needed) to keep things simple.
> > The problem is whether or not to use fast commits is the file system's
> > call. The JBD2 feature flag will be cleared on a clean unmount and if
> > we rely solely on the JBD2 feature flag, fast commit will be turned
> > off after a clean unmount. Whereas the FS compat flag is the source of
> > truth about whether fast commit needs to be used or not. That's why we
> > need an API for the file system to tell JBD2 to still do fast commits.
> 
> Yes, I meant the API could be just that the filesystem either calls
> jbd2_journal_set_features() with FASTCOMMIT feature or it won't. Similarly
> to how e.g. JBD2_FEATURE_INCOMPAT_64BIT is handled. No need for
> jbd2_fc_init() function AFAICT.
> 
> > Mount options that override the feature flag in Ext4 were mainly meant
> > for debugging purposes. So, perhaps there should be a clear warning
> > message in the kernel if any of these options are used? Even if we get
> > rid of the mount options, we still need the jbd2_fc_init() API for the
> > FS to tell JBD2 that it wants to use fast commit. Note that even if
> > jbd2_fc_init() is not called, JBD2 will still try to replay fast
> > commit blocks.

I forgot to add here: I don't like "debug-only" mount options in production
kernels because users tend to try them out and:
a) occasionally get burnt by unexpected behavior
b) the options become hard to get rid of because someone starts to depend
on them.

So I'd prefer that the options are removed unless they are really essential
for debugging the feature and if they are essential, they should be clearly
marked as debug aid... (e.g. with debug in the name or so).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
