Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AA55874F2
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 03:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiHBBG6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Aug 2022 21:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHBBG5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Aug 2022 21:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B00218375
        for <linux-ext4@vger.kernel.org>; Mon,  1 Aug 2022 18:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E72FD60FED
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 01:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B59FC43470
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 01:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659402415;
        bh=I/a58rWKRG5/Fw8ExkMiEP8PQdWTvktQfUM2uRgKZcA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MsqMjZ4NJS36p/Cb+Meb9qiy9zbvw1m4YM7RvrfqtYhlVuSdOfYAfGhx3Blpl/GuV
         1YGiCPRvga3HR2ezm1a1fPxY+Mbll07vSbjYFEhWzjTRNhvbLadTrYbJR+hoJgTkhp
         a71Sr1sbvEJw98saC+6rP23esalRnN36c3IdLi3B7QHDnWEeJyu/XQULQ3UwfXWodX
         Bd8ETQWwa9gnMt/+RCF5tYaEa41AxBVanlRFuY9DqYkx8v1ywvnNlNc6vbbNBtxfi0
         1m1HLQudKu0DggUU+HC3FwRVz5vCN7nIRtZCXucg1SAbuA8ZwuRSws9mYgq7wdfMFj
         2YvNTZyR9FjCA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 325D5C433E7; Tue,  2 Aug 2022 01:06:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216283] FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Date:   Tue, 02 Aug 2022 01:06:54 +0000
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
Message-ID: <bug-216283-13602-rQFJ8C4k0S@https.bugzilla.kernel.org/>
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

--- Comment #7 from Theodore Tso (tytso@mit.edu) ---
On Tue, Aug 02, 2022 at 08:45:51AM +1000, Dave Chinner wrote:
>=20
> On systems that automount filesytsems when you plug in a USB drive
> (which most distros do out of the box) then a crash bug during mount
> is, at minimum, an annoying DOS vector. And if it can result in a
> buffer overflow, then....

You need physical access to plug in a USB drive, and if you can do
that, the number of potential attack vectors are numerous.  eSATA,
Firewire, etc., gives the potential hardware device direct access to
the PCI bus and the ability to issue arbitrary DMA requests.  Badly
implemented Thunderbolt devices can have the same vulnerability, and
badly implemented USB controllers have their own entertaining issues.
And if attackers have a bit more unguarded physical access time, there
are no shortage of "evil maid" attacks that can be carried out.

As far as I'm concerned a secure system has automounters disabled, and
comptent distributions should disable the automounter when the laptop
is locked.  Enterprise class server class machines running enterprise
distros have no business having the automounter enabled at all, and
careful datacenter managers should fill in the USB ports with epoxy.
For more common sense tips, see:
https://www.youtube.com/watch?v=3Dkd33UVZhnAA

Look, bad buys have the time and energy to run file system fuzzers
(many of which are open source and can be easily found on github).
I'm sure our good friends at the NSA, MSS, and KGB know all of this
already; and the NSO group is apparently happy to make them available
to anyone willing to pay, no matter what their human rights record
might be.

Security by obscurity never works, and as far as I am concerned, I am
grateful when academics run fuzzers and report bugs to us.  Especially
since attacks which require physical access or root privs are going to
have low CVE Security Scores *anyway*.

Cheers,

                                                - Ted

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
