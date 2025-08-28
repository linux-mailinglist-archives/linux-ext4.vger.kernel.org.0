Return-Path: <linux-ext4+bounces-9726-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA9B395AC
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 09:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F66D3A5030
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946782D23B9;
	Thu, 28 Aug 2025 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uydcBJXL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5D25634
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366988; cv=none; b=Ou/6+QhsSPGKmQ6/YxtEfO8s2cytX/4LHKJGd6VpZRa/h63bYSuWJF5knGwjYWILSoRnp5JKRGzcueXLXKZMVcnvQ7VgUfmqYF2c+ZSH/1hpBqOewLS5FBPqOjn9+VwYvE2NEPZ7kShdAK0/iUM02z6+Kfvd/cwgS8Tj7CnpC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366988; c=relaxed/simple;
	bh=Hiswn7rV1i9/LpmHdWvbmjrzXPdwHqu4fyqv6UYA/1A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NS5MnwFrGEObkJ9swgwUyyORphNfkNkassxH63qpKh3s0dr0vw4wco7DM8RlXjDQo5JYVTMUtowyP9CHc5+Eyh5xYcr5esT8VgN9kmRYeZtf+dAATiFypzC9aYZTMINC3SXVPdiskGY7V5MWqwdAUA502EvpqJkFCTzs6qUJM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uydcBJXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8C7EC4CEF5
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 07:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756366987;
	bh=Hiswn7rV1i9/LpmHdWvbmjrzXPdwHqu4fyqv6UYA/1A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uydcBJXLoVg8yQWvfrD1rQ2By/rOpGdBG3JOtT4sRFp3Panxv1O0JDM1IZnvNtJ/o
	 eRHHke2f3ggBfvqOBbpCtN4zByJ+8UwgbXN7LrOOF5nnP++/RX0mrQmlE2JuatY43F
	 75gvfASJlIYz54m04oY4/h1cP4UFBVYVYCHio68jcXiYoq0a3z6vzRyBNph+zv2ttE
	 BIqTUgI66ydAIgauLM8dQ+Zy9wGnjOi/gDa6O90aUYgwQpohQ32mQq0JdOSRqOS8LE
	 zSSI0a7iwAwAfwgGZkM/tmARIq/8/ptSzX0Q9FelbPMUt7r7Pl3cCxMk+K6QthmhK8
	 3/bqTyEeA5T4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A1BF6C41613; Thu, 28 Aug 2025 07:43:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220506] INFO: task sync:4678 blocked for more than 248 seconds.
Date: Thu, 28 Aug 2025 07:43:07 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext2
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-220506-13602-GbFF4wtBOP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220506-13602@https.bugzilla.kernel.org/>
References: <bug-220506-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220506

sander44 (ionut_n2001@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.16.3

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

