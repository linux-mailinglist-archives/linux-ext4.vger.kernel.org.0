Return-Path: <linux-ext4+bounces-1657-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9F287CB17
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 11:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1E6B2254A
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21218050;
	Fri, 15 Mar 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGkrlxBU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316FE17BBF
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497070; cv=none; b=Mw/j9JSpsbg8SzRPyrw1UQEsGpK4e2g19artPrR7KZgLOihbBbSRT6Xl86sYPLdIw2L4tbzYgJSb5YRZm3cS+qzjIgvSnENA6YzU9eFVh1fcfzABayuaRItW04GBuup5ZMJiDbM4SUm8cdw+UMGDm7cPcc4A7mrpRmubTRf9ew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497070; c=relaxed/simple;
	bh=449D7MoCugPfyFaUWl4PcfvcZBJmFPsLcSSBgNgdzEs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gW0sY6e1NTPnBxWj8LB/UShdbfoIbcFw0eKFyaojhTCGrCwmCN+2p9GNipnIG5+eMzxuDXvogmLO4xpZp9mMGs8EgbbONzHGpbsQg8gaCGqdTbWzQwekV+qDKSX1yOfB36+CwzUdf84j+vBAevdPOO25wlCPj8a6+9ionrle/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGkrlxBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4B99C43390
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710497069;
	bh=449D7MoCugPfyFaUWl4PcfvcZBJmFPsLcSSBgNgdzEs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TGkrlxBUfdqUKIXv9eR6BD10pRiqmyLC3JP6AHcpAoKLdruaCFmMb9asH3LCyq1zW
	 E4Ga/kwfr2BYkYxusrZaZIt3e8cPaMpe+FXEaMhTjHhnwUpijlW4Hwt+/wPH9wuV/k
	 r4LtQR2kVMcoE0FUWAYjYdtAaQNK2JGXZaHcgkM884xigqzVs/kkSP8bOI05AiN2hg
	 +4fIRWZIZUDaVkdFROCd3WxmVynPakCNp2M0OXkig1g2nZuGP2CrMo2LLhIMddur8a
	 dLitWPifPsi0dn606oH1GjDTADNUsBkC4Gv4qqrgWi0UVvypRKl4yYgrp5YVM6JAMT
	 dJmqhbHtZc4Rw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AEF99C53BD4; Fri, 15 Mar 2024 10:04:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218601] Regression - dd if=/dev/zero of=/zero causes
 shift-out-of-bounds &&  NULL pointer dereference, address: 0000000000000003
Date: Fri, 15 Mar 2024 10:04:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component assigned_to product
Message-ID: <bug-218601-13602-H44PP0QJ4A@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218601-13602@https.bugzilla.kernel.org/>
References: <bug-218601-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218601

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|NVMe                        |ext4
           Assignee|io_nvme@kernel-bugs.kernel. |fs_ext4@kernel-bugs.osdl.or
                   |org                         |g
            Product|IO/Storage                  |File System

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

