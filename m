Return-Path: <linux-ext4+bounces-9103-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F701B0A43F
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 14:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068EC1C25D19
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679BC2BE7D5;
	Fri, 18 Jul 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAzB4sDO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD523A563
	for <linux-ext4@vger.kernel.org>; Fri, 18 Jul 2025 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841854; cv=none; b=D3cffkvYl7+3iHv6v1jufeg74QVfU8L0DBOtKrUlkLrpTIE6P9AEjyZVxuSwtiRw6pLkQINh6HuQ9LrXpZOSX3Me6vWgPUmfhmx1e5UWJDPQ7F0roFnPe0QHPxZIz7Nxl+4sOjkufJ6vWEq9on/7hCNJ5ahXK8E7ah01sTnmbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841854; c=relaxed/simple;
	bh=48DUHdS8LMtMVor34JU+zgMzqioFskD89uzc1eU/CMU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ua1hoaorLccBuX1+bY423Y7afFpfgIqGeSIKrSw9olkkHFeJqVlU3BvMrPmnyasDh2iNjAIZ8YnCpukjJb8Pcl9CYlcahNfcqdUcWz+3kfbdg2h1DU2izQjxjlBzjq9xiawQ6mY2lJhDQXK6wCUYr+j8l7HJPCHVUzsadV0HYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAzB4sDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D87BC4CEF4
	for <linux-ext4@vger.kernel.org>; Fri, 18 Jul 2025 12:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752841853;
	bh=48DUHdS8LMtMVor34JU+zgMzqioFskD89uzc1eU/CMU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AAzB4sDO9165HY6j7hykDZOIpYNwNNvc33UrwJSB64+nYviY/EPNkuk1zmICDBId5
	 sHhS64L2F5nCL6BGVnCp9hUZgFUk1CGu3T1S37vGUO/z1UJu60Pg5lKLZ40ydRdYmn
	 t7O8uz8aNyYdGgUciogQqWD6LsCxRBoa4HFkFpm5gax1lWv/KlNOYeJgtvBMFgqlAK
	 QGkOdQtxGBO2qqF/7I2KR1cVgspjfGrui34vxPZXm5s6vqR9Ftnc1l8MQJJZQqRyl7
	 5bw7ryVLHpntYKw1hKIr1EeMSyJb7kqIdn2NmKnxsxfLa4e1TEqKxEaxbHYliYRGIO
	 g5tgwP6SPWGFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5E2F6C433E1; Fri, 18 Jul 2025 12:30:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220342] After file delete, extent index structure remains
 unchanged
Date: Fri, 18 Jul 2025 12:30:53 +0000
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
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-220342-13602-t8zud6oBF1@https.bugzilla.kernel.org/>
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

Nicolas Bretz (bretznic@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #308381|0                           |1
        is obsolete|                            |

--- Comment #3 from Nicolas Bretz (bretznic@gmail.com) ---
Created attachment 308387
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308387&action=3Dedit
correction

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

