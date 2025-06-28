Return-Path: <linux-ext4+bounces-8689-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC4AEC5E8
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 10:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DCC1BC3755
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A116E220F4F;
	Sat, 28 Jun 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f54PS3EW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5A17A2F5
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751100427; cv=none; b=O/hCM91f1DnIj2zOyQ0f2QZm+B4xqY+X2zhycih8ArnX/xJjK9Gi4jtjCxZr6hlJar0pbtSOIe0urh4d/4MiniHVmdNI0PHnGbMHCCmBrcJjJ0d1gJLKRe/tCoOKBZL4zrN0tynR9NX9FNXKYtgqccBUUWc1JXDMaOlc6psgvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751100427; c=relaxed/simple;
	bh=nZn9JpwJDPn+5H7pd9SZJdoE68tbvbDKNYuejDDmrwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LAzcytuiTF+Tr9saLm+ooUDINlkJ52WhHA5UDlgcQqy4SKC21pl0gtqe8Am9Y8ILit/O20mTddGbObqp023GWm04cKt9kRPCxzon8EtcO9+K3cujav6keoZmfHf2zP6YhRmdV8/LQLN9DRLwNP/cnfslbnQjIq1urP9iG7i7sHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f54PS3EW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE239C4CEEE
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751100426;
	bh=nZn9JpwJDPn+5H7pd9SZJdoE68tbvbDKNYuejDDmrwc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f54PS3EW+DNrHaN8FJzX32+20uUrAnK7AjdgUPh+9mlZayomPLaVBlWdUhK2sb1el
	 swAl2/DbWZ1lUGiohAjNzFmUSSCOwb9el/M7v+GyGyG/cMufT4i88dHoRcTHid/vQx
	 A7QdVEQaeITsvLz/ngGeZOeU0wwe2r05GSjYmV2RKbJYOIsFT8wbFXc06dNhpetM0u
	 prdWpmRpVSogxYNtLAz0psduZDxH22rqUoS6PCBiNCvvCYyUwGrUzbPuQwiKIv5Omv
	 dXgdThaipnxR7WXAxBXNxA3cDEd1YwsK/hAhZ/M4rRTnCYRv8EKP9KKRL1Hz6gw5i/
	 yeNVKTzJuYeQQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AF972C433E1; Sat, 28 Jun 2025 08:47:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220288] A typo Leads to loss of all data on disk
Date: Sat, 28 Jun 2025 08:47:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: martin.vahi@softf1.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220288-13602-3XrhovDMrJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220288-13602@https.bugzilla.kernel.org/>
References: <bug-220288-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220288

--- Comment #2 from Martin Vahi (martin.vahi@softf1.com) ---
Thank You for the answer.=20
What regards to the line of thought that the behavior of fsck.ext4 is
just fine as long as it asks the user for the "yes" for modifications
then I think that it is a flawed line of thought, because from=20
users point of view the fsck.ext4 is run=20=20

    WHENEVER THE FILE SYSTEM DOES NOT MOUNT DUE TO DIRTY JOURNAL

and the end user will not start to do any "forensic analysis" to start
thinking, if some change that the fsck.ext4 wants to do is OK or not, speci=
ally
if it shows some kind of numbers as part of the question. From fsck.ext4 us=
er's
point of view the
idea is very staightforward:=20

    if (<partition does not mount due to dirty journal>){
=20=20=20=20=20=20=20
func_run_the_fsck_ext4_and_it_better_do_its_job_without_any_mystic_number_s=
cribble()
    }

and if some question about individual inodes does appear on screen, then ju=
st
press Yes to get that "nonsense" out of the way. If the text with the quest=
ion
were "Are You sure that You asked the fsck.ext4 to modify the right partiti=
on,
because according to our suspicionns You made a  typo and may be You want to
consider running fsck.ext4 on '/dev/sdc1' in stead of '/dev/sdc'?", then the
end user has at least some meaningful text to think about before pushing the
y-button. But if the question is, as You describe, about some i-nodes, then
from user's perspective those questions are expected to be pretty much the =
same
for both,  correct "/dev/sdc1" and for the typo-infected "/dev/sdc", which
means that the question about some inodes does not convey the message to the
end user that there could be something wrong at the call to the fsck.ext4.=
=20

Someone, who has self designed the fsck.ext4 may find the difference obviou=
s,
but for the rest of us, me being part of "the rest of us", it is NOT obvious
that fsck.ext4 asks some questions about inodes if I have given device name=
 in
stead of a  partition name to the fsck.ext4.

To put it in another words, it is not enough for a commonly used tool like =
the
fsck.ext4 to work correctly according to notes at some deep documentation, =
but
it should actually detect probable user mistakes and draw user's attention =
to
the possible end user mistake by using a message that even that kind of an =
end
user, who has  NOT read loads of documentation and NOT intimately worked wi=
th
fsck.ext4, can understand clearly. A messaging format that it asks something
about inodes in one  case and does not  ask that in another case is not cle=
ar=20
enough messaging format to make the user suspicious enough about possible u=
ser
mistake.

Thank You for the anwer and thank You for reading my comment(s).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

