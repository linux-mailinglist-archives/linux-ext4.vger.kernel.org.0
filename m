Return-Path: <linux-ext4+bounces-2493-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F388C435A
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59941F21A51
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8742A3F;
	Mon, 13 May 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9dXK+Lq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7A15E9B
	for <linux-ext4@vger.kernel.org>; Mon, 13 May 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715610971; cv=none; b=lhhveFC4GBwEvQKv5HyqPPlUGqUQCbVEZflIpjS3I/tTN7XntbJzmY34ZQ5XEHKvIK5WSloO21yDkTgqGVf/lyHYUPRE05Bj0wYYFIMC3ld1D4LGAIwUA0vf9U0QdXbnh8cro3rW/4OWxMdMtk+yqwsS4+P9aYBX2PIhPaYzkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715610971; c=relaxed/simple;
	bh=iKr/TDKtMLFSKz7rCvQQ413VCGYf6YxmYwhmXjB3iPc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EI7j9J9RUMe1jfh9IkNd61eNrILEjqu0ybq8x8Aavi3Mt3YsoazPYA7Pe6btXYHiNxWWEZ8bqQfPZHA25L6PUfw9otonhdO7qq3I7TsRge8LM2gJtJZOLEb8exunJBFfvbgaTZMbCO7DP8pfsFnhOEMHpec1Xjur/8Q/WIVFaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9dXK+Lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E19D4C32782
	for <linux-ext4@vger.kernel.org>; Mon, 13 May 2024 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715610970;
	bh=iKr/TDKtMLFSKz7rCvQQ413VCGYf6YxmYwhmXjB3iPc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B9dXK+LqeaCzdDv5ozbkA9rQ9Tg9jM2zO9U9q2kh883OhcAiKZTCUwJQ6i8jfj9ep
	 rJjzKtRCA+zfE0Tua4gDu+N52a8gY+xMQ15naiK8yP18xYkP7QG8IOrjx74M78FPS3
	 rAGzR3Xc4pIH3qtp8coCdmxUl6WYjDgfw84k0O5Vr00SqbcZuaIg2ez+fNuZCjYoSw
	 Aja0fDDUAauL7HfAAeUo3loZ4bBU45+9henxG5NLVxs2xzv3AGoywhsun3Sd65IMez
	 pRaW4PV6WvYflreaH20kxurADj949nFj//ycfE0T8D4slIPXYtX3xRYDphAyIm4dnD
	 c8WGvvJDq46MQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D505CC53B74; Mon, 13 May 2024 14:36:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218830] lseek on closed file does not trigger an error and
 affect other files
Date: Mon, 13 May 2024 14:36:10 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangchi_seg@smail.nju.edu.cn
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218830-13602-6iuz9KAbRE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218830-13602@https.bugzilla.kernel.org/>
References: <bug-218830-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218830

--- Comment #2 from Chi (zhangchi_seg@smail.nju.edu.cn) ---
Hi Theodore Tso,

Thank you for your quick response, I'm very sorry for making this incorrect=
 bug
report, I will read the documentation carefully.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

