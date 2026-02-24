Return-Path: <linux-ext4+bounces-13977-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EE2JkeanWnwQgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13977-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 13:32:07 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C9186FE2
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 13:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99BF230D5B2F
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 12:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B5396D28;
	Tue, 24 Feb 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKiAaNuG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF95396D12
	for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936181; cv=none; b=jMsVrM1P9unWDrKDEo4arvXQgKPCMIVb9HC+W0Gvmv+w2rZO4SOPd4XETVaLYpniUkGfh5t9nFolrJP+I8czP/DUq6XZqp3MRf/edLFMYsDTUNGgBV0KrgwthnPN2ete7oNdWxFrknjLJrhCzFDMxA/LuJkfK0KrZ9u08JgLbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936181; c=relaxed/simple;
	bh=4Nk4brUE9c0cHOHvRjQBQZii34SBzjk+bptrUw+er58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F2Zl3Fv+ns4f8HMAkznA+xqjeUyXVbjogWyHJQNs3CfqPRj91q7fhh8PDerRx1jQajDw5f3bZB73WNfoD9Rd5jyhEOiR0Vq6pWvwHE5d6RQf6KHolbxJXuNp6bTZuyB/8QbCJQU3vGVufVD+eB98jg7C0ewtMNtP2rAq886frfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKiAaNuG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8230c33f477so2353182b3a.2
        for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 04:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771936180; x=1772540980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HjRheRQ3fng1+sf53F1DgV3/ZGdhBv7J7v8XPZ28gGo=;
        b=FKiAaNuGoOFN7HaW14gypBFEwc/LmtbeeJth7eOQeOxsUSl9yHPG+R9xc13TWe7mCp
         RL3VUq1T9/V1hjw+bx49DCx26YYMgkXtLOSbienCEcUM1TpI+ANkCNisHUUdfei6kBLq
         RMm+FMsK+q2y7yr6l3WsRbeWXeyY16ikaIClNsY0x7Li5sbTMU6PuSDVHLLGCHiJ6nrN
         jpSvjaxye6/dtLPQHl1IlQvr9/3rgY5GKRKKWuP0vmvAFu/jFevw3AGPI+4C9OxMA4rm
         pMYIbmxthyqrVbE2FVtLeXptYueq9BhGzKExg1xbr9C6sQ9Qfw/8PPkhXIdDJQiYylAj
         sKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771936180; x=1772540980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjRheRQ3fng1+sf53F1DgV3/ZGdhBv7J7v8XPZ28gGo=;
        b=FfR5FzqWBlt6J4d/YABhAtTtDGSYMSl83LG9PeFPdYBicb52IkfC9zC8CiT+Wo+pWp
         MtRG99gNs+qjsT1Hkev0dprCsZgq8GOScV1zHiAS21P3xdkPjSYcKZ4hlxrtvl+T5jPx
         46Tr5JTReFP2ocYBDQT+ZnriyKJcQidN5BzA/khI+ZLm8/+Z3sze/IzzrP+1CDg3GKtI
         hcoWIcX6wB0d91oTP8zSL4kycnc2CArJ/FTllNBSo+du9XOI2kJRpWQ1v8jkgL5V0hMf
         6xwaNw6wS0g1EniinoBN0YjyPS8jQOcZxH644NWI/huSBWCqnQFO9l/+wUWRsBN0XfVq
         wBLA==
X-Gm-Message-State: AOJu0YwtL4OOHLFgIB1OViXRq3JEX+5kG/4pyNeKeVk4nf0mCEriWaUj
	oYsj9OJv6d/5bREzC6QQYpi4pHekKH9nN+TTLz9zg0B/frnojhlIRNwl
X-Gm-Gg: AZuq6aImVN0Sx4mFGpGFf0+LhOn75DSgMWI/xbaLNVWSrSGG5rJTHPu00h8+7m+n2uA
	SnhsGXPAtkKzCJsQ4zum4899dEPwtBuFaS23lXI+f2IbI87ZkJWmyjUuspX6jzgPT7lLA1ofwpK
	+SNAhn2XdAwCoubEjJ2cJIey8gxie98EbR0fOfzrSJmZ7G0+CQFn0C0pG3PTkrrBI6M9q74bZdZ
	QIWMYWz2rTO2LhLWK7bk22SD4MNAaSl8EXi9usGrOcEc3xsOc2WVcofvH69CTH0pLGWXUdmzHyx
	ffrhcQZnhh3uOeyanCNMP/FwKhnp6Ta2y2Qsj6I/fSvkPtrrxcHCIO3hIzba/h4swxDGlMkrLf2
	3XnSSaayMfcHWhzgGWmVmUyXWyIhLc11OmkEe7sSOcGJsYMkOdZ+6LCVFF+LaTBoyFo8UuCruOo
	5y3Pyk3LiDMu5ssuabbcxoOh1bPAgbq+k=
X-Received: by 2002:a05:6a20:3ca7:b0:38d:f8e6:fc8b with SMTP id adf61e73a8af0-39545fac23dmr9717360637.58.1771936179679;
        Tue, 24 Feb 2026 04:29:39 -0800 (PST)
Received: from localhost ([120.235.196.245])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-358af71e797sm9757901a91.5.2026.02.24.04.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:29:39 -0800 (PST)
From: cuiweixie@gmail.com
To: dilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weixie Cui <cuiweixie@gmail.com>
Subject: [PATCH] ext4: simplify mballoc preallocation size rounding for small files
Date: Tue, 24 Feb 2026 20:29:33 +0800
Message-Id: <20260224122933.27975-1-cuiweixie@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13977-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuiweixie@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 095C9186FE2
X-Rspamd-Action: no action

From: Weixie Cui <cuiweixie@gmail.com>

The if-else ladder in ext4_mb_normalize_request() manually rounds up
the preallocation size to the next power of two for files up to 1MB,
enumerating each step from 16KB to 1MB individually. Replace this with
a single roundup_pow_of_two() call clamped to a 16KB minimum, which
is functionally equivalent but much more concise.

Also replace raw byte constants with SZ_1M and SZ_16K from
<linux/sizes.h> for clarity, and remove the stale "XXX: should this
table be tunable?" comment that has been there since the original
mballoc code.

No functional change.

Signed-off-by: Weixie Cui <cuiweixie@gmail.com>
---
 fs/ext4/mballoc.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 20e9fdaf4301..dc7a0dee332f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4561,22 +4561,13 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 		(req <= (size) || max <= (chunk_size))
 
 	/* first, try to predict filesize */
-	/* XXX: should this table be tunable? */
 	start_off = 0;
-	if (size <= 16 * 1024) {
-		size = 16 * 1024;
-	} else if (size <= 32 * 1024) {
-		size = 32 * 1024;
-	} else if (size <= 64 * 1024) {
-		size = 64 * 1024;
-	} else if (size <= 128 * 1024) {
-		size = 128 * 1024;
-	} else if (size <= 256 * 1024) {
-		size = 256 * 1024;
-	} else if (size <= 512 * 1024) {
-		size = 512 * 1024;
-	} else if (size <= 1024 * 1024) {
-		size = 1024 * 1024;
+	if (size <= SZ_1M) {
+		/*
+		 * For files up to 1MB, round up the preallocation size to
+		 * the next power of two, with a minimum of 16KB.
+		 */
+		size = max(roundup_pow_of_two(size), (unsigned long)SZ_16K);
 	} else if (NRL_CHECK_SIZE(size, 4 * 1024 * 1024, max, 2 * 1024)) {
 		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
 						(21 - bsbits)) << 21;
-- 
2.39.5 (Apple Git-154)


