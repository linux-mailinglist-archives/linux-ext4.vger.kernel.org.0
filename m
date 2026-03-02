Return-Path: <linux-ext4+bounces-14450-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I58CfIMpmmFJgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14450-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 23:19:30 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D84781E52EB
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 23:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61FC532C39E4
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18F73822AF;
	Mon,  2 Mar 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3YwiYDr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152483750C6
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487273; cv=none; b=SHzMudBua4xxSXftkPjHwaxDfz5eqNbzU9dl8ZWDZrlI9fCSz9TR7WIkvurN/ShO7QLBKE5dtYBccmv/DNChq4CzML0fdcwI6Q9nl2YizzZVniwY0yIomzvfY7MhsKXArFrap2Y4wToi2WbEE8kbubs9Cg5H/xt7YPnUFpuBNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487273; c=relaxed/simple;
	bh=hk8UlceQuI431FXTiDWDxQwChWemgHl2+YsaXmHNKi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5++p9wi6e+FgWwajM3usJz3J77BR8yjF8DyTI+XzFeFyaI5v4on+HSGdxrNnMsot+hZf1LHNSymvnADdPRB4vKsjqWm7yh1153GjJQTUIo8ve9gIDD3fTQtYqXI2MsXKE2KF6hdY+gcBGM9EnanmvphZTMyhKqNVQEhpZzm2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3YwiYDr; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-124a635476fso5773814c88.0
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 13:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772487270; x=1773092070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn2nyljm/kUJU9VPlVJ2WiW+iHhd0FLGscyl10Z2G1g=;
        b=S3YwiYDrDqeON9kC+IUSj4i0zgwc6jlbBlwTXkCs4fQ4DrFz0qygfzlx6ehkfJEyEc
         39URXACUeh5lZVw1ag7wnY8s9kplLi0kGnsa13DUimKi+p0nAfFlMmfk1HgwTzoMVoRl
         +qiq40uEYH0RIoB98AKeFdeVEyNMr2sOY6VeOYLIbcvodjblkheRI9JnTaAWXYOBS2k4
         1tAdZ3iFvlyry4JBWsB/fFDgrI71V6cT3HulGh47BGD3ITYwwzIiSABAZtPULFVSSe9D
         L7scw0xNL13taOpSXhMLnT+6myWpHMmivrfrcOf4DwQz5Bkca0M6VCPHwsa3SOA/1eqL
         ba1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487270; x=1773092070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qn2nyljm/kUJU9VPlVJ2WiW+iHhd0FLGscyl10Z2G1g=;
        b=X+zYv8sQeJ8v7WHXt8/xeVcRekfZhrxhU1SKbL09jkIxZq/iRBylbXpgLacNt2j1Yo
         hzF6juYKEOTdTM2dwaaq7yOSrdOcCq82nsDd0MQr2Gv1HJvApE3RqUtoghEVGgnVD5vQ
         NV4GmHzkJKk9jGf+R3iFk+avSY/faMZ/1ETHrcuKU/N53xKslwU8qBfJATqs++t/FLXv
         CS6pLpTyV7nVqLmXw5o0X29W3MzM55WUxF6HndGMooEem3i4cUkhD+68hrceJIAb2tjn
         ZIzlJpgBc+d5XTeJf4inrjTA5/k7MBSX8qCV7ocuJn9Klf0lhF5gBbQmLrrlaum8XCkL
         S1qg==
X-Forwarded-Encrypted: i=1; AJvYcCX5igJzwWdxLU39LERkVovy0NpXzUvvBw5LrneV90bn5rEQs0LmRbsR0xRz2oWN8VXJJ4rzfqcyBmAA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyln5tNO+p5JPwNBcuO3JegvnfPGZrHkWA4IbQL0t3OHUzGBxyr
	qH0DyiibQ2bmtbwjxPGcXL8lG0yRVAOH6R6GwkT5xNXjLn7EtZaq3bXD
X-Gm-Gg: ATEYQzzfmDv3IJzoG53YPIviFbRCO0Q+7gG/uu642ISujW6KVupB52odkH7YZkZM/+p
	+Wivgh+M8rDRZhoTmGaxsvTnz5huLagNMddzKX8RVxdmAt19ECbf/RxEJ8izgwRjN6A8QzhuDRB
	JLzjDL/IRqEgHj4U5ZUhg6mi2f2zESm3bxChQCjzJvVy30CFc1bwD4RxYQzhLXbFsKyFoMIlshI
	lc6bO7n6y6x4GQ2+Cu9erosSm0ojR8aSXrXJC5aAHAcjbbfS76MPe5+d7sifxZXNFgamoo+x7cT
	VUKZ6ms7lKb8j7/bnS8SkAO7hCp1B4V5NCnQxAG6mf7veXGGs2h8Vr8kLOoVfM43W6FcnyodDtc
	FpMh/jKXl7xo6cEupLZv/6h9VHZfT2zdcRnRmnl8A132DRwk5mrG2kRiL55btKKGphy43JHWa2K
	i1M+xJi0zHdn6mMuMsZmGuIwBgL/FNL15lf2dTDN5+N9AQA3b+x0+bPNT4dbT2VjXO6bAGyadRW
	7am1PfGdMJJhpqjoXaMlNyNrOtOGXVq0S2+eVfgPgcv3uTqbxZxnLugWp3Kq+V0KagzHdqCtj/r
	HK/gsnjpoL3zVim66x+sJIG9PKd3QA+CivnEfbw=
X-Received: by 2002:a05:7022:6292:b0:119:e55a:9beb with SMTP id a92af1059eb24-1278fb7e1e5mr5012376c88.7.1772487269993;
        Mon, 02 Mar 2026 13:34:29 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a52ab0sm20032605c88.15.2026.03.02.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:34:29 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: [PATCH v2 0/2] jbd2: audit and convert J_ASSERT usage in
Date: Mon,  2 Mar 2026 13:34:23 -0800
Message-ID: <20260302213425.273187-1-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D84781E52EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14450-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello Jan and the ext4 team,

This patch series follows up on the previous discussion regarding
converting hard J_ASSERT panics into graceful journal aborts.

In v1, we addressed a specific panic on unlock. Per Jan's suggestion,
I have audited fs/jbd2/transaction.c for other low-hanging fruit
where state machine invariants are enforced by J_ASSERT inside
functions that natively support error returns.

Changes in v2:

    Patch 1: The original fix, unmodified. Collected the Reviewed-by
    tags from the v1 thread.

    Patch 2: New patch resulting from the broader audit. It systematically
    replaces J_ASSERTs with WARN_ON_ONCE and graceful -EINVAL returns
    across 6 core transaction lifecycle functions.

For Patch 2, careful attention was paid to ensuring spinlocks are safely
dropped before triggering jbd2_journal_abort(), reference counts
remain balanced, and no memory is leaked on the error paths.

Call-chain tracing confirms that upstream VFS callers (including ext4,
ocfs2, and others) already cleanly intercept these error codes to
abort the filesystem handle rather than crashing the server.

Milos Nikic (2):
  jbd2: gracefully abort instead of panicking on unlocked buffer
  jbd2: gracefully abort on transaction state corruptions

 fs/jbd2/transaction.c | 102 +++++++++++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 22 deletions(-)

-- 
2.53.0


