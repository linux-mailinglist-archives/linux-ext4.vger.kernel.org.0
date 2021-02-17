Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8C31DA8E
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Feb 2021 14:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhBQNcE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Feb 2021 08:32:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233053AbhBQNbg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 17 Feb 2021 08:31:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 37FFC64D5D
        for <linux-ext4@vger.kernel.org>; Wed, 17 Feb 2021 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613568655;
        bh=VuIKm35mODAyc0ezXzW7L2toqHc/aVGEW+P8oowDAkU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=q99gatXHCVOAejkmXiYXRg7bpbtO1cq6Y83Seb/vcPQk2QC4uZR0gHzMYy4xBPVpt
         U8x/xRiHEy3N+ugA5bHT1Xt0P4hibIkk/NMRY92DOpU4uKsyF3HjijrCJh198NlKlL
         INejtf3Gmct8DBZMEcecidzBvdunAceyHveCmqZRlOSORDhDQxeEUA53yYwiyjayNe
         Ih9pDpZqBvT+Va40KMkkUC8VuXLxG0hgt37pKkFosOT+98h1IjObbBIJg2+0UhXSXC
         04hnf8NerfD9FSYavEB7PniygXxMa5K5UHmQ8mgU+chN/jZbvXip9JlY+Tb3buq/9e
         nM+CSPLOVIGtA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 27830653C5; Wed, 17 Feb 2021 13:30:55 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211733] ext4 file system unrecoverable corruption
Date:   Wed, 17 Feb 2021 13:30:54 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: martrw@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211733-13602-Wpi0Qw8Vf6@https.bugzilla.kernel.org/>
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

--- Comment #2 from martrw@yahoo.com ---
Thank you very much for such a detailed response.  I acknowledge the lack of
actionable data in the initial report.  The event was initially anticipated=
 to
be a recoverable crisis and so no log data was captured to report.  In
hindsight, this was a mistake.

I do not think intentional reproduction of the event will occur.  Recovery =
from
this event was difficult and I am still not whole.  I would have to set up a
separate machine with sacrificial data to not feel at extreme risk to do so=
.=20
However, should such a repetition occur, I will be much more detailed with =
my
report.

I greatly appreciate your patience, insight and attention to detail in your
response.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
