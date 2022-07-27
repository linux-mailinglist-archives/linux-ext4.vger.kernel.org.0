Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD1B58359A
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jul 2022 01:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiG0XWh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 19:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiG0XWg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 19:22:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA65A17F
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 16:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C502B82292
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 23:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2D76C433D7
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658964151;
        bh=wBA24UdoKE0hU43dwxI5ytSHTMmwhYnasvJAuJsZO+0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eaTHQsYFnIU41VVw23rGW3/VMmfVv7CKX5dGocHXQP8c8KrLHXtXZ1SlMwLWeKFGc
         OzfD3QFC1LitvPXOC/H1n/+YYWQxlQQDBeBoPW7vif2f9BDvhuiMF0p9OKdvtj8Tpt
         bIJx//xJytGrpsJzgzWbXRBHj8TSIcBgflQ6c0vT3pJwWs1YflZL/XtLWyVTFpW3Qu
         xwDOx9WMBkby2ISqLjdveNbbvumOtjazqsLOkwavv43Afk1pT4TxFE69HrZmDpFL6E
         f1lxniu1I8z2hQwJQVBHZhKBtwGMOUvBkYY42nQKNGUWaeO9OTlOvYQCZ2LBxllJiF
         xCNapDKHZWemw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CC418C433EA; Wed, 27 Jul 2022 23:22:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216283] FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Date:   Wed, 27 Jul 2022 23:22:31 +0000
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
Message-ID: <bug-216283-13602-slKg997shQ@https.bugzilla.kernel.org/>
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

--- Comment #3 from Dave Chinner (david@fromorbit.com) ---
On Wed, Jul 27, 2022 at 01:53:07PM +0200, Lukas Czerner wrote:
> On Tue, Jul 26, 2022 at 01:10:24PM -0700, Darrick J. Wong wrote:
> > If you are going to run some scripted tool to randomly
> > corrupt the filesystem to find failures, then you have an
> > ethical and moral responsibility to do some of the work to
> > narrow down and identify the cause of the failure, not just
> > throw them at someone to do all the work.
> >=20
> > --D
>=20
> While I understand the frustration with the fuzzer bug reports like this
> I very much disagree with your statement about ethical and moral
> responsibility.
>=20
> The bug is in the code, it would have been there even if Wenqing Liu
> didn't run the tool.

Yes, but it's not just a bug. It's a format parser exploit.

> We know there are bugs in the code we just don't
> know where all of them are. Now, thanks to this report, we know a little
> bit more about at least one of them. That's at least a little useful.
> But you seem to argue that the reporter should put more work in, or not
> bother at all.
>=20
> That's wrong. Really, Wenqing Liu has no more ethical and moral
> responsibility than you finding and fixing the problem regardless of the
> bug report.

By this reasoning, the researchers that discovered RetBleed
should have just published their findings without notify any of the
affected parties.

i.e. your argument implies they have no responsibility and hence are
entitled to say "We aren't responsible for helping anyone understand
the problem or mitigating the impact of the flaw - we've got our
publicity and secured tenure with discovery and publication!"

That's not _responsible disclosure_.

Yup, this is important enough that we actually have a name for it:
responsible disclosure.

And where do those responsibilities come from? You  guessed it -
they are based on the ethics and morals that guide us towards doing
what is best for the wider community.

> I think the frustration comes from the fact that it's potentially a lot
> of work to untangle and fix the real problem and now when it is out
> there we feel obligated to fix it. And while bug reports and tools
> generating these can always be better and reporters can always be a bit
> more active in narrowing the problem down, you're of course free to
> ignore this until you, or anyone else, has a bit of spare time and
> energy to investigate.

It has nothing to do with the amount of work, nor does it change the
fact that us developers will need to do most of the work. The
problem here is the lack of responsible disclosure that we see
repeatedly with filesystem flaws found by fuzzing the on-disk
format.

Public reports like this require immediate work to determine the
scope, impact and risk of the problem to decide what needs to be
done next.  All public disclosure does is start a race and force
developers to have to address it immediately.

Responsible disclosure gives developers a short window in which they
can perform that analysis without fear that somebody might already
be actively exploiting the problem discovered by the fuzzer. We can
address the problem without extreme urgency, knowing a day or two
while we wait for private discussion and bug fixing to take place
isn't going to make things worse.

That's the issue with drive-by fuzzer bug reporting - the people
that do this have little clue about the potential impact of the
flaws they are discovering. Those people need to be taught that
their responsibility is not to through issues over the wall at other
people, but to work closely with the people that can fix the issues
to have a fix for the problem ready at the same time the issue is
disclosed.

IOWs, they have an ethical and moral responsibility to the wider
community to disclose these issues to relevant developers in a
responsible manner and work with them to fix the problems before the
issues are made public.

Once you look at filesystem fuzzing bugs from a security and exploit
perspective, _everything changes_.

Cheers,

Dave.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
