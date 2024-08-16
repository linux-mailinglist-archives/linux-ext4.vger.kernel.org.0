Return-Path: <linux-ext4+bounces-3745-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F16954F03
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 18:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4C41F26F8A
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0191BE235;
	Fri, 16 Aug 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig7qOA4l"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A431BCA1F
	for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826420; cv=none; b=RZCU6qXJNy43kM3rBa614twkUEKW+vEfa+Zx3G37aaGKfjKNOvr8XLq7YgG/53jk/FAcUA4dVnXCI/Fzc/AHvuHp0QbEq8ABrWBmm57rSZbI5ncZ7QIalLD3CCdgDZCpdbBABQxXOEwJ5A2jqVsuuILeIXBRUmtOw0r7EEwBLZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826420; c=relaxed/simple;
	bh=U0+9DKtnf4aS9jcGmNovqrmBPHtN+/euLmox9F+Eokc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UGiDg9wvUJS0XuM3w8CbR7/zilfvwEVF0sEfCeT0aWslhGTUalKNlwUT8isllrI0nyJnndFZ651vvX+qiXKKGLz2EjiqehoD8S8crBctVHV2xlmx9o8rCYUvE68QdBaFq6/744WF0oVGKoP1WGY/fFwQUVXmkxCDkkAq4TE4OO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig7qOA4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D714C32782
	for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2024 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723826420;
	bh=U0+9DKtnf4aS9jcGmNovqrmBPHtN+/euLmox9F+Eokc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ig7qOA4lVyGdTYc+pbpGfg8tKKMCyhLjEfy4FDMYs4/ZsLbhGI3sbsupPWjHfFPsA
	 GHzAhC++rp+NwD/RUa8ORqbx68DTlHw8zNoekqELL2HYO3Xu8xOTtUG4kye4MezaW2
	 3+NmBiv4qz+7Zi7h+1Q+V8FInA/s4u5TKf3spauLxlh1p+B+pC+c8i9NOWL/R9hUjT
	 0WJdpaO3GkQTmybP8E5Vq0YIcWKatZ1NQztR4Y5N/k3vfzZ+6uF9DoQiADsXEBEy+/
	 rVApKNibaOuvMw5MhiMW0902gGMIAxYBYgJCZGEB0pt7FCOX3S1MKjN7eZbS2YGB/p
	 qc6YcUW1Q5etg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 08F45C53B7F; Fri, 16 Aug 2024 16:40:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] ext4 hang when setting echo noop >
 /sys/block/sda/queue/scheduler
Date: Fri, 16 Aug 2024 16:40:19 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219166-13602-ww7sjzkrOf@https.bugzilla.kernel.org/>
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

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
This is a bug in the block layer, not in ext4.  It's also a fairly
long-standing issue; I remember seeing something like in our Data Center
kernels at $WORK at least five plus years ago.   At the time, we dealt with
this via the simple expedient of "Doctor, Doctor, it hurts when I do that.=
=20
Well, then don't do that then!"

At the time it happened relatively rarely; if you're able to reliably repro=
duce
it, perhaps it would be useful to send a script with said reliable reproduc=
er
to the linux-block list, and perhaps try to do a bisect to see when it beca=
me
trivially easy to trigger.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

