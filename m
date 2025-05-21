Return-Path: <linux-ext4+bounces-8065-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B840EABF872
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 16:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E7A188EF50
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D3222562;
	Wed, 21 May 2025 14:51:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638C1EB18D
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839087; cv=none; b=DI5dYKk3pgReXYljGjCdbin0A1wKXTTaG1zsT/7xq13lmDT/rgVAuTsvMbRTB8dn2zqiq3zy/+YmTVCgtIoU8M+f0Ik/H9mn3UMWH5MtE3dxFbUp5LFKAkFGMWrBAIh5AXqZmfQUX0JT6/5JyXeOkTGdYvJ/B2lgnRR+BCs7T9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839087; c=relaxed/simple;
	bh=GNvXfygELmT5H+seYMv1ixYLiAMVidPO+9LCSOJsO0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPVyofmTkWUbPILJHumjbhX4w/JgfzqScU4MTTtiRu3jcpOW1uuAs1AmXzngiZ5VWF9q9GU7qp8ImV7jZcNXo+2jJxNpp3a3iUQSBuvNNT26jvhPraFsglqLp1yTHbJkntz8f/1qIxbGyIWYpkmdSx9sxkBVmqrHA683Zl6TzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54LEpEJv001401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:51:15 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B68C42E00E4; Wed, 21 May 2025 10:51:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET 5/5] fuse2fs: better disk cache
Date: Wed, 21 May 2025 10:51:05 -0400
Message-ID: <174783906008.866336.2217822116966012138.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174553065491.1161238.812958177319322832.stgit@frogsfrogsfrogs>
References: <174553065491.1161238.812958177319322832.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 24 Apr 2025 14:38:52 -0700, Darrick J. Wong wrote:
> Improve the libext2fs unix io manager's disk cache by allowing clients
> to make it bigger and allowing hashed lookups, then make fuse2fs ask
> for a much bigger cache.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> [...]

Applied, thanks!

[1/5] fuse2fs: report cache hits and misses at unmount time
      commit: 2fc31e7f7678f611f69a4741a1cf11fa717bd362
[2/5] libext2fs: make unix_io cache size configurable
      commit: a5a6bcfb48209de749bba24ccebcdbb866a88666
[3/5] libext2fs: use hashing for cache lookups in unix IO manager
      commit: a3e22078df5b08107b12fc1f916c7f5ac0be59cb
[4/5] fuse2fs: allow use of direct io for disk access
      commit: 60d0575abb45230050362e0b9811c6cb3b959d30
[5/5] fuse2fs: allow setting of the cache size
      commit: 516805378ff5b0eff390e3ce75e110758b83f210

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

