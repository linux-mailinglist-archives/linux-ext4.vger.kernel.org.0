Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B97B8661
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Oct 2023 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjJDRXI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Oct 2023 13:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjJDRXI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Oct 2023 13:23:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87019E
        for <linux-ext4@vger.kernel.org>; Wed,  4 Oct 2023 10:23:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74653C433CA
        for <linux-ext4@vger.kernel.org>; Wed,  4 Oct 2023 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696440185;
        bh=Pbk22zZ/nrF7qMLUcL/1WAzMmZdSyPQEvEwWN37iBDg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FWklvtnLftnK5KcPwWuI6We7PnV/XetIh3sCRIat1dv6sXuTkHL8acrzplwrj6PMp
         OuDI+qOMcMlqKeobmxwKITbDjSkPqLde6G7J8uAxudk3fy9OXYvJCGxve+g8m+0hiC
         EYipiB3wHRTSS2okUcBl5dmWH/XHboMnap94LHWVGofAfddzfU8CWfVgGalQZ0H1S5
         CUY8BcO/4QvjjECHEb5WYBiK2ezv08LnhfKj+9KDa2dv7gzc66+BpbumCuXQWtYCOE
         jU+SPJffdNQ9BmjDTkVM3lsKWYvRSGKdpvun0Cg3DFaPupU7gEQ4/VrMkcn4e6QvWG
         V5R3x62zJT+fA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 25987C4332E; Wed,  4 Oct 2023 17:23:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Wed, 04 Oct 2023 17:23:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: iivanich@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-Pcd9ziHWpf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #11 from Ivan Ivanich (iivanich@gmail.com) ---
Hi Ojaswin,

Tried it but unfortunately it gives me nothing useful

[  619.894677] RIP: 0010:mb_find_order_for_block+0x50/0xa0

./scripts/faddr2line vmlinux mb_find_order_for_block+0x50
mb_find_order_for_block+0x50/0xa0:
fs mm ??:0

All required kernel options is enabled
zcat /proc/config.gz |grep -i
'CONFIG_DEBUG_INFO\|CONFIG_SOFTLOCKUP_DETECTOR\|CONFIG_HARDLOCKUP_DETECTOR'=
|grep
-v '#'
CONFIG_DEBUG_INFO=3Dy
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
CONFIG_SOFTLOCKUP_DETECTOR=3Dy
CONFIG_HARDLOCKUP_DETECTOR=3Dy
CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=3Dy

>Also, you mentioned that the CPU gets stuck at 100% util for 10-15mins, do=
es
>it ever come back to normal or does it stay stuck?=20

Yes, it comes back to normal after quite some time.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
