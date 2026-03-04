Return-Path: <linux-ext4+bounces-14642-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JqcFuhpqGnYuQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14642-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 18:20:40 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6118F205135
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 18:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4999030013B6
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2026 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E6B37EFF8;
	Wed,  4 Mar 2026 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZWbTtfc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4AF37F75B
	for <linux-ext4@vger.kernel.org>; Wed,  4 Mar 2026 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644828; cv=none; b=HLFMhPi4R7glCNWG2IY0+obDMAvLbCGnbibaC+FE+kZDv7E5vT6pCPWyArzl5XPlf7pPuZsanuQ+F1rgAEi8tYWql5OmzediMEGocA+fg9ujzktP+8rvQBWNr1pYRvCRAPpb4KkitP+Qf9CN4WSrNMKzoYx/lPnSGRYQSxRvaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644828; c=relaxed/simple;
	bh=/IXmo69Qqppsb0Rguh1puUkOgy5dR4pABTlr/a1NR3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuFjNNOdDFBJKSD3dunemqFmiBAVjMTXRS4NVne6zM0JZnuFC2AolWp7/Ioy2OroZZ56r6Bsd/d2sZavRsSQ4Yb+EqxuIUtlUHjt8zXl0F/ZhvCTOIcHcBb5MKcW2OFHi+gCs0/RG0/QEgy+FIJ5aDytdIhhm3kRUzS0p8uw+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZWbTtfc; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8133997eec.0
        for <linux-ext4@vger.kernel.org>; Wed, 04 Mar 2026 09:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772644822; x=1773249622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYGdbxnOx3otBr6PvYVC6d9nFh0rDHzCPxy+MS19bo0=;
        b=VZWbTtfc94FYS7d61xr9ObzwEyUUb0gRCvsip8xd6+mHhedXcKTNabuzbMzb9/AcJG
         OuY0Ro3GSCdWZdP7fr+/iO1M91iv6RiNvkiAUubSJyazBLSXD+xCRDeSx/pRVm/4tVRK
         VY2eGdZD7hnoM6NTFiNK3xxjputdSDmCMt3Q4oHyqHoulN0YceMWdsDJjSYMKadgq0XX
         rXw3p4hQTJxiouikeKqRFOyfbu+k977c9zQ0mgaA1dpHOs2RSlTHxIBTzsgbcBG6ZuyN
         spMNLg+0QPN7XmqqpUEmj8rI54gNW5kF/Gg4zx59Y/VYLBgtzHswpwXh6R0fQ35YQzcj
         Xptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772644822; x=1773249622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nYGdbxnOx3otBr6PvYVC6d9nFh0rDHzCPxy+MS19bo0=;
        b=cnm/oIjy5LnYd0Ge48Z7qn0lMryS/4S8diplwzzPCQdlsfga1jkrSdWcizFPdQarji
         XaF1E+PHE1uCfs5SiljWAC4gMB7HN1jPeTNzWoPpS9+rposK3oIeV26p9IeBbyow/CpY
         iWhl3op3B71YU93TyRYUOejiXF16UF6lDBjnGhmIZgmI0CPCW4un0L8OKaLUtQ8I7cHv
         WqT8x1Lnb0ONzHmv/JzZcN5ulB6tqltb5PjB69pT6TEMENTOh//QLGn79tGvyT7BKsXb
         Ohvt6NmelS8gV8DxqCV1lwgQ5G6oJVA6YxJzSIrdGvm+ig0NkzUtL2lWay61S5uhKxbz
         NmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVZnXy2uHFI6gM2LxP1rDY1jIwEMf9Cdu3tB2qg5Y0EHPmaW2cfgNV4QMdnxZuCyDVS1rxMGisFW33@vger.kernel.org
X-Gm-Message-State: AOJu0Yyld8o0m7hzOIqmeJAc33eauI82OwQK+kCNPI+UIsY/FG2ktYvh
	nMeFGeswPKKU3E/UADODd2g5W/3s7qJVafZTZXx/W1ZOVf072ICDkZko
X-Gm-Gg: ATEYQzwVl6alYVSNwCqh011YTYovPOfs1flZcKBQOjxYNiYJWCL0MV9Yc0O8Qkcfbjo
	c7/4c1YeBbrJqIV4A9vbBFOA3y1zt0N6BNiYzHNWhp7Kd8sHYZt9prtJl12UfwvTGQT4u+NmzOz
	y3cQl2ygOoU83OwGxO5KedvXdReHl4IO0OJr7FXyjooN7nE827TSKcGiK0bO1Vs0cTpoqMTAtmX
	teLa2HDyXXmT2+W98FT/TCoHzEpopuJ6jbjIWqeiTg0pTgeuV8dpvTIFZBdzE1RU84CprjN0BjB
	ddhLPIP9bkGpzgKCTMiGYWrTHYBVQ5juBZRuvVuBLoFt7zEkKr7l8beDMmYVVeHkSpCP3oi/Onq
	ppXnjjls/BdjL38HKy3PbdDAuIthHExEeSReuUuWGeFjl/wqj8bzVbxjDjfV+VCuw7N8QUDy9+1
	mJO7jGK7fXtY50zv2AeGl9y+SMzIGyL2QdFsgJ0g0uwmjzkxIIN3ZIgfxBg5R+xr4TDVpi0sd+E
	Gx7SINHwUFe2vcQgZzlhOsNnLHxzWUjkhWIdn6B9Gp8XixK8a5PFKK1V/Uks01Ex60lMt0FwKf9
X-Received: by 2002:a05:7301:6781:b0:2be:22b0:8bf3 with SMTP id 5a478bee46e88-2be310abb31mr976104eec.30.1772644821788;
        Wed, 04 Mar 2026 09:20:21 -0800 (PST)
Received: from arch.guest.box.net ([8.39.49.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be2800c89asm2904789eec.31.2026.03.04.09.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:20:21 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v5 1/2] jbd2: gracefully abort instead of panicking on unlocked buffer
Date: Wed,  4 Mar 2026 09:20:15 -0800
Message-ID: <20260304172016.23525-2-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304172016.23525-1-nikic.milos@gmail.com>
References: <20260304172016.23525-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6118F205135
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14642-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mit.edu,vger.kernel.org,gmail.com,huawei.com,dilger.ca];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Action: no action

In jbd2_journal_get_create_access(), if the caller passes an unlocked
buffer, the code currently triggers a fatal J_ASSERT.

While an unlocked buffer here is a clear API violation and a bug in the
caller, crashing the entire system is an overly severe response. It brings
down the whole machine for a localized filesystem inconsistency.

Replace the J_ASSERT with a WARN_ON_ONCE to capture the offending caller's
stack trace, and return an error (-EINVAL). This allows the journal to
gracefully abort the transaction, protecting data integrity without
causing a kernel panic.

Signed-off-by: Milos Nikic <nikic.milos@gmail.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/jbd2/transaction.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index dca4b5d8aaaa..04d17a5f2a82 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1302,7 +1302,12 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 		goto out;
 	}
 
-	J_ASSERT_JH(jh, buffer_locked(jh2bh(jh)));
+	if (WARN_ON_ONCE(!buffer_locked(jh2bh(jh)))) {
+		err = -EINVAL;
+		spin_unlock(&jh->b_state_lock);
+		jbd2_journal_abort(journal, err);
+		goto out;
+	}
 
 	if (jh->b_transaction == NULL) {
 		/*
-- 
2.53.0


