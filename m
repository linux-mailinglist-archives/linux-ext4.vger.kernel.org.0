Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5FC52D9EA
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 18:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbiESQLu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 12:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiESQLr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 12:11:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F003A30A0
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 09:11:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8909C21B40;
        Thu, 19 May 2022 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652976696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mgfoE43vpk48Zeloq29kAGoYm5fXlzBqVpsTmJDaFSI=;
        b=Uz2Wmb1dyKa1WjwXX77TRMtgtJ81aFrUZyB9bRbXs4lZ57DOUsZDgcD19pDk9/0Bg4ADk/
        lu1DMzsys3C5yD4PnFm/vRVdU7YiP1RYk/1fqT266cgXvwx8RAE0woxoHgHO6hjZnoUW3T
        eQVfQ9WKP1if64JCRU+CxY0Qb0xKB0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652976696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mgfoE43vpk48Zeloq29kAGoYm5fXlzBqVpsTmJDaFSI=;
        b=cUzSyRbUrmgq3VXBkfO3cyv/g9Thfv1uNpAzDo7aDeN5yvIEaHxy2KlT5fI/critRK8E8u
        l6r0NwApUmDIFGCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6C55B2C141;
        Thu, 19 May 2022 16:11:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 19AA2A062F; Thu, 19 May 2022 18:11:33 +0200 (CEST)
Date:   Thu, 19 May 2022 18:11:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v3 2/6] ext4: for committing inode, make
 ext4_fc_track_inode wait
Message-ID: <20220519161133.jrsdapiyizzywkeo@quack3.lan>
References: <20220419173143.3564144-1-harshads@google.com>
 <20220419173143.3564144-3-harshads@google.com>
 <20220427155032.pikb3jdb62732xvi@quack3.lan>
 <CAD+ocbzyHdb+Du+7dDePazue649nr6H=A-pCPo5S1+PSEQMhyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbzyHdb+Du+7dDePazue649nr6H=A-pCPo5S1+PSEQMhyQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 19-05-22 07:28:11, harshad shirwadkar wrote:
> On Wed, 27 Apr 2022 at 08:50, Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 19-04-22 10:31:39, Harshad Shirwadkar wrote:
> > > From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > >
> > > If the inode that's being requested to track using ext4_fc_track_inode
> > > is being committed, then wait until the inode finishes the
> > > commit. Also, add calls to ext4_fc_track_inode at the right places.
> > >
> > > With this patch, now calling ext4_reserve_inode_write() results in
> > > inode being tracked for next fast commit. A subtle lock ordering
> > > requirement with i_data_sem (which is documented in the code) requires
> > > that ext4_fc_track_inode() be called before grabbing i_data_sem. So,
> > > this patch also adds explicit ext4_fc_track_inode() calls in places
> > > where i_data_sem grabbed.
> > >
> > > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > > ---
> > >  fs/ext4/fast_commit.c | 38 ++++++++++++++++++++++++++++++++++++++
> > >  fs/ext4/inline.c      |  3 +++
> > >  fs/ext4/inode.c       |  5 ++++-
> > >  3 files changed, 45 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > > index c278060a15bc..55f4c5ddd8e5 100644
> > > --- a/fs/ext4/fast_commit.c
> > > +++ b/fs/ext4/fast_commit.c
> > > +     /*
> > > +      * If we come here, we may sleep while waiting for the inode to
> > > +      * commit. We shouldn't be holding i_data_sem in write mode when we go
> > > +      * to sleep since the commit path needs to grab the lock while
> > > +      * committing the inode.
> > > +      */
> > > +     WARN_ON(lockdep_is_held_type(&ei->i_data_sem, 1));
> >
> > Note that we can deadlock even if we had i_data_sem for reading because
> > another reader is not allowed to get the rwsem if there is writer waiting
> > for it. So we need to check even that case here.
> I turned the above WARN_ON to check if data_sem is held in either read
> or write mode and now I am seeing many other places where data_sem
> gets grabbed in read mode before calling ext4_fc_track_inode().

Hum, that's unpleasant. Which places BTW? I'd expect this mostly happens in
ext4_map_blocks() paths. Anywhere else?

> We either need to call ext4_fc_track_inode() before all
> ext4_reserve_inode_write() in all those cases, or ensure that places that
> acquire in data_sem in write mode, wait if there's an ongoing commit and
> only then lock data_sem.

Neither is particularly appealing I guess. As we discussed on the call,
probably using extent status tree for the fastcommit code might be a
cleaner option.

> > > +     while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> > > +#if (BITS_PER_LONG < 64)
> > > +             DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> > > +                             EXT4_STATE_FC_COMMITTING);
> > > +             wq = bit_waitqueue(&ei->i_state_flags,
> > > +                                EXT4_STATE_FC_COMMITTING);
> > > +#else
> > > +             DEFINE_WAIT_BIT(wait, &ei->i_flags,
> > > +                             EXT4_STATE_FC_COMMITTING);
> > > +             wq = bit_waitqueue(&ei->i_flags,
> > > +                                EXT4_STATE_FC_COMMITTING);
> > > +#endif
> > > +             prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> > > +             if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
> > > +                     schedule();
> > > +             finish_wait(wq, &wait.wq_entry);
> > > +     }
> > > +
> > >       ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
> > >       trace_ext4_fc_track_inode(handle, inode, ret);
> >
> > As we discussed in the call we should tell lockdep that this is equivalent
> > to lock+unlock of let's say fc_committing_lock and the fastcommit code
> > setting / clearing EXT4_STATE_FC_COMMITTING is equivalent to lock / unlock
> > of fc_committing_lock. That way we get proper lockdep tracking of this
> > waiting primitive.
> Sure, so you mean just adding __acquires() / __releases() annotations
> in these places right?

No. __acquires() and __releases() are sparse annotations. Sparse does also
some lock checking but it is a static checker and is pretty trivial. Here you
need to instrument lockdep. We do similar thing in jbd2 to tell lockdep
that starting a transaction handle effectively behaves as a lock - see the
rwsem_acquire_read() and rwsem_release() in start_this_handle() and
stop_this_handle(), respectively.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
