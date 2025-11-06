Return-Path: <linux-ext4+bounces-11552-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E51BC3D98F
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BD3B4E4087
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B1130EF91;
	Thu,  6 Nov 2025 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg6iL5dk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1D332904
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468153; cv=none; b=AHh4ExcD8eiMUJxaw/vYJgXh0IixVn2SIe0ABF5ckgQb/Bd8kP9LKYepfE8vMT/svRvyvAm9xMFUn0PK4QJ+Wro2+cIqdIngZMlHU/zBb8uolkrH1zkp32q/JEt2TwORU7flGOumVrnzTYZrSBD5Gfdqlc1+YrancRqlMDZ7wwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468153; c=relaxed/simple;
	bh=+BM0D7D7WGzq4+KenNtLKFhp1iZLzWXDiz0jqY2bGjA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qp9s/aESOTDNzCQzK9OsexsLdga9Ksj2m1JwzV8BOPahQUFsyA0s/KwiOVr+KJLQdNP97xTp6A/dxE1+89rg0/2BcC0j7myxJOYSfVSMt0RKsLb2zTigYu8pvZKOM0mDPJkIWcuO8GXBiJaazsk1jfZDYkD2dV9wqAG8bf2cUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg6iL5dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9FBC4CEF7;
	Thu,  6 Nov 2025 22:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468153;
	bh=+BM0D7D7WGzq4+KenNtLKFhp1iZLzWXDiz0jqY2bGjA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Xg6iL5dkALk0KOLZ/uZxKef2fgoNCsBurdFJfOu+KLEoLfOP/ghBfy57z80Y9LToo
	 Ah86DwsLOkg+eOrSaLtbzSvPZmGjAHrPQTZ+N9LgowlMgo2EnoTwmawAx4trrXX+Nt
	 iGXu2o2s7ZTt27T4s2NXKPUg/TP6hnF+mQwQwFZLXzNRHr8KtKsDAKcGVjskk5gUmR
	 HOlTU+RCq8xJwMirnDfTrHJq+deM14SRrnHYcEmtPmi2Nz4sJiZqhAFXEYcpNUAbTb
	 4Q3FUavvHXvHhB7vGl2hDL9YKpTabOVTvQiPBgZ4z9yeEZh1HgsHrxJTGy4KCBeFtG
	 r6cmyEnXjYwPQ==
Date: Thu, 06 Nov 2025 14:29:12 -0800
Subject: [PATCHSET 6/9] fuse2fs: improve operation tracing
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794829.2863722.7643052073534781800.stgit@frogsfrogsfrogs>
In-Reply-To: <20251106221440.GJ196358@frogsfrogsfrogs>
References: <20251106221440.GJ196358@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series improves the ability for developers to trace the activities
of fuse2fs by adding more debugging printfs and tracing abilities of
fuse2fs.  It also registers a com_err handler for libext2fs so we can
capture errors coming out of there, and changes filesystem error
reporting to tell us the function name instead of just fuse2fs.c.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-tracing
---
Commits in this patchset:
 * fuse2fs: hook library error message printing
 * fuse2fs: print the function name in error messages, not the file name
 * fuse2fs: improve tracing for file range operations
 * fuse2fs: record thread id in debug trace data
---
 misc/fuse2fs.c |   93 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 24 deletions(-)


