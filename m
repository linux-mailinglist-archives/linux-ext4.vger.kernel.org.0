Return-Path: <linux-ext4+bounces-14465-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOcBJv4xpmnKMAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14465-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 01:57:34 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7901E76CD
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 01:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07C94303B2E6
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 00:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2A22288E3;
	Tue,  3 Mar 2026 00:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noWOoprN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB41220698
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772499314; cv=none; b=adtedU8QBuC3n5h/wHmYSF2hUX88OeCgJDyQOGWlSBJD4nEbzpIrJluSZLRaHxrXQaG5+jrjR5Oqx/4XJFhRIpl7RJhTtxFMWoAuAFnNidlZx7aoRothKZvaNdXMYCbm2VlP0UOskgrNV5GQocTgKKbpctbMqIR+gywVkZTz3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772499314; c=relaxed/simple;
	bh=VTv6p9V1KuY3NuOQ/g19x6YUh6QjpeorFmtw98a94Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GctQMKp6LUyBs0IubtjcJqSCGuM4C1/9XLF54bRizzcbz81O8n3RP4BerT6/f3DcOtrbCdgjq/JTyhJVq0F6cYTyyKZ2zraS8C6ngyIbczgUKBG5mFA/1bWcnvQzb/3yTTxShAe5+kWccYpqrXaIOc0CL4L1UzJxALrBuwLcaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noWOoprN; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1273349c56bso6129957c88.0
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 16:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772499312; x=1773104112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dex6BTSk/FD4IJdE9hg782BTunzN70oc+BYZl89/r7o=;
        b=noWOoprNLlIJhgaXe7IfRO19Noo5PbjHeaeJL30zhZMfe2MlzDz5h9wkJffUdOQEYE
         ScjPrHoeI/pFQpOJWH9gxKmsZfctC7ocHIQ+jWXjqbKgXKWygFVJlcCvDHtZNpYX2bAP
         tNtezRx3fyRbI4zuJ8iDNcEVUWbfocO1TBhn7Lvrq0yY5/yHu8QssE0iTgxFXtXP/5d4
         5hI0nkOgdWyOyHGMKUogTDjL2gW/k6iAba0nLC2FDwfseD2t8UG3EIS9CuxXiXAVxLkE
         SwT49skCM037sGf03xNNzhMDSnGesB9zIR9R/pPBx7ivevY39DddJKpIuIrr37OlgZYD
         i1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772499312; x=1773104112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dex6BTSk/FD4IJdE9hg782BTunzN70oc+BYZl89/r7o=;
        b=rpgoK3yDThEcYdBHdaIF6bwIT8Z7Qjp+/Kp4ZxsCQd4IdRkg0P6JwGl/qWOaECazpP
         cM+LKlOYuckII1FQSqK4PvtQcXoTR3xfDZWsV2sop3PXcQ4rqpg3q9EtdIUEZob2y1Zr
         LSPfuy51pBQmZiMgf/cIdAwKdCnD28HUmsrfhSeG69xKMqX0wSv9RnY/vrRZ3nktaMB6
         TvvPs7REpMW/1otWKN69NH2dTiiQtIvjvaNmNMUqZ6kCJBkJyCb/KuKEnHWWU3tyoks2
         GG57VzBAVqdK/nZIZqHPbO6wyZJzA7GKHTwOXErigJ2cDVnZUFWrwrx539guqb+GTUVA
         c11Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxJHtcl5rZ2ydkQlTXsKI93eqEJeES6tfSdhrQN16mlDXzJaDYV5QPb1MBK4LkGzlaBxGci2cD0/YG@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQCCkh92C3cYrH6/vndqfohIaslQ8qCgGQ83OnCJvGdu1HTIB
	py66IozuxePej9Na3pCj15qcSt77RDrQw5EcajgELW0SMl7T0aW1QhPtGFHdm1olj5c=
X-Gm-Gg: ATEYQzwUTSqafstSY2S+3csytcLWB97+QmQIVjG6x4oDwCHb5VqzMFKR8mkbv3/OMFP
	eFKOvihrWaPjP6FTCi+bVPKd3BUiqIK4Q02p8nSLc9BfSNYEMvT0s02GsYfBWCgPLdFdCIbTpUr
	Ev+R+DTqULpgihdXcpD7CfMcKTr76TeUTWCTCv2MDObuosUpDIV7BNJdUmdUaS4hjHm7FHgHiCf
	pzRakDS1Eqn6P8Xv5msPbh06KDdYgMYqZsKdbGSWAD8CC3pRHE9xMLCsk6VBMSSvQgGqPAKl9rL
	zKIDxqrNgoq/ymgY0KwiKYcOjeKuSCPweHhci3yqPap/xu3WXDTb7pAHT8WNKprpaBQiYStIsZ+
	C1wfwGQytYu4esR1OtC2l5aSv9U/10NVtcxVHGk8aWsyLRXEi+h4oI3Mc0eajssSx2X/M0uP1Ga
	A0NvlauafHM2s6VBXsrN01wxC+BPN64J4N+BkZt99+WL3lbmd2N4tjC/GreAR7H96dGZeXGYhSB
	OeedQPM6LwDgM9FC/Z9Wvbpy5rWqFoxO6ULyeQxbNWbdyI6nfhRzjt9ePz6DJPUaRQOrtd65sBA
	E8xO/1I+lZiGhO/YY6XBFbPnowxX
X-Received: by 2002:a05:7022:2087:b0:127:9e96:6f5 with SMTP id a92af1059eb24-1279e960909mr2296916c88.0.1772499312197;
        Mon, 02 Mar 2026 16:55:12 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1279cbd1993sm6552005c88.2.2026.03.02.16.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 16:55:11 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH v3 1/2] jbd2: gracefully abort instead of panicking on unlocked buffer
Date: Mon,  2 Mar 2026 16:55:01 -0800
Message-ID: <20260303005502.337108-2-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303005502.337108-1-nikic.milos@gmail.com>
References: <20260303005502.337108-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E7901E76CD
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
	FREEMAIL_CC(0.00)[mit.edu,vger.kernel.org,gmail.com,huawei.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14465-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email]
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


