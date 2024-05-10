Return-Path: <linux-ext4+bounces-2442-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A546F8C1CAD
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2024 05:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42809B21C9B
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2024 03:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CBE148837;
	Fri, 10 May 2024 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjYirjl3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D6147C6D
	for <linux-ext4@vger.kernel.org>; Fri, 10 May 2024 03:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310263; cv=none; b=fJuKd6wzJXc0InnoGv6M1Fe1SNvHhFRdFFnQ48yPn2CB4+U+uhw74EywkNgDlszi55j1bYAUeSMD0qaKHmywoSzbBKQ3S31jbg9pDosKNZBhK/jzcfTOwZlYwG20BTeDEvu/VqCgTpGpaGxjD1k0GSzD7kEwiBT2Jb856VlkN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310263; c=relaxed/simple;
	bh=ZOezWREGiUC6ap1zRm4sJ+7/7flFeLHovMTLPI5EUjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pObXQVYvoTo959vo839q3c3WfqnkcXZzOFq/FHTBTLDCYugUDbJ+BXR3Im1vVrwCbAOhm5UubdPFdMnBJT0MDAvGVs7WPqORNZV32a/GAAZf3sH4a8sd25+mdMZJpY3ho6cwvlS4DuvQ0yfoXVZ/mS0MTxUl/RYH2E/bGEBdhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjYirjl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E854C116B1
	for <linux-ext4@vger.kernel.org>; Fri, 10 May 2024 03:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310263;
	bh=ZOezWREGiUC6ap1zRm4sJ+7/7flFeLHovMTLPI5EUjM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FjYirjl35gDfHLaBeNoxRyhYO9o7FhGdIast8sRAkhF6xdKxHLmcqCFj3jUUA6Z1g
	 t6m0cnl7laiaze0zYteUu/8xFSTMO+BQ9pEgq+eXS+LqGU379e3UFPdJ9PYhE336gC
	 JNSp227VuQN72pa9iWbzQKzwqYi6CkuQFKAYx3mqdAwWDcpUqa+Y+bwMDswvJ9VoQK
	 dOnxQMbHiY8rOhg56m67mVeCdzB41SBpzx9d+KGJpkW7WJualLy6uJFouQ01PezsW8
	 5gcwQkNpToTFZIlKEipVxtw+nCAUshOWjM0WsOgbavMDyTAvTk+YCqS5RleSZNC401
	 HCTfQaWG2zlAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 52D21C53B6E; Fri, 10 May 2024 03:04:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218822] Delete the file from the upper layer directly, the file
 will become "Stale"
Date: Fri, 10 May 2024 03:04:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Squall.Zhou@vecima.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218822-13602-uRHlc5IUMi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218822-13602@https.bugzilla.kernel.org/>
References: <bug-218822-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218822

--- Comment #4 from Squall.Zhou@vecima.com ---
Created attachment 306279
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306279&action=3Dedit
Test result for 6.8.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

