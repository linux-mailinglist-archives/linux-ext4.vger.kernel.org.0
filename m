Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C9D58E413
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Aug 2022 02:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiHJA34 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 20:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHJA3z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 20:29:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929372F002
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 17:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CE1EB81A3F
        for <linux-ext4@vger.kernel.org>; Wed, 10 Aug 2022 00:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1DF6C433B5
        for <linux-ext4@vger.kernel.org>; Wed, 10 Aug 2022 00:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660091390;
        bh=FeLwp+cJC9FgR5uuKTFwICbD73tU1wW4ppYq0S3VXg8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mSOBnDA18FdQa7MRqxY8kQTMOZ0Arx5Q7OXMMrviyKPTiALKqy7Kf/qBJguC7IsVb
         wG5KUTalfLgEvtvg8W2bz1GeSBhgkvOrna0lf8RuyCBJDM4TQt6jpZCrhUSawkb7cP
         3ueb9TgEPQzscVDJGscpZYc95SyDsLQDR35PkXoqLCQu26yfZfamfq9Wt8+2g3fmxT
         4Zz+LVnBdDkbKgTX+jbav+daKpgimphU6D5Rl/OonpbZXOX3Fvv823t+uyPNvHmQQK
         ARaJBKLtDTRehMiw1xAU5Upw4AhUnYoYIgcoTyuVCLYLf1CfPCsKYENeH8AubVwhN9
         Pq+P/wG4YALQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C6B20C433EA; Wed, 10 Aug 2022 00:29:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Wed, 10 Aug 2022 00:29:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: david@fromorbit.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216322-13602-Mh198xZIfi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

--- Comment #8 from Dave Chinner (david@fromorbit.com) ---
On Thu, Aug 04, 2022 at 11:47:47AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D216322
>=20
> --- Comment #4 from Lukas Czerner (lczerner@redhat.com) ---
> On Thu, Aug 04, 2022 at 12:44:45AM +0000, bugzilla-daemon@kernel.org wrot=
e:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D216322
> >=20
> > Theodore Tso (tytso@mit.edu) changed:
> >=20
> >            What    |Removed                     |Added
> >
> -------------------------------------------------------------------------=
---
> >                  CC|                            |tytso@mit.edu
> >=20
> > --- Comment #2 from Theodore Tso (tytso@mit.edu) ---
> > So the problem is that the FITRIM ioctl does not check if a signal is
> > pending,
> > and so if the fstrim program requests that the entire SSD (len=3DULLONG=
_MAX),
> > like the broomstick set off by Mickey Mouse in Fantasia's "Sorcerer's
> > Apprentive", it will mindlessly send discard requests for any blocks no=
t in
> > use
> > by the file system until it is done.   Or to put it another way, "Neith=
er
> > rain,
> > nor snow, or a request to freeze the OS, shall stop the FITRIM ioctl fr=
om
> its
> > appointed task."  :-)
> >=20
> > The question is how to fix things.   The problem is that the FITRIM ioc=
tl
> > interface is pretty horrible.   The fstrim_range.len variable is an IN/=
OUT
> > field where on the input it is the number of bytes that should be trimm=
ed
> > (from
> > start to start+len) and when the ioctl returns fstrm_range.len is the
> number
> > of
> > bytes that were actually trimmed.   So this is not really amenable for
> > -ERESTARTSYS.
> >=20
> > Worse, the fstrim program in util-linux doesn't handle an EAGAIN error
> return
> > code, so if it gets the EAGAIN after try_to_freeze_tasks send the fake
> signal
> > to the process, fstrim will print to stderr "fstrim: FITRIM ioctl faile=
d"
> and
> > the rest of the file system trim operation will be aborted.
> >=20
> > It might be that the only way we can fix this is to have FITRIM return
> > EAGAIN,
> > which will stop the fstrim in its tracks.  This is... not great, but
> > typically
> > fstrim is run out of crontab or a systemd timer once a month, so if the
> user
> > tries to suspend right as the fstrim is running, hopefully we'll get lu=
cky
> > next
> > month.    We can then try teach fstrim to do the right thing, and so th=
is
> > lossage mode would only happen in the combination of a new kernel and an
> > older
> > version of util-linux.
> >=20
> > I'm not happy with that solution, but the alternative of creating a new
> > FITRIM2
> > ioctl that has a sane interface means that you need an new kernel and a=
 new
> > util-linux package, and if you don't, the user will have to deal with a=
 hot
> > laptop bag and a drained battery.   And not changing FITRIM's behaviour
> will
> > have the same potential end result, if the user gets unlucky and tries =
to
> > suspend the laptop when there is more than 60 seconds left before FITRI=
M to
> > complete.   :-/
> >=20
> > The other thing I'll note is that every file system has its own FITRIM
> > implementation, and I suspect they all have this issue, because the FIT=
RIM
> > interface is fundamentally flawed.
>=20
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

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
