Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655306424F2
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 09:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiLEIpe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 03:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiLEIpE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 03:45:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D4E101D6
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 00:45:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9F3EB80D8E
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 08:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96179C433D7
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 08:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670229900;
        bh=wtkkhudWIRTR3Zx4n/Kj6f8bHZjZixhbRca7Z/Zoung=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DEwKKlnTlMVHB92N1jAgoS295nskY0XTlHPFSXsGvdkaZDmiTq2yzAzAygsfXyDYn
         wBarPF0qJE8hCxN1V72WnnBVJcEi5VgHt12rTgTBeoBkCKP60C9Yd/PHWU1tn4R21p
         3qjp3cq+9uVWJTrSQLDH/wNaygJ/tr7lkyikoiW+faE6ly91q5QfIE225+FZfD+1T2
         OOd7GEXYO8uLXc0orzvy7Kdy2lSQG5fgg4f3td/43ukq1XjhIeg7JKwvfiHGNswYMx
         4cKyn2U5ao769Ow/mwyCDnhmO1+aFNtL3SlkdIjsI94o4swD7z/9cmdciO0G76bcci
         pjDDKcGbftb9Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8129FC433E9; Mon,  5 Dec 2022 08:45:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216775] fanotify reports parent PPID insted of PID for
 FAN_MODIFY events
Date:   Mon, 05 Dec 2022 08:45:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: amir73il@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216775-13602-zRevW8I7tC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216775-13602@https.bugzilla.kernel.org/>
References: <bug-216775-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216775

--- Comment #1 from Amir Goldstein (amir73il@gmail.com) ---
On Mon, Dec 5, 2022 at 7:02 AM <bugzilla-daemon@kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D216775
>
>             Bug ID: 216775
>            Summary: fanotify reports parent PPID insted of PID for
>                     FAN_MODIFY events
>            Product: File System
>            Version: 2.5
>     Kernel Version: 5.15.0
>           Hardware: Intel
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: ext4
>           Assignee: fs_ext4@kernel-bugs.osdl.org
>           Reporter: saikiran.gummaraj@icloud.com
>         Regression: No
>
> Hello,
>
> While I've been developing a library around fanotify in Go, I noticed that
> fanotify subsystem reports the parent process ID in
> fanotify_event_metadata.pid
> instead of the Process ID when mask is set to FAN_MODIFY. I was able to
> confirm
> the error through a test and also manually verifying the PIDs in the audit
> log.
> I did not observe this behaviour for FAN_ACCESS bit.
>
> I've been able to reproduce this on -
>
> Ubuntu 20.04.5 - 5.15.0-53-generic
> Ubuntu 22.10 - 5.19.0-23-generic
>
> It can be reproduced by -
>
> git clone git@github.com:opcoder0/fanotify.git
> cd fanotify
> sudo go test -v
>
> The test "TestWithCapSysAdmFanotifyFileModified" fails reporting pid
> mismatch.
>

It's a test bug.
The modify event with self pid is generated by os.WriteFile()
Either change test to expect modify event with self pid or move
test file creation before starting the listener.

Thanks,
Amir.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
