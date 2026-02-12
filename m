Return-Path: <linux-ext4+bounces-13689-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBPXHzUnjmlrAAEAu9opvQ
	(envelope-from <linux-ext4+bounces-13689-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 20:17:09 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0D1309FE
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 20:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E3A23196464
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 19:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F116F29993E;
	Thu, 12 Feb 2026 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XypA3RQN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BFD2877ED;
	Thu, 12 Feb 2026 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923649; cv=none; b=MjlwzCsHRIO3aLJIRrU3tXFOVdMqLL5HI2b8Efj9nvw4S5tMnFflKd3IDQX9gvB5MReXNtPpOgvHWVMx3bDxfhVD/eEAXXXMuDk5b64bVDbbejK4+m8lCim9maElVhbB+Y6GGl44W+yXcaChnTilUHzV8nPGjXTYZpetTuW0cCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923649; c=relaxed/simple;
	bh=xWtTiz/Q6LwXubja6COkpYAOyHGIf3uqaIMLIt6zJT0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JeW1DABNmVxBvhp8z2zTAkwtiT29Cs/Md/11ktGrmNaA8P/9pQMNis6oIdbIK9+HmaTE94iNQ1BGI83xaBv7FSF5QFcla1q72SuqCX4u2nhjOy7GRkvO0dnBpTNa4K2H5WxGjpOEomLAJHEPnH8OGswWgIL7MZ11l9GFcrzbCwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XypA3RQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803D0C4CEF7;
	Thu, 12 Feb 2026 19:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770923649;
	bh=xWtTiz/Q6LwXubja6COkpYAOyHGIf3uqaIMLIt6zJT0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XypA3RQNRCgBBsf7roTfGW1JYK776oXmNhM9d5qbGXlyuGhxQLQhWViL3fS3y6tId
	 1ui3IycnCZysqv0NRn9V3DN7qVJSuPMmiZhQCMP7Lne6hppfIZ+ONzAz+5rGCmXHhS
	 083yHs3mOvHBpiyHEmyL/UWOzm20nBmWMi/MRvWG5A7O5tl1/iNWMK6FSPckxH2CLy
	 mQ0rTzS4olmsEg3nQva2hezVNfmsDdhfyVE7p40xuLQObEmU8UzQqVtUDysq4VsGUw
	 +rt9OSOWJnnUfFy4HQljilSqx5XJGjznI1w9KKSM+0Wac47bwXKVuJBdefUtqYnqJv
	 LijP8CZ/KF4Qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AFDA3800346;
	Thu, 12 Feb 2026 19:14:05 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 changes for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260212154721.GA2430983@mit.edu>
References: <20260212154721.GA2430983@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260212154721.GA2430983@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-7.0-rc1
X-PR-Tracked-Commit-Id: 4f5e8e6f012349a107531b02eed5b5ace6181449
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5903c871e21498405d11c5699d06becd12acda24
Message-Id: <177092364355.1663336.1607525923540407209.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 19:14:03 +0000
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13689-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4B0D1309FE
X-Rspamd-Action: no action

The pull request you sent on Thu, 12 Feb 2026 10:47:21 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5903c871e21498405d11c5699d06becd12acda24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

