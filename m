Return-Path: <linux-ext4+bounces-1720-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F27881C1B
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 06:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339551C210C7
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 05:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0C72DF9C;
	Thu, 21 Mar 2024 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgw+mg7U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A72BAFC
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710998403; cv=none; b=WRQOBMW8/z7bSbVxgdkJWzmpsZDjYmlk0RIXfttDejAAFZpThIdjP0M6mYnPaIa9thzHSv7r4nGWk7/IFp8beoKSu6cEOBj0zhOYFqNV+lMH0C6VoGYmDAAwSHS29COJ/wkYKp1wGAG3nFHq+p7IZ0SwckwVAtjWcMO8L64B0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710998403; c=relaxed/simple;
	bh=H6280AgSeSRgmEyu0p7yz+GmoAmLrPpqacRRd9MpYm0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MT1XtiEkfIcgaR7ufJCd9V6zJ6yiQo8AGo06qmA9s2EXJWnHAtZo3kfr6WZ9/ohbJb5HasbJqpRfkkV5nnamp+gYwA3plMS2O4DerPf7/GzhJtL83EF9kiIrZ3+5L5WEHRgNCM+enjlr21+pcinnKOl/vV02LDOwPSaQCGQl3lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgw+mg7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E3BFC43394
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 05:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710998403;
	bh=H6280AgSeSRgmEyu0p7yz+GmoAmLrPpqacRRd9MpYm0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qgw+mg7UQKaYmU98t8Ub8hQi6jZefxq7YBl2D5RT9oOa2ulUsFFUvHCMxYMi2XrIO
	 7k3YvTrjCrTq6+EHluEkol6k736icCecCY+TCx2qoyqUHvg7L7S2zGNAyxSMOMd9Iv
	 cHclowiJ/oSHWnDdve8w0SWkiHd0ZvweDbNU+7CcDKBIHMgvAoTECDpinD+ei9D4mB
	 aWLM4ON6l/Lv42YFQqqsfyUOutf/Gj+QDAlC184atGeslXQQqgr72oc/b+jNR86vkJ
	 VkYZLNRhbrTpICrilD3oOW2KKsPrZDUDZ9cAhpjyR2g1Lmma/GSEXDnP6t2Wftd6ig
	 2Tv7wxtTiRCag==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 937D6C53BD4; Thu, 21 Mar 2024 05:20:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218601] Regression - dd if=/dev/zero of=/zero causes
 shift-out-of-bounds &&  NULL pointer dereference, address: 0000000000000003
Date: Thu, 21 Mar 2024 05:20:03 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218601-13602-lIAU0DvjrC@https.bugzilla.kernel.org/>
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

--- Comment #8 from Colin (colin.kernel@i-pentest.info) ---
Attached is the dmesg output of 6.8.1 built manually from vanilla sources u=
nder
Ubuntu 23.10 when running `stress-ng --class cpu --seq 32`.=20

A few things I find odd:=20

- If this was a bug, surely the hardware is not esoteric enough that nobody
else would have experienced this?=20
- Again, it feels like this has 'gotten worse' since I first experienced it,
and older kernel seem more stable
- Building the linux kernel was segfaulting at different locations, I ended=
 up
building it on another machine.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

