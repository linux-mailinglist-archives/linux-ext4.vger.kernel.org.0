Return-Path: <linux-ext4+bounces-1723-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB1C885B66
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 16:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51030286CB1
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 15:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DF28613B;
	Thu, 21 Mar 2024 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJyodYrB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946851E879
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033653; cv=none; b=U3hDlsKUjRpj6OtG8KjlD9n05izVjgm6d9CJGdDgQ6t/VAj0hJU6zzt5N+VJ7nx5l/sATFPRsHq5PL4es80JnKL7rP9KOotwHWj7Fp99LhN63SyABdackrtuOea9pLgxLV2fdOJSFBFR1jy8Y3mLX/tpV7dJL4dg/KgMJUD7uYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033653; c=relaxed/simple;
	bh=ASTf40wPIqP9787tuNZCMrJBRjtGnY8j3VLC0DujcJA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHZ0/Gbpthbu4vdnxIAt3NRezaNtIEfBzp/61ErbrEbwex9UFh+Nb9Jl8zOJXqqZh8HDLLYrkhp61jGS+oMM4T+1nMo+GgEn7SuW2afD5oWdBLMAJANFulrTVdNQ2q3zP23J9Y8CK6GpGRheWqMAo9H0LWek3kN+tRKt667UhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJyodYrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25D32C433A6
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711033652;
	bh=ASTf40wPIqP9787tuNZCMrJBRjtGnY8j3VLC0DujcJA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SJyodYrBFe+fBLZndC5DBUgDt7YoOJk+xiU7ZIeSk/+iYMZpXN/RpcV9zK8g5ps+1
	 V2TPJH1rxt414lnRlZCVUo6QtKw08EWvLEcPc04wAuDFaZ1Cd5ebXm8W/627x4U4wr
	 1WDedCPUvMWHAS3Fe2fE2/gSAdwOQpk/QwkLKbEHxk9lEVsnUpiGS0nCId9pLFbAt2
	 s8dTsroG8LQTmG6hUh4wGGuAgzaYjn70ipufOUTh8u4mYl9nlYojziFYLXwpV+8nRg
	 qwVUIG76SynAa0U06dXnOao3j9wZkYjLnq/3+tVLr4WE3jo7NW2U60UqL9+jKQQbiA
	 jc7iFffv1OaAQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1DB65C53BC6; Thu, 21 Mar 2024 15:07:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218601] Regression - dd if=/dev/zero of=/zero causes
 shift-out-of-bounds &&  NULL pointer dereference, address: 0000000000000003
Date: Thu, 21 Mar 2024 15:07:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@nerdbynature.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218601-13602-RaA6w7hQmg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218601-13602@https.bugzilla.kernel.org/>
References: <bug-218601-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218601

Christian Kujau (kernel@nerdbynature.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel@nerdbynature.de

--- Comment #10 from Christian Kujau (kernel@nerdbynature.de) ---
> Building the linux kernel was segfaulting at different locations,=20
> I ended up building it on another machine.

Not good. Maybe swap/remove some RAM modules. See also:
https://bitwizard.nl/sig11/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

