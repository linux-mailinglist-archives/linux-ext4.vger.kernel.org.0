Return-Path: <linux-ext4+bounces-14548-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPTvHUrTpmnHWgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14548-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 13:25:46 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5601EF5D8
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 13:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94DA531C267D
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 11:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2CC33DEE0;
	Tue,  3 Mar 2026 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="lWcUKxuQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839033E34E
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539018; cv=none; b=Tm5xX7Ab7L6mCtwJotaUhvJKq0nELDsmCaLa2TV0OBzK4aQJ/wdmaHzCcj92DrKvyghXCBrk20K1Xk7HVhkMQxi4LjtWNY02iOkRlHTdHRmfjrsgbrb0VbdIr7jEN28rWEsX+eEyP5ydVwd58LQSWHVioaXkbjHOvF8QoVh1tNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539018; c=relaxed/simple;
	bh=0sd6pwBKQ6PbID0tCchjpoDlAMKpvR/hYfovFcHJ49I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apYi10RaGzdkbnV+Sm2NqsPU5PdSMoenrdThsNIEeoxDmRV0/57JySw46PTY9HGrBo9/oyJpA0LK14P4Nzkx1CRChE6YNiD1TANPYqIwynFvFcpaDV3rY7LX6ExSWT7MgnjkyPNHX+TIAAvEModtcSqBL4Uos7vCh3I9sV69W3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=lWcUKxuQ; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id F40AE1CBC3;
	Tue,  3 Mar 2026 11:56:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me F40AE1CBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1772539010; bh=0sd6pwBKQ6PbID0tCchjpoDlAMKpvR/hYfovFcHJ49I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWcUKxuQ+5ZPfrlEcPH0yS3w/hoy8/IPfm9uGXtugb8HL+zS2JDRHE6p60QKrg7kv
	 csqIsT5BMeC88RiGLJ/1xKlDomOxZqyIx9x06Dd30ko5H8I5VU5QdjKauU1yUtR5h9
	 CdHdfwSNxdN9kWJSlv3QszvjnW3qmg/NAFML02yY=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id 41s7IH/MpmkwQgEA8KYfjw:T2
	(envelope-from <dxdt@dev.snart.me>); Tue, 03 Mar 2026 11:56:49 +0000
From: David Timber <dxdt@dev.snart.me>
To: linux-ext4@vger.kernel.org
Cc: David Timber <dxdt@dev.snart.me>
Subject: [PATCH 1/1] filefrag: fix fibmap error message
Date: Tue,  3 Mar 2026 20:55:38 +0900
Message-ID: <20260303115637.453629-2-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260303115637.453629-1-dxdt@dev.snart.me>
References: <20260303115637.453629-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD5601EF5D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[dev.snart.me,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dev.snart.me:s=00];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14548-lists,linux-ext4=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dxdt@dev.snart.me,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[dev.snart.me:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dev.snart.me:dkim,dev.snart.me:mid]
X-Rspamd-Action: no action

When an errno other than EINVAL, ENOTTY or EPERM is returned from FIBMAP
ioctl, the negative errno is passsed to strerror(), which only accepts
positive errno values.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 misc/filefrag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/filefrag.c b/misc/filefrag.c
index 4641714c..d45288cd 100644
--- a/misc/filefrag.c
+++ b/misc/filefrag.c
@@ -517,7 +517,7 @@ static int frag_report(const char *filename)
 					filename);
 			} else {
 				fprintf(stderr, "%s: FIBMAP error: %s",
-					filename, strerror(expected));
+					filename, strerror(-expected));
 			}
 			rc = expected;
 			goto out_close;
-- 
2.53.0.1.ga224b40d3f.dirty


