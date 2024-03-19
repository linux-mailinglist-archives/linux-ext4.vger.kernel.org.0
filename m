Return-Path: <linux-ext4+bounces-1684-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037EA87F739
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 07:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354EC1C219F0
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 06:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5B48CFC;
	Tue, 19 Mar 2024 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2VVEZhJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424153378
	for <linux-ext4@vger.kernel.org>; Tue, 19 Mar 2024 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829363; cv=none; b=TWYlvWqYRJRQqHDDmp6Y66bD954qgHCkKA+mj4lZ5Kqs6Rz8e5U5ddQ5D3ual3jVo6N4GrTkqZI+heg1tS07Y7h3RyLKWtQNv2UyBP2rDw2cabWemo8cwgExPiAWh3vpzDmi+sx2oeCEFZSiCQ8g+YbY8QQJL1Ajd5JlUmi/+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829363; c=relaxed/simple;
	bh=Bl7MIJyB//o01ewlBZlUgO4wFPfhjKb6CVzGD67KLvs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GFOhVfbLCg/rB4Y9D3H6bQgczt7WpaaGprvxl+/b8yeDJv6vHsahzqsQB1YLzp/IXfwNf0LEIhchAcA/H0p0GxGhlN1nbTJ1IcMvwiop24W7jfd7FqJvt+8plQDjeYqcF4p+ewKmCIsQEi1WHxH57hF6CeG5ikXrXa63Pm97F8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2VVEZhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4779C433C7
	for <linux-ext4@vger.kernel.org>; Tue, 19 Mar 2024 06:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710829362;
	bh=Bl7MIJyB//o01ewlBZlUgO4wFPfhjKb6CVzGD67KLvs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g2VVEZhJo7M3WzBIFYBrPLfykMKnEb0DDgwBjDWgEycofr6FETfu1s1MJtsWZAG4y
	 EBQ/Wz/VV1bfchdnEJOJTmGCmIXVWDKeCbyJ1Lzyv9+fgY79ex3ui3W4eMSObZIiWo
	 zneTMo0h/jXCvq0t7DD2rh0wi6KmH0iCCE3uzxkxuzeSxvpftr8/m4jW2ATjrYIGP/
	 jGfgxKSOo2CTJmPSBfP1bNhfmrtzdSKfkoUGK3sBOhf3YBHmAw8HtjHA/gBYYz+ONO
	 KujYgGYCsYvj41b8/VwGqk3vcUDnp4+Zkja8gZk/maoA4pbKO/il0rPIctFKKZyas0
	 SD+AJnSuZ3hhw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BBCD4C53BD4; Tue, 19 Mar 2024 06:22:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218601] Regression - dd if=/dev/zero of=/zero causes
 shift-out-of-bounds &&  NULL pointer dereference, address: 0000000000000003
Date: Tue, 19 Mar 2024 06:22:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: colin.kernel@i-pentest.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218601-13602-LvqzgibOrV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218601-13602@https.bugzilla.kernel.org/>
References: <bug-218601-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218601

--- Comment #6 from Colin (colin.kernel@i-pentest.info) ---
Firstly, apologies for any incorrectness - the commit reference link did not
accept inputs that were 'probably this sha' or similar - it was not meant in
malice or laziness, but admittedly I was very tiered as a result of the
unpredictability of this issue.=20

I suspect this may actually be dead hardware but it's hard to tell. If some=
body
is  interested in exploring this issue further feel free to provide instruc=
tion
over the next few days, otherwise I'll buy a new motherboard / RMA the
processor if the motherboard does not fix the issue. I value both my and al=
l of
your time, so buying new equipment in the hopes that I'm rid of the problem=
 is
my preference unless there's some burning desire for further exploration.

Here are some facts:

- `stress-ng --class cpu --seq 32` reliably crashes the machine in less tha=
n 60
seconds with the error message 'stress-ng: fail:  [2701] af-alg: ctr(twofis=
h):
decrypted data different from original data (possible kernel bug)', as well=
 as
other algos (pcbc(fcrypt), cbc(sm4) etc) noting `dd if=3D/dev/zero` is not
cryptographic. I routinely checksum files with sha and do not notice any
inconsistencies.
- I have tried vanilla kernels inc. 6.0.1 and 6.8, `dd` _seems_ to fail fas=
ter
with more recent kernels, but maybe that's just due to a small test sample
size.
- I have been unable to crash Windows using Prime95 (24h) Furmark (24h) nor=
 dd,
nor am I aware of any errors from either tool. Windows install routinely BS=
OD,
but went away as soon as I switched to a different USB stick both freshly
flashed - it's possible this is related, but it could also be a bad USB.
- The motherboard is an ASUS Prime Z790-P WiFi D4 LGA 1700, the processor a
13900k, I have been experiencing the issue for about 12 months, seemingly it
has become more frequent lately
- I cannot visually see any problems with the motherboard, no bloated
capacitors as far as I can tell.
- I have replaced the RAM, PSU, SSDs (w/ an non-samsung model) and removed =
all
aux cards, with the exception of onboard wifi6 which cannot be removed
- Memtest86+ was run with my original 128G ram configuration on 2x24h occas=
ions
and did not yield any errors indicating cpu<>memory integrity is not the is=
sue

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

