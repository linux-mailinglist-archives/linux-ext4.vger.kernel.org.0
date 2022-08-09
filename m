Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F4D58DD6E
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiHIRsS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 13:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHIRsR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 13:48:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FC635E
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 10:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D03CB816ED
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 17:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B0E1C433C1
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660067294;
        bh=nbk2KKjzuhiPf4oxPz45BoThCRZ9BDKOKFMGWP2FYWg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=juxKaw+QLoBTlNP18XyW2iNU26zSimNkvQ2sVQngKhHNKMIVFRD1akr326ry7omNh
         VYm0AMzncbqm2w/uZGNuKvtM6ZqgdwtAIZhfg03skemjNwS8cImO8qulCS5BMKmhZe
         ZnLQv0H6Q5waT4fsovBZSsrmUvIF+Cz64dq2Z7e4stfYuIXYkLIn4/d1PJ9JXbpJ1Y
         S80mvQJ1eDpwa1FoZckHnidCTyzrsFvz1lZMUHBSrrVs7vFHV5A2IVmVz0pAaVuA/8
         b/smaOq3O48PVsFxilSnlK6IrTfd5w6RdZGJ/y7z80q+2bfD2s1Lg7dlBvuw+BDbQ+
         ZeRyrdOWC7uKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 13CCAC433E6; Tue,  9 Aug 2022 17:48:14 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1 tasks
 refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Date:   Tue, 09 Aug 2022 17:48:13 +0000
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
Message-ID: <bug-216322-13602-tTepK30xfV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216322-13602@https.bugzilla.kernel.org/>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216322

--- Comment #7 from Theodore Tso (tytso@mit.edu) ---
I suspect you got lucky.  Depending on the SSD's performance in processing
discard requests, the size of the file system, and how fragmented the free
space might be, it could take several minutes for the FITRIM as executed by
fstrim(8) to complete.   At the moment, it can be interrupted via a kill -9,
but not anything else.

It wasn't a matter of the FITRIM failing to make progress; it was making
progress, and it was busy sending tons of discard requests to the storage
device.  It was just that it currently ignores "fake signal" sent by the ke=
rnel
when it attempts to suspend userspace processes until it completes its task.

So if the FITRIM normally takes 3 minutes on that particular storage device,
and it suspend was triggered 90 seconds after fstrim(8) was triggered by
cron/systemd, the 60 second timeout would have caused the suspend to fail, =
and
then the next suspend would have worked since the FITRIM would have complet=
ed
before the 60 second timeout expired.

To reproduce this failure, presumably what you would want to do is to mount=
 and
unmount the file system, since FITRIM sets a flag on a block group after it=
 has
been trimmed, which is cleared when blocks are freed in that block group, a=
nd a
subsequent FITRIM will skip block groups that still have the flag set.   Th=
en
trigger the fstrim, and immediately try to suspend the laptop.   If your SS=
D is
sufficiently slow, and your file system is sufficiently large and fragmente=
d,
then you should see it fail.   If not, you could try changing the kernel
timeout to a smaller value, to a value smaller than the time it takes for t=
he
command "time fstrim <mntpnt>":

For example, on my new laptop (a 2021 Samsung Galaxy Pro 360):

% sudo time fstrim /
0.00user 1.32system 1:14.57elapsed 1%CPU (0avgtext+0avgdata 2732maxresident=
)k
176inputs+0outputs (0major+137minor)pagefaults 0swaps
% df -h /
Filesystem      Size  Used Avail Use% Mounted on
/dev/nvme0n1p7  1.1T   28G  996G   3% /

This is a 2TB, so if root file system used the full 2TB of space, it would =
have
taken roughly 2 minutes for fstrim to run, and FITRIM is uninterruptible
(except via a kill -9 signal).

On my Dell Precision Tower development machine, which has an older SSD, thi=
ngs
are even worse:

% sudo time fstrim /
[sudo] password for tytso:=20
0.00user 34.56system 13:27.21elapsed 4%CPU (0avgtext+0avgdata 2724maxreside=
nt)k
10184inputs+0outputs (2major+131minor)pagefaults 0swaps
% df -h /
Filesystem                 Size  Used Avail Use% Mounted on
/dev/mapper/cwcc--vg-root  824G  283G  499G  37% /

Please note, I'm not requesting that the kernel timeout be extended from 60
seconds to 15 minutes.   We need to find some different solution.  :-)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
