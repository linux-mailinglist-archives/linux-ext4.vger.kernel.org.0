Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB358E412
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Aug 2022 02:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiHJA3t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 20:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHJA3s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 20:29:48 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5EF41AD81
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 17:29:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-193-158.pa.nsw.optusnet.com.au [49.181.193.158])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7EE1E62D628;
        Wed, 10 Aug 2022 10:29:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oLZbV-00BEms-F3; Wed, 10 Aug 2022 10:29:45 +1000
Date:   Wed, 10 Aug 2022 10:29:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     bugzilla-daemon@kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1
 tasks refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Message-ID: <20220810002945.GK3861211@dread.disaster.area>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
 <bug-216322-13602-2MvUDlAfJU@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216322-13602-2MvUDlAfJU@https.bugzilla.kernel.org/>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62f2fbfa
        a=SeswVvpAPK2RnNNwqI8AaA==:117 a=SeswVvpAPK2RnNNwqI8AaA==:17
        a=ZCXp25Omcg5n1RXD:21 a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=VwQbUJbxAAAA:8
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=Qzhb2gN4u6QXIkT9oDwA:9
        a=CjuIK1q_8ugA:10 a=hP7KuYlNnP_hzIlKH_V0:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 04, 2022 at 11:47:47AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216322
> 
> --- Comment #4 from Lukas Czerner (lczerner@redhat.com) ---
> On Thu, Aug 04, 2022 at 12:44:45AM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216322
> > 
> > Theodore Tso (tytso@mit.edu) changed:
> > 
> >            What    |Removed                     |Added
> > ----------------------------------------------------------------------------
> >                  CC|                            |tytso@mit.edu
> > 
> > --- Comment #2 from Theodore Tso (tytso@mit.edu) ---
> > So the problem is that the FITRIM ioctl does not check if a signal is
> > pending,
> > and so if the fstrim program requests that the entire SSD (len=ULLONG_MAX),
> > like the broomstick set off by Mickey Mouse in Fantasia's "Sorcerer's
> > Apprentive", it will mindlessly send discard requests for any blocks not in
> > use
> > by the file system until it is done.   Or to put it another way, "Neither
> > rain,
> > nor snow, or a request to freeze the OS, shall stop the FITRIM ioctl from its
> > appointed task."  :-)
> > 
> > The question is how to fix things.   The problem is that the FITRIM ioctl
> > interface is pretty horrible.   The fstrim_range.len variable is an IN/OUT
> > field where on the input it is the number of bytes that should be trimmed
> > (from
> > start to start+len) and when the ioctl returns fstrm_range.len is the number
> > of
> > bytes that were actually trimmed.   So this is not really amenable for
> > -ERESTARTSYS.
> > 
> > Worse, the fstrim program in util-linux doesn't handle an EAGAIN error return
> > code, so if it gets the EAGAIN after try_to_freeze_tasks send the fake signal
> > to the process, fstrim will print to stderr "fstrim: FITRIM ioctl failed" and
> > the rest of the file system trim operation will be aborted.
> > 
> > It might be that the only way we can fix this is to have FITRIM return
> > EAGAIN,
> > which will stop the fstrim in its tracks.  This is... not great, but
> > typically
> > fstrim is run out of crontab or a systemd timer once a month, so if the user
> > tries to suspend right as the fstrim is running, hopefully we'll get lucky
> > next
> > month.    We can then try teach fstrim to do the right thing, and so this
> > lossage mode would only happen in the combination of a new kernel and an
> > older
> > version of util-linux.
> > 
> > I'm not happy with that solution, but the alternative of creating a new
> > FITRIM2
> > ioctl that has a sane interface means that you need an new kernel and a new
> > util-linux package, and if you don't, the user will have to deal with a hot
> > laptop bag and a drained battery.   And not changing FITRIM's behaviour will
> > have the same potential end result, if the user gets unlucky and tries to
> > suspend the laptop when there is more than 60 seconds left before FITRIM to
> > complete.   :-/
> > 
> > The other thing I'll note is that every file system has its own FITRIM
> > implementation, and I suspect they all have this issue, because the FITRIM
> > interface is fundamentally flawed.
> 
> I agree that the FITRIM interface is flawed in this way. But
> ext4_try_to_trim_range() actually does have fatal_signal_pending() and
> will return -ERESTARTSYS if that's true. Or did you have something else in
> mind?

Why not just do:

	if (freezing(current))
		break;

After the call to fatal_signal_pending()?

Remember: FITRIM is an -advisory- API. It does not provide any
guarantees that the free space in the filesystem has any specific
operation done on it, nor does the backing store guarantee that it
performs GC on ranges the filesystem discards because discards are
advisory as well!

Hence the FITRIM API isn't a problem here at all - it's purely an
advosiry interface and does not guarantee storage level garbage
collection. Hence if filesystems skip the remaining requested range
because the system is being suspended, then it isn't the end of the
world.  Userspace already has to expect that FITRIM will *do
nothing*, and if userspace is doing FITRIM often enough that suspend
is an issue, the next scheduled userspace FITRIM pass will clean up
what this one skipped...

Hence I don't see any problem with just stopping FITRIM and
returning "no error" if it detects a suspend operation in progress.
Simple logic, easy to retrofit to all filesystems, and doesn't
require any userspace awareness of the issue at all...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
