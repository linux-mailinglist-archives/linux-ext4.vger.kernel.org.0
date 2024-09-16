Return-Path: <linux-ext4+bounces-4186-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0006997A2F9
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 15:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ABEEB25194
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EBE154C0D;
	Mon, 16 Sep 2024 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjBppRcb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B62D047
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493477; cv=none; b=LHf9lb/UTzLByKGalWxEr9WBRjLdAUf7M4TXT8Z2Me8MNL0Wav9lF8jCyCLGWyM7fIG6AZMKUi5UNxa0W9PJ9MrRtNiiSHzwh+NF87TAk3pck2PQ69hIsbcygjIFnigsrngcjOWovLzTHZbfDGmYrdwaojT6T8URRWkUG9iJTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493477; c=relaxed/simple;
	bh=13nheDCVGbF+AoNZ1+mMBLAARjKF6HorR6n6yirThOQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GShy4muRK7+dQy5wEnWLVzOiDVbbicd/6YlAOG91dNBtiIltWPGFkQxGaRtnp8RoLwT233ETggY5BZhusG0mNLZEwBsC2XY8K8CkXI3HQcJRBYuGyRiEaJAQGNiQzhfsa3m+I83y73Byn3MUXJCLYxLRPuL9mnIOvUlmd1OgMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjBppRcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B47C3C4CECC
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726493476;
	bh=13nheDCVGbF+AoNZ1+mMBLAARjKF6HorR6n6yirThOQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tjBppRcbzlcwKPI6PbDSK9fLZlhPQo/yjG+218zglpNRYD4R69JYdli6NqrqKN/Q7
	 TCkwL51kQirz2gRO2OhV2HrFRKfoqq4mjAhbE6Pjcefd+UMZoh0UbLhB7EKC9UGHMX
	 pk6kuvRcNZsTuLQ7lE20U5qzVtFEX8Y0Aw/wr0LlDX9C+eogXji9L4YitnKjlH7j13
	 TYjsvKpge8EV+SxTnKRpWevSwZAc4inbOd3Vv9eRNFrLQnuxkgrBmyl7Nvo7vZm2F+
	 FeIxHZ2LsbbqZhEXG5WvixA9rxu77u4lPgfnF9xP94r2WUYh5IfxstzJOB0ssXgy3V
	 nAfDnj2666c7A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A5F80C53BB8; Mon, 16 Sep 2024 13:31:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Mon, 16 Sep 2024 13:31:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: colin.i.king@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219283-13602-afNfUXPwg3@https.bugzilla.kernel.org/>
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

--- Comment #1 from Colin Ian King (colin.i.king@gmail.com) ---
Oops, typo, the reproducer should be:

sudo ./stress-ng --xattr 8 -t 120 --vmstat 1 --temp-path /mnt

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

