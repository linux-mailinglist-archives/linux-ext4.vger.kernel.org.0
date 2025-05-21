Return-Path: <linux-ext4+bounces-8068-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FE5ABF855
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 16:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65467A99C3
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7FF222593;
	Wed, 21 May 2025 14:51:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89DA1EB1BC
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839087; cv=none; b=C7qez1l5qFfCkqqPCfBnAT0X/ToRKC8CWM+lt9Lj+AqJdK4YztAoUvStKASIXRL26icOYK38vcsXxgjgGzEHDzgy+WABpCqPOOoV10Cw/2yT5jA5D5qNv1djoa3eKUDK2tkcbXMYnEdY19bQ5PcZfnVOVTn4zr03Tcw7SLyEkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839087; c=relaxed/simple;
	bh=BvajW8G83x98qKLGkkzU9QQreRuKdFHwhIorBmIULkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwabIACpmTQchy3mEGc+XBQv/gSg+y4HwdaV7VWut5Fw4dH9SAopvt70FXalvAXHVsotj5CiE6RFEAIjXL7U/qT/Ke+xK1ZYy3Ly0E2mFBdRJ4W3+EFba6ZNPAEBC3CoKEL3PbKuPWRDbov9tI9/99uI9fmJdzoie43ryLHHl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54LEpDDr001381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:51:14 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B16FB2E00E2; Wed, 21 May 2025 10:51:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET 3/5] fuse2fs: many fixes and improvements
Date: Wed, 21 May 2025 10:51:03 -0400
Message-ID: <174783906008.866336.519054448967693851.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 24 Apr 2025 14:38:40 -0700, Darrick J. Wong wrote:
> This series fixes many many bugs in fuse2fs.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> Comments and questions are, as always, welcome.
> 
> [...]

Applied, thanks!

[01/16] fuse2fs: refuse unsupported features
        commit: ccbc6f24fed095b28f9faa7b575159e49787fae0
[02/16] fuse2fs: return -EOPNOTSUPP when we don't recognize a fallocate mode
        commit: 7775293c08d2255e90b1e003ee532d826af52d95
[03/16] fuse2fs: implement zero range
        commit: 44e024fd9cea41097c9f16bfbc73bc6aaac21f00
[04/16] fuse2fs: remove posix acl translation
        commit: 0111bdb70a9c460052387111414a2e2dc8c06822
[05/16] fuse2fs: log names of xattrs being set/get/removed
        commit: 1686713e8afc3f40f4a92e86949a909492fda3cd
[06/16] fuse2fs: add an easy option for emulating kernel access behaviors
        commit: 667ea124cf16c45f3a35b3ba024a3add962788c7
[07/16] fuse2fs: report nanoseconds resolution through getattr
        commit: f2b51fa65536f7172de4252b56c7b16d222d8178
[08/16] fuse2fs: clamp timestamps that are being written to disk
        commit: e13395876d63cebf008101b934ee9e5cdaae0150
[09/16] fuse2fs: add supportable mount options from the kernel
        commit: 8ba9236f207a9a2fe5cecadbb5bcb45b62ee2cc5
[10/16] fuse2fs: support getting and setting via struct fsxattr
        commit: 9b5012c1569d4e6a0df1aa506bee1564435b7fd3
[11/16] fuse2fs: support changing newer iflags
        commit: 0b47ce4878eb9fd2e33991ac6bb6d5a172b6a2f2
[12/16] fuse2fs: update new child timestamps during mkdir/symlink
        commit: f73fbf8e2cee1f2d49f4e7573eadb9f1cf141879
[13/16] fuse2fs: report real inode numbers
        commit: e135cae7d121f051e047c1e78a9aaacc6733603c
[14/16] fuse2fs: disable renameat2
        commit: b431abbc8fe0fd1de4e414aae3520c4c19411048
[15/16] fuse2fs: fix FITRIM validation
        commit: 7235b58533b9cd72b783daa4d6d554a9d8ee088c
[16/16] fuse2fs: report inode number and file type via readdir
        commit: 7b5d75ef8843ff0fd60397160ab002e70b858fd4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

