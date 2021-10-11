Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343C14286CA
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Oct 2021 08:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhJKG06 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Oct 2021 02:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234130AbhJKG04 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 Oct 2021 02:26:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AF65D603E7
        for <linux-ext4@vger.kernel.org>; Mon, 11 Oct 2021 06:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633933496;
        bh=ex6zYqYAfQNTB9y2gJzI6CWYrZviagjnjq5x3yjFYXg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=j+CLskGhEpYGoPAcUc8iYXE85aVemVTaSnBNLNEle+3jWIJKHZbjE3gvDeSZtb1lq
         j1aZ98BuBnKZ71DsN3tDb/eXhWTM2XFsZaP7bED0+kelsWRZQkwyYiadN3S3PWnA9X
         XbANrvKSgb1fIG6gzZYDGqVyGVzQoVyD/9JLI3j8fc+GcDEb3GZthMrE3L8eGuueJH
         oDzXAAqCBDVvrJh1+KZwFDe/+iwFkYHKMTd5+aXA44OE6pxinlO5jCz8Hmsh43qUyo
         Mv2r7NfDFpEyzwODZDxVhA41UOzQjhEQbGs41LYK+tek4fqsYwHoIDRBDJ5t8cVwPA
         pSUO/lzbDpwsg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id A321260E15; Mon, 11 Oct 2021 06:24:56 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214665] security bug:using "truncate" bypass disk quotas limit
Date:   Mon, 11 Oct 2021 06:24:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 1157599735@qq.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-214665-13602-ScDAd49LNn@https.bugzilla.kernel.org/>
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

leveryd (1157599735@qq.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |REOPENED
         Resolution|INVALID                     |---

--- Comment #2 from leveryd (1157599735@qq.com) ---
i know `truncate` file does not task up disk space, but i still think it has
some "design" problem about security.

* why i still think it has some problem?

  because developer will trust "quota limit" very likely, so they will not
check the file is "truncate file" or not before they do some operation on f=
ile.

  for example(assume a scenario): developer limit every ftp user's disk spa=
ce
by using "disk quotas", and there is a crontab job which will backup ftp us=
er's
files every day. if this crontab job does not check "truncate file" exist or
not and then backup using "tar" or "zip" compress command, then when a
malicious user create a file using `truncate -s 100G id`, after compress th=
is
special "truncate file`, the machine disk space will be consumed more than =
100G
actually.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
