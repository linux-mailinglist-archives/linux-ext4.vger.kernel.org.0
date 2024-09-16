Return-Path: <linux-ext4+bounces-4192-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5140697A70C
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 19:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CF8283E21
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A1915ADAF;
	Mon, 16 Sep 2024 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krFMkNCv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17EE57D
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726509100; cv=none; b=pUuFvniC08DD6NKw2r8G9WqWL3ScCMIwpBfxYgkI4EaGrSQsHJmyHUA0EfKTc1F8RLLHSOiOi9QH4iNyHNydpxXODmIoDCzPFnWbXGrqiCcwgVNjwvKK40/VdelbGQ8og97fLqp3vhiSQ61d/EMmREiYaqsbwO0PgqhtdzSE5a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726509100; c=relaxed/simple;
	bh=qtn5hN7HtYYdUinBqnXyvf3pW6zirv/CSrrqctbwzYk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRXWRMGC1ZLVL5itR7C8kFWnjyCaj6xMhRSXdF6manU9PZiYidmRA/I4JrmxK/fq2SUixu/coBzntbPbA+Km0YLHKi2fZWxIk3u8vPKTDw9QGgnw3PhEK9y9GJjJDUDQguH5vJ9Ij0+sA3rqdudJD9Lti4GgzYbbmmyDvWLheQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krFMkNCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBE89C4CECD
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726509099;
	bh=qtn5hN7HtYYdUinBqnXyvf3pW6zirv/CSrrqctbwzYk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=krFMkNCvttLHAzqx8vH0X6IOyIpyF+nOXV2ZUlBU19YhrjtrLpxKUn1f4DarXFQXF
	 bHKlipYIYX+MzWDRlBZlFlnGolnAE0Nh6Bpuhz2lVcaQLIehdvOPwnPSKqVHX2OnHx
	 AHbr80XFjJBaRRoAkZOm1feX6qFwWVzvXghgZ+QpNOhcELKnr2YFjnOVGoFy3ewVkD
	 UYE2BpnXY5xeP0nNdUPfVlRRca2Iv9mf48veJ59ek7Ok1KAghmwsh6iken28OZi1tC
	 5RDZkUi50u+XzUdsCywlG8LeByVcyBOL9MsqnhQ9QwJOqS1lQA3tGXh5kBUoWrjhPS
	 hO0vPPHGb6asw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BD097C53BC3; Mon, 16 Sep 2024 17:51:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Mon, 16 Sep 2024 17:51:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219283-13602-u2s56l6gWN@https.bugzilla.kernel.org/>
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

--- Comment #5 from Theodore Tso (tytso@mit.edu) ---
Thanks!   I'm traveling for the next two weeks, so anything you can do to
narrow it down will be much appreciated.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

