Return-Path: <linux-ext4+bounces-14641-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEPwJt1pqGnYuQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14641-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 18:20:29 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D01120511F
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C095D301DD7A
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2026 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B506C387574;
	Wed,  4 Mar 2026 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN6ssZGW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBD37F735
	for <linux-ext4@vger.kernel.org>; Wed,  4 Mar 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644825; cv=none; b=P5wCLSkht5lxeif7hkZsfb2Qxnz3odphy99EJnb8kXlAXR0F/IJnhFn/OUMNjk84wFv/C4fH0alPOB/6aLo4oY2+FaJ9vnBXLXYYjsKVd9pzfKVVij6LoeXzw0QHijLRocCIUUsaP76Wps2Sv92uCfPK/1PwIh+lHRbyfRmXSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644825; c=relaxed/simple;
	bh=peJj7Q8NiQ8Grsrx3aJXrZaptm24iMlHWXSw8zPiwoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZ72O5HEM2nMSOqQiX1rLHHplMZ8FDhIYxvYrTV58fIYgvk1byw4nCFsOZMZj3I9tYr8MOszJwTr/V5gAAWVGTLVdexRQdrZ8r04bsbv4+trWgwVOyWea40Kpca6Idx6RcnGagIDDkQuCuhI0LcZ/urXbVVoXaBgge7FERw7Pas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN6ssZGW; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2be1d9c356cso4728006eec.0
        for <linux-ext4@vger.kernel.org>; Wed, 04 Mar 2026 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772644820; x=1773249620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3EjPgnyNQ/RKAU/npHlRHCvzZZke+fnwSJ3S38yCtY=;
        b=VN6ssZGWaolGl+coyJQnIBwifv8C+ha3RlNMsvmmksUd1FZQA33XSK8rw0Ojcus+ew
         nyS/32/FxsdrOqv5ZPExIr4F6Wxltkxh+GzZ8BvOfVjSIyg7ZQu0NxADuOVBzpfcX7HD
         vfCMwsuAWpqae4OoHI1uxK4JbdD9FoNN9ChIMXtNZe6Y93EZPXKe/ql4bh9txjO5D92h
         U6EFwUAOeiy39UxPBekkCuX8KLmrqzX1wUzC5HpZQFNaZgTLLt75wBqyCSn4XEljIvQd
         PDKroo3u1hCVxmPOPFiiARwFeGu9cDKDtR8c4HRPw51Syq0RaRmZ3rvo5tI19glLIn8l
         GHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772644820; x=1773249620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3EjPgnyNQ/RKAU/npHlRHCvzZZke+fnwSJ3S38yCtY=;
        b=VaHhtsXDPn/E8RIZhkeA3hnIJaQMgMJYhMWGLnQIdE8baTx+IghC6ke4Uv2Jdtn7NI
         qmd/7zSo/VDnpdPriOs3r6KvrG4tZ+OJFwqhkYZwTfirxRe98FEGj+otP1mOvyAUAN98
         JLq2QHwuYVVXxqnx6YgYHKhInYgBOHmHBAhFMaVz1ELYvvYxK3kLELlii0zJJJ9QHckQ
         q3X46crD+3m6TzChOjzzjHF84Gne4twltJk8X767VmlroNpldk4yMMaP3EOV/DlwVwee
         20xSUsifgD49NVXriGYrfZ3kM+J+wTtW71hi6BJ73l0CAlRmVAZNukZjSAxMgMDxFhTD
         3Z+A==
X-Forwarded-Encrypted: i=1; AJvYcCXP3DQwDDscWMeAm6YQqd19sPQmmsjbNck6Ot0tl2FK2r3M1luZ+yo6NcEyUf9ByKtXQAF7zRldQ6Oj@vger.kernel.org
X-Gm-Message-State: AOJu0YzvLzRqh8VSjhKPh+rlmDRmgXDCINqu1vskLHC1cNpyLlSXwKI1
	1VDGMvbeKn31w4JwNyF2Bga3+SlEJGRyzCpBMrwt4cRaoqi7hRAJsHA3RHgy7A==
X-Gm-Gg: ATEYQzy6KzDv/Q1/CO6Epnb/HVwuS8XpBwKOyk3zDrYVot93BVv645+3saBKfT205Bn
	+tGZVg7TwMCzH+G8Vph4ijUx2Z4k+fpElgYOVZKX3JmWnDMcdQEXbuAKqSRY8keHxUnqWtNPkau
	yZlxS3Gsh7jGXyG221+FPwSdykIUJBnhwzpOGLxzSKsRqGJOGP1/JR6/Zx88Vj/qvBDJ75Yiyl2
	Kq5B/C7q6S2eUbb+UNpQxSsN2Ms6SAhiYyg+42AnVq92ZkiTtYn9O/Ub3451pUREKvlA4U0BNTx
	vEHSazLdExoldUhtzlmBBiiG3rj0VeWa5wd7QgTJv3h3BXPjr3nHmnFJOrLI3IsghJgOEO3OSY0
	RndbIUEhvD2Pn2cwJ0Bje8PLq58xLoRUwA5xp5LpL/wkWflo23gUOiyZ7pLl596lYKX5UMoC362
	DmN2O9lvYZDbcay7EW6f2Ui3WkGUc6A0UGgbqDR4CXxU3go1AmP9D+opsHqEcVA4Xio5QyxnMjN
	w+Z+Od4j8b0JUZEt9t76u44aFmY1NeolB436Trn7NfK2c+dzgjohNdIUvu2VLW1SdGaXuQOWIH4
X-Received: by 2002:a05:7300:fd0e:b0:2ba:6458:b325 with SMTP id 5a478bee46e88-2be3108f17fmr1164311eec.23.1772644819815;
        Wed, 04 Mar 2026 09:20:19 -0800 (PST)
Received: from arch.guest.box.net ([8.39.49.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be2800c89asm2904789eec.31.2026.03.04.09.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:20:19 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: [PATCH v5 0/2] jbd2: audit and convert legacy J_ASSERT usage
Date: Wed,  4 Mar 2026 09:20:14 -0800
Message-ID: <20260304172016.23525-1-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5D01120511F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14641-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello Jan and the ext4 team,

This patch series follows up on the previous discussion regarding
converting hard J_ASSERT panics into graceful journal aborts.

In v1, we addressed a specific panic on unlock. Per Jan's suggestion,
I have audited fs/jbd2/transaction.c for other low-hanging fruit
where state machine invariants are enforced by J_ASSERT inside
functions that natively support error returns.

Changes in v5:
    Patch 2: Folded a redundant if check into the WARN_ON_ONCE block in
    jbd2_journal_dirty_metadata per Andreas's suggestion.
    Carried over Reviewed-by tags from Jan, Andreas and Zhang.

Changes in v4:
    Patch 2: Fixed a build test WARNING by initializing a variable
    `journal` earlier in  jbd2_journal_dirty_metadata().

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

 fs/jbd2/transaction.c | 121 ++++++++++++++++++++++++++++++++----------
 1 file changed, 92 insertions(+), 29 deletions(-)

--
2.53.0


