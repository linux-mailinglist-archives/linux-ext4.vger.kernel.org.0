Return-Path: <linux-ext4+bounces-3663-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13CC94A8C9
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 15:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAC31F210DF
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3691EA0B8;
	Wed,  7 Aug 2024 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzbjV0kC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81191E7A47
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038106; cv=none; b=cBPL0kvPNZdTQHwNYtRCsU49WAy6vPetz0m0UGClubGOwZtXILWU8gXSqFyTPQzHoqCzMZHW3Xk73cdxcuglXJCjuf2a4r/sY4zyfzxuMIlWFgHTvcsRnCjGbQ4h6IFPVY5KcQ47cfA38jNMDG69208Q6PtEM7st4rfO1yU+8kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038106; c=relaxed/simple;
	bh=pcGQ78Gz3axCnmg+wWu5TLrl4wWxqWtSwD5wxsDn1Jw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEuM5FcAZU+lNfmnQYjFG0lynLRtpB7/NCo3y8qUtChRjH8DKD9364PHYxhDmW3+PiQo+LlrHqvAdrx/JnujyLltFkWbaqp5e35a2n5hZ1poKZUXXR7yoYYoGj8sxxtpXo0u6occ2s6xrMYjhtBgNC5I+kvpFlIxgX7d3G3WGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzbjV0kC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5155BC4AF0F
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 13:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723038106;
	bh=pcGQ78Gz3axCnmg+wWu5TLrl4wWxqWtSwD5wxsDn1Jw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dzbjV0kCaY/MS6tyhERn5nsV6CT4/PIT5FT85JV2mcSIN6Si4Vzc+up5XTmnqM3n8
	 avg/3rgE9qq2YkzOZnQmtYWF5PuJ/UmMe++ktMUC5OpIw5WQ4kfXBu3MNWuY2Ke22m
	 WZpvBCszMdu8FbO3dInZTYOETBMU/oBQN5f9pDA6QZuwuKar0L8aKYD+9gGd4YRNst
	 yLPURm0V1WHb5T2jCFfJglQCukvM7l73vZt7weheGAg9y6zbTCM4DM5zNW3nkKBQtO
	 mbQHgp8U1+lcuyLTneLBWZ5CD/stY/djHMXg+XRdQopYpZEchFiACNbd8gpKHHWLtW
	 +tLeFR0AwU0rg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 47BA5C433E5; Wed,  7 Aug 2024 13:41:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219132] Redundant "re-mounted ro" message
Date: Wed, 07 Aug 2024 13:41:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219132-13602-bLycEclRXA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219132-13602@https.bugzilla.kernel.org/>
References: <bug-219132-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219132

--- Comment #4 from Theodore Tso (tytso@mit.edu) ---
I hear you, and I agree that this is a reasonable interpretation of the log
message, even if it's never been the case.   If you'd like to submit a patch
which makes the change where it only logs when the ro/rw state changes, and
drops the quota mode, I'd certainly accept it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

