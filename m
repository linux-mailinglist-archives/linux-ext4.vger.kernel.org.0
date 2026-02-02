Return-Path: <linux-ext4+bounces-13469-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG3CONL2gGmxDQMAu9opvQ
	(envelope-from <linux-ext4+bounces-13469-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 20:11:14 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41370D0661
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 20:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10D6A302801B
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Feb 2026 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558592EA731;
	Mon,  2 Feb 2026 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T40s4yQF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04052D060D;
	Mon,  2 Feb 2026 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059468; cv=none; b=pgQV4+GjG4pbVegqt/EQ1R6vurylsiH+TJz6+5uQX5MFl/baBGGG17tq7z+aBcn4nz046QeqZnOZFqJHOqyQzeTL4943kgGUGn/OcsaOwacXfdXUYCrRtJImqZkLRX+v6vTv4YgkLguxahXk0dmgTfkzS19cWLOaHukF4Sc9SK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059468; c=relaxed/simple;
	bh=DtfmcfHLZXouW2zGkC13NeSXG9RbkpZDUiAq3cEm7Y8=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=uVODXrEeTCRxodkSr6g8nBvtTh0eg698wo1j5sXBddvjAJaqb+oI2IlKQR8HbCxIf85AsQIwWjxB9XDws0QdYkqShAodSEA8TM/FnA8zxNQ6xQEvDaHzuE2mBzVm5cItAqt+8oYq/vdtSrBeLJNX1hTmJkO+bTxPAxZQnUm7IiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T40s4yQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7C3C116C6;
	Mon,  2 Feb 2026 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770059467;
	bh=DtfmcfHLZXouW2zGkC13NeSXG9RbkpZDUiAq3cEm7Y8=;
	h=Date:Subject:From:To:Cc:From;
	b=T40s4yQFsK7O10rJCWk7BzZmIUVV3sUm6XO2GE5JQX1PqTjROZd02DiquclfMzGtH
	 jwYVRpdb1jNIEBpu0q83RUqe0qWOxQRsUMpGx5oxByuSl45oWqG3v8pJ38t+f3kBKD
	 LhBdnMGP18+jtaiipmxWKKdA72QIlnMH+Bvh6kYCOFaRZaGmb09jGKQanEFB/21rek
	 UluGoLcufF+MuOEc8U3fV1ZVFENoDin0MPTR3s/nIDulQpU8Q7aI6RscbEQf8MI9H0
	 f6WxTOM8Kzs1YdaNf8dFcEw27KSgVdB0JaOUOtuQEoImNuDfvcC275QAEQg9EyOSB7
	 8d1hh4uaHUqQg==
Date: Mon, 02 Feb 2026 11:11:06 -0800
Subject: [PATCHSET] fstests: more random fixes for v2026.01.27
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 fstests@vger.kernel.org
Message-ID: <177005945267.2432878.7105483366958924034.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13469-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41370D0661
X-Rspamd-Action: no action

Hi all,

Here's the usual odd fixes for fstests.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=random-fixes

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=random-fixes

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=random-fixes
---
Commits in this patchset:
 * xfs/018: remove inline xattr recovery tests
 * xfs/620: force xattr leaf format for this test
 * generic/749: don't write a ton of _mread output to seqres.full
---
 tests/generic/749 |   11 ++++++++---
 tests/xfs/018     |   24 ------------------------
 tests/xfs/018.out |   45 ---------------------------------------------
 tests/xfs/620     |    7 +++++--
 4 files changed, 13 insertions(+), 74 deletions(-)


