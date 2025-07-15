Return-Path: <linux-ext4+bounces-9014-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B43B05D2D
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 15:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70AF97AA19A
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ED22EBBAC;
	Tue, 15 Jul 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkcnqiFt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EAE2E889C
	for <linux-ext4@vger.kernel.org>; Tue, 15 Jul 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586194; cv=none; b=KWv9dWXDxLUOobLtduW2mjsU3iFnMSyzahcpB/6LBz9aTU1sGQ/OBoNYQZBRK2RdkO3rNGU7bEztagjG9Yjb20lrnnETT4GOiLDniyMb9CfiIC2V9gKllJFQgndsZoW+kWrYVoRM/fD0/lHrPP5wdGf1P5U3Ix3dyrBrPjn4ghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586194; c=relaxed/simple;
	bh=6WDZfTTTwZsYe2uetA98wmDfOZS+WSOu/4EIxbl2ctk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DQfHagIK+NypA+ROn+nkJzUWB1g0p0GlK0PxDPeOiU+EPpd7hCXjEyWhgydfYkMYzowNbV5exehtTtMKOYBqZacea8k1eZpSDzbwnD8PkTTA5Y8B3gbqln+Hago00D+xji+XkanyAu0oO/M2VnNBnN02RHZqHNjE9bzVWbAsDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkcnqiFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33558C4CEF7
	for <linux-ext4@vger.kernel.org>; Tue, 15 Jul 2025 13:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586194;
	bh=6WDZfTTTwZsYe2uetA98wmDfOZS+WSOu/4EIxbl2ctk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TkcnqiFt3C4uQd4NlRj0lS/ub1d18PHfzNAeqkiV8C6Gu0IXq/hkzmxlXOlIn30gm
	 LvtHHJ0tqFc8Yt5buUtOeXiSWyO2ULAX1D121Mv0wZwnXq0z5qPvzTvIS1dCDxYD51
	 mW42a9YnQ3k7LKWTipJE5mSlpQQpx6icpw/ov8gxugfd6vE1s8T6obv2LTria6cg1v
	 fNyxEZp4r8MlVhAWv/M0yjs79OZrY9k+bjjMHevZpk8fzy9MRjlWK6AaM7tgaD34/o
	 MRlxsZxoQkAi2G1QCHzfDCo+UqtpWrkoWr5rwhnT1Nd3bLzE1Ix3FUkmEuQvplkuMS
	 TWGYIpYR/1k0w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2B3C6C41613; Tue, 15 Jul 2025 13:29:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220342] After file delete, extent index structure remains
 unchanged
Date: Tue, 15 Jul 2025 13:29:53 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bretznic@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220342-13602-rD9h8nGiLy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220342-13602@https.bugzilla.kernel.org/>
References: <bug-220342-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220342

--- Comment #1 from Nicolas Bretz (bretznic@gmail.com) ---
Created attachment 308381
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308381&action=3Dedit
patch

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

