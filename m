Return-Path: <linux-ext4+bounces-1660-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE187CD16
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 13:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFE51C217FD
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 12:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B31BF5D;
	Fri, 15 Mar 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn16yoKp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEB51C69C
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710504873; cv=none; b=HE7YMYwqlh/IWsX2iR0t0QYnl7cLk5BTquJtwvquxflLeqbNdBfPUcSxNTaAGtAjOha7oytfEJ6uB/jYNwec2yvr29KRLWYd5pdyomwe44SePmAajpyl157IYCo5Zs3DtVH/pHjG99vrRs2Kosg1rpxxCVOY4M4I6dMxhM/5pC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710504873; c=relaxed/simple;
	bh=xCGXjGXnxTA6xM+opL1uV4ex8paT2SIXUOHG7nqEAhY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cEN1/OpUQT9nldIBsDGhKlWqusbhqd1gzOZjJcM/joODW1fHd0uplreunRWUUwjbmoh5H6SdjNfxEeJ/X/c8zbz1DWxuQ4MUqsFgKAq5FW4oxSJ+nYlUolhEww3/beI6YqvIKn5PkGBtiny3fdyTIdIIu0Z4YC3jpLmtGnrPD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn16yoKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDAA1C43390
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710504872;
	bh=xCGXjGXnxTA6xM+opL1uV4ex8paT2SIXUOHG7nqEAhY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Bn16yoKpK1nD8kUxzpdjM+QxA/NaX7C1pv81u3zRKxrhfJrw0sqmUg3rT1TJP3NCb
	 Q0/AE/yR5ga0rBPxYihoM1aML0L+/0XSwjeim2Agx5hW6AFDX+P5X2aVUWhz4u/IYu
	 /IsnZFDQ4scWQcL3M5tacxYs640/VpsSS+5/CTR8i+8Rjr/cVsfoWxZekWwYz19kgI
	 F0X8US13jWAiAK/Va9hveibz+VMikhV8kmMy360RISbyJiL2Q3FjLnwGj/LedmZVYF
	 7WMNhN+u9ki1K3yBzsJ2aSgfHRqsQwSdA1BQvb4jWCOj+ZHWnkp044xiowori9sOrF
	 VRJr16oru8UJg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C45C7C53BD0; Fri, 15 Mar 2024 12:14:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 205197] kernel BUG at fs/ext4/extents_status.c:884
Date: Fri, 15 Mar 2024 12:14:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: antony.ambrose@in.bosch.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205197-13602-BV4AeT3Ahn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205197-13602@https.bugzilla.kernel.org/>
References: <bug-205197-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D205197

--- Comment #7 from Antony Amburose (antony.ambrose@in.bosch.com) ---
Thank you for the response. I understand now , why there was not much atten=
tion
to this issue. Sorry for providing a minimal information in the first
communication...
 We have back-ported the interesting changes from upstream (~70 of them) an=
d=20
could still see the problem. I have reported the issue based on old kernel =
to
have the continuity. The old  issue reported as well seen while mounting an
encrypted sd card and we have also seen this on an encrypted volume, but its
onboard storage. I thought it is logical to continue the discussion here as=
 you
had given some debugging hints and issue did not progress as the old report=
er
could not reproduce the problem but we could even after backporting the cha=
nge.
I will create the bug based on the latest kernel in future. Thanks for the
hint.=20

The issue could be reproduced in a sequence where we interrupt the power. F=
rom
our decade long experience working with ext4, we have never seen an issue w=
here
we could corrupt the ext4 volume in a way that it is not mountable  by
executing a power loss sequence. That was main reason to report the issue to
the community experts. Ofcourse we have some paid support and also inhouse
kernel engineers, and I thought it is also better to report to the community
experts as the old bug is still open and we have a reliable reproduction .My
current assumption is either that we have a problem with our sequence or
problem with handling encrypted ext4 partition.

Regarding our knowhow and usage of tooling , we can work with the hex dump =
and
understand the ext4 disk layout and also work with the e2fsprogs to debug t=
he
problem. Hence, we expect only some debugging hints and direction and hopef=
ully
we try to solve the issues together.

As the device resets cyclically , we could not hook into the device and get=
 the
/dev/sdXX . The existing tooling only get the encrypted data .We will try to
resolve this situation and somehow get the hex dump and provide more detail=
s on
the nature of corruption and will also provide the fsck output.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

