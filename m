Return-Path: <linux-ext4+bounces-13411-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH+sNDFRemnk5AEAu9opvQ
	(envelope-from <linux-ext4+bounces-13411-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:10:57 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B0A789D
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990FA30BDDD6
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 18:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C98372B30;
	Wed, 28 Jan 2026 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="l4Y2sqLn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D33037105C
	for <linux-ext4@vger.kernel.org>; Wed, 28 Jan 2026 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623537; cv=none; b=PT98ymKSJcHiy4pRFy2phgJ/mFZEBe+rlW3dMFHhCRG5lhHkSWoRa4lq978HMplimPy3B83Qno0eFalL6irIMVPs+PBU2aDnkpaIVgJnkd0L50tuVJzLnLN/jNA6Ey2zcZZQ7xpLZ6kgYnBgF9WumdoKaBQECawpU8Uyjfl6hwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623537; c=relaxed/simple;
	bh=Z5Y0ypxvByBYwjX882uJ7Vj1LBD1G57O7acbyz/bNg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/CstWaRQwoCPHtS03gJXy1xZmv0I3sRNeqyehnYSz4Vw9uWmwmYqovlDxOCEpPFK5ue8pzIeb+unhLoI9RgOSnzNevT32L69IQQM86CFrVh6Au1en9pLQTbyyUOApDGgeU19d2a69SkxOFi/F6C18Ix0Y75tHifJYm5+t1zNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=l4Y2sqLn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-123-50.bstnma.fios.verizon.net [173.48.123.50])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60SI5INC028707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 13:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1769623520; bh=HUdpk//KLYaWaJDXR2jsgdTu6WM7NU4I0jkVARXteCU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=l4Y2sqLnyzXR/XvAoq2mHPf2OB/BmVMC9zbxiRw37VFkQOn8KWNSfRi4p6LSf/pOy
	 T2KJmlwKvI9wGd8459ss3gaqG2kk04Xr9BstsmY1ECfbCnucWKdReWHgf9djZ8/dh3
	 2i7T6g3UwD0MV+hxKz8/CRfjm6cCa7MKuzW6oP3d1MgSyFYde4rPUfhjQLgJIe68en
	 d+unHmp9yRT1K7JzEDbB2/RUPCWZWs3th2DOmThQtXBPk2XNiuUY5mhdq6Kf25mAZB
	 oUph5YIsADi86gXPYebNLlnBtV18sog7dUT1A2gb+9eIPnMXIVJO4n2WWbrIFqBAnE
	 yxlvn8ZCHy22g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 1AE772E00DF; Wed, 28 Jan 2026 13:05:16 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Li Chen <me@linux.beauty>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC 0/5] ext4: mark more ops fast-commit ineligible
Date: Wed, 28 Jan 2026 13:05:05 -0500
Message-ID: <176962347636.1138505.14797940787687720541.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251211115146.897420-1-me@linux.beauty>
References: <20251211115146.897420-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13411-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+]
X-Rspamd-Queue-Id: 466B0A789D
X-Rspamd-Action: no action


On Thu, 11 Dec 2025 19:51:37 +0800, Li Chen wrote:
> ext4 fast commit only logs operations with replay support. This series
> marks a few more operations as fast-commit ineligible and accounts
> them via fc_info so behaviour under fast commit is easier to reason
> about.
> 
> Testing was done in a QEMU guest on loopback ext4 filesystems created
> with -O fast_commit[/,verity] by exercising each operation and checking
> /proc/fs/ext4/*/fc_info for the corresponding ineligible reason and
> ineligible commit counters. Detailed steps are in each commit's message.
> 
> [...]

Applied, thanks!

[1/5] ext4: mark inode format migration fast-commit ineligible
      commit: 87e79fa122bc9a6576f1690ee264fcbd77d3ab58
[2/5] ext4: mark fs-verity enable fast-commit ineligible
      commit: 16d43b9748c655b36a675cc55789f40fd827e9b1
[3/5] ext4: mark move extents fast-commit ineligible
      commit: 690558921d9f9388c6bc83610451d8cb393e4d88
[4/5] ext4: mark group add fast-commit ineligible
      commit: 89b4336fd5ec78f51f9d3a1d100f3ffa3228e604
[5/5] ext4: mark group extend fast-commit ineligible
      commit: 1f8dd813a1c771b13c303f73d876164bc9b327cc

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

