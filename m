Return-Path: <linux-ext4+bounces-8685-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CAAAEC298
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 00:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7606E6D03
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 22:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA2528DB57;
	Fri, 27 Jun 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1GGeDMp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0228A40C
	for <linux-ext4@vger.kernel.org>; Fri, 27 Jun 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751062971; cv=none; b=bPkL9Y+WVw4j6Z5n9luRvxN2FvcqOhv2fYjynfDrLDew5+ZReTs/ubW2guL2/PfdNoKkNTq4f/JQnNakw6Q4yWZE0cVJVaDvnF2hv2YMrqeXFgZ6eSN08g5eLX+BSoat5WI12r+vlW1rkrSWtseGwAtZX8J9jvPDtO5qPbjvQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751062971; c=relaxed/simple;
	bh=cFgsEMx8xRfHQyyYFApOq9oU7eItkd/CGvckyND5F1E=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=krczx+C4jwDFfKBfgCGYLlkfxpQctNl6ma6swYXwUwCQO5dP370b5VXRzflcnjD8fJIlEhJxvvYZZQvR4ib2kXaBjP6HbHQiCfVEMsse8xdQpYCIOxbYpQ+HaR0xO7YV79LKCAlFV8ISpsOpMY9bnNg/VlqKQ+Kdir8GKeRdDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1GGeDMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB0A8C4CEF0
	for <linux-ext4@vger.kernel.org>; Fri, 27 Jun 2025 22:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751062971;
	bh=cFgsEMx8xRfHQyyYFApOq9oU7eItkd/CGvckyND5F1E=;
	h=From:To:Subject:Date:From;
	b=j1GGeDMpzCq7lVePp2uD3kkQw23VtOS9C7TzvdVCYjUonchPPNqXQhvb1IfMdfC4U
	 AJ3X/NqY/n2aZPP0LLLFzZet5bTc+le7Ii0/IhgMRWQqDoVlKexotptHi4DFFLG38Q
	 PwAaCmfCwzZkuRC8i5XRL7YfRr0FlLDQtX6Xy8336jJtUrftTqVXchiKYkKfGUjxm/
	 +OWSEQm39WPsXOU6xdrvg1BMHBM6J9k3uOX9bzwW8ISC7eEgRiSzrbOoBuyygnlHIK
	 kakkV7uYONHkSV/6k/y33Mo9w0u2GnrY9CqqPtXyjGgic+e5DhDa2SWjMn1qHSnUYZ
	 XJWiGhin3168w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D758FC41612; Fri, 27 Jun 2025 22:22:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220288] New: A typo Leads to loss of all data on disk
Date: Fri, 27 Jun 2025 22:22:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220288-13602@https.bugzilla.kernel.org/>
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

            Bug ID: 220288
           Summary: A typo Leads to loss of all data on disk
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: martin.vahi@softf1.com
        Regression: No

I wanted to run=20

    fsck.ext4 /dev/sdc1

but accidentally missed the "1" at the end by typing

    fsck.ext4 /dev/sdc

and lost all data on /dev/sdc

My suggestion is that there should be some regex based test to see, if the
partition name candidate ends with a base 10 digit and if it does not, then=
 a
confirmation prompt, possibly with red text, should be displayed that expla=
ins
the consequences and asks for confirmation. For non-interactive use of the

    fsck.ext4 /dev/sdc

there could be an extra parameter, "--skip_warning_prompts", which should be
mentioned at the text of all interactive warnings so that people, who stumb=
le
on those interactive warnings do not need to look it up form fsck.ext4 man
page. A temporary workaround for myself is a Bash alias that wraps the
fsck.ext4, but in my opinion that's a dirty workaround and such critical
warnings should be part of the tool itself, specially given how common the
fsck.ext4 usage is with USB-HDDs and USB memory sticks.=20

Thank You for reading this bug report.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

