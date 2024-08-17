Return-Path: <linux-ext4+bounces-3756-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823199557D5
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 14:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C851F22113
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 12:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3386314AD19;
	Sat, 17 Aug 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAgurzzH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007313A250
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898479; cv=none; b=RGxL4PiHIRUpWlOgmtjT66Z9dk+xW22nW8+S68K4GNQBtoTzg4+2/ao45kY/9XayHVnK/XOMZQO6N+nzlsS/tb9Aolc9c9P+Z7aBRLK25AaM8CVtkopWSQdgQQ58zyPB283ovoa65CuHYySmdzY1tqdj4JjuwiKBkLGUFnVv9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898479; c=relaxed/simple;
	bh=B6Kri5FuH4KyzTaikMpLqW0rJfYdkY6OKHtJN7fek4I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EtJUIWfkxPJioRrr0c4opUN5jPbGywY81qbdvZ/ec2PFlxCGgrTjDCnZWVwhtzFFdAoX9glZ7cLN3FN4GRhpj6Rd9dytGJTJV6c8JUY+DnJZA4v/jY1LKU6nPNGbMVcvBp40G3xlIkRD/G6Kio2Gn2j+VD0df4Xk8DlfvI96N3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAgurzzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30C2EC4AF0D
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723898479;
	bh=B6Kri5FuH4KyzTaikMpLqW0rJfYdkY6OKHtJN7fek4I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CAgurzzHBbYVgzYNvry2lweXIz2fyrm55seGwCIx3YoukI5ufqRG64wFU8oQ+8roJ
	 XY2L8+e1nMMXuzZvlELmIUEq+xLmCWof93+Mi/6thheGlypG0W4LLQ86qGjuSruWEr
	 QoyE6ajaYgH5jtKqpken4RgcRGYdEhuZDmRHTEiHpirQzq70AaQMrqIBqVF0eceq+b
	 O3U5VgJcQzkrw0dENC5QYdxBLnGyYDExcX9qYI64fO4jkxhQzL3cioMQTQv3NC8NFm
	 q7zclJhCfikaYYVz+83B5SKGqB5oDwRH7tg89kPZQi33wT6aNGf4rNRyEMFbeaaUBK
	 Xhu4YZUM6833A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 23EDDC53B73; Sat, 17 Aug 2024 12:41:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] ext4 hang when setting echo noop >
 /sys/block/sda/queue/scheduler
Date: Sat, 17 Aug 2024 12:41:18 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219166-13602-TAL2rLIA8r@https.bugzilla.kernel.org/>
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

--- Comment #8 from Richard W.M. Jones (rjones@redhat.com) ---
> while true; do echo noop > /sys/block/sda/queue/scheduler 2>/dev/null ; d=
one

Should be:

while true; do echo noop > /sys/block/vda/queue/scheduler 2>/dev/null ; done

as the guest is using virtio.  (Copied and pasted the instructions from my =
host
test, but I did use the correct command in the VM test.)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

