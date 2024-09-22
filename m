Return-Path: <linux-ext4+bounces-4262-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5F097E2EF
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 20:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEA8281219
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3344DA13;
	Sun, 22 Sep 2024 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4O/Q0a/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5CA49654
	for <linux-ext4@vger.kernel.org>; Sun, 22 Sep 2024 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727031506; cv=none; b=aTWQYotGmVCq9t/HcKD2shoKkOSYTRoOKGvgNwn2aUyX5U/VYHO24Sw5wqJJwzG9oa1HTsgcUqCFnaOMTavRhjmnz6A8BMXk5enTQCENEMdVe7aGMWlnp69XnhZszJjlD29yn6/RADUPTmKozNLYu7x2AhT9zqBbbMg6UtVTyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727031506; c=relaxed/simple;
	bh=XuoCFYadU6V+VYoLBJQRMlqNrJ3QoQufiyHC4gslM+Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iMHoFB7Nabm4tYhr1RqldOJHrA/NlmXnTAbjmkBhReKNBLkWCtBle2ouI7uLv9NtIUwANyo0/FJi624yhA8q3c8LNeywpFMlNpPQK+lUHGvdO5CPFFyCRt0cm/g49OCXm7YUi396IIcfASwwF6lg+u+6p4hGQDzXteU+ZxNXUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4O/Q0a/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6D2BC4CEC3
	for <linux-ext4@vger.kernel.org>; Sun, 22 Sep 2024 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727031505;
	bh=XuoCFYadU6V+VYoLBJQRMlqNrJ3QoQufiyHC4gslM+Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f4O/Q0a/5joGAznw/5uTwOCEGYRdVuPZzBuNom/cAFEuEtymJOjz5N7XYEkNZwFfR
	 1j0y7tWGap4rqmahi80VqnvhCBjN9QKEKHwNW2fKBnhUzL267XrIzA2xt9LLUrqmpz
	 n/HBzaGQgNOHej09GEa4FFNzuc0CZedkvHna8aOymMSWZ5KkggEilif5nwjURnG5yO
	 /e3QhxuxzI8NJV+vyomX0uxlHd5GsnS8xhi0+JRsVmfFHTf9fc8dxV/BZlhM0sc8+g
	 iY/QpONs8EAWAjYOpgced0BlZmqg83EI9uOVxpWroa3yMM+BhM95aFFfqLWkTG1Anb
	 0162TmfnNU/PQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BCE69C53BBF; Sun, 22 Sep 2024 18:58:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] ext4 corrupts data on a specific pendrive
Date: Sun, 22 Sep 2024 18:58:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219300-13602-UsHqyJUA0o@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219300-13602@https.bugzilla.kernel.org/>
References: <bug-219300-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219300

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
> [11844.111565] Buffer I/O error on device sdb1, logical block 7533568=20
> EXT4-fs (sdb1): I/O error while writing superblock=20

Typically, such errors indicate a storage failure, not a filesystem problem.

I strongly suspect your media is broken or damaged and should not be used to
store important information.

The easiest way to test it would be to use badblocks with a single pass, us=
ing
the `-w     Use write-mode test` option.

The defaults for -b and -c are quite low, I'd suggest:

sudo badblocks -b 4096 -c 1000 -w -s -v /dev/sdX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

