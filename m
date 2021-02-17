Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A858931DD7B
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Feb 2021 17:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhBQQil (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Feb 2021 11:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234113AbhBQQik (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 17 Feb 2021 11:38:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 01A2F64E28
        for <linux-ext4@vger.kernel.org>; Wed, 17 Feb 2021 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613579880;
        bh=Ut7LZKvQf5qM1Q8QF/P38PilwvCu98gLZsuM3SZw1cQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NuK6zTpNG9eDmctPQk99duHCWNjoseh2+ozgC0giIc0DY/U2H/+xorV/RbEiWPERW
         kUFmsHdgIpyctkGL1swxMLdZuwYxz/AfKjmJBGdYqeXU24hl99x8CWc36W9Qruat1G
         9/Etyqu/0uj7cvSdLPffZ1znPGn3KjyHXCbV5VrNomf8O4tibe2PErPVMiZgfxp2pO
         lFG5U8c7araTmE+uA8UDDPRvdPAZx1D89uE2ciESVkrVM7PRr7ys87b3Qw6omYCqSq
         citt0/Iyq/MSlf74I/pElZKyVTmRYs8DRF9hLD1fYEmh5wGNVYe6FR4bP6BEPPkEBN
         xIbTCAN1TfF9Q==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id DE92B653C6; Wed, 17 Feb 2021 16:37:59 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211733] ext4 file system unrecoverable corruption
Date:   Wed, 17 Feb 2021 16:37:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211733-13602-hzhpo9qivP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211733-13602@https.bugzilla.kernel.org/>
References: <bug-211733-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211733

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
Free advice?   Before you do anything else, back up *everything* before you
even breathe on the system.  You may think it's not going to reproduce agai=
n,
but if it does, you may end up losing more data.

I tend to keep things very simple.  Which is to say, I try not dual-boot
Windows and Linux, and if I do, I use separate HDD's for the Windows and Li=
nux
systems.   So if I were doing anything like this at all, I'd boot into a Li=
nux
system, and then copy everything from the Windows partition to the Linux
partition in a single go, and then be done with it.   The KISS (Keep things
simple, stupid) principle is always a good way to follow especially with
valuable data.

And we're only talking about a 500GB HDD.  Getting a second 500GB disk, or =
for
that matter, an external 1TB HDD or even SSD, is cheap, compared to the val=
ue
of your time.

Backups.  Backups.   Backups.   I've worked at MIT, and seen a graduate stu=
dent
lose ten years worth of their research data due to lack of backups.   One c=
ould
perhaps claim that someone who was dumb enough not to make backups doesn't
deserve to have a Ph.D., but regardless, it's still a tragedy; and totally
avoidable.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
