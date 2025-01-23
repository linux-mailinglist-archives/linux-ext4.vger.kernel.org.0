Return-Path: <linux-ext4+bounces-6228-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFFDA1A501
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 14:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACBE168E55
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBE820FA9D;
	Thu, 23 Jan 2025 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuAeETiG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A3211499
	for <linux-ext4@vger.kernel.org>; Thu, 23 Jan 2025 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638951; cv=none; b=H5s/v8oSW+UKLeYC4bAffNartbLkqBH0Pt4spcwD9pt/UuHeArQVrwMxN49lFHtrMsrIIDYek5aOcrUfQrJW/UnFqLQwi+u3/i3jFkfbmnXoEywKO7sFBi2epO8r3uI/nz8+ShVGU4hEdA0hF7EL2mikL7frbYIco5TIyzwLQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638951; c=relaxed/simple;
	bh=1K7yX1BAPc8XSLQzhlDpHXD/tR5hURH3t+45+lab0us=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pg50dkXXYGFNZ+vx+KDEEZhOlBySSmu97/04P+nXU6OLU9/u4vGligRZCqwM6DpdF1m96bvn/V6Avpxqn6Q5DFskvx0vgvKEcWQV1hkHtEzPVEGUl2rvVHQE1/IQgB8/ij9zpkh0Dmrh0PZoVioFZjSXGyFNF2QkaCXLQiX3A24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuAeETiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5E61C4CEE8
	for <linux-ext4@vger.kernel.org>; Thu, 23 Jan 2025 13:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737638950;
	bh=1K7yX1BAPc8XSLQzhlDpHXD/tR5hURH3t+45+lab0us=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CuAeETiGonE3/wsBjPvv6itybtnXDJzf6c8uIHAKcNu+KU4tL1IN1Yx/8OCLj1TCV
	 f7Y9CF28fbykHarlpUSC1lYtw9IpLQ0/Drema3F52bwen2JiQbjGqTI+9HqX2NaWG8
	 Jz+WhbSgiZ95gOWZVGatMAOxeuHcP7hWV35bmW1UFAm0SxMVs2iy1AKYHGXcAw4Hke
	 DYkAB6R9MiYETw5QkqLk413DVJrHjTuNPJqeW0aodbA3y02BTJ9insC5PveqCLrs9P
	 C2KeU8S1a1vbcK6uUUOCaYXnt7Alf9GHmdUAp3Auv6mdXQx76Lq/ZAwWmiqvtH9Z1S
	 wCI9p4DWFN9kA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CADC0C41616; Thu, 23 Jan 2025 13:29:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 86681] INFO: task nfsd:16901 blocked for more than 120 seconds.
 ; NFSD: Failed to remove expired client state directory
Date: Thu, 23 Jan 2025 13:29:10 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-86681-13602-2ZYsN92c7b@https.bugzilla.kernel.org/>
In-Reply-To: <bug-86681-13602@https.bugzilla.kernel.org/>
References: <bug-86681-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D86681

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

