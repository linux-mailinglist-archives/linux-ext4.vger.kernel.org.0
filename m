Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF4443FB2
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 10:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhKCKAi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 06:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231435AbhKCKAg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Nov 2021 06:00:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 461C16112D
        for <linux-ext4@vger.kernel.org>; Wed,  3 Nov 2021 09:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635933480;
        bh=1juSRWFrA51+06IAjfEHAaARQnDK6UxEsE+dgTGTMe4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GJJWWL2+vN3SrIRdBmQgxDxm5+fvLAJSkawrljdchcj7KZbtQgMhPrT8KstR25Dpt
         SaGnzIHIXmA4igv/1xpLwfV3zn9VdvSYmMsamUGyTepxU3BAQZT23BW+vG7va/uffx
         rl4Wu/gyKqiXPInr8Mvs/lvsNh6Wc4F5rw0vxq5s3Vd767smO8KSlYqZufpqtSa0VM
         6fQWfsCgtpfnZfYTU+7R3rRReq9FTZH6ohS+cx2NWqmeOpOEgE/1iPi2x0BLKcgymR
         LoqE3/CdGfe3RUK9KVXTiX7AuLwaIdNPfcYg4Lu0u7N87VUeH052e8IizFlKMou5W6
         AJM3O6VF+Dr3w==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 34AC060F41; Wed,  3 Nov 2021 09:58:00 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214927] re-mount read-write (mount -oremount,rw) of read-only
 filesystem rejected with EROFS, but block device is not read-only
Date:   Wed, 03 Nov 2021 09:58:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext3
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Ulrich.Windl@rz.uni-regensburg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214927-13602-2D0LRGAikE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214927-13602@https.bugzilla.kernel.org/>
References: <bug-214927-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214927

--- Comment #1 from Ulrich.Windl (Ulrich.Windl@rz.uni-regensburg.de) ---
The last error I saw in syslog was:
kernel: print_req_error: I/O error, dev xvdb, sector 30704496
kernel: Aborting journal on device dm-4-8.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
