Return-Path: <linux-ext4+bounces-3647-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2F9949773
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 20:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A344B283DD9
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE28770E8;
	Tue,  6 Aug 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy8Q82ei"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496E757F8
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968407; cv=none; b=tGcuL7cxAwhVJXl4MEiotndljkhecR6thU4DCN5dzsr3KHhZQSodZ9wsA8KRSwXicCHdyF7n2OKpg1MKgLPMDzq+ZBTCb7yTAj8bjp5stBinuC57Uu5tnHsslJrhOFCdam/YJXgHJwVoMAWpNJWyieGf1OGF8PugiXq1JVVBdm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968407; c=relaxed/simple;
	bh=q0wLitqyWO9TUFji3yYa7TyCmeQdMfe5lrLrcMIHp3A=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b27AM6btHMN2Lxgke8uetHDR0Ru6BRkacwmRZJNylfsAtmOCrD/mJ1jXm9wL6vuWMYifbyfbodn1tKnsK9fWtc4WGzmsgXZM7NAlLHnusY59hgGq/UcVXHfsups6XgDTtTFzcfAEqwEoVFFOEUmlGWROqnED+0wgiTd0IDFQ6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy8Q82ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 348CBC4AF13
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722968407;
	bh=q0wLitqyWO9TUFji3yYa7TyCmeQdMfe5lrLrcMIHp3A=;
	h=From:To:Subject:Date:From;
	b=Vy8Q82eiWS/MXvOcHVpuX2k6yg9HWlsinoCwsMeeMZCiym0vj4KraqIwvSwrJ4h0T
	 zRIokfb4EPpDMbn2M+vQxKJRkvOWkeLsSANY297TopGzY8l09JaXIEJTvwlSnLMqCH
	 gXCzB3vUtj2etkEkETaeg6kny1ocaVbDWI0aI+OgH6uMnRPJPQzmEFY5jpdGOM59Qj
	 ZH7cU5F1OUhvy4NGG/wNM140fGU+kWMitb0oTjWEXK7f9jdWIKCsDnhxMkGdbXkvYA
	 xXpLUTW4pxUpO2ddfXFhej6vuIZomgGmd9TN09HQflnZ8kjumMChS58Jf27oDbnV0H
	 EHrzukAbQ3O1g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1F356C53BA7; Tue,  6 Aug 2024 18:20:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219132] New: Redundant "re-mounted ro" message
Date: Tue, 06 Aug 2024 18:20:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219132-13602@https.bugzilla.kernel.org/>
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

            Bug ID: 219132
           Summary: Redundant "re-mounted ro" message
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: low
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: aros@gmx.com
        Regression: No

I'm not a fan of ext4 logging this:

EXT4-fs (nvme0n1p3): re-mounted UUID ro. Quota mode: none.

when the filesystem was already mounted RO.

It's confusing and may lead the user to believe the FS was mounted RW
previously.

I'd like the ext4 driver to ignore or not log RO remount requests when the =
FS
is already mounted RO.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

