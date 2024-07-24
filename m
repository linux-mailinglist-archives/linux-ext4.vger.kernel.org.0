Return-Path: <linux-ext4+bounces-3421-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BFD93B498
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 18:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CD61C20F48
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FE315E5B7;
	Wed, 24 Jul 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VhOxnjrh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE415B10B
	for <linux-ext4@vger.kernel.org>; Wed, 24 Jul 2024 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837493; cv=none; b=GV18H7ipIdTnYVfhAdyB32oaRQts+59zvaQxw8uJrVEqg0R4Fs87GGviUIqmxkTAusQDlUuFnvZr6/Rx9fXMpXeeqwm/qPZfEMa3Uc8PFsul0iaAfnYUYnxvDNtmL80Av2YAFIPBeZWCH/3tno3mJlWm/rBbox+U9K3ht0HZs4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837493; c=relaxed/simple;
	bh=RHWwB4IHGV04hTuEiAFg01WkRz5yU8JfHY+cHSHL0rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxeIJ3qOg1IZJ6ktbCDmvyTJG2EVETpzOnSzWdiCNo+r9AM7gjHrfvpNIR2BHuQIyns0lEdMUq/TLqj+g3OuqILQNpp0vWOHa+hD0wLv/cwbQmSsiQNtomyAqwsKspprcz7pD/jFkVflNwYLPHfNIZKSrDt+i7viHjfEN8SSbG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VhOxnjrh; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721837488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O/k6dbgmrfT9pZ0z9AcYiu7qwgs0jPmgRU+xwZdWGkk=;
	b=VhOxnjrh668EaCiK9WaW5aOgN0m9mchhVe3rXMVz3nW2NhaYeUn1/TthbKbemRbRzC836j
	9SiqA1c200WG+cg00E4x2jR+7L2rEaDqizm3svQmUDTnws1Xr6BaK4LhwxOp6fnSxiXod1
	0lV9YxBGcNg5wtl37pmRMVLVN9WHf0c=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 0/4] ext4: fix incorrect tid assumptions
Date: Wed, 24 Jul 2024 17:11:14 +0100
Message-ID: <20240724161119.13448-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi

As discussed here [1], there are a few places in ext4 and jbd2 code where it
is assumed that a tid of '0' is not valid.  Which isn't true.

This small patchset tries to fix (hopefully!) all these places.  Jan Kara
had already identified the functions that needed to be fixed.  I believe
that the only other issue is the handling of sbi->s_fc_ineligible_tid.

Each patch in this series fixes a single function; the last one also fixes
the sbi->s_fc_ineligible_tid handling.

Changes since v1:
- [PATCH 1/4] set 'has_transaction' variable on each loop iteration
- [PATCH 3/4] dropped local variable 'is_last'; renamed 'is_first' to
  'first_set' (including corresponding semantic adjustment)
- [PATCH 4/4] removed extra braces in statement

[1] https://lore.kernel.org/all/20240716095201.o7kkrhfdy2bps3rw@quack3/

*** BLURB HERE ***

Luis Henriques (SUSE) (4):
  ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()
  ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()
  ext4: fix incorrect tid assumption in
    jbd2_journal_shrink_checkpoint_list()
  ext4: fix incorrect tid assumption in ext4_fc_mark_ineligible()

 fs/ext4/fast_commit.c | 15 +++++++++++----
 fs/ext4/inode.c       | 11 +++++++----
 fs/jbd2/checkpoint.c  | 14 ++++++++++----
 3 files changed, 28 insertions(+), 12 deletions(-)


