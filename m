Return-Path: <linux-ext4+bounces-14294-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C/iMZXapGlhuAUAu9opvQ
	(envelope-from <linux-ext4+bounces-14294-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 01:32:21 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 330AD1D21F5
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 01:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2C7D3018289
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 00:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3827202997;
	Mon,  2 Mar 2026 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvMgTN2D"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453983B2A0
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772411521; cv=none; b=kbk8Tr9aUBc/QcxTKxrRg5A7Q+Bv6HVKN5O0ue67H5NdU+7Avk9G5u+vUanVWhsCwOxhEMZJmsJGFNco2P3gT73UQFnd/Xerwuvf6x0bW0iIlmoLumMbFeLKMlQrI+DJfEinrTzifNeNebwbsD+ESvirtE6QK3mVuCUSwHP3UOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772411521; c=relaxed/simple;
	bh=AlrKbqDeHRNXNb4EDS6ApO+T0fQy/Ymm4/uVtcv5ddg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahP6SmdQiYuRPTaEG73kQQBSFP5QSXHfJ2uiMyQnrodmmrPV4zK2qTXM73TTLLcv1joj/Dc9W4g4A9+zwIZidwCOZM0Ed8WQBScjbWHsnG4qRx831DjbPWRRvDmin7+RIPNZ0YJxi9Nr0JQz232VFQIxcF32jZeXnjnQzcZtm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvMgTN2D; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-124a635476fso4544595c88.0
        for <linux-ext4@vger.kernel.org>; Sun, 01 Mar 2026 16:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772411518; x=1773016318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aa44Hm0AKiWgB7Fd7mIwjWSqvDDfhYq64s8ZEZ38CMg=;
        b=cvMgTN2Dx3VxpoDFfDdGAhHRC9Vdc54ier4nbq1SzuGG2T31NtLR/bx4rlfpcawODr
         KmDpx8yAPnBrG/xYwavqB5E37uzmJlfUHkqmeuJHPC775frl+Zp85bCzxsNQeH29QfyW
         2V7Qd+/l2+hxtDU3ZeCfEqrkUptbjXv2QKne3HKl+lwv1xmi5uvB7LDaVfJx3Jz5agPC
         uLvU5oox8lSq0OyynyDFYc1mxTG0/X5Ba6ahncy8X3CKZdqJkw+kGIyKSCCsQrNIhR16
         1OKgw3G6yH3ioFkS97L8e20931sfKU5IkRLwNzgRZeUW2zoe/3Gr8a7OgngVeP4X5WwI
         u7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772411518; x=1773016318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa44Hm0AKiWgB7Fd7mIwjWSqvDDfhYq64s8ZEZ38CMg=;
        b=V3WVAqfALK7k018VGELZtTOFFvF+1/Ab1vwNCieYiVHyjZbiuv8PQTOX0m+bzflBSs
         azcHuHeyVUuOHyPTo3838pE/JOI/7BmcyWapqGdX0iSTgx50lr1nLkGbzmDz+OH0Y/Lm
         QqMz0fuwi5aAI7R+vJGEW22Et7B8WE4ixeg6AN/QYXf9XOMiQdf80FxrcH9hiMyTe67c
         exeGtjtuZxMkpg14NLRmJdTUBTg4XGHwyCu4QhJ9kKYODVSHrtiTtAAuCirFebHYMwVb
         wbvSn6b0cuqk+k016uzmqFjN5Ie+oZhHAGqPxUcJO8USxWXcwCe9Y44ulhZrn59dnxza
         7qfQ==
X-Gm-Message-State: AOJu0YzQAYvXtsyqSxMzlqNz4dEjlU8lpV7asEwUSP2axTXMpEd3W5xn
	i71kgxbh8GjR5hk6TM28kN2mLfykbHGMjQR+H/+K0ZMjSRYg+GXccI90
X-Gm-Gg: ATEYQzwmIFoYakvmLqOhc65UB6i1qX2zQ4uwo8TY+DXUv9TrsZ1W286+EvrTdR5yA+m
	KlVGnuIchxbbf2NEq0ERBUac9/C89PlRElZ4Vh1TkSWMIh8fnw1I8Zb1HZBu7ICLhGgbXQRfY0j
	Y81UYkGrlq5Vb2LknDL47nRCJj/jwI4+QOS86LlfGuk20qXi4w1+enR+lpqjTR20MNx4GoYb6s5
	mmnrHdVpAAJ+IRANJO+0c0gZZuIVVQb48+VnjrUpJydTWKuOGsgyG7mBe8IGVWACXT0XmRanHFC
	psz5zjCB1DkqRT9QNxci65qZP1w7kfxvVYZyGyvwRa6yBvT5ukfc5dmOtqOlTvtB9uNU3eAsAS7
	qtBo3gc06x6VOEYa9E/dSDhWBZ3JF5nsXaD35DMUn/U4+pu5Yc6HhEomjcBuGNK/T0lYUUNwMSG
	JgHgk6wsANAH9odCfoLXL4YXyscZIzqEOS7FYJe+DaI84PynQ+/fVx+/PocPmqHNNKP9uSn+cNz
	YDGcp4w0rUMYhLtdeU0Y48SiE1H6QJUkWUOhflR3KGnojNdLQyn/t9telwK4DmO5WCnu6oc/i54
	1uOuEdeHoY3UGtJib8Iu9Al5ZX+g
X-Received: by 2002:a05:7022:698e:b0:11b:ade6:45a7 with SMTP id a92af1059eb24-1278fb7de0emr3640973c88.1.1772411518251;
        Sun, 01 Mar 2026 16:31:58 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789962f89sm11506020c88.0.2026.03.01.16.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 16:31:57 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.com,
	tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: [PATCH] jbd2: gracefully abort instead of panicking on unlocked buffer
Date: Sun,  1 Mar 2026 16:31:35 -0800
Message-ID: <20260302003135.93802-1-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14294-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 330AD1D21F5
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


