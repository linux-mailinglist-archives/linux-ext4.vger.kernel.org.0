Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5BC30C58F
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 17:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhBBQ0D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 11:26:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236160AbhBBQXz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 2 Feb 2021 11:23:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EA8E064F74
        for <linux-ext4@vger.kernel.org>; Tue,  2 Feb 2021 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612282995;
        bh=GF9LJ4+W9JNrX3k7btx1oSzAhLJC5AYqXahtgE1qaCs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lLPCdvdid5RJHJBWnJiYZ12nK6RQPMbgWHpxAfOCs3hc1+XsCfEDJWlmG9vlnZrzq
         cjicelP7qfDVgBNVhreeMK3M6YCqPgYakH9CgUnoyV6VVXTarp4s8rpYeopxWiLqJd
         bViB1r4UBvc1hrWp0WMkCA8Ykr7aiXVMY/WrUlpS2H3v2jRRZ67u74YqBP4cwSDfvW
         R1k6nlbA6ohSz4RGqPmDHkPJFlpd3Po0gTVjU1pbe1mVQH7UoSd6ePdUCC2bRlMx+9
         k1LsZaup7xa0g/zkoCLH4O8FbBR0pkdJFETqinD2D0quQatouSsLSHtchslVixkkGa
         vbgJP5jo+uDWg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id E219D6532E; Tue,  2 Feb 2021 16:23:14 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 210185] kernel BUG at fs/ext4/page-io.c:126!
Date:   Tue, 02 Feb 2021 16:23:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: enbyamy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210185-13602-xJsuJa79BL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210185-13602@https.bugzilla.kernel.org/>
References: <bug-210185-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210185

--- Comment #12 from Amy (enbyamy@gmail.com) ---
On Tue, Feb 2, 2021 at 3:00 AM <bugzilla-daemon@bugzilla.kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D210185
>
> gpo (gernot.poerner@web.de) changed:
>
>            What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                  CC|                            |gernot.poerner@web.de
>
> --- Comment #11 from gpo (gernot.poerner@web.de) ---
> Hi, any updates here lately?

Nope, forgot about this thread.

>
> Hitting the same bug on a completely different workload and setup. 5.9.x
> crashes, 5.8.x works, this is all on Debian 10 Buster running as a VM
>

Do 5.10.x or 5.11-rcx work?

> Currently we downgrade to 5.8.x because of this. I can provide further
> information if interested.

Yes, that'd be great. You said you tried 5.9.1 - does it break on 5.9.0?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
