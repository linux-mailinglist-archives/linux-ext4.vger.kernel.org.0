Return-Path: <linux-ext4+bounces-4197-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DF197B48B
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2024 22:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B59BB226BD
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2024 20:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD1C170A0B;
	Tue, 17 Sep 2024 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mquXxnJu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBF813777E
	for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2024 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726604303; cv=none; b=gylfbCzy4hh1LRCMpQMDyoEd2yhOFHTiyxYaqa6WoJscZo29gLlaJGpKDnrwsEM5nnXtJrUUITuPSvqAi/ZUpdEx2+7p8DwXcT5xnijaDJRIRuEo/Wv47u0OEVq55lbXSm1QFY/f4bN0R+TUQRYc0Y6qB08ELunbeO1ZneAQiLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726604303; c=relaxed/simple;
	bh=M4rOkYlOGRlrv06CX/aozxe8CrNzl0i2ioln2WtELYQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=anljRWuAF6C11N14lD/OYH/IfUfNBEmvBbpgx4zHB1Gkb2OLPYXNfGAksKNTKdGC9vSxKTzuIBYSimW6/kqjuCMHJyJe4AYeEn3vMSw/I4ts5ZO8hw+5VItI/DOt21wqpCpAG/RwnZ9A14hj6fsYrr5q81xME+XRvTuPHIibMLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mquXxnJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 053F6C4CECE
	for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2024 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726604303;
	bh=M4rOkYlOGRlrv06CX/aozxe8CrNzl0i2ioln2WtELYQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mquXxnJuYkq4Vkjqzx3wesufH9vB0epqXOVHQ5FL6BSS27F0Dtj2PN1O8pKR8k1XN
	 yzhytFKFS9GY3ehdNedPJzeUf7CAeRfpv6d9RFUorYlcU9ZsFllAOdWSYDsEqda7mi
	 l0z7dAPIAWQaPf727NVOq+c3vReQIyEB0vKXYUAHnSyxK4MEE6KyvxbvRsjQ7y5bhZ
	 LJvuZdppXf12hbMMWb1yVS8i09e9n4eUXBumCXbZI2VEUj4hIWRUZJjhop+Sur5Zrs
	 7BgdX5gMQiVFFp9hGj6xU3tS8T1bSi+sQBnZ7+eeZNc8sQMY3cc/Agf6X4wFP9zkzW
	 sTgxXDso1nXpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E8FEEC53BC4; Tue, 17 Sep 2024 20:18:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Tue, 17 Sep 2024 20:18:22 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: colin.i.king@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219283-13602-0ttVWRmeAn@https.bugzilla.kernel.org/>
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

--- Comment #8 from Colin Ian King (colin.i.king@gmail.com) ---
And reverting 0a46ef234756dca04623b7591e8ebb3440622f0b on 6.10.10 makes the
test run OK, without reverting it the kernel will hang.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

