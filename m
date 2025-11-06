Return-Path: <linux-ext4+bounces-11551-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64351C3D98C
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55CDB4E7E9E
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E84334C33;
	Thu,  6 Nov 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moB3Xbhk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30003328F9
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468137; cv=none; b=boJvvcU6w9802MvWumP54tMBPNZBPj+pK9mztgqN6qwudXLXHxJqwLuCJN5nX8Oc44JvK2AE+e0t/EzJzK5XkY6jURG9V0UWNtKb47jeB/BIAiQoVC5//WZ1Y8jghGeprGIWeJYeXsOvnL4yjqAiDv+6oOkAq3a+CitQ6lTljkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468137; c=relaxed/simple;
	bh=1VSTJItfyxVH+MQqXue7Y2y8zIjl/EGT6/0+6nvKbfU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UD8IiDCKtIO4muLGqWmow/w0Ffxt6/v/hK46W5yOYoDuH1voa5SbAy8YYztEsB9U3uTzF6ih8yZ5J6bBALiW3y7u+4arJxe/MBGwHLEuoO1l+x5zjG4BAJPu7akqmQSPqt18Q9NZOOC7BpmQ3w9923DAPgUpqTOwRrpxNRCKX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moB3Xbhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9F6C113D0;
	Thu,  6 Nov 2025 22:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468137;
	bh=1VSTJItfyxVH+MQqXue7Y2y8zIjl/EGT6/0+6nvKbfU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=moB3Xbhkiwk/0YAbnoFMV3G/3TFM1tEv8MC93BIvi9NkNTTELOIqWcvgJfvcJ//Ur
	 GkFrZUyC2ub9a9cDdoIij7k8WMSSDt3r3Mf6xx7IfFjdnQ3fzTGqYyEHAbSXBwAVSR
	 kwFNh0dUX9/CPOXShKaG7zUMWHkPS2PoqFHBEDU5fLY/pNVLwUpPMC+pot9ogQHKxn
	 aT+nEqMC8rxwn7if4Wi4PGvgcwcOrlEngFe78tRCXJt8AvCsxIF7poKLWB2bQHzpYF
	 rYjtSNb21bQ67n1PJdDfc8Job7DW+9+0weRs9pv+VvF/4ATgucxEVv9rmi5Xy0cHA6
	 /Mlj+NUv/OS+w==
Date: Thu, 06 Nov 2025 14:28:56 -0800
Subject: [PATCHSET 5/9] fuse2fs: refactor mount code
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794639.2863550.14252706802579101303.stgit@frogsfrogsfrogs>
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

Here, we hoist the mounting code out of main() into a pile of separate
helper functions to reduce the complexity of understanding the mount
code.  This isn't strictly required for iomap, but it makes main() a lot
easier to understand.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-refactor-mounting
---
Commits in this patchset:
 * fuse2fs: split filesystem mounting into helper functions
 * fuse2fs: register as an IO flusher thread
 * fuse2fs: adjust OOM killer score if possible
---
 configure       |   37 +++
 configure.ac    |   19 ++
 lib/config.h.in |    3 
 misc/fuse2fs.c  |  634 +++++++++++++++++++++++++++++++------------------------
 4 files changed, 413 insertions(+), 280 deletions(-)


