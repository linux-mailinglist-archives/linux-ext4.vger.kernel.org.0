Return-Path: <linux-ext4+bounces-1780-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F7D89155B
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 10:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE471F2184C
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED79836119;
	Fri, 29 Mar 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEOHPQc8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CC2BD1F
	for <linux-ext4@vger.kernel.org>; Fri, 29 Mar 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703219; cv=none; b=nX5ZzbS6eUeEMJg5ekjfvpgm/RjKwG5EmjKl0OWWt4TfphCgSuoD14JfYsGHSLcPUzlVVub5ICwjr+3XOrZQ6jzy6oCtbabCaJac+34XBUOkDg2HCbmeF5QuDc/OskNkYiR4p47tx6j/yE+rQfRQaLUvg8+tPVuOCDgsetHFZaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703219; c=relaxed/simple;
	bh=e1YUSllUBm8mAxt505xld/h45ZyXrkPqV+O9OFpn+Sw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kqwZ8WhRGI/UpEslhT8RixbyqXDSKyqE1d1puzb1/NgFG5JZSYb51/54MMZXlCh0aEqB3ntVJcHheAZdW92OKp+oTpAwQMFYGqQMV36hudn1vra6DZzMsnOb42L803k4L2TUJoS2dLL/RIq0faU5+5/KsXvyRTHCJ+gGJ1Ru73k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEOHPQc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 168B0C43390
	for <linux-ext4@vger.kernel.org>; Fri, 29 Mar 2024 09:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703219;
	bh=e1YUSllUBm8mAxt505xld/h45ZyXrkPqV+O9OFpn+Sw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SEOHPQc80IagmQMQHOBuwqWMW4eD+Alb+4EdKp9udOs/kIL8C+9OsHEM5zl5hfv8u
	 +wR0wIpZLpCdxX1KPNhj6NBrdYhEupv56tKHKrDqlHvkvGi7qu33qVzpAz6/CT41Kq
	 dd+dFu9UWNjbqEKMVIHIzBR+rlHvBZRmJAw1mPq0KvYwanH2Qgqu7bY1xc2NVwAcOC
	 vBo2nE+qFNifWT1at1N8+XDvYAp8sfZ0UPznIB/L4ZNHIGT9tZ8HYuZ07TNGfgVNOG
	 eRAKdYbNPU1oBry9/nAyJkbcj5D5vQZZyQ6hv1Mhf6ehnE3F7JB+612LX+Za1LYRD/
	 YOMl2gDa3JlUA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 07564C53BD1; Fri, 29 Mar 2024 09:06:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218648] ext4: previously opened file remains writeable on
 readonly ext4 filesystem; Data loss.
Date: Fri, 29 Mar 2024 09:06:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218648-13602-58X3QxHM6h@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218648-13602@https.bugzilla.kernel.org/>
References: <bug-218648-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218648

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

