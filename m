Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD7F4350D9
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Oct 2021 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJTRCv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Oct 2021 13:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhJTRCv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 20 Oct 2021 13:02:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 92CC361391
        for <linux-ext4@vger.kernel.org>; Wed, 20 Oct 2021 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634749236;
        bh=Y5D2MWg6cOMcs8+uIUhzHC/ozPpVW3oBsbJ0FCp4vzM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NK1jY4Qv2Md4c4q5LP+uBAdNSWgLe6iuXNpQAR3AR3xc2X2XpQQY+g0zU3v6HUPqv
         QPV5e7RMlbZqSAZLpI5W0pgj5BTqY0t6Y6SvyFUKdAPxN4yf7FzXSRYnRJT6tOVie/
         kKlCNfpdpaPjIeq8YIYaO8+XEcFvspnr2gZL+oKXdvCt7ok4cdYHImo/qRVmkss9dL
         u2sBqtx6ZSsYmwgoKbk8lS7pJkusjvGW1w00vcSe3vw+bxUesvdny1sSYFJLfJHvit
         cH6a/SscwsqKkNLq1FWj5XdyFqmZB1R0Yg5+wEzcPNcTqZTLakCVskFayZxper/8ez
         MU7yqrEyVHcVg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 8173261106; Wed, 20 Oct 2021 17:00:36 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214655] BUG: unable to handle kernel paging request in
 __dquot_free_space
Date:   Wed, 20 Oct 2021 17:00:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jack@suse.cz
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-214655-13602-alf2jvwnAn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214655-13602@https.bugzilla.kernel.org/>
References: <bug-214655-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214655

Jan Kara (jack@suse.cz) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #2 from Jan Kara (jack@suse.cz) ---
Indeed, I can reproduce the problem with current Linus' kernel but I cannot
reproduce anymore with the fixes I have queued in my tree. Namely:

d0e36a62bd4c "quota: correct error number in free_dqentry()"
9bf3d2033129 "quota: check block number when reading the block in quota fil=
e"

So closing this as fixed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
