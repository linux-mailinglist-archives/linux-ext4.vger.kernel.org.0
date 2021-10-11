Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB5D4291B2
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Oct 2021 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhJKO1N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Oct 2021 10:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238723AbhJKO0v (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 Oct 2021 10:26:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2FDF760E74
        for <linux-ext4@vger.kernel.org>; Mon, 11 Oct 2021 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633962291;
        bh=hvOEvTl9RGAgxfu56gtUMLWhY7NRPq5YQqwGK4o1vFU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uBFp+4J5zE//S6DOhpfzwIOpr9hrCwmJlnO3sSZZTsSwdl7Sz2I00mPDrAb/v40zP
         RHMkBFnvsz7Pwhxi0ayg3+X/BfQxkywvd3lBW59PJ8cPLoD3dwWjKzlSS15xt4QVRZ
         S7W+Ow6MWd8FMwMWzseTQto73jXwhQPFaR21VzRHd4IGiVNUysfy5FwOWGiDQvYEKD
         ny0z8hmlN/Y2DhbgdWY/YDR91SDQzgC6KKJDfpXZNLjQikgNX6kqAu55ZXicQiyFV8
         Wwql++4Ahux/v/RTesG7Z7ksKfdWxZ5CVkS731TDyGOeWTGNGhAnrZbyEZyvbkVXyX
         UQzhM/czPX3dQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 2607260ED3; Mon, 11 Oct 2021 14:24:51 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214665] security bug:using "truncate" bypass disk quotas limit
Date:   Mon, 11 Oct 2021 14:24:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lczerner@redhat.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-214665-13602-dQr4tqBLp1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214665-13602@https.bugzilla.kernel.org/>
References: <bug-214665-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214665

Lukas Czerner (lczerner@redhat.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lczerner@redhat.com

--- Comment #3 from Lukas Czerner (lczerner@redhat.com) ---
Quotas help to control the amount of space and number of inodes used. If the
sparse file (created by truncate, or seek/write, or any other method availa=
ble)
does not actually consume the fs space, then it simply can't be accounted f=
or
by quota. So as Ted already said it is working as expected.

Back to your scenario. Quota has nothing to say about how the files are
manipulated so if the program copying/decompressing or otherwise manipulati=
ng
the sparse file decides to actually write the zeros and thus allocate the
space, so be it. That's hardly a bug in quota or file system itself.

If your expectation is that while manipulating the sparse file, the file wi=
ll
remain sparse, you should make sure that the tools you're using will actual=
ly
do what you want. Note that tar does have --sparse options which, if I
understand your example correctly, should work as you expect.

Some basic information about sparse can be found here files
https://en.wikipedia.org/wiki/Sparse_file

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
