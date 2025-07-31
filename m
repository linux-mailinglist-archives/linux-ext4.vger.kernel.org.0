Return-Path: <linux-ext4+bounces-9247-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA3DB17361
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Jul 2025 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866EC5858F4
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Jul 2025 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A42155A30;
	Thu, 31 Jul 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="OK1zT2cW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350E2905
	for <linux-ext4@vger.kernel.org>; Thu, 31 Jul 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973270; cv=none; b=FDab9sIeLr3t4g7iC35p9Zw1I9++AH+FyikEHzXGDKStPKrW6dUKXIq9ZnATuMOj/5vfSpx0D9j8viIxfs6QiqFucJ9GR0+363MMiYw21sHm2OtYKWKoXl6fooLTla9nxRh7Bs+qL4XOre6lJHh6LeFc8ZzQMOgk9tPlbs+ju4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973270; c=relaxed/simple;
	bh=43gcPUwn4STo+5Ztvrc7kDm3Os5XBajqjV41vw5bOOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qI3GFTOu569U8rffDsjs5UIl7M5ok0HuBU9df7ZfDGijxbbk5aU74yCztk1yJYOaoNuNQ8OUADN+zKIQYvvZN224MJEZNHDbKxur8s54IautsE9wgapYPzSP9xL/Jz8+8lt2D74FIJLk16edObA5VQ9nsJxf0oVy7UrO76CaYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=OK1zT2cW; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-136.bstnma.fios.verizon.net [173.48.82.136])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56VElfWx028413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 10:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753973262; bh=Ibb6drDMNQatTg2pK87gNyquIoQ8IzDIZg9T8Y64IFg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=OK1zT2cWGJxVTMIIGWYe/pYdIOpxJOEOGQ+rdvIGWp+ucuhvABPtnDHPKa/p+UMb/
	 6lcrQaVc4gEnLEVsZPMfEHV0rdrx5m0RwrnI8SQaLDyNDEGcX1Z5ysOc170Ss+z4C/
	 b7GAwF6/yR7iIdruXIkPd6zSx06ev1cpWN/1SkwGe6DCSQ1A7W75LgYF8LSLX12y+p
	 qTU9lzSTITBFxNNinZPv4pDcp/t1+FXuspQXtmy2Wt2sVcDcfTveJSDAQU9A08VrEF
	 3veR4IxgT+9rRNj7NJIIob2+Iygdf3huGAbDb9dOf4+OS8VeTkQUmhfIZfJ5feV9xx
	 B+f6nLNccpkWw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 40A6B2E00D6; Thu, 31 Jul 2025 10:47:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET] fuse2fs: more bug fixes
Date: Thu, 31 Jul 2025 10:47:37 -0400
Message-ID: <175397323611.570632.3955883946343856986.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 06 Jul 2025 11:30:54 -0700, Darrick J. Wong wrote:
> This series fixes more bugs in fuse2fs.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> Comments and questions are, as always, welcome.
> 
> [...]

Applied, thanks!

[1/8] libext2fs: fix off-by-one bug in punch_extent_blocks
      commit: 509da98991e2a3f72042c6b29e538a5269357a80
[2/8] libext2fs: fix arguments passed to ->block_alloc_stats_range
      commit: 520caea10dec63fb9abebaa55578a671d9f2aa15
[3/8] fuse2fs: refactor uid/gid setting
      commit: e1d3faea4ed9875a438a54a6b89c1089d81098c2
[4/8] fuse2fs: fix gid inheritance on sgid parent directories
      commit: 33880eea11b71ec6f7ef80c5f4911464d5de2edb
[5/8] fuse2fs: don't truncate when creating a new file
      commit: e3a1437758398e8adcd141aabb7c572af8ef356a
[6/8] fuse2fs: fix incorrect EOFS input handling in FITRIM
      commit: 62b2a1619d858f65acaa6ce64623fb8684a88882
[7/8] fuse2fs: fix incorrect unit conversion at the end of FITRIM
      commit: 861aa217652426711a619d11aab5c92006a98e22
[8/8] fuse2fs: don't try to mount after option parsing errors
      commit: e7774d8fef39d16eb96f1e55cf2f33d3acb14d88
[9/9] fuse2fs: fix relatime comparisons
      commit: 5cd55fe0aca3fed5a7ca6f0b4976f0e7b1e4a972
[10/10] fuse2fs: fix lockfile creation, again
        commit: 9bdd3c20c1bb2b47fdd7bff59f75110b792bfc13
[11/11] fuse2fs: fix race condition in op_destroy
        commit: dde5994fa0c314fb5b0f4020106937db4b12d68c
[12/12] fuse2fs: fix races in statfs
        commit: 5aeeba417fd0a6598046cd59807235db00e99908
[13/13] fuse2fs: fix ST_RDONLY setting
        commit: b9d23a1a128e553f6ce73766bc884263ba30990d
[14/14] libext2fs: fix data read corruption in ext2fs_file_read_inline_data
        commit: 10d7761527fa0778a64ea5cf3482744869dbb3a7
[15/15] libext2fs: fix data corruption when writing to inline data files
        commit: bc599a8bf3d448a12d14e9b2f2f1618600c2daa1
[16/16] fuse2fs: fix clean_block_middle when punching byte 0 of a block
        commit: 9b44c01c1f9d800a56bb7a01a53e4f318c08d9f2
[17/17] fuse2fs: fix punch-out range calculation in fuse2fs_punch_range
        commit: e18b350af2d77f1e063ad9ae765dd161022bb04a
[18/18] fuse2fs: fix logging redirection
        commit: f79abd8554e600eacc2a7c864a8332b670c9e262
[19/19] fuse2fs: don't record every errno in the superblock as an fs failure
        commit: bed461d69f4c14b35f86ff25bad220ba3c5d500e
[20/20] fuse2fs: fix punching post-EOF blocks during truncate
        commit: 86a24ae12c4fb81ec0b27ae1b63d3e5b05c7d46f
[21/21] fuse2fs: fix block parameter truncation on 32-bit
        commit: a5da316e5b54e12da000c60191c6220692c00f0f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

