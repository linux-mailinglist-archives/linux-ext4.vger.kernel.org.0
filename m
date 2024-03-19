Return-Path: <linux-ext4+bounces-1698-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D51F88003A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 16:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61B2B22803
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DFA651AC;
	Tue, 19 Mar 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cebv1z+S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18DA24B33
	for <linux-ext4@vger.kernel.org>; Tue, 19 Mar 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860885; cv=none; b=IeOgnobwl9A8J6FmtdwnKilchzy+j4hqDejrvWEYPB5DZ7AzLR4Amb3ZNmrVdaiXLH5JJ0PdI5vi0xg/Jzbc6Pwi9uy1GOvM1Grl0DjCiI5FcUVy6FS+OqJguqPBGZO+qiA8BwjxnkdKNoADe1p0aqjW1IxZti+7wKIdMNVcB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860885; c=relaxed/simple;
	bh=haULTBsf43CVwUuY/4mQbxhcohiW8P75+xCeeS2peL0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NGBoN9AQJ4/a5ccajKudL9GVhWDtC3MM3WhV31YzuYk5I2BDxtL31IHpC6qjTVJjVezBWgI+qS2sJWHe9upOhjL9XmC55S54YAH/wEwRd/z7VPVd+qS6jZCeueq7WOQA+8i6EfHAIfcytgC+qxV/8TwAwyM2ueoagJ4W4u6v0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cebv1z+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 550D9C433C7
	for <linux-ext4@vger.kernel.org>; Tue, 19 Mar 2024 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710860884;
	bh=haULTBsf43CVwUuY/4mQbxhcohiW8P75+xCeeS2peL0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cebv1z+S177+o/s1xW6th1VCIgZBNc+uOo+LL45PV1NFxRa5q317z/4SnAT7xYP4N
	 2Gtrbub6wbw8NRHUCNgqr3MK07RTclm1fEOF4ozCpK1Tyeo6+V6RAt8BTiuuTkj4BG
	 RM1gKHHvCj/SQG/ASTK+QflB3lbZxZag0+jCdK3Pqu+vMQHG2Ds0GJBO0Iax1kGxi6
	 wBksdqXafF/zTIVCMBF5GS+cqZ11wDGXjdhUGZ+bTp5AZTaF1rIAXU3B4cFo7k2ygv
	 xsUizG6VEMOuUGfmfXNptk/fzCoRyDLWWlbObGg+fKaCCu7Kp4PccHHJeqk+5ZuHSY
	 toa+XuYHwbHTA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3BD24C53BD4; Tue, 19 Mar 2024 15:08:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218601] Regression - dd if=/dev/zero of=/zero causes
 shift-out-of-bounds &&  NULL pointer dereference, address: 0000000000000003
Date: Tue, 19 Mar 2024 15:08:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kbusch@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218601-13602-CAUF3Jj1MN@https.bugzilla.kernel.org/>
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

--- Comment #7 from Keith Busch (kbusch@kernel.org) ---
(In reply to Colin from comment #6)
> I suspect this may actually be dead hardware but it's hard to tell.

I can't necessarily rule that out, however, based on the stack trace you
attached, this looks like a software bug. If you want to go further, I
recommend following Ted's suggestion and attempt to reproduce with a recent
upstream kernel. The most recent stable version as I write this is 6.8.1.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

