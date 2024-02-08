Return-Path: <linux-ext4+bounces-1174-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8392584E46E
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Feb 2024 16:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AB61C2032B
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Feb 2024 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC217C092;
	Thu,  8 Feb 2024 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Qtnw++Ez"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FF07B3FF
	for <linux-ext4@vger.kernel.org>; Thu,  8 Feb 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407657; cv=none; b=MucWeva15iZR/2S4TqujgVwK2rS8vuGyNoV2uR76doJkI4NABYGieq4xsz1vCZHvNWgQXisx9NpNVuYamImmA9ryUm3J+qXLUypy8LF3R278vp6MxsA30vItwQfAXKeFHCfVJHADRtYIRFXxg2ZSUL9b27KXh8ap9mU2NxBxyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407657; c=relaxed/simple;
	bh=NWhJqhFHNA3/MsHhGH2E+ravx88pQ+jJG19b/PP3ZaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G26hcw8EGdmr8Kkkh1gB5eW8aKeiwPCAMw3lM7pN54rSqy0O6ywddfElYa2sx0uL2gc/YsiCgNF2dPvUotQmg/3jHjY+1E52Gyc585vFjlzi0hYiQ8ZsMpTVOD//PIt/pC4HU8pR0+jv7fjoKYzCLhDbghbfIDN/7mlOWWwyCyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Qtnw++Ez; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 418Fs6TM006221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 10:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707407648; bh=eAoFcQNHhIhh6dcif1FLUj53Icsi44u3Kas+ebeQMBA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Qtnw++EzqW05skuxAgjJ3tyNe3W7di4aS2S3UZsoA5AKldTS1y21f4u3OY2TD5nUy
	 vmYTpe9ifWJiIsy/r9ZRW/k2G4lTt1BU2jTETtufmMlSCPzrowkfAhW6FVNh++nZPi
	 A9zsRAnIV9h3JZM9vZErD1WEWC9ng34voIFLZKgCnDvUgAHzyCgwK+1+YI54yuPaNc
	 FBO2XKOg7l0sAQ1+nnXFX2LGpb6wl5/v4zVkkg+adZzTOQkzJnGSPAnvX+zukjR2L3
	 g7BnKSkKaTreMnOFBDeYyiWkvC5RhBix8nIWPk3yFEyr+5EGpmU6oDogo7PEUOEMC/
	 x5VhE7ac86+CQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5361D15C02FD; Thu,  8 Feb 2024 10:54:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Li Dongyang <dongyangli@ddn.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger@dilger.ca
Subject: Re: [PATCH] ext2fs: make sure we have at least EXT2_FIRST_INO + 1 inodes
Date: Thu,  8 Feb 2024 10:54:03 -0500
Message-ID: <170740763969.1039797.836269910365939997.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20230720125012.641504-1-dongyangli@ddn.com>
References: <20230720125012.641504-1-dongyangli@ddn.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 20 Jul 2023 22:50:12 +1000, Li Dongyang wrote:
> When creating a small fs with 100 1k blocks, mke2fs fails with:
> 
> Creating filesystem with 100 1k blocks and 8 inodes
> 
> Allocating group tables: done
> Writing inode tables: done
> ext2fs_mkdir: Could not allocate inode in ext2 filesystem while creating /lost+found
> 
> [...]

Applied, thanks!

[1/1] ext2fs: make sure we have at least EXT2_FIRST_INO + 1 inodes
      commit: 196cd1224ccaf5ca76540fc0a6238695d4476ca9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

