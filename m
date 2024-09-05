Return-Path: <linux-ext4+bounces-4054-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D14E96CC05
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 03:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA451C2469E
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2024 01:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBACC4C92;
	Thu,  5 Sep 2024 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djXAK0ku"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45600802
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498299; cv=none; b=jRV28T7gMnptaOrTRxDXBlnzY+yqrU19LU8hV3uqk+kfYtjZyiSzjs0GARypzhRGUO0pigD2JX2RNixzPav33jG3VPeh44p6QVIKsHaJ8c97xLBtqxXf3SfrVwZAc7Y1YxsGmHTUPCHGC8IgNaAvtTp7gLQOx3RC2+Qb4Zjd8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498299; c=relaxed/simple;
	bh=Nwnt1wSi6q6iwMn9WXvmawW+/WIlQp8a3/eO8fpr/wA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TJdZgXs2vcX5XIIbHMf9BT2CXbOLCAagNGxEvv73MVt+1YeUGR8OkmB4v2wf1l5EcDVNPYzOmBxn/qK3wij/wxrWYUCt/g6H4DXQUhXgygRzJ+5itL0L8iW/qa6Nv6K8YNW4wpAFo8TRKyEQnSMBLTZ5+byIjbfEBFSFquSJ4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djXAK0ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAEA1C4CEC2
	for <linux-ext4@vger.kernel.org>; Thu,  5 Sep 2024 01:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725498298;
	bh=Nwnt1wSi6q6iwMn9WXvmawW+/WIlQp8a3/eO8fpr/wA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=djXAK0kuVmAYmlxSLMi8Jf020USgeYrZZvfaQvFpdK613EsrTUxS8f63rBqoC1K+2
	 dQW78ENnyapVDmP2dBqQVcI6nkRzjJwXC2sr/jHqUa7RD6odaKnDd/MxJLkPL3+AIz
	 zdmbULBWIGDHKUISBf0aNsn+z1MtvSn8nohj7NKMMUpV8RbFK/vxZQs1d4au97SXxG
	 bximLjoFFzk1hqrBRuYAqVy1EL3/RjLe/xIkL5rnW8sorYg39Gv+Wsmv3MrIXh21Ep
	 zKXHYfHGH7ytynKdG1H62LpJYjt35A+d6ovf9smXet2u2W3qWvZnh9pJE0fuCOf2iN
	 iGRd5rt+wSCfQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B132CC53BC2; Thu,  5 Sep 2024 01:04:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] occasional block layer hang when setting 'echo noop >
 /sys/block/sda/queue/scheduler'
Date: Thu, 05 Sep 2024 01:04:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tom.leiming@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219166-13602-1TqAJ48EY1@https.bugzilla.kernel.org/>
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

Lei Ming (tom.leiming@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tom.leiming@gmail.com

--- Comment #11 from Lei Ming (tom.leiming@gmail.com) ---

Hi Richard,

Can you collect the blk-mq debugfs log for this virtio-blk devices?

  (cd /sys/kernel/debug/block/vda && find . -type f -exec grep -aH . {} \;)

There is known io hang risk in case of MQ:

https://lore.kernel.org/linux-block/20240903081653.65613-1-songmuchun@byted=
ance.com/T/#m0212e28431d08e00a3de132ec40b2b907bb07177

If you or anyone can reproduce the issue, please test the above patches.

Thanks,

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

