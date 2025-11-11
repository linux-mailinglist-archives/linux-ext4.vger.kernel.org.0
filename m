Return-Path: <linux-ext4+bounces-11793-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B1776C4FAC1
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 21:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 457DA34B6CC
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 20:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22D33A9BE4;
	Tue, 11 Nov 2025 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gYgG8oNh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19353A9BE2
	for <linux-ext4@vger.kernel.org>; Tue, 11 Nov 2025 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891800; cv=none; b=Y81ZeecEZHTF5zShbbMKBOfAN76KCdsWdyhrAE8X9Dpnd5X9fJYh65j7raPy7nzDS09aTojQXL+1jWG/zuRZVQEPXvcEKUyKtZXR0N96TDhWNjIJ+duHcZ8JC1lFbqBxrVWm2WGkXf+W0hFPkF/it+xbwsDGLZTCxPxlmUgkaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891800; c=relaxed/simple;
	bh=aKU7CwRoFN7GwAUk/VpcFt8d8rBypsRl8Gnocq6cGlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qyr1Vu1yawIEUIsRJW3WQ6Whh5JJLMjU6ftC8TB+bjWORzxnO1TzzHzRJTpJ/mTnd/tXxvkneWEXoljBqszP56OyBtUbkYG48b6dZim/SKeIL/uXzZBrWNX2mj1l2poiw+i/VlB2Xj6GlsvL7bHKV3JVDokLtbpcXRhtcKqHsFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gYgG8oNh; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5ABK9ow4008978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 15:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762891792; bh=rGKSYEkWslJh+Ex2G50XKu2IgwJMeDD9JJcg3/TUlCU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=gYgG8oNhOwFxh8c5gDdlVLX4n0abFeLNwsVvdM4kXkovttB4PaAtgWiwRjVc6AgGA
	 nyFr5q7wLjzjqa+Yq/9EgxcMj90z1+c3C9nfws4zVs3jkLWE4rLrketniBG48wAU1u
	 J8Q4uTOVyk5/k+/riCzzjX+zmH6pRiNBHsrfLvkpjs6hwDx235RT74DyrBGO+YSj4f
	 ww5Ubhi1pHmQT52Q3ZNAOhtUXyZk3xLPK1hIhcFlhzFGGNEn3jdXzko8KKDwWlYwV7
	 JtiewaFCVTZcbWw2VdPyd/Dn4/kI8A3eS0khzPZmFfEodq8cb47PSTcmsJYM8Ib1dI
	 xdRrOCm5DA8Pg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 502FD2E00D6; Tue, 11 Nov 2025 15:09:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger@whamcloud.com>,
        Li Dongyang <dongyangli@ddn.com>
Subject: Re: [PATCHv2] ext2fs: fix fast symlink blocks check
Date: Tue, 11 Nov 2025 15:09:46 -0500
Message-ID: <176289177750.1399954.9061912181115390685.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250808080505.1307694-1-adilger@dilger.ca>
References: <20250808080505.1307694-1-adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 08 Aug 2025 02:04:27 -0600, Andreas Dilger wrote:
> Use ext4_inode_is_fast_symlink() in ext2fs_inode_has_valid_blocks2()
> instead of depending exclusively on i_blocks == 0 to determine
> if an inode is a fast symlink. Otherwise, if a fast symlink has a
> large external xattr inode that increases i_blocks, it will be
> incorrectly reported as having invalid blocks.
> 
> 
> [...]

Applied, thanks!

[1/1] ext2fs: fix fast symlink blocks check
      commit: ae7370a5fa175c609bd7c780a5ffaefdd58efc91

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

