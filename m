Return-Path: <linux-ext4+bounces-9013-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ED5B05D0D
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 15:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EED23AEB3C
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C2C2EB5D5;
	Tue, 15 Jul 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcJIPoJg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9092EB5CF
	for <linux-ext4@vger.kernel.org>; Tue, 15 Jul 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586166; cv=none; b=U4hHpZ0uRO1/FBTgY6VFTUzwbZu1fe1rEdDuvq966f1e7NC4Ak0gEX6lpMbFGr6GgkigYeQ+uV6AVRblLkJifQmDz0D6uIBIs3Gtmq37HbFE7j4OdwJ8jMvBv0zX2v0gf4oOfxDI8ghS/FN1xXllf/MG6l+gpWz2TITT6Ed2zLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586166; c=relaxed/simple;
	bh=n86VZ+XTfStLR+YI4Du4GQyyE8BPD7NRiXT7VtNmP1k=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IKpVgPIV+fzlznTU88N6yAYNL5BDixz69/KP3//QG7yEPJtv/1FAl++za75ZEYmlOZjOgX/Yr9v5JC6vL/m+kRZiHSW147Y1hXthRuPGtFVdtgJAtfaQdB/VJcNpH7lvc6CzbID1WNd/NywkWSEDWnv1UIHYFS0bRDJHIrjaMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcJIPoJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 134BCC4CEF7
	for <linux-ext4@vger.kernel.org>; Tue, 15 Jul 2025 13:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586166;
	bh=n86VZ+XTfStLR+YI4Du4GQyyE8BPD7NRiXT7VtNmP1k=;
	h=From:To:Subject:Date:From;
	b=HcJIPoJgJI03jkg7hzJNjXvRVGmBvP8ap3TSxzZ4ZpsJMGKrc2quBmIeW6Au779mQ
	 u5IQhFFqbHCkkxyJk+yYmVUIk5saI9gxf3AaFcpz6TZmOK1ujPia+9XiO2rC7RqwKw
	 1PINEP0y1vXi8AVLFgzmMR2zE0upiWje2o5AHseYcnlrOwwBF8Is5yP2hYswG3WJZy
	 fp9emWPi3u+MExiM7aV8Jdj7T1p80ScohHFJn8Sx8x4sqPxlPnLrQHS/y+aDgnXllP
	 AqdD+ysNHjOGpb7aFgYyYX5jEXh4+JAGkCqEuNxBKjdMGZWdcPU27pDgTWWscEd3oI
	 crCrtr517KfNw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0D935C433E1; Tue, 15 Jul 2025 13:29:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220342] New: After file delete, extent index structure remains
 unchanged
Date: Tue, 15 Jul 2025 13:29:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bretznic@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-220342-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220342

            Bug ID: 220342
           Summary: After file delete, extent index structure remains
                    unchanged
           Product: File System
           Version: 2.5
    Kernel Version: 6.16-rc6
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: bretznic@gmail.com
        Regression: No

Created attachment 308380
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308380&action=3Dedit
ext

When a file without extents is deleted, eh_entries and eh_depth are cleared=
, as
well as ee_start_hi and ee_start_lo.

When a file with extents is deleted, eh_entries and eh_depth are also clear=
ed,
but ei_leaf_hi and ei_leaf_lo are not cleared in the top inode.

The attached screenshots of hexdumps show the issue before vs. after deleti=
on,
for non-extent and extent files.

With ei_leaf_hi and ei_leaf_lo still present, it's easy to reach the data
blocks.

Having said this, extent files have (regular) extent structures lower in the
tree, and those are not cleared. (Unlike the regular extent structures of
non-extent files)

I don't know if it's worth clearing those structures as well. I guess for m=
ost
instances it's not, and for security conscious users it would probably be a
nice to have. But then, where to stop? I don't know...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

