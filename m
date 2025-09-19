Return-Path: <linux-ext4+bounces-10251-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890E0B87B2F
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 04:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657E21CC0D74
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 02:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758D71A7253;
	Fri, 19 Sep 2025 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXOX7Vge"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE61459F6
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 02:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248217; cv=none; b=Oo26Bf0Fd7G2mDs3xESyto1nTQ4X8wHlAz309KyYcFVbild0V2/KTacxek7fRzqK1l0Q/b5RElFaVP118LRucJ2QDRDW9DXu0hwgw/6wIdpcNzbuGaYRwwu7Zcj3OOGGAGAn5EdfRYcSB5k06MG5ggvxGzHg0pdKWPPUhMY9ydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248217; c=relaxed/simple;
	bh=210TdSVRQGZUuag20lbWvInkQii//sdWj+6pzFcdVRU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGJCga6S9pyDUiu9GosVxSUS29KfZQzog61CQuGSTRHc6nDSrgB/vKkoR0NOROYayLMdEIQUAzg8aOksU+raEceMZ6Ue3apKb/U3SLK3c9AyRnXdZzAFk93JsQXTORzHwAKA71fBj6HoOgv/gFnGEPVSnhT6RIE3yM2QB/yFkY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXOX7Vge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D683C4CEFA
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 02:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758248216;
	bh=210TdSVRQGZUuag20lbWvInkQii//sdWj+6pzFcdVRU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aXOX7Vgeq04x8+Nho9NEyRAlBeomZ/aTvygCbk9yBy6Ao1HMkBm8DDQCOpj5L+1i0
	 cJgkqrjSur2x6UN+QHTL6qPwdaA1ki4sXA2IvYojgDVqt2Pugi7PvQksO83bV0suwM
	 ZVcGIVSS6zc9jGnRM8+g0cYJwtNFQlZ6sIaSlZLf/kPLV3ZzZdlICDZ4+71gb8onbj
	 TuNITrm7lX2ofryGuMIS1OlqrVIgeCLF/mI4mu6OGSqKEkH1+mNRe/vwZvs+Nkc6aU
	 spkLn3axfsHNd2Iq3Z5WDPBWldeezFZ6IFEjcDYBhBr8cCrpmor/PDnNwpaNGUOwR0
	 ljRGdNEwl1S6Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7EF9DC53BBF; Fri, 19 Sep 2025 02:16:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220535] ext4 __jbd2_log_wait_for_space soft lockup and CPU
 stuck for 134s
Date: Fri, 19 Sep 2025 02:16:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: waxihus@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220535-13602-2cf8WJVKdT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220535-13602@https.bugzilla.kernel.org/>
References: <bug-220535-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220535

--- Comment #6 from waxihus@gmail.com ---
Created attachment 308696
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308696&action=3Dedit
vmcore dmesg reproduced with the latest version and untainted kernel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

