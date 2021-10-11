Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E64A429532
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Oct 2021 19:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhJKRHh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Oct 2021 13:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233084AbhJKRHh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 Oct 2021 13:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DD86E60E90
        for <linux-ext4@vger.kernel.org>; Mon, 11 Oct 2021 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633971936;
        bh=aI7dZftw29UUWH7za9fCz+g7yxGjJ9bPsN7i6MiMvrE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YcbNf4hQF25UypxVzr7HorysyccmdMx+j2VCfqux73yYHAWohQhfbW0a/2TqcbxKD
         /aF1bCbDtlea+N46J5DiSbIEIrrCg66GnTBJTEeCeyfQGXCFgCGjEkcGOmu8jyu1/L
         m5M9NU8RyVDHwJc5IbT+rygSxtv7It6rbBC1ToWEkuskE8RJNC3clXzkUTWWLQTgUH
         PzHM+b+VHTFegkxjsj8UWD30w19MpUjsLYs8qusqC1egmU+Mi/h+6KeEjpxqH+tZ32
         4KVakQ8i57t+8acT5FWg0YummGrPEZzpSHBGo+ZSdcgzDe+qG9bpXEA7hAcxfPrfEn
         T+Wxyx+j+JRaA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id CFF6360ED3; Mon, 11 Oct 2021 17:05:36 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214665] security bug:using "truncate" bypass disk quotas limit
Date:   Mon, 11 Oct 2021 17:05:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: djwong@kernel.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-214665-13602-uwvmlFjeU5@https.bugzilla.kernel.org/>
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

Darrick J. Wong (djwong@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |djwong@kernel.org

--- Comment #6 from Darrick J. Wong (djwong@kernel.org) ---
(In reply to Theodore Tso from comment #5)
> Correction to #4:
>=20
> There are plenty of other ways that an *inexperienced* sysadmin might sho=
ot
> themselves in the foot....

I disagree, there are plenty of ways experienced sysadmins and kernel
maintainers such as myself shoot themselves in the foot. ;)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
