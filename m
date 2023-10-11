Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8247C4C68
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Oct 2023 09:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJKHxn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Oct 2023 03:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjJKHxm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Oct 2023 03:53:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF06D8
        for <linux-ext4@vger.kernel.org>; Wed, 11 Oct 2023 00:53:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E52CC433C7
        for <linux-ext4@vger.kernel.org>; Wed, 11 Oct 2023 07:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697010820;
        bh=S5v0XFFqEChTCSPoUhbnCwjUaPS///XgaT1GXIn5KCE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IDuTNFwrT8SrQKkO6k2Y+uCCf9tW5bFqf2O76MKc0tCkrbVHSObizz2aZJEdGC4ze
         hDI5Qd1ClLwALSnnSIjZvEnDcZDudk5RJrP27rqrzA3nl/tVN3YA/HPB75RwqelUDf
         b50aliFMCWoGdqfatve8XAktnc48gNQmy5q6a2fELj9dfESm2QZze4Xg1noJ4LQIEb
         cpRN/lU0n3iyaaUAfC664gLEg6zsO7d4rXcS9UqniCgr5WVwBQG9nZ0UJhDwSRDATV
         g2nMBIsHjFs0UwXPm4HeYH3BeeO2J25djKslfvxuFszd4DZf8/Q+qH9Z/Q9oNK0MD8
         9TmJ8BqieTVxA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0A2CBC53BD0; Wed, 11 Oct 2023 07:53:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Wed, 11 Oct 2023 07:53:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ojaswin.mujoo@ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-YEM8MziGb7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #12 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hey Ivan,=20

so I used the kernel v6.6-rc1 and the same config you provided as well as w=
ell
as mounted an hdd on my VM. Then I followed the steps here build openwrt [1=
].
However, I'm still unable to replicate the 100% cpu utilization in a
kworker/flush thread (I do get .

Since you have the config options enabled and we didn't see them trigger any
warning and the fact that we get back to normal after a few minutes indicat=
es
that its not a lockup/deadlock. We also see that on faster SSD we don't see
this issue so this might even have something to do with a lot of IOs being
queued up on the slower disk causing us to notice the delay. Maybe we are
waiting a lot more on some spinlock that can explain the CPU utilization.

Since I'm unable to replicate it, I'll have to request you for some more in=
fo
to get to the bottom of this. More specifically, can you kindly provide the
following:

For the kernel with this issue:=20

1. Replicate the 100% util in one terminal window.
2. Once the 100% util is hit, in another terminal run the following command:

$ iostat -x /dev/<dev> 2  (run this for 20 to 30 seconds)=20=20
$ perf record -ag sleep 20
$ echo l > /proc/sysrq_trigger
$ uname -a

3. Repeat the above for a kernel where the issue is not seen.=20

Kindly share the sysrq back trace, iostat output, perf.data and the uname
output  for both the runs here so that I can take a closer look at what is
causing the unusual utilization.

[1] https://github.com/openwrt/openwrt#quickstart


Regards,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
