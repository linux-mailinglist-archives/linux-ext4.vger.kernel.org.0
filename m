Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0608147F13B
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Dec 2021 22:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353594AbhLXVuK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Dec 2021 16:50:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37210 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353591AbhLXVuJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Dec 2021 16:50:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1426B8234D
        for <linux-ext4@vger.kernel.org>; Fri, 24 Dec 2021 21:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77030C36AEC
        for <linux-ext4@vger.kernel.org>; Fri, 24 Dec 2021 21:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640382607;
        bh=aq/BJOqvrfRf3I7ANEFLY7jDwEns0IyDt0dV33BDIGo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RIVqWDbJlCnDsRm00zH4477Dw3J2rsnW3eqm2h9Aqbncgdu7y173zknpuSsQpZjOA
         1In/yx7UgTvMA/AIBbMB+BxwVzRgiejIHbfOg8oS3xoec4ZnN6mu1DRaeHyZiGpkYZ
         8vbj0XUDEYbR+z/lpL4djH3qEXJKIPcF5dmv0ku3gm5hjksDsLES2DcQulQ85pApyA
         MJ11W/llEYaKZVsdOAnIJ1C8HQZhWNVGfTQe/RdWBbhptA8wdLi6zQY2/HLVdp9yHh
         z7D7keg+Mb017e+bCwPcgi+F5bV7LgQh8tpc+g9tLbf+jeM31F07BmtZwXYO96gddY
         bg4j9a8RBoO5g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 30D0360F9E; Fri, 24 Dec 2021 21:50:07 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215225] FUZZ: Page fault and infinite loop after mount and
 operate on crafted image
Date:   Fri, 24 Dec 2021 21:50:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: qhjin_dev@163.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215225-13602-bwS1Tocgi0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215225-13602@https.bugzilla.kernel.org/>
References: <bug-215225-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215225

Qinghua Jin (qhjin_dev@163.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |qhjin_dev@163.com

--- Comment #1 from Qinghua Jin (qhjin_dev@163.com) ---
It seems that the tmp38.img is corrupt. Could you please send a correct one?

$ e2fsck tmp38.img=20
e2fsck 1.45.7 (28-Jan-2021)
ext2fs_open2: The ext2 superblock is corrupt
e2fsck: Superblock invalid, trying backup blocks...
tmp38.img contains a file system with errors, check forced.
Resize inode not valid.  Recreate<y>? yes
Pass 1: Checking inodes, blocks, and sizes
Root inode has dtime set (probably due to old mke2fs).  Fix<y>? yes
Inode 13 has an invalid extent
        (logical block 0, invalid physical block 8332801, len 1)
Clear<y>? yes
Inode 13 has an invalid extent
        (logical block 0, invalid physical block 64344, len 1)
Clear<y>? yes


Thanks,
Qinghua Jin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
