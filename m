Return-Path: <linux-ext4+bounces-3639-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16397948DB5
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 13:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E721C23327
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB581BF31F;
	Tue,  6 Aug 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og8S0+js"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF74A0F
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943858; cv=none; b=ReD2fcrlIb+MRwa51kzC6Nm9/RPyFd7+4WCaRreKlYv02u1l9ApnSDU8PttVoX2UK8X2SFjFKhxzWarKySpUB+JXx6jRodgKdXUkTERkybV6BoR8gcjXyrDavQ0YMC0f2ptE9BcnPn16+SW30Nphp9FeNQfjPeiaYkoVQZSf43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943858; c=relaxed/simple;
	bh=LyA6VAfrCaEWtOECdjEkqa/LyFh2IWqIUkCBu61SfZw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R28mUj/dSnoNJW6Nn2UmmpPeVFdR6CGYi/w2acyDNHQfO1X5Zj0QaziOWqfRzNMSvW/4bumA0MvhI7SuHGVOlp8XZDoV4eyeRz3ZUX4BsDKu3zUV+ykJy0lsxsEKwiWTDUwe4retn/PUhLy4VYeIwRXYMVKdsSYxSCHl1OAgKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og8S0+js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A804C4AF09
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943858;
	bh=LyA6VAfrCaEWtOECdjEkqa/LyFh2IWqIUkCBu61SfZw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=og8S0+jsTCDM0f52DLGU14WMGr1oxvOkpzpJIzbH2bxKSIDeeRntYeXsuZO0CZ/gX
	 vEmYMHpZ4a/Nn9PWpLcsaCE9o3ED9Xzd4BZS67qHK20FnZ+QcYSuHieQtVAWrapk9E
	 fRFmqrP2nJQGbgeuuRY/AHq6/Va0ng1NFAtHcMvUklU4AR2uqA7q5x7SEU7zsxIXVT
	 8cVR5l90TtIuB8cL15gaqaezSVXKYQGcotNXPzcfWxD8p1EO/DeC7UMj2KP9jsp0QO
	 2j17h9HjG814NGfnsqE/PTiW6YoYT10pC1cPojrIAU7ajDFkweEppzjTO2+S+KYkID
	 4GkgolEh0gctA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 641FFC53B7F; Tue,  6 Aug 2024 11:30:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218596] kernel BUG at fs/ext4/extents_status.c:884
Date: Tue, 06 Aug 2024 11:30:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: antony.ambrose@in.bosch.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218596-13602-6QeafRVVwB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218596-13602@https.bugzilla.kernel.org/>
References: <bug-218596-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218596

Antony Amburose (antony.ambrose@in.bosch.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #2 from Antony Amburose (antony.ambrose@in.bosch.com) ---


*** This bug has been marked as a duplicate of bug 205197 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

