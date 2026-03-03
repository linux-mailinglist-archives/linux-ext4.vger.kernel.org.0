Return-Path: <linux-ext4+bounces-14464-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tZj2JMkxpmnKMAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14464-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 01:56:41 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 049E41E76A5
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 01:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30C583025A65
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 00:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22084213E9C;
	Tue,  3 Mar 2026 00:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXAx0XLX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC107082D
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772499311; cv=none; b=IdfRhUxJyTxAIZnIXLEIzJ2ssESU3MNRdlYqWaJJStHFp+IxO8huTs53LzgkjW5Yb2TIacGyMeVHldmvcMNDuK7/i2K/q9ulRsMykWh92T5BNJbnuoNy2KOd+z4VIVHozIlxX5zROnPbOkJIwjRRLmnwSpK154D8HUDSnQX6I7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772499311; c=relaxed/simple;
	bh=yyQAKcC0oOvfnRf02kX36V2wrgSfQ2N0cVj+SEr/spI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZ2ovgbtOr3OqY3ikLwvS//hIjK01/dDFn032IKOJ+MEuH16qD4XCP1WBEewvZK3i6m23ZeCX5o6dsbKNcVqagnr/+DjXNrnh/VZGUTW3U8cSJX7eJHIZ4NleyCva95zHbDH/4jZ5oOHEg2Yh7U/Q356iL95BXmKGe/Efs9ti7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXAx0XLX; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12758ce1e8dso450478c88.0
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 16:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772499310; x=1773104110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79Eh2CloD2STqlMgzEcGUwt4qWBzZcnLWAi/q9oJcqk=;
        b=JXAx0XLXcRj2m5V/twDgihxNfcGbFUrP/QI+zqs7jhgU9gxhO8tkau4SBNgJY6dPHS
         rv89VB+2WZlDkaK3pPXpAG3S0l/Zlu07HwYdW/boSFOMDZDALReQIcTwoqVQeiPa42lP
         UkmejqW/Z4P0+Us3Go0t1Jo8Yr1AOV/o3RDvxRwJhVU9FkuIbnI0Masv3eaZHpknePzI
         KDt8s7J7IsczN8xIc2+tUiIIYzzFkqg6mKJEYWsuxGaRrF7qQBhUuapik8UN4UmdAhxk
         9GssrwSDyD+mCL56S3eRVwF1goo1dhHMOte5W1o9r8Kq9yaAMYEOgSIMQ2RoCPePjzqF
         RkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772499310; x=1773104110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79Eh2CloD2STqlMgzEcGUwt4qWBzZcnLWAi/q9oJcqk=;
        b=Vr4Q0FCNsIVfRgT6nhhk8p1RX21/m6GJ70QdpRSs9vMyb41mVM0sKH4gbf/aUG3jy9
         bQzXlXV4v5WpwdN4IgVRevP8pDxDrPpRtvdz6AiIBIrdFo2bbF3l6NU7fySaMJSmdJmJ
         c8UO/Q20Xw6xIrk6i7IplE1YaYy9iqub7iCHcR/q2BfzAmitvIfeyRMmqAWajKSIk1oF
         x9VTAGQoei6XX/g+AZRB8KweTT++RbkH54OMkjqij3x7+qNSW+ceoh5/pTCsVnvROFEc
         sWc7aikqfS+Q0ZudLy/kw2GoZxNt1KxEoFUKRsWRFEDq5mDkX9ZBj3OVpr0k/wmSXRhb
         my0w==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZLnjGBpwvj8xL4qSLQPGy2XgZhpsWcgq3SmdGiyXQoeRUWfnuvAuyoWUGSNpfCGonyAflD7Cf4sF@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYjPMFM21hnK6HucG3GfiQHAC8Lz6HoqBhpSfrYoSYHegdiXp
	3QBdaj2gapNeyFjIIncCn9xynx0v8XV481a/tfqRuMl9nJJzg2G2XafT
X-Gm-Gg: ATEYQzzTTJvp45sq9KqJ5mR6LVjpH+f3ckhkuYAK5vg6AQ7kGpUOPMjNEKA3S3G++lw
	2HeL7vnblWj0lAr8V5BX7Ji8yTff7Ti6s8Or1Uvh8HVB1+8adURXabwV3W2e/L7w+nh2tUbSgTW
	bwrY4pg7dybFLkgDSA4zKOlrBK0aGkShnT5R1JWNwS5TZHM+OtWWzYqoOaYhgEBYvNemypoGP7P
	T8IQg0Bw7uvh3B8J1AfDHL+bgD1bHjiU2l5NBzerUfLPCD9it2QxdAi+3n8QIEKDNVsW+VVlIBd
	kKbgHVnhYdpzQUtfnaadp+6JidwzKSNzjx9DXxND6XvUKHoxfVTd/Ur1Toz7KtWT3RwgO/KmRpE
	6vcPQW1cOmarO5R9qsIGbSN735LeDnE4Hozk2kLfQgXdzp7H/DqE3Qco9AwBK0QYDLaurl4pZdy
	vShjXa+JoUJ+Ty6/L5K0oPulgAUC0UChWnoGwcxKmbb0IxZ8Km1k7osKK5EaKUUjpwcDERYU9R7
	crkYFQoAOmnIiSacm/ZsF6jOX7RtsHfiyWfJiPdZyF0EWoioi+P2haG3eQDRTD47+7pXV0E0Q+O
	+p3XecQQ0bLWbq35gLOCSLeWZMJIV2Zr8MzBHSo=
X-Received: by 2002:a05:7022:b9e:b0:11e:f6ef:4988 with SMTP id a92af1059eb24-1278fd6de06mr5654353c88.36.1772499309658;
        Mon, 02 Mar 2026 16:55:09 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1279cbd1993sm6552005c88.2.2026.03.02.16.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 16:55:09 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: [PATCH v3 0/2] jbd2: audit and convert legacy J_ASSERT usage
Date: Mon,  2 Mar 2026 16:55:00 -0800
Message-ID: <20260303005502.337108-1-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 049E41E76A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14464-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

Changes in v3:

    Patch 2: Added pr_err() statements inside the ambiguous WARN_ON_ONCE()
    blocks (where multiple conditions are checked via logical OR/AND) to
    explicitly dump the b_transaction, b_next_transaction, and
    j_committing_transaction pointers. This provides necessary context for
    debugging state machine corruptions from the dmesg stack trace.

Changes in v2:

    Patch 1: Unmodified from v1. Collected Reviewed-by tags.

    Patch 2: New patch resulting from the broader audit. Systematically
    replaces J_ASSERTs with WARN_ON_ONCE and graceful -EINVAL returns
    across 6 core transaction lifecycle functions. Careful attention was
    paid to ensuring spinlocks are safely dropped before triggering
    jbd2_journal_abort(), and no memory is leaked on the error paths.

Milos Nikic (2):
  jbd2: gracefully abort instead of panicking on unlocked buffer
  jbd2: gracefully abort on transaction state corruptions

 fs/jbd2/transaction.c | 115 +++++++++++++++++++++++++++++++++---------
 1 file changed, 91 insertions(+), 24 deletions(-)

-- 
2.53.0


