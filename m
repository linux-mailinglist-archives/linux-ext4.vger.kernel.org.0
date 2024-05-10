Return-Path: <linux-ext4+bounces-2434-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5B08C1C07
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2024 03:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB8D284ACE
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2024 01:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD6B13B787;
	Fri, 10 May 2024 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwZEIcfn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0413B5B3
	for <linux-ext4@vger.kernel.org>; Fri, 10 May 2024 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715304214; cv=none; b=MMSrogkgRV1fIpXsvD+i7qVruFp7fn5yjTwPQN6Qk8O+2eX7xrcAjIxPwvOYF61ZKFDu4WmP2Z8+YFmv9zQOx1TdYhbOK4sF7kyDh0ylWs+F+ZauyAaa+XP3YV6cFQ9RPsSOn5HLpUu0yrA24xf/RihThN+/35rfECovHYxHLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715304214; c=relaxed/simple;
	bh=AdaqjZg8V0cI+dQwUgSHb3wF+nqicn6XJ2f+AKUBxMI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NFSI+ncn1Ka7Fh5hRCEaZxkYj4NorfesEF1ymy3XJp5PcqDgHmX2nMX/rvZUpEGu67yivZA6w3D9jw53K0fYH6dRuax+7EPMp0ZuaQ/1txZxM0LV6ruko5ELhe0MExOi76Q3dOvpG2E/iOEScskSJnPwYXbZY7jjoQSskNMIio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwZEIcfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61004C3277B
	for <linux-ext4@vger.kernel.org>; Fri, 10 May 2024 01:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715304214;
	bh=AdaqjZg8V0cI+dQwUgSHb3wF+nqicn6XJ2f+AKUBxMI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gwZEIcfnB2uYzvKlVKfTd4yGzw096QlZC+JC4DhZIl9bvg16RfmSDLU0VYU12Av13
	 SlMnO3hwvA2HAywcqczXBPXDpY9dHyUwFoG0uIRhK75wVhFaoOQWhD1ih9UjO/IP4n
	 DV6LUzApUrLSvT54mQNdvES2pvVqpUbyYLTWbUL0A65Tb+obt4d6+/iiz5+OCnJYH1
	 6Qy2+WXaKX/9I4nqcpLxUtgubSLr1/qcBK3NuSnOOr3KQEfLMtoCIfcLPjWpleujDW
	 tDPYwr2g7BdTc2YEAd90S/sww/zRtgP20HjBaSVo8UNCwenDFmtGOLkbKht1iwfAq2
	 VSQdqMHNXAG2g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4B9ABC53B6D; Fri, 10 May 2024 01:23:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218822] Delete the file from the upper layer directly, the file
 will become "Stale"
Date: Fri, 10 May 2024 01:23:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Squall.Zhou@vecima.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218822-13602-20wG9wTvZx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218822-13602@https.bugzilla.kernel.org/>
References: <bug-218822-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218822

--- Comment #3 from Squall.Zhou@vecima.com ---
(In reply to Artem S. Tashkinov from comment #2)
> Is this reproducible on mainline 6.8.9?

I don't have such a new system.
I have tried it on "Linux allenwei-VirtualBox 6.5.0-28-generic
#29~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Apr  4 14:39:20 UTC 2 x86_64 x86=
_64
x86_64 GNU/Linux"
On this version, I can reproduce this issue.
This is the newest version I can get for test.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

