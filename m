Return-Path: <linux-ext4+bounces-3383-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE7393A3DE
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 17:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB352846D0
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A56B157483;
	Tue, 23 Jul 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mRqYsb8j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6431157461
	for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2024 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749457; cv=none; b=H2Rbdp/6Y5yHJV4bXc8mQ2tiIVmJEuiUk3WpLk8cECnBTs3r/ev+sNHeafae04MOHzEnBuCYEM9UocnFdoh6P7dPlVXNNkVKO1nF4OJdxtXvqH+GnaFat/+rLmgKHtTYYl0qQpExClCWIcNfz0doHv8/CF/P216831j76mT1fys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749457; c=relaxed/simple;
	bh=DQV4xd0rpQfQHtXJmu/WkAyKkA1AwGqrlkSgbIPWt3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYdh+YK7g0j61E2n4KrBbKd4ezIueJKwrkPHyz+qW7Qy2Z0q/OeTWs+O5pQ6gh83qmwjT3vCvS5CUw9xnr7mulbgieCllDfgzrI3Ln/sKvrptwy/PQLJK7BEC6+ENEw1YUscGv/lTRGhsgjuWvuPk6M2n43xy3OoUKBZQ2NDkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mRqYsb8j; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721749453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lBf+hdVHh1tA2foRJ8dZy87IKb8tdrjOQhBj2FgXZFE=;
	b=mRqYsb8jz9PPTqLnRe6vFKS/8R8iybrrxC0pLULUr6FtCA1bVPWSo98siJy3d1EXgfa3Vd
	cOiolhMAldK0HffH8hGU6ytVP+Y+CZN+iqF51fy3/wQEjKsjJ1cgGNoKz0J0bNug1S2tfv
	daPf10+DSOzpiQsCaIs+fX4igmmoFnI=
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 0/4] ext4: fix incorrect tid assumptions
Date: Tue, 23 Jul 2024 16:43:58 +0100
Message-ID: <20240723154402.21125-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As discussed here [1], there are a few places in ext4 and jbd2 code where it
is assumed that a tid of '0' is not valid.  Which isn't true.

This small patchset tries to fix (hopefully!) all these places.  Jan Kara
had already identified the functions that needed to be fixed.  I believe
that the only other issue is the handling of sbi->s_fc_ineligible_tid.

Each patch in this series fixes a single function; the last one also fixes
the sbi->s_fc_ineligible_tid handling.

[1] https://lore.kernel.org/all/20240716095201.o7kkrhfdy2bps3rw@quack3/

Luis Henriques (SUSE) (4):
  ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()
  ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()
  ext4: fix incorrect tid assumption in
    jbd2_journal_shrink_checkpoint_list()
  ext4: fix incorrect tid assumption in ext4_fc_mark_ineligible()

 fs/ext4/fast_commit.c | 15 +++++++++++----
 fs/ext4/inode.c       | 10 ++++++----
 fs/jbd2/checkpoint.c  | 15 +++++++++++----
 3 files changed, 28 insertions(+), 12 deletions(-)


