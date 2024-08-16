Return-Path: <linux-ext4+bounces-3749-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB7D9551E2
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 22:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D06286080
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4E1C230D;
	Fri, 16 Aug 2024 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abxlTHyR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53514B664
	for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2024 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840603; cv=none; b=qUUDsKJzKMusDIW+tyal2EFv4yzLF3qf0EVe6SLDrKjDZLLyH1i1ZOE0siNd616RH37jln94YMcrwgZepppdY1T9HvJkicR3cDIxTKZmLyAGcPlwOCxrSZgS2ZIu6tWmg0wzv61jdFUtvCwgk4kqxAsekF35hq6TFcQmSLfLNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840603; c=relaxed/simple;
	bh=hnTb7p+13G7w8k3QCP79AMO3H5LKfCEX+iTdVxs7EeU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uhKRckOTNY6HNQ4dR/lwSpVu0/04Q3PEa4r5KkjIPVvhvQqgPrHfl8wFAERCM+PajtwPRaEJE1awuxjJxdtThZA08k2rXzaP6YzZOYK8QxdQjg9BA6yQk1DSptHkbyjFfqNzqeIZT5ceHJRgXe+j/lKKtBXksqpZ9uIa0zFkTPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abxlTHyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C61FEC32782
	for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2024 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723840602;
	bh=hnTb7p+13G7w8k3QCP79AMO3H5LKfCEX+iTdVxs7EeU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=abxlTHyRg6Nh5VJD1v9qBoFLh+3rv3yucbI9gBPe9zVVVT6VS92TNFhBJWnr/W5Ad
	 evc5wVbacn5ZIgS1cTkZqv1nzLdEI972WRL/gXczIhTZJH+DQmDopAimCyTck6rrpq
	 Couerqyb435/F9EFpJ467KUWF5mohv2fSNnp2o1SEtNxJj52+v4/MjOL0nBmTlTzxT
	 PO+y07ErKeTyIrwZoi27R0otzFsT39dAeA3kIWUxZpN6gyHONO+/IqAIok1EBThqEa
	 jxaKA4irPikGL+kdwYytj6xUXEbiM8l8ENMOhP8t8OIamAdrzN6fRwd08N93TT3bWi
	 xPhYrNxDnxjtg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C049DC53BA7; Fri, 16 Aug 2024 20:36:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] ext4 hang when setting echo noop >
 /sys/block/sda/queue/scheduler
Date: Fri, 16 Aug 2024 20:36:42 +0000
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
Message-ID: <bug-219166-13602-UmX07mEQiJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219166-13602@https.bugzilla.kernel.org/>
References: <bug-219166-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219166

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
So FWIW, what we saw in our data center kernel was switching between one va=
lid
scheduler to a different valid schedule while I/O was in flight.   And this=
 was
with a kernel that didn't have any modules (or not any modules that would be
loaded under normal circumstance, so modprobe wouldn't have been in the
picture).   It triggered rarely as well, and I don't remember whether it wa=
s an
oops or a hang --- if I remember correctly, it was a oops.   So it might no=
t be
the same thing, but our workaround was to quiescece the device before chang=
ing
the scheduler.  Since this was happening in the boot sequence, it was somet=
hing
we could do relatively easily, and like you we then lost interest.  :-)

The question is whether or not I want to close it; the question is whether =
we
think it's worth trying to ask the block layer developers to try to take a =
look
at it.   Right now it's mostly only ext4 developers who are paying attentio=
n to
this bug componet, so someone would need to take it up to the block develop=
ers,
and the thing that would be most useful is a reliable reproducer.

I don't know what guestfish is doing, but if we were trying to create a
reproducer from what I was seeing a few years ago, it would be something li=
ke
running fsstress or fio to exercise the block layer, and then try switching=
 the
I/O scheduler and see if we can make it go *boom* regularly.   Maybe with
something like that we could get a reproducer that doesn't require launchin=
g a
VM multiple times and only seeing the failure less than 0.5% of the time....

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

