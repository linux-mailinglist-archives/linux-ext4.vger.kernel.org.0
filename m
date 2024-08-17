Return-Path: <linux-ext4+bounces-3755-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5DF9557D1
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835C11F22068
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EF514AD19;
	Sat, 17 Aug 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueoYiOJy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC6335D3
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898283; cv=none; b=Hz2gwEjKUTdZHJ4WnqRFqnLxm17No7VjjnNks2N8Q2OEXENJB+ndovlJnLPKKwvxQReUM+UfB2ANLFOmLpY82e8vZSZ6Gn7zFTLKu/mIL6ayepmRGCa1cjUCQqvX4slOl/qfpDfoeSUf6rOPPW/3j1L70PgC7+VqnGNuwYQmUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898283; c=relaxed/simple;
	bh=XuJWy8mld2gCX87QkAh7d7UkqVouo+9HdzdlscDm59E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Je0x3o2McF+3sFyTDYgN+S/HRbnolaJa+m1OyajcQ6Wh7IrXOqqHMqgH4ma2LA6e+miBqzZMMAOsAzw1xxTX32FhBlCjqGwRo5LhB5d+B+VVymYBg18zxMUVUb8sfmfHKDLx3w3CvFzSCcPwgAunr+LQQPk84KeSlSglll/6K+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueoYiOJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 558FCC4AF09
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 12:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723898283;
	bh=XuJWy8mld2gCX87QkAh7d7UkqVouo+9HdzdlscDm59E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ueoYiOJy17331+M3IR6KRlsaZLz8FkdE4B9ZOi+IBbTXtD4QPxkPkVy0mocSogu8E
	 7LhYYLYeKNT7We1CUrEhBUzO9HS+KbJFFzYSK3qsn10H5z+k4TYO/mWe3zk4cKcpHt
	 5Vwkp9RTo61BS7EUEvEeBRUXff6uZmYRAKz0/dJtmyrq6ed3L6jm2x7wk5JA7emXV6
	 w0SzRAxF1bOEmNBArWs7RUIAbdTnncwWydO7js5CI4CjmtRp9wqpRrA9E81enDRHeV
	 0NbQJfsxaIlduCdlCH6v/+vHx85JvKZ9aI2HiDH+uIpqEUAHGBbKPbuBQ5uxhDuJXC
	 a/WikDxLz/66Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4D71DC53B7F; Sat, 17 Aug 2024 12:38:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] ext4 hang when setting echo noop >
 /sys/block/sda/queue/scheduler
Date: Sat, 17 Aug 2024 12:38:03 +0000
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
Message-ID: <bug-219166-13602-bOO228q1Xo@https.bugzilla.kernel.org/>
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

--- Comment #7 from Richard W.M. Jones (rjones@redhat.com) ---
> virt-builder fedora-40 --size=3D10G --root-password=3Dpassword:123456

Should be:

virt-builder fedora-40 --size=3D10G --root-password=3Dpassword:123456
--format=3Dqcow2

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

