Return-Path: <linux-ext4+bounces-1721-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2255F881C1C
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 06:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74E5B21716
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 05:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7412DF9C;
	Thu, 21 Mar 2024 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V30bbL77"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F7E2BAFC
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 05:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710998438; cv=none; b=NoniddHqFAeIYIHl334eyPjo90gc0uSzVaySY8I6vLJOGliCszgLseCZ+kRD3+ffHPrJWEFKg2MsVncAgm0OW0MlUphHmukIH5hQtkHHW4bmdDbYbDrNbxyxlEVBUVcH/P9MKIvsoFfsq0WGGEuqDI0FXHoiiqDxnCu83t3OMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710998438; c=relaxed/simple;
	bh=NyFR9qAiYpRWY+te0KzItMliHwuhDBCYC7MUaGoDtjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TtWEl8sQIsOUIY+pbmXrScQZOItsH+Pf/pQXpnJsguUuI8QeXMEAhMoQ/ki6B/ZYeHvNVF8mhNsBPdgiLZ4YjZDhtEMUUpxIKPELXX3iBzVzRH331SnWbTk3jJma3aSfEKEpVNq1jCKiU9EsR88Hb5Az+7ZxE43tpoxxZZWjN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V30bbL77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B02CEC43390
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 05:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710998437;
	bh=NyFR9qAiYpRWY+te0KzItMliHwuhDBCYC7MUaGoDtjU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V30bbL77Mq7r++qVwDbwfyNmRA3k3MwlOqDp3BHBoP2jb/maitQ+7w+QKV45AmfvZ
	 LSJrNU9NQGIXCNGe3EiCcX/3POsJI/3VIQvOGwzh3Nma1J/3KMwfgvPPbjHzGJ9XPk
	 Ec285SyIyYL2CiVqEYpOOS1Ys/YiA6N++c6OPJAA20GGDlUIcXtolZPXUrofY5XCnu
	 GhJGq8LPu5Qo+70dxuAs/PdS9t+tNmFWWsIr9mTC9iX4hFiuhp93QP1GoKGv+KjVvB
	 XPL+j4GuYzT04Pf3EzBOoWYxV6eMeBWTdkDZsvfYqTZZ5PpIotMd1hVbCTKnav22Gd
	 YwBQImTakapew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A93ACC53BD4; Thu, 21 Mar 2024 05:20:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218601] Regression - dd if=/dev/zero of=/zero causes
 shift-out-of-bounds &&  NULL pointer dereference, address: 0000000000000003
Date: Thu, 21 Mar 2024 05:20:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: colin.kernel@i-pentest.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218601-13602-GGjdUgMYlg@https.bugzilla.kernel.org/>
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

--- Comment #9 from Colin (colin.kernel@i-pentest.info) ---
Created attachment 306016
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306016&action=3Dedit
kernel 6.8.1 dmesg of stress-ng

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

