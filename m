Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2237E58372C
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jul 2022 04:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiG1CrP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 22:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiG1CrP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 22:47:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AA4AD56
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 19:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67D96B8224E
        for <linux-ext4@vger.kernel.org>; Thu, 28 Jul 2022 02:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C55BC433D6
        for <linux-ext4@vger.kernel.org>; Thu, 28 Jul 2022 02:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658976428;
        bh=4ZYxHOSsOj2GXrTjrmj9ByLKBcJyH2ft/w1rDGPkiJ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZdOFFiBpJ9htP7np86rd+42K0VeKJLcOrchG/tkSjB207awHNp74s95tcAJ5xfTh5
         IyNog3L/DpTa6WpXLf28nlI7PcPIK8+3MLuQqPQhyAksdKEmu5EP89hwEd8t2op1O3
         187OgqI3bKKtZipjWblGhDwGyPhGYVGIhoyd0gjYy6HbQNGlhCgc+9wAS48kh97Z4H
         R3c9vF2pmeiVOGFto+d6U585j9+C1Wlp8ZYLO62ARbRAsfHbrEumH88gKZ7OocWy95
         43tGke2quhThe1C8RJEmAcFTWVNXpNBrrW4+iIFxtcIJL6W2/6dChJ7EqdK6mI222j
         XskoBSQiA5HFQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 07512C433E4; Thu, 28 Jul 2022 02:47:07 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216283] FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Date:   Thu, 28 Jul 2022 02:47:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216283-13602-P62ZexpGfa@https.bugzilla.kernel.org/>
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

--- Comment #4 from Theodore Tso (tytso@mit.edu) ---
On Thu, Jul 28, 2022 at 09:22:24AM +1000, Dave Chinner wrote:
> On Wed, Jul 27, 2022 at 01:53:07PM +0200, Lukas Czerner wrote:
> > While I understand the frustration with the fuzzer bug reports like this
> > I very much disagree with your statement about ethical and moral
> > responsibility.
> >=20
> > The bug is in the code, it would have been there even if Wenqing Liu
> > didn't run the tool.
>=20
> i.e. your argument implies they have no responsibility and hence are
> entitled to say "We aren't responsible for helping anyone understand
> the problem or mitigating the impact of the flaw - we've got our
> publicity and secured tenure with discovery and publication!"
>=20
> That's not _responsible disclosure_.

So I'm going to disagree here.  I understand that this is the XFS
position, and so a few years back, the Georgia Tech folks who were
responsible for Janus and Hydra decided not to engage with the XFS
community and stopped reporting XFS bugs.  They continued to engage
with the ext4 community, and I found their reports to be helpful.  We
found and fixed quite a few bugs as a result of their work, and I
sponsored them to get some research funding from Google so they could
do more file system fuzzing work, because I thought their work was a
useful contribution.

I don't particularly worry about "responsible disclosure" because I
don't consider fuzzed file system crashes to be a particularly serious
security concern.  There are some crazy container folks who think
containers are just as secure(tm) as VM's, and who advocate allowing
untrusted containers to mount arbitrary file system images and expect
that this not cause the "host" OS to crash or get compromised.  Those
people are insane(tm), and I don't particularly worry about their use
cases.

If you have a Linux laptop with an automounter enabled it's possible
that when you plug in a USB stick containing a corrupted file system,
it could cause the system to crash.  But that requires physical access
to the machine, and if you have physical access, there is no shortage
of problems you could cause in any case.


> Public reports like this require immediate work to determine the
> scope, impact and risk of the problem to decide what needs to be
> done next.  All public disclosure does is start a race and force
> developers to have to address it immediately.

Nope.  I'll address these when I have time, and I don't consider them
to be particularly urgent, for the reasons described above.

I actually consider this fuzzer bug report to be particularly
well-formed.  Unlike Syzkaller, the file system image was in a
separate file, and wasn't embedded in the reproducer.c file in a way
that made it super-inconvenient to extract.  Furthermore, like the
Georgia Tech fuzzing reports, I appreciate that it was filed in
Bugzilla, since it won't easily get lost, with all of the information
that we need.

In any case, I've taken a closer look at this report, and it's
actually quite the interesting problem.  The issue is that we have an
non-leaf node in the extent tree where eh_entries header field is
zero.  This should never happen:

debugfs: extents <16>
Level Entries       Logical      Physical Length Flags
 0/ 2   1/  1     0 - 98030  9284          98031
 1/ 2   1/  0     0 - 98030  9282          98031 <=3D=3D=3D=3D=3D=3D
          ^^^
 2/ 2   1/ 84     0 -     0  9730 -  9730      1=20
 2/ 2   2/ 84     5 -     7  9739 -  9741      3=20
 2/ 2   3/ 84    16 -    17  9750 -  9751      2=20
 2/ 2   4/ 84    26 -    26  9768 -  9768      1=20
 2/ 2   5/ 84    36 -    36  9787 -  9787      1=20

This causes len to go negative in ext4_extent_insert_extent:

[   26.419401] ino 16 len -1 logical 98040 eh_entries 0 eh_max 84 depth 1

... which is what triggers the BUG_ON(len < 0).

What makes this particularly interesting is that neither the kernel
*nor* e2fsck is flagging this extent tree as corrupt.  So this is an
opportunity to improve both the kernel as well as fsck.ext4.

Again, it's not an *urgent* issue, but it is something that is worth
trying to improve in ext4 from the perspective of improving the
quality of our implementation.  And since it's not an urgent issue,
concerns of "responsble disclosure" don't arise, at least not in my
opinion.

                                        - Ted

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
