Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59764587411
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 00:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiHAWqI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Aug 2022 18:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiHAWqB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Aug 2022 18:46:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591DA2654D
        for <linux-ext4@vger.kernel.org>; Mon,  1 Aug 2022 15:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCC2BB8188F
        for <linux-ext4@vger.kernel.org>; Mon,  1 Aug 2022 22:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A121C433D6
        for <linux-ext4@vger.kernel.org>; Mon,  1 Aug 2022 22:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659393957;
        bh=ll7Aj+nJY0zZm6wGgA0xhFIB3q+Dn404LuuA8aysPAA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=P2XUe1XC56ISZ5LGpfo8gbOOPm/Jns9QGU8yUrcEQZp3HLGQ5UwkjTX+a0STemt2n
         v5DgGPFelx6dDPh6l2a2wzila3iZf6lLfybZFhYoXwlXuE0zyi3vKi0iUC0GP1e5LI
         lBnThlIDsPIo2NDC79XkM1t0C6qllAJ2cX93U993mf8tWghKK1MZcRMwLJUanVpu27
         BuMGq5y88M/kYVXhJ67CwEVNfKT1AOZTc5FxPaSoiLmOG3SZXb1ivZZ1rnlHb7EOsh
         5TVvOSoSek1c6KiXtHIJdfX/1U5L172a907VQyhXCd1eM5Ie31IhURYof6AIA1bXoo
         2W3BPm6/V6waA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 744FFC433E6; Mon,  1 Aug 2022 22:45:57 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216283] FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Date:   Mon, 01 Aug 2022 22:45:57 +0000
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
Message-ID: <bug-216283-13602-5NeMqcQTFu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216283-13602@https.bugzilla.kernel.org/>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216283

--- Comment #6 from Dave Chinner (david@fromorbit.com) ---
On Thu, Jul 28, 2022 at 09:25:10AM +0200, Lukas Czerner wrote:
> On Thu, Jul 28, 2022 at 09:22:24AM +1000, Dave Chinner wrote:
> > On Wed, Jul 27, 2022 at 01:53:07PM +0200, Lukas Czerner wrote:
> > > On Tue, Jul 26, 2022 at 01:10:24PM -0700, Darrick J. Wong wrote:
> > > > If you are going to run some scripted tool to randomly
> > > > corrupt the filesystem to find failures, then you have an
> > > > ethical and moral responsibility to do some of the work to
> > > > narrow down and identify the cause of the failure, not just
> > > > throw them at someone to do all the work.
> > > >=20
> > > > --D
> > >=20
> > > While I understand the frustration with the fuzzer bug reports like t=
his
> > > I very much disagree with your statement about ethical and moral
> > > responsibility.
> > >=20
> > > The bug is in the code, it would have been there even if Wenqing Liu
> > > didn't run the tool.
> >=20
> > Yes, but it's not just a bug. It's a format parser exploit.
>=20
> And what do you think this is exploiting? A bug in a "format parser"
> perhaps?
>=20
> Are you trying both downplay it to not-a-bug and elevate it to 'security
> vulnerability' at the same time ? ;)

How did you come to that conclusion?

"not just a bug" !=3D "not a bug".

i.e. I said the complete opposite of what your comment implies I
said...

> > > We know there are bugs in the code we just don't
> > > know where all of them are. Now, thanks to this report, we know a lit=
tle
> > > bit more about at least one of them. That's at least a little useful.
> > > But you seem to argue that the reporter should put more work in, or n=
ot
> > > bother at all.
> > >=20
> > > That's wrong. Really, Wenqing Liu has no more ethical and moral
> > > responsibility than you finding and fixing the problem regardless of =
the
> > > bug report.
> >=20
> > By this reasoning, the researchers that discovered RetBleed
> > should have just published their findings without notify any of the
> > affected parties.
> >=20
> > i.e. your argument implies they have no responsibility and hence are
> > entitled to say "We aren't responsible for helping anyone understand
> > the problem or mitigating the impact of the flaw - we've got our
> > publicity and secured tenure with discovery and publication!"
> >=20
> > That's not _responsible disclosure_.
>=20
> Look, your entire argument hinges on the assumption that this is a
> security vulnerability that could be exploited and the report makes the
> situation worse. And that's very much debatable. I don't think it is and
> Ted described it very well in his comment.

On systems that automount filesytsems when you plug in a USB drive
(which most distros do out of the box) then a crash bug during mount
is, at minimum, an annoying DOS vector. And if it can result in a
buffer overflow, then....

> Asking for more information, or even asking reported to try to narrow
> down the problem is of course fine.

Sure, nobody is questioning how we triage these issues - the
question is over how they are reported and the forum under which the
initial triage takes place

> But making sweeping claims about
> moral and ethical responsibilities is always a little suspicious and
> completely bogus in this case IMO.

Hand waving away the fact that fuzzer crash bugs won't be a security
issue without having done any investigation is pretty much the whole
problem here. This is not responsible behaviour.

Cheers,

Dave.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
