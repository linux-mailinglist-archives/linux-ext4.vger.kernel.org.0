Return-Path: <linux-ext4+bounces-10080-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4390BB588AA
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 01:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3949B7A3572
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 23:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAFD5C96;
	Mon, 15 Sep 2025 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0MnCssE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C82DAFD2
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980748; cv=none; b=Ay55ZLbsA+nxiohcBKlWSTKfvqselisZ23wRLMjAFtdplMqYO06Ca64DEjQZrcVVIGSo5nFkdkkl27oIGZP0wgByV6qNA0+Q59rouMm6MIH+QBU/qCrLFksL28ktDtYNDGM6sEJSAbO5H5g0uNHz3lq1f3CWC4k90ouRcb7pFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980748; c=relaxed/simple;
	bh=5vNQ7XBvexDA54gC11wIBrHxP2qB9iLxjABG4cAhb6M=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=gtGw1ZwgozfQqEDMKxfsfzVzjBpWYsEnXpbtFhsEj6gcia+P7V0cDe2jAWgtvaVeUpo29A351RnxOiadbkum1XgGkqJkLsVaHSHE5KFs3Ycd8ora5g0iwSRSnaoZm1v4DyJEGXdKSNyMo8Mr0SEfxnbsUqlBA+UQkev35AX6zig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0MnCssE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2088C4CEF1;
	Mon, 15 Sep 2025 23:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980747;
	bh=5vNQ7XBvexDA54gC11wIBrHxP2qB9iLxjABG4cAhb6M=;
	h=Date:Subject:From:To:Cc:From;
	b=j0MnCssED0Jsmsvep7lOPjhtIF5IvraDex2VDYQbCVP2SOHTNmNLSLKhuSWKpp4Y2
	 m7ZPlG5VBPNjobh9ri6mdwirEzfovJi+TuvBHqLeZCRbAqGLcSCxQ3ZiV3Gj9t9a6K
	 mrIwtTvqWhVLXxwq1241+pGhKhjZIkmQmTH6d+RHqzTpw2fWtwTXqbh3/MorC+ZhqZ
	 B7asGu0d9Ba71D54sUHUyg1NhbvE2ABepjL55csTzgLgdw06nAd3tiHcn4kCl54BrC
	 b44B4P9jO1GP72Ow7kYV6zq1iqCykDgDU87e89Qas/47trcNB3/1q3iwIu+xVV46iu
	 +E70kzBj1OesA==
Date: Mon, 15 Sep 2025 16:59:07 -0700
Subject: [PATCHSET 5/6] fuse2fs: improve operation tracing
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064915.350149.2906646381396770725.stgit@frogsfrogsfrogs>
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
 * fuse2fs: register as an IO flusher thread
 * fuse2fs: hook library error message printing
 * fuse2fs: print the function name in error messages, not the file name
 * fuse2fs: improve tracing for file range operations
 * fuse2fs: record thread id in debug trace data
---
 configure       |   37 ++++++++++++++++++
 configure.ac    |   19 +++++++++
 lib/config.h.in |    3 +
 misc/fuse2fs.c  |  111 +++++++++++++++++++++++++++++++++++++++++++------------
 4 files changed, 146 insertions(+), 24 deletions(-)


