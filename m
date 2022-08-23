Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD2C59EA67
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Aug 2022 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiHWR6W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Aug 2022 13:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiHWR6G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Aug 2022 13:58:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B127C88B7;
        Tue, 23 Aug 2022 09:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A69FEB81E4A;
        Tue, 23 Aug 2022 16:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E3AC433C1;
        Tue, 23 Aug 2022 16:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661270626;
        bh=DcQguS3xcqvdUwJBYUKZFjMYJ1eAQt2jFuBShofNZFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lym0j6r1LtkcJ42JLxWeB7eOzui/CeL8GpRtf2Bf6zpWMwq3sl1gNI+bpnNtQ3RF5
         heF/j9XzObSiiTYJprQpOWl/D30OIekk+ZiCvxb6Nc5SXUqhspkfkCrgQ6oU/07DNb
         u/3nK2TFUZnn+esL4oNgY4lIYkmVtLPDsyqOcquw416NlqcyK/VtNkKkP+Hi531nGO
         DAxj4R9Ve3kAsx0swBwdRIOZPAu10Vr/CLPfRrf6/QzbZoUwAb59mRv2WkA57SVe+i
         vpRnMnwciUk6UHFRVrByeXatrwp1EWU4dyoPGw93se1xEQ3yM9VweGiaVas87S1uO/
         Tfp530/wFr3Sw==
Date:   Tue, 23 Aug 2022 09:03:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lalith Rajendran <lalithkraj@google.com>
Cc:     tytso@mit.edu, dilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] ext4: Make ext4_lazyinit_thread freezable.
Message-ID: <YwT6YelUyY+fjkT4@magnolia>
References: <20220818214049.1519544-1-lalithkraj@google.com>
 <Yv7UYfFBmRTKXNc7@magnolia>
 <CANscXK018_PSLPSeTyne7D+KWHa74kyHmdJ8Bxfxyf=5YMPSfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANscXK018_PSLPSeTyne7D+KWHa74kyHmdJ8Bxfxyf=5YMPSfw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 23, 2022 at 08:37:43AM -0700, Lalith Rajendran wrote:
> Thank you for the comment.
> Can you provide more details on how
> https://lore.kernel.org/linux-fsdevel/20210417001026.23858-1-mcgrof@kernel.org/
> is
> related to your comment to freeze all filesystems in order?

This all got started a long time ago[0] when I noticed that suspend often
fails on my laptop because the kthread freezer will shut down some of
XFS' low level background kernel threads before higher level background
threads have been put to sleep.  In this case, suspend kills the buffer
IO completion thread before the XFS log worker, which means the log
worker stalls trying to write the log contents back to disk:

[0] https://lore.kernel.org/linux-xfs/20170203010401.GR9134@birch.djwong.org/

So I then proposed a patch[1] to mark the buffer completion workqueue as
non-freezeable, which was rejected because while that will bandaid the
suspend problem, it'll create bigger problems with hibernation because
the log and buffer workers can keep running while hibernate tries to
write the state of those threads out to disk:

[1] https://lore.kernel.org/linux-xfs/20170327204611.GA4864@birch.djwong.org/

That came with a suggestion that the power management code should freeze
the filesystems before trying to put kthreads to sleep.  User programs
will go to sleep trying to get write access, and all fs background
threads will already be idle.

Luis Chamberlain offered to pick up that work[2] back in 2017 to figure
out how to freeze filesystems prior to suspend.  His first attempt
simply walked the supers list in reverse order, and drew quite a few
comments.  The second version[3] improved on that.

[2] https://lore.kernel.org/all/20171003185313.1017-1-mcgrof@kernel.org/T/#u
[3] https://lore.kernel.org/all/20171129232356.28296-1-mcgrof@kernel.org/T/#u

Four years went by (I don't blame Luis; I've not had time to get back to
this either) and his most recent posting[4] I think tried to restart the
discussion.

[4] https://lore.kernel.org/linux-fsdevel/20210417001026.23858-1-mcgrof@kernel.org/

So that's where things stand now.  I've idly wondered if a better
approach would be to hook filesystems into the device model so that
filesystems could watch for suspend notifications propagating down the
device tree and turn that into a fsfreeze, but as I mentioned, I've had
no time to figure out how that would really work since I'm not that
familiar with how power management works in the kernel.  I don't have a
clue where you'd attach a network filesystem.

--D

> Thanks,
> Lalith
> 
> On Thu, Aug 18, 2022 at 5:08 PM Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > On Thu, Aug 18, 2022 at 09:40:49PM +0000, Lalith Rajendran wrote:
> > > ext4_lazyinit_thread is not set freezable. Hence when the thread calls
> > > try_to_freeze it doesn't freeze during suspend and continues to send
> > > requests to the storage during suspend, resulting in suspend failures.
> >
> > Maybe we should just make suspend freeze all the filesystems in order?
> >
> >
> > https://lore.kernel.org/linux-fsdevel/20210417001026.23858-1-mcgrof@kernel.org/
> >
> > --D
> >
> > > Signed-off-by: Lalith Rajendran <lalithkraj@google.com>
> > > ---
> > >  fs/ext4/super.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index 9a66abcca1a85..d77e0904a1327 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -3767,6 +3767,7 @@ static int ext4_lazyinit_thread(void *arg)
> > >       unsigned long next_wakeup, cur;
> > >
> > >       BUG_ON(NULL == eli);
> > > +     set_freezable();
> > >
> > >  cont_thread:
> > >       while (true) {
> > > --
> > > 2.31.0
> > >
> >
