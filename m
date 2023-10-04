Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19A97B7F87
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Oct 2023 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242359AbjJDMof (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Oct 2023 08:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjJDMoe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Oct 2023 08:44:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B21FB0
        for <linux-ext4@vger.kernel.org>; Wed,  4 Oct 2023 05:44:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 203EEC433C9
        for <linux-ext4@vger.kernel.org>; Wed,  4 Oct 2023 12:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696423471;
        bh=PAZX/hCbLB00l/9uG8LPn4tYKIgZZfWXAKnunnT92nc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bfCMxO0Tz8Pu+EPEjLCJGwVIMl+ODxnF3Di6fpfcs/AuOgDPUxXs31EbviTLBiSyB
         v67exov3ZbqeItazckayO86HZO3HNK375+hEzWe2HSUfdprvTQT9RMgqrpB5lnxuON
         lPfPUwHdxd9e8vN5WGtPl00sRcrGlxe4ao3q1kRyUmrSDr/U0T3ID2/EegnK6St2dd
         QzAtE44eYqu298FKorVowVm9QlJpqUOiiCRPZIx6x4F00Xxoir2U6J/DazutKTzE3A
         F/Nyybo8L1MGWBQCN2HJLFG5ijNkeoi8RXYPrK0eZ1G8gu4iyWGtycHpYrUm0Wf5E+
         Zj5JPuea1BMHQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0A44FC53BCD; Wed,  4 Oct 2023 12:44:31 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Wed, 04 Oct 2023 12:44:30 +0000
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
Message-ID: <bug-217965-13602-moueCdh1e5@https.bugzilla.kernel.org/>
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

--- Comment #10 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hi Ivan,=20

So unfortunately I'm not able to replicate it yet at my end. While I try th=
at,
wanted to check if you can give a few things a try,

So it seems like the CPU is stuck at mb_find_order_for_block() called from
mb_find_extent(). I do see a while loop in mb_find_order_for_block() but its
not obvious if its stuck there and if so why.

If possible can you:

1. Recompile the kernel with CONFIG_DEBUG_INFO=3Dy CONFIG_SOFTLOCKUP_DETECT=
OR=3Dy
and CONFIG_HARDLOCKUP_DETECTOR=3Dy which might provide more information in =
dmesg
when the lockup happens.

2. Replicate it once more and note the RIP value in the trace of stuck CPU,=
 for
example in the above trace it was mb_find_order_for_block+0x68 for CPU2.

3. Run the following kernel's source dir to get the corresponding line numb=
er
(CONFIG_DEBUG_INFO needed):

$ ./scripts/faddr2line vmlinux mb_find_order_for_block+0x68

Maybe you can share the code you see in and around those lines as well as t=
he
exact kernel version.

This will help pinpoint the location where the code might be stuck (for exa=
mple
in a loop), which can help root cause this.

Also, you mentioned that the CPU gets stuck at 100% util for 10-15mins, doe=
s it
ever come back to normal or does it stay stuck?=20

Regards,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
