Return-Path: <linux-ext4+bounces-3672-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3C294BC6C
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2024 13:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEE71F20CBA
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2024 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59F118C321;
	Thu,  8 Aug 2024 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyX2oA1n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA912C7FD
	for <linux-ext4@vger.kernel.org>; Thu,  8 Aug 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117263; cv=none; b=NAeKAAJfC7Fkxr/o0SG0A+Drs7HS2LAHqzmACwPLg2k8mDtjzhUoLv6q3aMJbpahnREYPQfEeeT4piUy6KZ/cBAnB5kFmmNQ+tZO1xj5f4FohJCc28zQ2we+OnGPVH8k88dwIo1oCy9F38aUI2pyNWXj0xpdTtEJ7tnOk6DcC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117263; c=relaxed/simple;
	bh=ZwJjIbz2QNeaS6ncJE4ZtLA/qc+czVpmsuIQIrkXSc8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e7A4Mvl9VOspNiYmbxLv7/zz0mAgCIdQKKa5e2TJzQG17MeLZL63/s0/lpH770ac1IOOhs730mSh95uEntPo2UBpBQCa19gE+J8/qO4RSr9xd45KlpqWajFzcmHGu7QVeveMNKWF0iNrNaNhQKsdiG9efGW6hM3JsSorTzk1ybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyX2oA1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C58E7C32782
	for <linux-ext4@vger.kernel.org>; Thu,  8 Aug 2024 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723117262;
	bh=ZwJjIbz2QNeaS6ncJE4ZtLA/qc+czVpmsuIQIrkXSc8=;
	h=From:To:Subject:Date:From;
	b=tyX2oA1nv2ER9EqYT+rTybyQZYXHN5pNmCRht2aSD9m/3UVXHsi+l+IZCoJ1kOTxy
	 +CbJCmEAnegT9g9at8tmD0WV1bjovnJHSOiD13Qxf/1sKmc+mBEBOx1k1Hce4p5eZN
	 jNLFQ/LQEzzURYgEGzv2dM1S6mugE5PRF2CpRD7gMyOzr9EqUB5EF3SziSLaaQft5+
	 U9DKoyud6oa9ESEut7CVooinXmQs71s2kdBhLOMYWQo0AZ5ldrDLG9aLNpg8iTae/x
	 Nf7TiGyurnbr8hWdsQglEL+9LuW3rG8rigEzRc/H/9BnGZRYKqEVKE9odt/Fkg66Nc
	 Cjp8bWqPQno/A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BE647C53B7E; Thu,  8 Aug 2024 11:41:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219141] New: nfs slow , rw error ffast write
Date: Thu, 08 Aug 2024 11:41:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: walter.moeller@moeller-it.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219141-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219141

            Bug ID: 219141
           Summary: nfs slow , rw error ffast write
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: walter.moeller@moeller-it.net
        Regression: No

hi, since kernel 6.11.rc x

there are problems fast write, deadlock at rysnc , slow reads, at nfs also
normal filesystem --- is ext4 .

can not debug --- please have a look.

cpus , intel , i7 i5 , m2 samsung , server epic,

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

