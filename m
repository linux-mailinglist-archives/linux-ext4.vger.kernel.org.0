Return-Path: <linux-ext4+bounces-14451-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ1fN9AGpml1JAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14451-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 22:53:20 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 833C31E43AF
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 22:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60DA4306CDC9
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F938236D;
	Mon,  2 Mar 2026 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4TeNGza"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3EA382362
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487276; cv=none; b=kJ9NkfcM7cjZO44PdVIRfSQdbGHvGzsDAf634DRu6fxxb6P6XbR1rB7EfpXpg6FVhcjALnumtIwAX9y7e+djHwCscftMv1N4k9fRStuSPK53ann3Jb58gzl+DcnCSFHhNjkOaMI3m1kX/NoUBlmvHBvO3HGAiOKkei//vHiM0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487276; c=relaxed/simple;
	bh=VTv6p9V1KuY3NuOQ/g19x6YUh6QjpeorFmtw98a94Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qu6nE7j6jIRNX7Xoem7NsaOxlfLKuKk2TnEv7rjrPBR/ikA2cDvXWrV2J7F5SSBZFVWnk79nc2spbmbCl19+QEpno3x6YvUX4ReFHrahPfDALEhbotkNoMU2R2F05W+6yy8V/4Mrnk4Bjjqjc+9nKqfrUaiAGHuh2Gpy/BCvWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4TeNGza; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271195d2a7so937629c88.0
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 13:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772487275; x=1773092075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dex6BTSk/FD4IJdE9hg782BTunzN70oc+BYZl89/r7o=;
        b=F4TeNGzaP+0QRL5KFTTu8RSVBaeFeELUm9vGR+zBmAiw3ntAgPpG4C3L7GhI8eIOIu
         hOf4EYMHZGlr+3VRRYqV6P2+aKgv6yjJwD3/gAu/5cUb9v7lmA7iOjJRVHANrKVgQV6l
         Ln9sdjor9qOIlwhp230/iEhntiOcMEBFgb3KqFoGKZD/fDskKxZjQ++clvSoDMQb5fuE
         o0zCBcdk4PgsFO5bgwK1eauGIL4N2ZZi/yyLDUEskK/fSMLPMkPgbCA8dpqShrVS6yK+
         St0xz4EBbhGvkFI2IaXA9HxTRNOzV85zPiy/IVrcy4k1lQiTVuBCXUlGZmaW7uHykc2p
         ATeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487275; x=1773092075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dex6BTSk/FD4IJdE9hg782BTunzN70oc+BYZl89/r7o=;
        b=POIuJiQ8aovh83LYJzcmSUInnl9Mm4wxz7zPpIfienRWinQhFaoEePGjJtu4/fQ2cO
         VuWpRMROjmUScNgPHQNV7xhKxH3cIdegH2gOvwa2keLjTAnADCUYEs+lXqusdhcggDc4
         7PbUPXjmii96firy5RCGZQ3fQFqtRmfNrdid6SBpvVdVtSmnJetNUJORBArUVeDp0HkI
         Mykkc2xjhqLcrCViRZZvCIyvrVEussK/x3PFulkyyb1xxy/NfkdDXBQTB6f/Om/pX8rG
         ejdx6hjqIyG0pR0LImYtQGNCs1S+EfS1qM6TnSQDrPzvooWEIfMtPRdTERJUYigXiZIA
         NVWA==
X-Forwarded-Encrypted: i=1; AJvYcCXDtyjI6hde25TvJ4cA1Ntna9juodz/HNc63dsFOE54EA9eVW4nAYgu+WaUhH4a65qehLfENrF8+VbU@vger.kernel.org
X-Gm-Message-State: AOJu0YyECJkEHv2tgz9L2kPFwt/7myWdFZ4X2GyEKI+jkkoNPrxJX3Pb
	XUCAa+GDHBBMT/SGhb2iihPopTu788z0IYi3ND+6Ugk0tHPg0JECUfaw
X-Gm-Gg: ATEYQzyJ63Bu4VC8ogrnHR/eoBjHuK2Kb1KD9fg/ceZzX2epW9BJ876Mg+y20LQVY2q
	SNIPVP2SXVLP2IiZpqXkghywi2BoEMjz3WrV+iBnk7SQPJ5HOYgZptjRJ5kR2kOXrZDg+GqyhH0
	49XZBgWn4LaG08LuAOtIkWtjIUYSSlWlUpA89WCLwjL5Ex/OnSa7/VVaVcPwrY5zyOObCdFk1Di
	z+albWVHaBxwfF7ZB1OiFHXR1BRKgi4vLnUxnx/SrsMgZThL5la3Wsu9effa/mfgPtdzt9B1mzJ
	5Jn00LeeCRnpRBa6qHgeamroCm5Yq9SKe01DqoIl6aG50Ydy+JzXzp6QaM0SgLtZvhV4lcswlLz
	vUPtyjnO0KCC9imrmwvyKt6JLojpYLV40RSp/hbOPzPlBuYixasArtuftWyYw7hfjqN6GGKUr1y
	C/M0m4h7uyRVC7gk8R7gX3CvjDGLybnOSdvKeSSBCxjeleHqO/qB756jGzf5VcHUFhzTe9agl4u
	T2b968Qp0FNL+H6cuKo2nrcluE58fcbZxAgTj5/lTDa9w/fP8gefqp3yMaIpg2/Kt2TiFIxuEvW
	eayWkaM2kW+XSYIVWz3sGTlbK9VdCznYM7Z3BDY=
X-Received: by 2002:a05:7022:4381:b0:11a:51f9:daf with SMTP id a92af1059eb24-1278fc56a82mr7378968c88.14.1772487274540;
        Mon, 02 Mar 2026 13:34:34 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a52ab0sm20032605c88.15.2026.03.02.13.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:34:34 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH v2 1/2] jbd2: gracefully abort instead of panicking on unlocked buffer
Date: Mon,  2 Mar 2026 13:34:24 -0800
Message-ID: <20260302213425.273187-2-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302213425.273187-1-nikic.milos@gmail.com>
References: <20260302213425.273187-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 833C31E43AF
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
	FREEMAIL_CC(0.00)[mit.edu,vger.kernel.org,gmail.com,huawei.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14451-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:email]
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


