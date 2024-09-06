Return-Path: <linux-ext4+bounces-4080-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F00196FC4E
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Sep 2024 21:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB15A28B105
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Sep 2024 19:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2F61D54FC;
	Fri,  6 Sep 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hw5+RPBx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F941B85E5
	for <linux-ext4@vger.kernel.org>; Fri,  6 Sep 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652005; cv=none; b=OKMBwpA+8vqBRLw93qLxWp0VGc+3F4DD0VhQTskpuTwRarTCbPP8xqo1xOiyLytCm8XVhPm/A0V+59kMNm/tH7+lR9PAh8aeXMygnp5tp+OGqNVRh0e8fAjalHgwHZO9pT0O/u5Hdg1KaSaTjU1fQYoiqmbLi7BHeLXCilklu7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652005; c=relaxed/simple;
	bh=p7mrfn/QHp0eAqiysSS2XUaeOwHodjXIVOU0u1cKLNo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cRWUWAO2CU8DPa8pyzuCTUlQEhsKnfKr+Jl6nSp8weOMHqyiBH7cwoRBGsv3BhM496Sms1W1rKqRJoMEgHxtysYw5XHzYAIBBY9gLnwmBXhz3hc/WTK3Sp1QN4GHU5UhUiYdUyLO/P6vqeKwIIj4uFX1i0WOD/rL00wAlBnplUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hw5+RPBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99417C4CEC7
	for <linux-ext4@vger.kernel.org>; Fri,  6 Sep 2024 19:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725652004;
	bh=p7mrfn/QHp0eAqiysSS2XUaeOwHodjXIVOU0u1cKLNo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Hw5+RPBxCkdK1APGARANI5NoHxmEWt99fu05s/k4yMc+sF/fK8b+R2WFyMCGVm6qZ
	 ZH9VpF9T2nR68N8fs3r7EBMsAuJulwQ5/yBEfMHVtByIw/3EmzbEVO9h5nr97e26gk
	 IijyrW+FTbGvB38DRltDVTnLLbIItpijRRIYaWXsLx/Xsw/5wm9TDAf7Hbs83fNi8w
	 CQfYWvmiL6/fDeYschgp5QM8cF1+njkwucDgT1b5DEQHM9b9/wQ4+HyVCevN8PIcUm
	 jkBIQZ1P8E85T/v1UAOXafg2KB6T16p8vo7onY7N9vCvfAls2AtQFEQpme1/Q3xlBC
	 KG82EAlPF9Hmg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8F0D6C53BC4; Fri,  6 Sep 2024 19:46:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] occasional block layer hang when setting 'echo noop >
 /sys/block/sda/queue/scheduler'
Date: Fri, 06 Sep 2024 19:46:44 +0000
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
Message-ID: <bug-219166-13602-wlxrEbsfjL@https.bugzilla.kernel.org/>
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

--- Comment #14 from Richard W.M. Jones (rjones@redhat.com) ---
I think I have bisected this to:

commit af2814149883e2c1851866ea2afcd8eadc040f79
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jun 17 08:04:38 2024 +0200

    block: freeze the queue in queue_attr_store

    queue_attr_store updates attributes used to control generating I/O, and
    can cause malformed bios if changed with I/O in flight.  Freeze the que=
ue
    in common code instead of adding it to almost every attribute.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Bart Van Assche <bvanassche@acm.org>
    Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
    Reviewed-by: Hannes Reinecke <hare@suse.de>
    Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
    Link: https://lore.kernel.org/r/20240617060532.127975-12-hch@lst.de
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

