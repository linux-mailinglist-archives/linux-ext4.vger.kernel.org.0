Return-Path: <linux-ext4+bounces-10078-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832DB588A8
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 01:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF711167A38
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 23:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD9E2D1F6B;
	Mon, 15 Sep 2025 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM6OMGXo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7445C96
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980737; cv=none; b=jp7om0Q/NWf/hh6y+8T9fTpTH+a2lZeoluIVOrjH2FoO15BX+VnUlnxeYgBeOk5/g7Af/K/uGbs0mMzwIxvRQLhm5zcqS+XBe6hnBa+enXICjZneacN7h1pVJ1qdspWQ4aXKSSOrlHdjkeW49Z84FamaMy2D0j5sJnygRWpb0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980737; c=relaxed/simple;
	bh=P26fRQYpXS2xq5irVv0G1ThR9WucmGX+7xCmRQj6jls=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=DQiabcPLLzesXiYHyvAzdoCVpBzneQCk/htSqSkwKCOXJUtQ4ktf3BRqMjnKb/xnrM1yzIav2f+MqTs9D0fGq1s07Aj5JIn/j3vpo0/VAk4OIfIKH5qEP9ybqnCharjMYkJPcVsq/AfLkBBE7w3gATPChr55/VaVpLXdneDQIqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM6OMGXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7653DC4CEF1;
	Mon, 15 Sep 2025 23:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980736;
	bh=P26fRQYpXS2xq5irVv0G1ThR9WucmGX+7xCmRQj6jls=;
	h=Date:Subject:From:To:Cc:From;
	b=VM6OMGXoj36PUCsx5/KyD8DfnVwwDk14cPyxJPj30QgtOQq2NKhB54nhtCn2j6geo
	 HgyyxwK7Xlafa+StcJTBJU/DCLvpXOXQm2PTPH4i72pGE2MUdDVPQfBUwa8S1Uaa8i
	 bsj0Z3zWzKdYDRGOwADogDczDUZRdCL65ICTVVZBIaF97mm3tyeBWB9CUdP9QMamtX
	 a4r3j2UDItAyq9uLOxD3QUgfAVFAmK9A8eDAliiwdlUdBWkg8tlMOHty+oIjiQetLU
	 YusljJv7yUCFv7orpAtIJYrPqJ59/YWfbDSt7/Jl/o69Vrb4FX0ozzcKClUwMVpjZs
	 fbAzCDDtXuxtQ==
Date: Mon, 15 Sep 2025 16:58:55 -0700
Subject: [PATCHSET 3/6] fuse2fs: refactor mount code
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064569.349841.5710112269701643406.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here, we hoist the mounting code out of main() into a pile of separate
helper functions to reduce the complexity of understanding the mount
code.  This isn't required for iomap, but it is necessary for the
fuseblk mode introduced in the next series.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-refactor-mounting
---
Commits in this patchset:
 * fuse2fs: split filesystem mounting into helper functions
 * fuse2fs: make norecovery behavior consistent with the kernel
 * fuse2fs: recheck support after replaying journal
---
 misc/fuse2fs.c |  312 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 187 insertions(+), 125 deletions(-)


