Return-Path: <linux-ext4+bounces-8075-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC09ABFF96
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0401B64C8B
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2FC239E62;
	Wed, 21 May 2025 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ+WSNTW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA22B9A9
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866882; cv=none; b=CDycxs/aFqSsohqh/McheY4MJ+LpZtoOYVWUmgQOoVrld6F89NMG5GOuArqPI+0pizzHCI9pdfzHapf5T+7ZUSoWUfestQk7yWEKl7dGYUZEag5Z37HYIgdrAA4pf+8zHWhqhrEHelBCfW5mTDAsm0SuciMFyuskOQnsFndgERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866882; c=relaxed/simple;
	bh=b/WvV5SvgwObuSAVFZVCfXEtVFhRoG7iQiAAUdlKSPw=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=cokpu1go6VXaimvtpoxJox/aoBLvu6IkcrGmxz8Pp7AOIFNVDSGqM4J0dFrWQPV9wMr3aFHmNUmanbzSskgQGILzD++FGFGDUGfKcB2DKbUudG+2Q+AvsDHiJ/vV0MWKpvuiAOXGDZJN0hv/5vsPZy0WaN7yACisDQ6s1IUyTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ+WSNTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5D5C4CEE4;
	Wed, 21 May 2025 22:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866882;
	bh=b/WvV5SvgwObuSAVFZVCfXEtVFhRoG7iQiAAUdlKSPw=;
	h=Date:Subject:From:To:Cc:From;
	b=fQ+WSNTWTnnCLFpnf8zErw5/VmSsaL3BnJQIQ7akb6Enb8XXZIuk01XyvIQSnwgpm
	 cRA/hDVN+i0UqAGCt96JTwb43+TkNyP4GvgNgEw7NJ5VAqR9GdZHvucPiBPjPixVoR
	 6GsXCJ+8ynol5A77CJT/Xk5q51SY6ebq3FVyX1MVb7fDOwpldH939ttEWY/23rT2JV
	 J7ZAsRa98tPEHFZ/WowXDDFgZJTSiJJRI52+yq0NGGquW27Yb6aUz5sOjXa32K8ECx
	 JdSvGsrbyb8X1eCzrqwGElTXCu0jJVGrZBYW9DYi0cT9B9VPqy+5TZvvINjuddmgtM
	 BIqLhGY/DIYKw==
Date: Wed, 21 May 2025 15:34:42 -0700
Subject: [PATCHSET 2/6] fuse2fs: various filewide cleanups
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678184.1384866.10606130086625220802.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Clean up the inode reading and writing callsites and the opencoded unit
conversion code throughout the program.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-cleanups
---
Commits in this patchset:
 * fuse2fs: clean up open-coded ext2_inode_large -> ext2_inode casts
 * fuse2fs: simplify reading and writing inodes
 * fuse2fs: implement blocksize converters
---
 misc/fuse2fs.c |  269 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 132 insertions(+), 137 deletions(-)


