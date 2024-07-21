Return-Path: <linux-ext4+bounces-3345-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DAF938621
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 23:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625EF280FC6
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251F8168492;
	Sun, 21 Jul 2024 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obpzw1Y+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F4C8C7
	for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721595690; cv=none; b=MBV2KIvXrJCf7pqv8FrgoVi0jPAEXGxKDIP6eOw6HtRiKVVtSKsyFqjxvost+b25ekwd6f6kOJ/14bOvzxSioLE6kFvj3olxYJdCXDXFDfspeJx8sTGXQm5TArTUQ6tzW1deZCbzN1+re1Sol/2LQ2Mxsf3Nb1elusRSASSlg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721595690; c=relaxed/simple;
	bh=xLPeS6xUHvhg8H27Q0SGNsSypPbF7vTLP5cxur8N3y0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZV4w0pxqFME2iWxYuTQ6eu2Z1hB1dtnbibTpXIaH3SYOr+XfIVYpXRdvGjG0+4uDBeXUWMYxvCB4sXF5OrlWEfiTeacysvUJX8zsjgVJY5NgZrsa7pV26/RM65nn4UIqAamiGZK74nwMEe7B8UFAEwyTpDBxsyGQ202czMiT5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obpzw1Y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30190C4AF0B
	for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2024 21:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721595690;
	bh=xLPeS6xUHvhg8H27Q0SGNsSypPbF7vTLP5cxur8N3y0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=obpzw1Y+DkyCeM5z4V3B87VDInFPiewqW8YHB3zRAu5583IdpG79dmSerrQ5ou5yn
	 B09nEVjGBi46VZNGuSBDLFEmbdXIeOeiuJ8YIIa2bikhB1BCI22NrV5NN46P7K3Z7w
	 1Bcex0HaRDTizl9JVxmzv1OEoIM0GX82Dug1CK0F+K1GDEPen1nHM5yiuQARfBdPjy
	 WbM5qeHAcyAWH+Sw29QfuVcvH5VqZn3Yfrd647rR9YNHqcULKTFLlWcveopf7nlKBb
	 YGFBwc9mrM8RDVPSVXrwkPdjUrlVdqQ62QoTDas+f94twsJj1uvvtmKqm2j0Fb4r0l
	 3SU9Uywj9kT4A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1F806C53BB8; Sun, 21 Jul 2024 21:01:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219072] After updating to kernel 6.10.0, one of my Western
 Digital HDD stopped working
Date: Sun, 21 Jul 2024 21:01:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc component version assigned_to product
Message-ID: <bug-219072-13602-yiuHs9wEFq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219072-13602@https.bugzilla.kernel.org/>
References: <bug-219072-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219072

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu
          Component|Kernel                      |ext4
            Version|unspecified                 |2.5
           Assignee|linux-kernel@kernel-bugs.ke |fs_ext4@kernel-bugs.osdl.or
                   |rnel.org                    |g
            Product|Linux                       |File System

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

