Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44EF7B60FA
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Oct 2023 08:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjJCGuQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Oct 2023 02:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJCGuP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Oct 2023 02:50:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F643AC
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 23:50:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAA89C433CA
        for <linux-ext4@vger.kernel.org>; Tue,  3 Oct 2023 06:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696315813;
        bh=Pa7huweICdqzg+qr1Zo79huZUs41deJGtNow42HjGkg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hl/lllSKJjIle74rsBe/4QDWkRMyntTsHaJyMJwxW+v/D6gxj24OmnTFSep1jACc8
         rFtXR4iKCgrjORQHIqy4BQ+h2yS+a6R73qcLkxkIm8vfDClUkJ09cIY51aRKjaGj1I
         OswYtVMM7Qa5cf1QeVOcxUwA5Q83paIXPff4S52cZ9yPREhzrmyY2kMuFC7QC0Ml/B
         Q4ifAiW0p+B19tH7YAJ/NJHZZQrojyg+LSQ00OX2C0oA6KNYC8xvtMgDJxvpiO7DzD
         Ps2a7yuAuJNB+SyoXcmewHe8vSSEB2UIbqRv2UY32tR6Rrjc/aCKAtmiFdJulEolHL
         Gep/lzhVXo9yg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CD7BCC53BD0; Tue,  3 Oct 2023 06:50:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Tue, 03 Oct 2023 06:50:12 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217965-13602-F4YcPSodG7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

Ojaswin Mujoo (ojaswin.mujoo@ibm.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ojaswin.mujoo@ibm.com

--- Comment #5 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hi Ivan,=20

Thanks for sharing the additional information. So I can see that you are
passing stripe=3D32752 and from the backtrace and I do see some of the func=
tions
in the trace that indicate that a striped allocation was taking place. There
were some changes in the allocator in 6.5 kernel if I'm not wrong but I'll =
need
to try to replicate this to confirm if the issue is related to those and up=
date
here.

Meanwhile, can you provide some more info on the following:

1. I want to check if this issue is related to the striped allocation code =
path
or if its also seen in the usual path. To check that, will it be possible f=
or
you to run the same workload without passing "stripe=3D32752" option during=
 mount
time?=20

2. How often do you see this issue, is it noticeable 100% of times?=20

Regards,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
