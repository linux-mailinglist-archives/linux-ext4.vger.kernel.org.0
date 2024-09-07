Return-Path: <linux-ext4+bounces-4084-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DAA9701D3
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Sep 2024 13:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC9F1C21216
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Sep 2024 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102C158536;
	Sat,  7 Sep 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqGBHpop"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D281494A5
	for <linux-ext4@vger.kernel.org>; Sat,  7 Sep 2024 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725707397; cv=none; b=DJgHQCa57D+wnamrd5oOPe/83K6yDaIGNJKyiCfAy+sinKwT05w6rzX3UZap4DdqwJaWfdUqbKTcinzc7955wQ3soLrSfqpFrfSfsbhhfrOsA8scf/63tPlpAtcFYAJaDuQSTV2OOpLox+D0ml9ghSE9+0JgTRMvOBVfy+dfmr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725707397; c=relaxed/simple;
	bh=F3JOtH//PglmV9AxiyZnv199D3cqKp+gob1FmhXmiro=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M8ZCUJ1btASVTfx/ZdGug6IZXSk3Vihbi58SCfAhSOrlTTxd6BOtjblkbGqOYy31B3anCQ2GxtaW6K/jrBdZKPsrebx2HXFDn50hm3L51v6UVPyZnDlSsE3PimscLRjXCzQlqRbUDGZZGsGotnY+0s09u5PRd1AqJFKRS4Znl7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqGBHpop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8BAEC4CEC2
	for <linux-ext4@vger.kernel.org>; Sat,  7 Sep 2024 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725707396;
	bh=F3JOtH//PglmV9AxiyZnv199D3cqKp+gob1FmhXmiro=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cqGBHpopVP7Ui4ofyJPWbxBQaytYYwOmshOhVbEr8nGl4gSLMPnacGzSDGWAz3BM2
	 7ZrEFh6fICnvlojCsJaK7Cu0JOY0RloVJiSbvEP+CmGOgy/hN0SwpOAFqlG0j05Tpp
	 yQxJGNPQ/CKGwCFvpsy3zDOi55bUgzAE6tTDfB0e0//oIrf/OwYr8x3yMFrSaDN8o4
	 ZAYrqbUGXNJzIjV93l4TzMxYyUImgks6R6wBsRuVdzPTqnz0fo4JeQq42gG+YNfLAD
	 7esZiClIp3hDk7ZVL7PkZhv1yVa7QKGn+FfUVDh2CrQp1KcXky/VEXdubGqXWe1NIZ
	 jMl21E5kUaOUg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AA016C53BC4; Sat,  7 Sep 2024 11:09:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] occasional block layer hang when setting 'echo noop >
 /sys/block/sda/queue/scheduler'
Date: Sat, 07 Sep 2024 11:09:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: Block Layer
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component product
Message-ID: <bug-219166-13602-y330obTjGL@https.bugzilla.kernel.org/>
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

Richard W.M. Jones (rjones@redhat.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|ext4                        |Block Layer
            Product|File System                 |IO/Storage

--- Comment #18 from Richard W.M. Jones (rjones@redhat.com) ---
Upstream discussion:
https://lore.kernel.org/linux-block/20240907073522.GW1450@redhat.com/T/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

