Return-Path: <linux-ext4+bounces-11554-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B4C3D99E
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20E23A8BF3
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D41C32B9BA;
	Thu,  6 Nov 2025 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rnjxem4X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF9303C93
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468185; cv=none; b=Pl/DFdNPMMxvg1/4J49LjL7zqt6dfJZCexgmBTX6GAaOcfEiT81aowSd0C+muZgVMEPRNh3M62lnm7EA3FgJ+8QXz536gFEKdVT1mfao5U8uXTVkQk8j6btL4ohlmBf0fXr+X8LAOt4fYBoq/n6hugviJRKbaN+fE7cBnkTKe5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468185; c=relaxed/simple;
	bh=z848DgVqTvByaGqU7UHkSN0dakaHOCmWk9X5CkB7Y0g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNbWC23WobyNhWKUVtFmXKjQCODTULYq8rpAhjP4Mp+ratNSrqGUUrQ+iHAM8RUbVAV+wOcOtt9xvwXI+q00KHupjWK36OInpu2sLBDrvSX0hw6fuXhEdA+tz7DRtAUYumWd/+l6WDPZc3Rnt4tzbovR0EhIrEa+db2EIY4SMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rnjxem4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7F0C19422;
	Thu,  6 Nov 2025 22:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468185;
	bh=z848DgVqTvByaGqU7UHkSN0dakaHOCmWk9X5CkB7Y0g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Rnjxem4XLFMYnTbwRgW60ZD2ClnpV6TDXEdGusXgVJdD+IV/HEOCaDPPIWFosrZir
	 Hgm04k4zY2WSB+dp0M+f7thTJbRjN4/axLluifG0hfwbqnAYboEa16AwexW0Y82ZcO
	 3tyVnhiMEmFpxZMOgacooecKYcpIdk91rGqI/929KqF84kU+7BrOzIJ/pZ/eqCqvyW
	 UV82NE0mWv2o3bUVx6O9UTz+FM7l811k9XYMhs5rp94RqzUWLBQpvd38ioUu3uJ4bL
	 bFWGyBo44x6tZynbj+HLD/JZW0GfUzCH1a4oUQNd3RkvAiFwAfvrbmF/MTaCT2gRZI
	 fukPB9f9Fr2HQ==
Date: Thu, 06 Nov 2025 14:29:44 -0800
Subject: [PATCHSET 8/9] fuse2fs: upgrade to libfuse 3.17
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: amir73il@gmail.com, linux-ext4@vger.kernel.org
Message-ID: <176246795228.2864102.6424613500490349959.stgit@frogsfrogsfrogs>
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

In preparation to start hacking on fuse2fs and iomap, upgrade fuse2fs
library support to 3.17, which is the latest upstream release as of this
writing.  Drop support for libfuse2, which is now very obsolete.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-library-upgrade
---
Commits in this patchset:
 * fuse2fs: bump library version
 * fuse2fs: wrap the fuse_set_feature_flag helper for older libfuse
 * fuse2fs: disable nfs exports
 * fuse2fs: drop fuse 2.x support code
---
 configure      |  318 +++++---------------------------------------------------
 configure.ac   |   85 +++++----------
 misc/fuse2fs.c |  252 ++++++++++----------------------------------
 3 files changed, 115 insertions(+), 540 deletions(-)


