Return-Path: <linux-ext4+bounces-11364-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A040C20146
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 13:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D78F84E5EB0
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124E1BFE00;
	Thu, 30 Oct 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeBsICvr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555E31062C
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828525; cv=none; b=gyCBjrLKpRmJWTxqBwCLd8iOVwHSyg+rhlsq3El/w5jZzS+BNLz1j+JqTHbNO47b+FXpsoSEKLVZZD83l+yq99HUdzjsXX/OSLpg6xsl0PdFzVOVrohCKQojceNZy7t7+B3LLuJfYoRcjYWtn2Lybp7Rr1cceIfeP86pGwsIZdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828525; c=relaxed/simple;
	bh=8qJ1qr/LEphsxDNA+2KKQqs4hHKmk0B2RHVxlR+JC2Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OAcq8lD7Bx6aaWo1If7hI51URiB1KmVTyM/S4r2+BDu3wAylfP+PKpnHhkK3QZVZMtiRFYQy8izToUpD3AXrqXZvxSB1KVVkEDXjWvCaV50PNAjt9qgXoOMbaOkcWrrKH49Xmi9kbyKUIKkI2xnKDEC/bUCwJWE+gCjQcz70/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeBsICvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 576DAC113D0
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761828525;
	bh=8qJ1qr/LEphsxDNA+2KKQqs4hHKmk0B2RHVxlR+JC2Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MeBsICvrbr5tAip2JUR8oI3tJ4zNT0gdFxOqij4PHkFBn4tvTta+pOB1BcoVMhyet
	 r+W0uDULJWn0BNyMpYE3FcToPlOs1s8n7vJ8n6x4vzKj8kh9rNce2mJ8FVr2EXlXYW
	 ntu51WCE1vS5IvXqEx3LZ8zIWLJjGtxmRFx2C8FFKtiR0jIqZC8dtbvmwv7KufyKEu
	 5/Ok20nYugr2Z7fOXWSgbl2M8Nd35dkek3/fzwzeG4XayCshN0OTkTQFNANIrwcvMr
	 AuyJ+uLRGxEgC4eO+aDakc9+5V3Fq/QB7I0QVJecmHQ1oXkNe+0inYsKlSbG3ATKVl
	 TfibGWHqBq+6Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4B2FAC53BBF; Thu, 30 Oct 2025 12:48:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220535] ext4 __jbd2_log_wait_for_space soft lockup and CPU
 stuck for 134s
Date: Thu, 30 Oct 2025 12:48:45 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220535-13602-MXfdtR5J24@https.bugzilla.kernel.org/>
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

--- Comment #8 from waxihus@gmail.com ---
I wanted to kindly follow up on this issue. Is there anyone looking into th=
is
or any progress made? Please let me know if there is any additional informa=
tion
I can provide to help with the investigation.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

