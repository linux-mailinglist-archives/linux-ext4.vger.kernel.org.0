Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B4542927E
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Oct 2021 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbhJKOtf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Oct 2021 10:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238914AbhJKOtc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 Oct 2021 10:49:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E5E0460551
        for <linux-ext4@vger.kernel.org>; Mon, 11 Oct 2021 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633963651;
        bh=7FWx50tjTjjXxK7o/5o31b8RwDsgXFEd9gOSN0gdqi4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=f6pRtXNvvCkXcJI0y94S69q7y3JkSR8cP/vQLBjcxj77DT1mqaL0jLut6cwxI44KR
         KvVPGl50mcR8miEI3CHx2KLv1CdS0e9TD4t9NnKY+5Mw24ZGQ/61MalhyGJL//mHN/
         L0uV3uURAYS1egGkBuW95aI5bzmBjx/73AT22yy/QDxU5Ox6h60lCCuVGrtp+HbMHI
         qVrVFGhq4XLFMlyKmAVXNA82MpDLa2HQ1+GncseiSaCfbDHM/jGUKynSNm74MAN8+6
         eNpsxGj8/8aNwPtQtyr7ijfP/1uaxwhJMv2b0556tnDW6eT7t+wywyb9wHr2H75Hy5
         UYJ84jC5A+mYw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id DA74D60ED3; Mon, 11 Oct 2021 14:47:31 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214665] security bug:using "truncate" bypass disk quotas limit
Date:   Mon, 11 Oct 2021 14:47:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214665-13602-1S4sZ0Y8ZE@https.bugzilla.kernel.org/>
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

--- Comment #5 from Theodore Tso (tytso@mit.edu) ---
Correction to #4:

There are plenty of other ways that an *inexperienced* sysadmin might shoot
themselves in the foot....

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
