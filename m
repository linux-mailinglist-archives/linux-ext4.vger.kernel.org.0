Return-Path: <linux-ext4+bounces-4191-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 346A997A685
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA091F278D6
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655FB1591F1;
	Mon, 16 Sep 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL+u+B5T"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9C15852F
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506784; cv=none; b=sJlebhWFnVqj+9/5su1UwirvCwvfzWRDXowSHr1BNsOW42m3OvOeGpA3d6DECoe0SC1WUhHwaGpGmWUR72to69EUk8VY+b7Hp3oQjmRbgbv+osYvEcCBTRV2Q5jpnmEA54kwf7/AlTewp2o71zlCbk7RnK6mqg0kkPgUGRXBVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506784; c=relaxed/simple;
	bh=PHBPSvPpC1z+stO31VmDoiDFqO9KpqV7QJyesPD5NLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E434UDXW1VLkU5xKcwv5ISvcmFViNR5d3gyqDwYuYmyGnqMdz7wFj7PLIu/8IUNMgVTASpNR3e6lOkHMZROh7InT2Cq3a3docl2pbT00l9t5lx4iEWCdZpJIC5Z7Vw5LgcmR1A4i8+3h5IKEAIqZjGudxz6FHwP20yjpZw+ZDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL+u+B5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59A23C4CEC4
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726506783;
	bh=PHBPSvPpC1z+stO31VmDoiDFqO9KpqV7QJyesPD5NLI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lL+u+B5TOvnunheIpukj13bi0Bg9xbyu3D+LnC9HPwaquqtcbDB/fm/WxSR0Ikquo
	 rIFzDLUtC5e0IYhJFDUczarXGjr35SMFZlFI580kRAVEz+3CmhDLmcRp+lFLRZCzNg
	 4e6hXbBMgdZ+5O8+42epN7StkDhTPU4RAiVrdbwGfHDO4GVLbPXA61C3Zw9qiPh+n9
	 zqea5lI+eoeT/4VpFoBxKSY7DOf4MSLeCgqWaUz3X6LDVchFeJnQNjE3pxq/NA2cGn
	 ntbeYu8l4Jij/1t/+3v+KKrMWvesy4IKjJ5g+mu1BZsqHahLbcjMR97wllscO6Hs+P
	 kEX4mLM1AKzhg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4FBFFC53BC4; Mon, 16 Sep 2024 17:13:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Mon, 16 Sep 2024 17:13:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: colin.i.king@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219283-13602-dZsHnjUJje@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219283-13602@https.bugzilla.kernel.org/>
References: <bug-219283-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219283

--- Comment #4 from Colin Ian King (colin.i.king@gmail.com) ---
I'm doing some bisect builds, but my system is a bit slow, so may take a few
days.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

