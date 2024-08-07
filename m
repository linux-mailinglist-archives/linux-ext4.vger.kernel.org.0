Return-Path: <linux-ext4+bounces-3660-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1809394A817
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 14:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A07B1C22EB0
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0341E6726;
	Wed,  7 Aug 2024 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldtToKPv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3651C37B0
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035180; cv=none; b=ubKaGcHxL4dzxymVtPEffizwQ1tyczp68kLYKVyzuyjGDSb7OkDM0dR74Jg5M7um5KKu0BzSfDwfHP6nwI7iViSd9uier8RQ6aUUc67Yb136B9vOzYlTJlhCXacoLn+GR2G571zsJ4K1l9Bajh9Yw/yYtlz7RU5yqb5nuMER428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035180; c=relaxed/simple;
	bh=u57mQT1xx9ViORMtFEBxA672Jrx7zD9iIKA9d9ucxbo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3KULAdP6yxevzFUW/MGHHmRR+JHmVRETRSIwf+OIksXjLU9C/uTMYfaNYM7rZvOoAMh9BWIdM0Dmf7UHp7kzUyfOfEVAcK9KeKXlMtk2IH8iCK4jUlzn1Tdz3/uXf4XdbRSZmeaeW8228doXCDs1K+rlj+3wyMC/Vo1+M1pa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldtToKPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CE0EC4AF0B
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723035180;
	bh=u57mQT1xx9ViORMtFEBxA672Jrx7zD9iIKA9d9ucxbo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ldtToKPvF5Z4kZuX3HWcqWs0ZY/uJ+qVGZDST/ns9KwMGvhXaeymHeaZPc23ziNVa
	 j0vtCmiEy8CBUHrorHH7gwh/nY5ncqON9crSmMQvUjiCP6xV7c9wuTauLsnZuq8hjt
	 bphehBDU2pWNZvVnoj61JxCgvW5Thn/y4b++9+bC4ErevRvBVDL3VL3KOgt9QfI/hU
	 xDe9TafKqCqsDoeU6GB0oflkNfW+Yh7agmlsbNnD82iXprSAxy0oqzYOdWSK097KkX
	 lVVlpmPizACjE/keTngjL3R0/lsx37nBRro8kxVkZnOLFVPp9hJC8gNJ9OOk3jcKIr
	 0TERnNpoD5hAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 56E00C53BA7; Wed,  7 Aug 2024 12:53:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219136] ext4: dax: overflowing extents beyond inode size when
 partially writing
Date: Wed, 07 Aug 2024 12:53:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219136-13602-aTuXIBf1uZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219136-13602@https.bugzilla.kernel.org/>
References: <bug-219136-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219136

--- Comment #1 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 306683
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306683&action=3Dedit
diff

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

