Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA6832C883
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Mar 2021 02:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbhCDAum (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Mar 2021 19:50:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242640AbhCCRPO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Mar 2021 12:15:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BE5F064E28
        for <linux-ext4@vger.kernel.org>; Wed,  3 Mar 2021 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614791667;
        bh=oqfPZUEOaBSmYJzlz6we6WgVrCCaSSkoksEAmDDTxFo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=agnQuo64UfHCpDXK78Co7rA+oLxKHMKYAuraC7w+LZxxaZaO5D2g8h5ZYpTJNpGzR
         5fT0eaVRP+8J6ORL4cq5mfuxTCbhomz6q1u6kb9W0XFOjWwSzYIuxCHxvHs5tBvHYy
         wtpvE3SjxI5Q5IluW/n8cbTqQnIMAYmOpqUz7UloR0uVlDJh4bJ3w8fsBkgPBC7m0j
         3FNwssfI9vgCtYhnXrJzXRA1zxyrS8ZNQZgpbqNAqshYiJAaWcS6SMRtuQW25OO3kI
         P2cs7sXrKnKGAb2/e5x+sYm8eJ41XPyHtz1nnms4RTSbZp4hrz5LZ4h8Kz1iLNjJgS
         KDsNTn4A25Lxw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id BB5616536C; Wed,  3 Mar 2021 17:14:27 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211971] Incorrect fix by e2fsck for blocks_count corruption
Date:   Wed, 03 Mar 2021 17:14:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tmahmud@iastate.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211971-13602-NudUPEa3VT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211971-13602@https.bugzilla.kernel.org/>
References: <bug-211971-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211971

--- Comment #3 from tmahmud@iastate.edu ---
Hello Ted,

Thank you very much for the detailed clarification! It mostly makes sense to
me. But I still have two questions regarding the debugfs/e2fsck behavior.


(1)
> > > debugfs -w image
> > > debugfs:  ssv blocks_count 4000
> > > debugfs:  q
>=20
> This will update the blocks_count in the primary and all secondary
> backups.=20=20

This is different from what I observed. In my experiment, =E2=80=9Cdebugfs:=
 ssv
blocks_count 4000=E2=80=9D only updated the blocks_count (and the checksum)=
 in the
primary superblock. All secondary backups were not updated (neither the
blocks_count nor the checksum). Does this imply that there is a potential b=
ug
in debugfs (because it didn=E2=80=99t update all backups as you suggested)?=
  I=E2=80=99m
attaching two images before and after =E2=80=9Cdebugfs: ssv blocks_count 40=
00=E2=80=9D for
reference (=E2=80=9Cimage1_before=E2=80=9D, =E2=80=9Cimage1_after=E2=80=9D)=
. I have verified backups are not
updated by dumping the backup superblocks information with dumpe2fs.


(2)
> The problem is that e2fsck can't really determine that the blocks
> count field has been corrupted.=20=20

In my experiment, I observed that e2fsck was able to fix the debugfs-modifi=
ed
primary superblock using secondary superblocks when the secondary superbloc=
ks
are located in default locations (ex. 8193rd block). However, in an image w=
here
secondary superblocks are not in their default locations (ex:513rd block), I
found that e2fsck cannot fix the primary superblock using secondary
superblocks. So e2fsck=E2=80=99s behavior is inconsistent depending on the =
location of
the secondary superblocks. Could you please comment on this?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
