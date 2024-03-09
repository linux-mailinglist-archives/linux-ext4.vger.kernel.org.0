Return-Path: <linux-ext4+bounces-1580-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C677876ED9
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Mar 2024 03:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DDDB21378
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Mar 2024 02:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9FC2D638;
	Sat,  9 Mar 2024 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3w414JD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410132033A
	for <linux-ext4@vger.kernel.org>; Sat,  9 Mar 2024 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709952712; cv=none; b=mqnmIt78aRskdV17Mjnff03oJJNhOQJ6mp15uwkFlccyo/E9y6RuGHnnXP2Qj52YOb2XTByeg228UjGZlnwzN2opR5rcG99Xic0iMubf3nYiDUE72v5Z8BIwGUy994ZzIhIr+uBEI8pM9pAv5YwVAkmu9JTPY8uPj6vP7HNW7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709952712; c=relaxed/simple;
	bh=MobypYCtv7lyBxRMt9UCy0wNF9z4Z73qdPb1caOAiv0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rrx3QYRi79DH0JCEnZTU4a3Rg7zQeb+B2kJvYV6676nXD03+rSyvGv96ncxi6+okQVVyxCfoZhyBZZdeEVo0WhEWhGPg/dzW7CDKPM2/eLqsJZQ4sYBGmslyWzTWBCfOgYzspoth1KIvvd759/eW2mUuFbb5MxWecu3NAmhIdA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3w414JD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4326C43390
	for <linux-ext4@vger.kernel.org>; Sat,  9 Mar 2024 02:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709952711;
	bh=MobypYCtv7lyBxRMt9UCy0wNF9z4Z73qdPb1caOAiv0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Z3w414JDar0lqDrn5mbLxoFU1RmIdkujrIA5zWObc7obJOFN9JNIjVly17eoVTrtp
	 nFdPcXdss0u8zX+pFWhz+huKdIGuxvKO+fjlDjqwbbOqiZi0tMVHT1K75FhFX5icaI
	 94HTvn6JXmAmVko4BOQ0w/WHcxubVHFRUBEGQWrr0TDRzMxADj99zRNtXq9gjYV93g
	 GJIEdZ/XyDnYXdYuMJxb20A8W3E8i1BV8Di0LPjAHdjzUhVHmqW2zKe/RWHGtFBRxo
	 0MMMcm9c2Nq8Tsw1ArqdXnxEFMgpnexCEgJWaWN0dYAIE7iMIVoELuDybWkKU0DkHe
	 1SlQY1lG3cOhQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C4817C53BD0; Sat,  9 Mar 2024 02:51:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218576] ext4: ext4_mb_use_inode_pa: BUGON triggered by invalid
 pa
Date: Sat, 09 Mar 2024 02:51:51 +0000
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
Message-ID: <bug-218576-13602-J5LahIhebm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218576-13602@https.bugzilla.kernel.org/>
References: <bug-218576-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218576

--- Comment #1 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 305967
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305967&action=3Dedit
diff

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

