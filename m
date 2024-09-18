Return-Path: <linux-ext4+bounces-4213-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C90C97BEAF
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 17:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADE7283C94
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06054188A13;
	Wed, 18 Sep 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqNrLYkB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7AD299
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673749; cv=none; b=BtqjVy3lzEhFaw5Eu8TeXQOKqlzgXTbitNRTyYQ2ByxdpLbIzhwuke97tE9V6LdcYwEYktFYYX98bZF23DSEe+XEud768y6sA6rL/OlbPnKCUaCzm07lIe10UMK2WQV+XHBmDbmV8/sCscw7Et6VpFY1VdZQgfWqYHMDc6Poyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673749; c=relaxed/simple;
	bh=Nakw0qADUEp0H9iIlguTIjkA19gJqCAQ9xTbau8F95A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DAiojK4NxFWMP6gIIe7sl77pLPeQ9wvXe57O2J4iRabJBg8kEQC0a9QgC5qoZnwNW+FQQKeKcWCgHrQrATPhTaJu2y4zFa7Ih8PTVO0UAWy26wvG2zFklA24/Im9eVMc5TypYjBqMaOPsU9BUAihZtb+/P/kET9pkRo3+2tsdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqNrLYkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30579C4CEC2
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726673749;
	bh=Nakw0qADUEp0H9iIlguTIjkA19gJqCAQ9xTbau8F95A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dqNrLYkBt9Ztx5efNU5awFH+7FKAyPtmECDjsyFOFvrcy8iUicmGYH0XCKa3ABHkR
	 5I2VbOXbqUp5Ky5Q91i2RVEfpBPZLBWRbUypddgnHkXZKexYX0k3bkCTGa+prh6w4C
	 UKqcZda+HJ15O815sNl1qy21qwMpsUb6zuaueF8blbDymikx7MzUpYDeAoWO/v5uJx
	 CKbDc61cMUfbxGmGn2M02ETk4eVluX39b//q4PpwX8mTB7L+0U56iXCnerU2VRM/re
	 gbnNwLBg3HbRtD94U15S0jX/VvIQUSa4dff6JlgdeTtv1gLv74Ks0KmjotCJXCYKPa
	 SrwJVB+bJS1cA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 225BBC53BB8; Wed, 18 Sep 2024 15:35:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Wed, 18 Sep 2024 15:35:48 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jack@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219283-13602-iwAPHIVw0u@https.bugzilla.kernel.org/>
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

--- Comment #10 from Jan Kara (jack@suse.cz) ---
Yeah, I'm already watching it because when you narrowed down the range to
6.9-6.10 I started suspecting this commit :) I'll try to reproduce to debug
what's going on.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

