Return-Path: <linux-ext4+bounces-12290-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 061FFCB5B59
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 12:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEEBD3026B18
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 11:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A8A30BB86;
	Thu, 11 Dec 2025 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="iPV2LAqP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47B130B53B;
	Thu, 11 Dec 2025 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453933; cv=pass; b=jOKEGbUR/ZY370NKJLwmRixdF73DFfoXbOW3skyBRqIVtZhVfa7Cch21xhg8346dvzhnXbH5S7e6ek544RxQQEIbrdle6VTP341D5pZMp3QPWJ5nlaO17zA09nLiRhpGMer034YoyNSjDUEkBWbIkgnd9IojUPv2LXwZo4MH7Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453933; c=relaxed/simple;
	bh=2z2/KBe2FEYM46e2DTFJx1/PBFBvHTuqpVzdRl2D3Sg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rHj7l2J7vRnK0cO4gEo8oiERV7dHX9sFV2rwRcEbdnqArqeb1kQ+qjcjnOgWnAbDSCBhfjQj663YV62sy80Q2ss79gRscKBSnO/FEMGWyK4qxsZWDNdC0F+Ysc8nxdLyIy36PSqV9D/kTw4w5+GLFwluQaecBvtC2ztzST73KH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=iPV2LAqP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1765453917; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kgHCiR8u/2CnpoEY1Fz0PyfSIq+VwAhbY3HRGinyVQWBE52iCS6vUT2aZQje67EphtmJmP7C8GSXHUwecjmgWBoV2dNGt8mlJiyo6ruzYTmo2ALFYnoVhB6u04mqWHteR5DyMPgcILsIoxyEqrLZjOBKfHMQPwQRwbfgfzbtPIw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765453917; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=7/id9n+MCW2Pd2a3ElegjPUV3sCfxbhj29uUVCs76pQ=; 
	b=Kp7s6mqo0CMfWXV3BXfI3mc47UgYrIA/owuY4tQNQwTEnjpbDRJ392sQUdCKyDuMcpaJRCPk8z2nBvS+cTrjVRge9YH7IPn/v1fmZaRaY3QCFZnvnZ5axQRSEJd/dWg75aM77s0z8gns+Bu+vT0dYoc586ww3dh/g5VKA+z3thE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765453917;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=7/id9n+MCW2Pd2a3ElegjPUV3sCfxbhj29uUVCs76pQ=;
	b=iPV2LAqPQf4j5ftNNFIRxie8ShaCga5UvwHdrMGQ7p9hYnrIG9nzgq60y3uwXLQ3
	89/pWy/NPEz1aGiScl+knXAOuEiLOae0tePJSgEwPyQHl7zJHhov9knOmMHfSUIR2K6
	KOCT20xQ1koKb9YpMYA/5IyhC/uXsj1GfjbsxRwg=
Received: by mx.zohomail.com with SMTPS id 1765453915375487.01665194653924;
	Thu, 11 Dec 2025 03:51:55 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC 0/5] ext4: mark more ops fast-commit ineligible
Date: Thu, 11 Dec 2025 19:51:37 +0800
Message-ID: <20251211115146.897420-1-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ext4 fast commit only logs operations with replay support. This series
marks a few more operations as fast-commit ineligible and accounts
them via fc_info so behaviour under fast commit is easier to reason
about.

Testing was done in a QEMU guest on loopback ext4 filesystems created
with -O fast_commit[/,verity] by exercising each operation and checking
/proc/fs/ext4/*/fc_info for the corresponding ineligible reason and
ineligible commit counters. Detailed steps are in each commit's message.

Li Chen (5):
  ext4: mark inode format migration fast-commit ineligible
  ext4: mark fs-verity enable fast-commit ineligible
  ext4: mark move extents fast-commit ineligible
  ext4: mark group add fast-commit ineligible
  ext4: mark group extend fast-commit ineligible

 fs/ext4/fast_commit.c       |  3 +++
 fs/ext4/fast_commit.h       |  3 +++
 fs/ext4/ioctl.c             |  3 +++
 fs/ext4/migrate.c           | 12 ++++++++++++
 fs/ext4/move_extent.c       |  1 +
 fs/ext4/verity.c            |  2 ++
 include/trace/events/ext4.h |  8 +++++++-
 7 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.51.0


