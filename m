Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA74589B30
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbiHDLry (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDLrv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 07:47:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3F31FCF9
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 04:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F9FAB8244B
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 11:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 687E1C433B5
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659613667;
        bh=UGKbHtEiMaEW9ZyPTzJhhsSZsa9iSv7KWBs4+4KRrlk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=P4SXxAHXyu4dR2pJ0esjS2/xeit1iP9Yp+/V7mIGuKX41Tr+dpwlk4gL9gdXEE9bl
         ln+WkKk68uyif4gYq2FRSkCoCsAqDn0PkJdsA86eQrtQPq0IaYwTHXjMPnNnwNwiZa
         HqVFeiCVBZTrQ+slZE4lUCqIVSAcjvJRpBytFR9KIFU4JROcIU5x0xOXQyGPUT8UjH
         FAnByP5Xw24N2j5lb1RpXmc+Jr/vzAw4KjKfooMNpFvbosozrC+TsOPk6lAh9KR7Mh
         nRETChnKG+Z9VKO7hnSG+3zIY7F7dQQUcLCG4m2q4Pdcl/SqCSB12Ri2cEDnKDsNFp
         VjDaCnypHWLrw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 514FEC433EA; Thu,  4 Aug 2022 11:47:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Thu, 04 Aug 2022 11:47:47 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lczerner@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216322-13602-2MvUDlAfJU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

--- Comment #4 from Lukas Czerner (lczerner@redhat.com) ---
On Thu, Aug 04, 2022 at 12:44:45AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D216322
>=20
> Theodore Tso (tytso@mit.edu) changed:
>=20
>            What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                  CC|                            |tytso@mit.edu
>=20
> --- Comment #2 from Theodore Tso (tytso@mit.edu) ---
> So the problem is that the FITRIM ioctl does not check if a signal is
> pending,
> and so if the fstrim program requests that the entire SSD (len=3DULLONG_M=
AX),
> like the broomstick set off by Mickey Mouse in Fantasia's "Sorcerer's
> Apprentive", it will mindlessly send discard requests for any blocks not =
in
> use
> by the file system until it is done.   Or to put it another way, "Neither
> rain,
> nor snow, or a request to freeze the OS, shall stop the FITRIM ioctl from=
 its
> appointed task."  :-)
>=20
> The question is how to fix things.   The problem is that the FITRIM ioctl
> interface is pretty horrible.   The fstrim_range.len variable is an IN/OUT
> field where on the input it is the number of bytes that should be trimmed
> (from
> start to start+len) and when the ioctl returns fstrm_range.len is the num=
ber
> of
> bytes that were actually trimmed.   So this is not really amenable for
> -ERESTARTSYS.
>=20
> Worse, the fstrim program in util-linux doesn't handle an EAGAIN error re=
turn
> code, so if it gets the EAGAIN after try_to_freeze_tasks send the fake si=
gnal
> to the process, fstrim will print to stderr "fstrim: FITRIM ioctl failed"=
 and
> the rest of the file system trim operation will be aborted.
>=20
> It might be that the only way we can fix this is to have FITRIM return
> EAGAIN,
> which will stop the fstrim in its tracks.  This is... not great, but
> typically
> fstrim is run out of crontab or a systemd timer once a month, so if the u=
ser
> tries to suspend right as the fstrim is running, hopefully we'll get lucky
> next
> month.    We can then try teach fstrim to do the right thing, and so this
> lossage mode would only happen in the combination of a new kernel and an
> older
> version of util-linux.
>=20
> I'm not happy with that solution, but the alternative of creating a new
> FITRIM2
> ioctl that has a sane interface means that you need an new kernel and a n=
ew
> util-linux package, and if you don't, the user will have to deal with a h=
ot
> laptop bag and a drained battery.   And not changing FITRIM's behaviour w=
ill
> have the same potential end result, if the user gets unlucky and tries to
> suspend the laptop when there is more than 60 seconds left before FITRIM =
to
> complete.   :-/
>=20
> The other thing I'll note is that every file system has its own FITRIM
> implementation, and I suspect they all have this issue, because the FITRIM
> interface is fundamentally flawed.

I agree that the FITRIM interface is flawed in this way. But
ext4_try_to_trim_range() actually does have fatal_signal_pending() and
will return -ERESTARTSYS if that's true. Or did you have something else in
mind?

Also in that case, I see no reason why we would not be able to adjust
the fstrim_range to make it easier to re-start where we left off if
we're going to return -ERESTARTSYS. I am missing something?

I have not had time to look deeply into the traces, but are you actually
sure that we're not stuck in blkdev_issue_discard() instead?

-Lukas

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
