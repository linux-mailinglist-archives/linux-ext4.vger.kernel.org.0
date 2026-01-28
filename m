Return-Path: <linux-ext4+bounces-13406-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KneB7NQemnk5AEAu9opvQ
	(envelope-from <linux-ext4+bounces-13406-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:08:51 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8500DA77E4
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B58BC3049951
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 18:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2062937105C;
	Wed, 28 Jan 2026 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Nx/98xkd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7531B4257
	for <linux-ext4@vger.kernel.org>; Wed, 28 Jan 2026 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623530; cv=none; b=qmKDKanTKFFoiGOm7+5nMuFDkVKgwXwEkKG0iU/d50dDKScG8QiXm1U0Fdaz7blgrDE8aCgy3ruBMyAOVDMWinjXLe0b2M5QXRVvtR/rXaoGMS1ur7QXZahDcVvrsxEalXMOOdWMQfHP9TYgDw7bzihb2UYalbCm9bZlPQqDqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623530; c=relaxed/simple;
	bh=VIsDiK+2BRF0SW5DFNHjyyDZGZ0W93mIRWEfsjUjCB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPhefkMaY5ZN5+p8ox0Io3LGZdq6RlDNu1TC8cToKv7i3F3/FH+dJWMPiLnU2aYZJC17PcPNO+VWY76ScrhM8hhwHGOyR005ZO2zUy5Rs57j0ecuf2ZrXSaAHM2uFoKVWltgNG2svGNW5rnPd80LXLBSer2V/B8LncGGnOq8zhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Nx/98xkd; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-123-50.bstnma.fios.verizon.net [173.48.123.50])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60SI5I5t028739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 13:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1769623521; bh=lsKu2rHK4zKsJbcnpYKXJuKR+DBMCaXK6Bj8kOdzT1A=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Nx/98xkd1dRvLMRLx3jg3OEjXryzVX7NNB4oLnlPh5el/jnYXTl5TqOC1Af/ujqqy
	 p16vdzYuC1rE19eJnHqxhEec5KENDZYQkX7HA9SSuRAY/AmaX2RHIvwaHr04aJLOPZ
	 3yfm78TT2DcgHUnjmoUzEhz3JhWDnP+KppyVKmJmwwcy0wkAGJdLNP+QkvnlrAkxYP
	 sllrtRweYAxTsAXKXV/r1nr9/XKinMy2+llVQTva956LMlNc9kaE4H3Yt2QpKOVyQe
	 VhnObZd2FMsSScle1dArVlmQ9wySthQTf+TZEm4gw8deTjQah+6WX+hKrTVG13i7gH
	 dSmKYkK0xXxrA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 298402E00E4; Wed, 28 Jan 2026 13:05:16 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] ext4: Fix memory leak in ext4_ext_shift_extents()
Date: Wed, 28 Jan 2026 13:05:10 -0500
Message-ID: <176962347638.1138505.3045993165442370929.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251225084800.905701-1-zilin@seu.edu.cn>
References: <20251225084800.905701-1-zilin@seu.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-13406-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8500DA77E4
X-Rspamd-Action: no action


On Thu, 25 Dec 2025 08:48:00 +0000, Zilin Guan wrote:
> In ext4_ext_shift_extents(), if the extent is NULL in the while loop, the
> function returns immediately without releasing the path obtained via
> ext4_find_extent(), leading to a memory leak.
> 
> Fix this by jumping to the out label to ensure the path is properly
> released.
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix memory leak in ext4_ext_shift_extents()
      commit: ca81109d4a8f192dc1cbad4a1ee25246363c2833

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

