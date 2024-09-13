Return-Path: <linux-ext4+bounces-4158-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E09789F7
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Sep 2024 22:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEC31F26EB3
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Sep 2024 20:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE8146D40;
	Fri, 13 Sep 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7bIJVPW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754614F9D7
	for <linux-ext4@vger.kernel.org>; Fri, 13 Sep 2024 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259558; cv=none; b=ZKTflv/AY+nhocsVJZuCfhqCexO+lLEi2UDQqUFtwMrQHRUq8wZvyGaY5Keamd3N9XJolKQfK7OrvW6hAPA4eQ5Gyi6a1RTFtImwo6QDA/2M7IjvAuzHis302W6fgEfOkX+FIBN/1xEN0pws3DDyXbee6kWK+BkqUkN4VbhW5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259558; c=relaxed/simple;
	bh=r9EW+WOrFjyY7AJsQfOTeH4c0K9cvMo//QfbrKGrO6U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=raVow8Uu8VFTcNPI4RRG2tDKHayjwHmBzOMMXQfIcxQIUCZQIrYpUDXFDkNUCHW17IjbayoRcwM2iIHl45Mh2Jzy2Ii7xg24ImDMLRA4mZm8CumhYIXmkjEia7Lm6fhqtDjcuYahcSsw0bY0kgs1X1iM1UonMGRjFonGmEFnj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7bIJVPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44BDCC4CECD
	for <linux-ext4@vger.kernel.org>; Fri, 13 Sep 2024 20:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726259558;
	bh=r9EW+WOrFjyY7AJsQfOTeH4c0K9cvMo//QfbrKGrO6U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=d7bIJVPWGwSk29wwIAsCeP0SNmRv4iSRiM1P9srj3fifkFvvWbf/BCWUjZP1rBEkR
	 ot/5U1WElir8HZa81cQiKOuje2YZrANcOU+MFHY6CltSkYn3J/it09nRra3omBMhkO
	 gijDTdn2GqxSZLtzFMB4L8q0x/GWTUe7Jzs6fyicwDwR/xMjtjBxEKjuwKXlkwFhP9
	 4nPzi57T6H9pBT3zsLgata74w5nR2OO57ri4nTSuRuHg/DVkWZlK1ZkfihWq8TeN5l
	 hpjPxRvMBc0PtGY1POdMvuMlQIpJ2gJgWAZBjh2McTgkSk+B+33cIYmMGlQrnaanOB
	 bYC6b0bNI+O+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3D7F0C53BC2; Fri, 13 Sep 2024 20:32:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 202809] ext4: ext4_xattr_ibody_get:591: comm systemd-journal:
 corrupted in-inode xattr
Date: Fri, 13 Sep 2024 20:32:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202809-13602-cSdJEtMfzD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202809-13602@https.bugzilla.kernel.org/>
References: <bug-202809-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D202809

--- Comment #8 from Theodore Tso (tytso@mit.edu) ---
Comment #6 is SPAM, marking private.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

