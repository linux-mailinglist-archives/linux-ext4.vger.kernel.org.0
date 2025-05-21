Return-Path: <linux-ext4+bounces-8066-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F65ABF873
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 16:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEF81BC77F9
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E8222574;
	Wed, 21 May 2025 14:51:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA61EA7E4
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839087; cv=none; b=lA9txAjgBIc81AIeToa7jjKu50lKU6QL+HjKxZOfzUzbX7Or/byI3u6bj2S8jNIJ3qh75BlF2WQPwRtSMGsQ5AIdJDHCAUoAfAxWiXKH+4ABZtqHD9N5uMvxc9D87bAsergXYk/P0sFwgZl3RYRzl8uLXiTN6KldF20b2XatgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839087; c=relaxed/simple;
	bh=blweNaJPAytyiGIRHWYNVeBXzYsOyzq1c7xrjt3LBTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETLYoAFUj/Er70K/LMjz78thOYy9ROvdKpxD50Jn2M0ZaCcS4iuKkq66wiFgKpMLBGGv8YgRQCDJoclbcW3gsOTKo50l9uRtpPYCBPeKOjyUcJXSCjcTcB+hY0PZf4UvYFPO+hXEfgpSkBIxVx8xK3iCge5TW0O0lyPXKHkkuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54LEpDE7001380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:51:14 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id AF1E22E00E1; Wed, 21 May 2025 10:51:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET 2/5] fuse2fs: prepare for kernel driver replacement
Date: Wed, 21 May 2025 10:51:02 -0400
Message-ID: <174783906008.866336.11173738902550116677.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174553064664.1160289.1903497308767982357.stgit@frogsfrogsfrogs>
References: <174553064664.1160289.1903497308767982357.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 24 Apr 2025 14:38:35 -0700, Darrick J. Wong wrote:
> This series creates a new "kernel" mount option that signals to the
> fuse2fs driver that it's being used as a containerizable replacement
> for the kernel driver.  This has the effect of delegating quite a
> lot of decisionmaking to the kernel, and opening access to users
> other than whoever's running the fuse2fs server.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> [...]

Applied, thanks!

[1/3] fuse2fs: add dummy acl/user_xattr mount options
      commit: 5776fc59fb26ecf7a9d4f4ee4cf139ba52bc27a9
[2/3] fuse2fs: set fuse subtype via argv[0] if possible
      commit: 13e365bbfdd97cc086ee9e33cb42f514d8a415ac
[3/3] fuse2fs: make "ro" behavior consistent with the kernel
      commit: 3875380971d3b63d08fd97c37dd86bf99e898ac8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

