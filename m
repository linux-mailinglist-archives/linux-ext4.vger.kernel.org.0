Return-Path: <linux-ext4+bounces-13611-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JouL2KHhmk+OgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13611-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 01:29:22 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C34F1044BD
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 01:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D43053032CED
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Feb 2026 00:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4501F37D4;
	Sat,  7 Feb 2026 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Frf2wJZ8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42511EFFB7
	for <linux-ext4@vger.kernel.org>; Sat,  7 Feb 2026 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424154; cv=none; b=QszvTggBVJcC1VGDX+3vUhOh3eUn378DyMgcRiTDWcFS/uyRaN4mf0tLHE7Vi9dhdZtyeS7HdF7LCqPvqfgNtqUkViil2j8boO31idphYrEDfxVwA5MnH8FDzF59jG6eBtf+Vx57fAzMmHlIJVBdSHJmrNV/heBAF7nZu41tsJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424154; c=relaxed/simple;
	bh=skr0q9cIrptO3jYTtxwpSYcxo6Nd26oG12M2ZdETpTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8suU2ykE+j1Gp+6suIFUvS1WuPrIDOylV3pXIBQTAdNvw8+Dj1arKN73kOgb1s2Hyfc9bRkdOdasFxWT0VW7WmmSBd2CuyDp6FITK1g6MhqGC+74aBuwO3Rqicx8jVsyiNpAi0SptgKozluQl4DNyjVj7UX4EMSXchKVof3+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Frf2wJZ8; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1233b953bebso6439786c88.1
        for <linux-ext4@vger.kernel.org>; Fri, 06 Feb 2026 16:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770424154; x=1771028954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2dEAdmHXMzF+9uLgOKx9EjDdHVoeBphA9a+kf1vMM8=;
        b=Frf2wJZ8gIYZMIJSfzf4B+bjh69BiuZVihKcgAhE/5BZQbXxNAeZlspcZ1qSUV31qz
         Rw4Zivt+xzicWntN4uoBbjZgPcuDbOWGGAjITiHzbklwZPgEvRHqjo8l47FPvgQ+Lj7S
         R6/HbcHGPia2IbGvo5gXrJDW6YozWciHVvyQR0RIkvhASXUgrFbhUZIk6wZkGUJcN0qa
         N8dwcoYfZ5NsAtZbiFfhV7IW128tRNE3BjslQB6VQ3qvCPCk2Txk0rwPwpEah0GNDG3i
         20ST1OAmQnS217xz/EsGR45jpoPbwRTgmn8afSRRzQkCzlGU5mW3kjxRG2ktv0ojHpYx
         Z06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770424154; x=1771028954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2dEAdmHXMzF+9uLgOKx9EjDdHVoeBphA9a+kf1vMM8=;
        b=PTlO+YvMpUc/ql9glAPa1IViWWPXia177Udn+VK/OPL41loL4bSyDAx6pCpyk9hBW+
         stvPkwOFUzl8F2Dg34pZhqtUu6ixP9PaaWmiOk1I5a8F90FiOC1G1ZpUDHVBN27p3RF0
         k67muuxzKvZV8ENgcOTWpqbwEgEXQcz7iJiq+PmP9BW/Cp3MrgZQlcfQdF1kFwmURfRd
         +aS8DRDkwWIiFy/FvwYdhvkv/x5DirHQ50OzI1qlNFVzUM7Nc0onxotGp3LFmEfWwYIr
         6gZbjyS8Sc5rFZKrKzp0L9LHrgfKeXkP8/oh6Xos6QBvqoZ74Vz0gmT3DF3fDiZadLQG
         nBgw==
X-Gm-Message-State: AOJu0Yx4hHCBglHG4L4ETcisE7sTKqzYwUJp9vC2il2dZ3m/StQ8E7Ca
	hCtje/2pPBR2Xfk7/NvIB7Hd0KWOxnjtd6FC577r4lqa6dhbIq5JhapX
X-Gm-Gg: AZuq6aI2jvB6iwofq9dAvz1heAU0tN/ZDBZrByiwxTSCt8dk7cwZUfZ50Gvw4aWlNoe
	oxwvwsXHAW5ZyMAJJqm20bP5CxuXu4jQF8LXoLaYkDpBYAXX/6LMJ7l4UEvXBYxyOqtG0ZX2okd
	njAtBvp2/xzRm+ixN+ixgFSfnww7O9mGPj9VfKKsrfnd1IXIhMrr9vc5+nVMDpj3iqqSno8SXK6
	+uQ2TNoiLCRrJ4lsvu5xcq3orN6HrJoBlVVo70mKP8HVHClCM6qJLC0ossDzdezm+Q4HiReqC7Z
	5/Ahgo6D4eK2fn4v3sxgQ8i+RNXWTi6bSTbem4YTkN34Iz93Go13sI/pErHZryARLtv1ePxtyFs
	kEyTf+lEk6zb09u/ayhjbvmTakHC0UAztvPUjFg9m6v7UwTUeqavOLTfp6qybXVBy/h6eIJsLD+
	qcwIdBFaBpAzapVv+N0/F7BMvpPBzGb5vDwtwd9UQP7HkcpwZCySfkoLjKDDcN/Dj5cRE+YCFvz
	bpV4YjphX4QjIwz9JLdVUN0zcUfckxcZWw7
X-Received: by 2002:a05:7022:912:b0:119:e56b:c75b with SMTP id a92af1059eb24-1270405a241mr2482435c88.32.1770424153695;
        Fri, 06 Feb 2026 16:29:13 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270433ae42sm2742784c88.10.2026.02.06.16.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 16:29:13 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: [PATCH] ext2: remove stale TODO about kmap
Date: Fri,  6 Feb 2026 16:29:08 -0800
Message-ID: <20260207002908.176933-1-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13611-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1C34F1044BD
X-Rspamd-Action: no action

The TODO comment in the file header asking to get rid of kmap() is
outdated. The code has already been converted to use the folio API
(specifically kmap_local_folio).

Remove the stale comment to reflect the current state of the code.

Signed-off-by: Milos Nikic <nikic.milos@gmail.com>
---
 fs/ext2/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index bde617a66cec..3ab23de558fb 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -14,8 +14,6 @@
  *
  * The only non-static object here is ext2_dir_inode_operations.
  *
- * TODO: get rid of kmap() use, add readahead.
- *
  * Copyright (C) 1992, 1993, 1994, 1995
  * Remy Card (card@masi.ibp.fr)
  * Laboratoire MASI - Institut Blaise Pascal
-- 
2.52.0


