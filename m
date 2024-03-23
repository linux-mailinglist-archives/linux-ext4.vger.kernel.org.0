Return-Path: <linux-ext4+bounces-1742-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E172188779D
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Mar 2024 09:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4AF1C20A37
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Mar 2024 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16192D515;
	Sat, 23 Mar 2024 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9b5gcRe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900EE6D39
	for <linux-ext4@vger.kernel.org>; Sat, 23 Mar 2024 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711184035; cv=none; b=e1m8HgTyH+SyLxu5SajRLxA3Xjlkgh6jomqx9FBnhUMaSw3p+EC417CkZHeGURpL/dWNZ48x2RfzWaC+nemIELuh8YPeCbnEtDILMIwBX2dntX4eKk8bIn634T2Ypb7H5qstG49x0hZTdLS/lCbM1x5epWc5meY9x8RIrzTz2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711184035; c=relaxed/simple;
	bh=3edj8jdX/im9LzSxhVcaVkr8dw4BLZVuFNRz/NuRSH4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Is/lDuBVdcqKU9NzrdaAKaEFC+wLLoOB2Ll98xaELwK9RKlGBHaX6IJAu7yKtBasqP0gdciP6/rVUvve/OLkuxmOn2K6pJB+qILoD+li+v0EvdtAhoz5aJRADDIy5N67nsO4KCDJjs3n948L9/u6etj0lkmqZ/gQhzi0ASMeuq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9b5gcRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CE36C433B2
	for <linux-ext4@vger.kernel.org>; Sat, 23 Mar 2024 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711184035;
	bh=3edj8jdX/im9LzSxhVcaVkr8dw4BLZVuFNRz/NuRSH4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p9b5gcRefvt5gOXmOsZ2/GtpJVkbA/jey+gS0ItokF+9wutg9BYL7tw5E+7CrwdGs
	 llefcnqdafA0EKWCVTJyV2dFj8ByGtWwLCRA+JV2VlSdPLkOMKs0MqIy2/f5Iis9G2
	 7M34veUdBcgBX36flzNBoRA7Sa6qr38CLk62OgGjwS9OHCnTQmnfAU8HBgw6CoGERj
	 EPpTS6bEjwZw/+WuOIqHT7svjtq9JY8ue8XbzcNNpFiEVkeTipuBjnR+mU8ATUSzVQ
	 w85ejSAVeGjlOTA+Yv5lejWOyTgd8LOp93Lyxwbpu21xd0qdHOul3XPbDWvzJNH5oe
	 x3e8KcmD6hapg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F1F00C53BCD; Sat, 23 Mar 2024 08:53:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Sat, 23 Mar 2024 08:53:54 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: denk@post.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-gDmgV2yURH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #71 from denk@post.com ---
(In reply to Ojaswin Mujoo from comment #68)
> Hello Denk,
>=20
> Both of the commands you mentioned "mount -o remount,stripe=3D0 <dev>" and
> "tune2fs -f -E stride=3D0 <dev>" should be okay to run and aren't dangero=
us
> for your filesystem. You can always take a backup to be extra cautious ;)
>=20
> That being said, this issue was fixed by the following patch [1] which I
> believe landed in linux kernel 6.7 so anything above that should help you
> avoid the issue as well.
>=20
> Regards,
> Ojaswin=20=20
>=20
> [1]
> https://lore.kernel.org/linux-ext4/cover.1702455010.git.ojaswin@linux.ibm=
.com

Hello Ojaswin,

thank you very much! I changed stripe to 0 last weekend with tune2fs -f -E
stripe_width=3D0 <dev>, as tune2fs -f -E stride=3D0 <dev> did not change st=
ripe to
0. And since then my system is back to normal performance. So far no further
issues.
Thanks you very much for all the work for ext4!
Best
denk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

