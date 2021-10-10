Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B1C427E25
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Oct 2021 02:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhJJAWK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 9 Oct 2021 20:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhJJAWJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 9 Oct 2021 20:22:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E527A60F6D
        for <linux-ext4@vger.kernel.org>; Sun, 10 Oct 2021 00:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633825211;
        bh=t5bztGbi4sI3Qmp2vhJS7rGneSWth1bTi8dEtTptlRY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tjJqjKyE7HBj/oqchOyEcxlJWghO8EfoIP7sgTjqhQvT6T6HBW+3JmQ10CC2GaOv5
         scoyKK976X3p+Opa7HSdEtGYu2uCNR8AMHQv9apMA3lOpyVbleRBnzEBdk9op/bsMR
         HDSYch48oTWQvvvZ/pDk8yBrPxbicBfdr0QCh7uqBQJYWCz/lbt7Ik9DUawKZCAsY/
         6EvqZnP63rsV05+O2EDlsxuTmmQJLyyexzEXDiUdq/Bq+80KHUb/u2Hkz1riiJ/kZQ
         RIykNKNaaoWay1NdDh0B0JZOdd/IE3XM22X0Q4JcUvD+ag99eYiN8MS/NTZHLMhD3S
         ZuLletTT4lZmw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id D9E9860FD7; Sun, 10 Oct 2021 00:20:11 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214665] security bug:using "truncate" bypass disk quotas limit
Date:   Sun, 10 Oct 2021 00:20:11 +0000
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
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-214665-13602-5WozJpgxWk@https.bugzilla.kernel.org/>
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

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |tytso@mit.edu
         Resolution|---                         |INVALID

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
This is not a bug, but rather things working as expected.   This is because
truncate does not actually allocate any disk blocks.   It merely sets the
i_size of the inode to be the specified quantity.   If i_size is less than
where blocks currently are allocated and assigned to the inode at those log=
ical
offsets, then those blocks will be deallocated.   But truncate never alloca=
tes
any additional data blocks.

Try running "du id", and see how much disk space the file takes.  Or try us=
ing
"ls -s", which will show the disk space used by the file --- which is diffe=
rent
from the size of the file.   If this puzzles you, look up the definition of
"sparse file".

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
