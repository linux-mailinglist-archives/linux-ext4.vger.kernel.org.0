Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255BC5825E9
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 13:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiG0LxX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 07:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiG0LxW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 07:53:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E11849B7D
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 04:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06BDEB8202F
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 11:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE290C4347C
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 11:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658922795;
        bh=ErMJDgBN5YfYH6KPzp9CdkXYj/lXQm+JSWp0RpEWlr0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dSIwl6O3FY8t0JAtn0b331udN9yF3tFh2qRySlhKbgw8wjQ2GbcevGxHoONTGmScK
         bv6PqIctqKyM9PhUPu/VCIfXruWU8Y0B9WDPmtLQEetkLXhHcFhvYpyRRN/JdsZqgs
         Q8Bl8aNAnZZqnJl5Eeao+icrk7Hek+TnNmXFTlqycdnrMBxFvf/r+p1o74uYVGAJEP
         XwYLiNvBdbMoG6AsEgTcYwe8EvbBbWH+EcFUjkJ8lkEVYRFSsevYlsGDA5fJ+T5hNT
         Fxd+oFDgquo452Nj5PP+QdDDS3lahFci5Hb+5+bc/qMVFIg0ivYLuJXFxGFiaTfrnT
         oNaMldszsxo6Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 95424C433E6; Wed, 27 Jul 2022 11:53:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216283] FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Date:   Wed, 27 Jul 2022 11:53:15 +0000
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
Message-ID: <bug-216283-13602-B3pbXtQvhV@https.bugzilla.kernel.org/>
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

--- Comment #2 from Lukas Czerner (lczerner@redhat.com) ---
On Tue, Jul 26, 2022 at 01:10:24PM -0700, Darrick J. Wong wrote:
> If you are going to run some scripted tool to randomly
> corrupt the filesystem to find failures, then you have an
> ethical and moral responsibility to do some of the work to
> narrow down and identify the cause of the failure, not just
> throw them at someone to do all the work.
>=20
> --D

While I understand the frustration with the fuzzer bug reports like this
I very much disagree with your statement about ethical and moral
responsibility.

The bug is in the code, it would have been there even if Wenqing Liu
didn't run the tool. We know there are bugs in the code we just don't
know where all of them are. Now, thanks to this report, we know a little
bit more about at least one of them. That's at least a little useful.
But you seem to argue that the reporter should put more work in, or not
bother at all.

That's wrong. Really, Wenqing Liu has no more ethical and moral
responsibility than you finding and fixing the problem regardless of the
bug report.

I think the frustration comes from the fact that it's potentially a lot
of work to untangle and fix the real problem and now when it is out
there we feel obligated to fix it. And while bug reports and tools
generating these can always be better and reporters can always be a bit
more active in narrowing the problem down, you're of course free to
ignore this until you, or anyone else, has a bit of spare time and
energy to investigate.

-Lukas

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
