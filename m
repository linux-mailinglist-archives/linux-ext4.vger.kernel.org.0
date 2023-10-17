Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFA07CB811
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Oct 2023 03:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjJQBlY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 21:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQBlX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 21:41:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7359B
        for <linux-ext4@vger.kernel.org>; Mon, 16 Oct 2023 18:41:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06CC3C433CA
        for <linux-ext4@vger.kernel.org>; Tue, 17 Oct 2023 01:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697506882;
        bh=k3dA0eYbqkqMaExw8g922BIgpf/g5lUWZ/HYDxhenR4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r7yaJ03NUk/5E6x9Dc5ONMleoyBnNCtcg73PvOXBTvNjIt5jMPg0vGld6QiIf8dQl
         yyVwzyYTG2aDOmRUU1rjp1By1zwQ583TrXy6Z1Ww47yQNaxGGsl95H3Y/gsxZll3zn
         d7TqgX7oQUJ34vG+wRTmNJHi/hs5aIVO+W2GJJn58EHLMSdJBEr+pcC41XhhGdH3fE
         RUsb8KGVgSV9NXj7W7AIrDgBN9B/yqyeZfe3WUwCmlkb4hDJdlDEFGwf7pJgvDXdAJ
         aZizzYcJrxIj1HUc8XeYL4YTMoprZiUeIn4cHD9qQdGzligjPtXINU0WqqL33xnCy8
         E0X9yca4noBJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E94D2C53BD0; Tue, 17 Oct 2023 01:41:21 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218006] [ext4] system panic when ext4_writepages:2918: Journal
 has aborted
Date:   Tue, 17 Oct 2023 01:41:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: fengchunguo@126.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218006-13602-sySzU4Xe1v@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218006-13602@https.bugzilla.kernel.org/>
References: <bug-218006-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218006

--- Comment #7 from Gary (fengchunguo@126.com) ---
(In reply to Theodore Tso from comment #6)
> Unfortunately the 4.14 kernel was released in 2017, which is over six yea=
rs
> ago.   Most companies where you can pay $$$ to get support for Linux
> distributions based on 4.14 are EOL'ing products based on 4.14.   As far
> upstream kernel developers who are essentially volunteers when people ask
> them for free help, in general, upstream kernel developers do not support
> LTS kernels, and certainly not an LTS kernel as old as 4.14.
>=20
> If there is someone is willing to be the ext4 upstream stable backports
> maintainer, then that person might be willing to provide limited support =
for
> LTS kernels --- but the 4.14 LTS upstream kernel is planned to be EOL'ed =
in
> January 2024, and I had stopped running gce-xfstests on 4.14 LTS kernels
> about a year or so ago.  I barely have time to run gce-xfststs on LTS
> kernels for 6.1, 5.15 and 5.10 every quarter or two, and if someone were =
to
> volunteer to become ext4 stable backports maintainer, I'd encourage them =
to
> focus on 6.6 and 6.1 LTS kernels, with 5.10 and 5.15 LTS kernels as a low=
er
> priority (because most commercial companies are going to be moving off of
> 5.10 LTS in the near future).   But volunteer support for 4.14 LTS?  TO be
> honest, that's extremely unlikely.
>=20
> *If* there is a company that has a misguided business reason to support t=
he
> 4.14 LTS kernel, then of course an employee of that company can certainly
> fund an engineer to to do all of the support that they need.  But quite
> frankly, I'd be encouraging that company to rethink their business case f=
or
> supporting the 4.14 kernel.   It would be probably far more cost effective
> to migrate their customers to a non-pre-historic kernel such as the 6.6 L=
TS
> kernel.

Thanks for your reply.

We will try to debug this issue. For this issue, I think that we should foc=
us
on the below infromation. Emmc error should be one side effect.

[2023-10-13 02:51:08]  [60086.731357] EXT4-fs error (device mmcblk0p44) in
ext4_da_write_end:3210: IO failure
[2023-10-13 02:51:09]  [60086.739386] EXT4-fs (mmcblk0p44): Delayed block
allocation failed for inode 155757 at logical offset 438 with max blocks 25
with error 30
[2023-10-13 02:51:09]  [60086.739388] EXT4-fs (mmcblk0p44): This should not
happen!! Data will be lost
[2023-10-13 02:51:09]  [60086.739388]
[2023-10-13 02:51:09]  [60086.739399] EXT4-fs error (device mmcblk0p44) in
ext4_writepages:2918: Journal has aborted

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
