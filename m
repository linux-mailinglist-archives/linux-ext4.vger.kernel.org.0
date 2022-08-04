Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69E2589DD9
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiHDOqD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 10:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbiHDOqA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 10:46:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A671A39A
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 07:45:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F97F60C7A
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 14:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE858C433C1
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659624356;
        bh=Or0sKAANoQZvPPUWjjVvODQJyeaD4RS1s6OX3f+cZtE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JKUXdUkZvwhDeUjCvOyPtfUqUCwfBBDYI9VW5H53jd43LCX4CCncS3BiKfcS1LCTU
         VWoKJMgQ0WqRKEI4Rjqtju08ALmKz6fJTDkykZk44xGc5BPIzlb0hWrMtS/s9Fgw/S
         yLoEk4+AkV2HGyZ4E4IiMOzYUBcHniSIno1SfNK4zZ7e87xaF7YGYN7EIP6sQlQm0U
         tOrPgchOfXSCVAXdLyE8Ak8wixrWA1BG+OCiJfsIixBhjSMPq9I2xEpz3IHKa7+OzY
         el235wxQRaWMLLN+uQtkpOx22yUERgeXLOoSwErExgG9MBxrYIP85oCFL3MY603jGF
         d0XCbbftpbXNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 982E2C433EA; Thu,  4 Aug 2022 14:45:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Thu, 04 Aug 2022 14:45:56 +0000
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
Message-ID: <bug-216322-13602-cDr2h08iqz@https.bugzilla.kernel.org/>
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

--- Comment #5 from Theodore Tso (tytso@mit.edu) ---
On Thu, Aug 04, 2022 at 11:47:47AM +0000, bugzilla-daemon@kernel.org wrote:
>=20
> I agree that the FITRIM interface is flawed in this way. But
> ext4_try_to_trim_range() actually does have fatal_signal_pending() and
> will return -ERESTARTSYS if that's true. Or did you have something else in
> mind?

The fatal_signal_pending() only checks for SIGKILL.  I'm not sure why
it returns ERESTARTSYS, since that's not applicable for a kill -9
signal.  The fake_signal_wake_up() function in kernel/freezer.c
doesn't send a fatal signal, so the fatal_signal_pending() check isn't
going to help here.

> Also in that case, I see no reason why we would not be able to adjust
> the fstrim_range to make it easier to re-start where we left off if
> we're going to return -ERESTARTSYS. I am missing something?

Well, we could adjust fstrim_range.start and fstrim_range.len to make
it easier to restart --- but that's only if we know for sure that
we're going to be restarting the system call.  So we need to break
some abstraction barriers since if the signal is one where based on
the sigaction flags, the system all is *not* restarted, then
fstrim_range.len is supposed to contain the number of bytes trimmed.

And even if the system call is restarted, there's no place to stash
the number of bytes trimmed so far, since fstrim_range.len is
overloaded.   This why the interface is so horrible...

> I have not had time to look deeply into the traces, but are you actually
> sure that we're not stuck in blkdev_issue_discard() instead?

I'm not 100% certain, but unless the block device has been put to
sleep first (in which case I think we would have noticed much sooner
since lots of other suspend-to-ram use cases would be failling --- in
writeback threads, for example), I'd be really surprised if we're
getting stuck there.

Even when we need to wait for the queue to be drained so there is
space to send the next discard, that shouldn't take 60+ seconds.

                                               - Ted

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
