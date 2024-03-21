Return-Path: <linux-ext4+bounces-1724-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76B885D4F
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE391C2177B
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690512CDB5;
	Thu, 21 Mar 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCsCejnM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D330012CDAA
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038055; cv=none; b=utaoRaph/pC92uanofpmlJZomLEf0MX92OC4utrOs/k+AZ1/5IKe7z2C/RXzQ2XTaT8ffgdzhuw/VmGqUl62paFAkXQbl7zxZ4xcnuDBE+2x9PMH9Zt4HzhG68wySuZjRQEMqLh19qpnPaWZ/H1AUNLgS+Ou8azzI9+xMwr7K5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038055; c=relaxed/simple;
	bh=65M/wcOA1OqruO2xxJDahgb2SpPOe9U/pJrNvp/OfzU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pmVH/NpE5cyOJM41qLXIyG/imyguEqZWWEBMUtKiRU0w8I64J/SO8HwacI17It27th9APY7YTWr5vpnp21/wmMkFNmt2ipZyupgwEHFhymyURbkpd0GYkyqxzDs9HL17UVwg97DgVjvgm27ae+rIGFoZXoj9vHkanqnTnIz5cCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCsCejnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DAE9C433A6
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711038055;
	bh=65M/wcOA1OqruO2xxJDahgb2SpPOe9U/pJrNvp/OfzU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aCsCejnMAymq7BdsKm+GqXSxnvp+SzLgPIzlYECUnXcbJoQEesOAzbGSpD0XRpBOB
	 L0TV3z26oUnoQhAc8ly4qqR79FxM+ddlkCKqHlLvPyC8QrRlSMUy7A/S69YWB9nSQt
	 GTTXhSOLT4iRxtBGS+sm4O8L/NM58f8i2eODaLxf+/7RhfifVSKCUATRwhneIe3SSN
	 A/9kS6z0Y4HofKcsHBkjgybh2H0rTRKhBjK5UabDMM12yarTnAL/W6viOmrQDHeF0i
	 mFmq27A6XOzElnZjkefOrH+y+mSYfl7xxDyXYMaC4Tl/UTU2uoOSwzEKVAEDM9mRX7
	 KZ71bg96CscmA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 62D44C53BD5; Thu, 21 Mar 2024 16:20:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218601] Regression - dd if=/dev/zero of=/zero causes
 shift-out-of-bounds &&  NULL pointer dereference, address: 0000000000000003
Date: Thu, 21 Mar 2024 16:20:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kbusch@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218601-13602-IYdXNRkSPk@https.bugzilla.kernel.org/>
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

--- Comment #11 from Keith Busch (kbusch@kernel.org) ---
(In reply to Colin from comment #9)
> Created attachment 306016 [details]
> kernel 6.8.1 dmesg of stress-ng

Doesn't look like the same failure as the first attachment. Maybe your hard=
ware
really is broken.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

