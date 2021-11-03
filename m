Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8AC4448FF
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 20:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhKCTgO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 15:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhKCTgN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Nov 2021 15:36:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 025D76113B
        for <linux-ext4@vger.kernel.org>; Wed,  3 Nov 2021 19:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635968017;
        bh=Ib8Fe36DLkkiz8dv9ZYWc7pUuPRgqHqtGyXSJWAfXFU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ARKNvXLYdEzFUpx27kF6q2hlfcC6pSySm9M8x3LGdTZuv8NyHRJFAE6NkpZfxfIRd
         aPO8T7NG/V0RDGUgAzbC8THGUCXQR0BiboTwGtGiBRJOc6Fu3VnpixjoZlJFhUVWB3
         dL8MR32YeBM94At9dalIIBJtqmi5fKnvQ2wPXgkh4U5blBRocXO2mLfU+FPK/prbAX
         oQ60p163L8UD347fNA+b7RKSYBQflxzOyP6zSqPzobDq55odnp4HTCtPbDvk6mCOya
         oQep9ISzcHULXM6piXSAvLI6V46MJKAhiyjS5fy+IAc/gDAQvbSrFZvmmxja/q8yq9
         BPT3p3BtdNsZA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id EFB4E60F48; Wed,  3 Nov 2021 19:33:36 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214917] 5.15: kernel BUG at fs/ext4/inode.c:1721!
Date:   Wed, 03 Nov 2021 19:33:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: enwlinux@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-214917-13602-nN9dxnHGEL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214917-13602@https.bugzilla.kernel.org/>
References: <bug-214917-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214917

Eric Whitney (enwlinux@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |enwlinux@gmail.com

--- Comment #1 from Eric Whitney (enwlinux@gmail.com) ---
Thanks for your bug report.  A revert didn't make it into the upstream kern=
el,
so 5.15 contains code causing the OOPS you have observed.  You should be ab=
le
to
avoid this by reverting commit 948ca5f30e1df0c11eb5b0f410b9ceb97fa77ad9.=20
Please
let us know if that doesn't work for you.  We'll be applying this revert as=
 a
bug fix to 5.15 as soon as possible.

Thanks,
Eric

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
