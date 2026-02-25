Return-Path: <linux-ext4+bounces-14003-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPyfL8OEnmmGVwQAu9opvQ
	(envelope-from <linux-ext4+bounces-14003-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 06:12:35 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F8C191D4F
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 06:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA313098022
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 05:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE252D94B5;
	Wed, 25 Feb 2026 05:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dYyfyJyX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84B2D8771;
	Wed, 25 Feb 2026 05:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995788; cv=none; b=jtATwGLAkTwYRoMIxLL6t/JkXKgm9rYUAKwFzSuMhkUsbCAuEI/45PAqEYqd+igQ24aOq3ZbnpAtpZu6oLwDk9PSvefIYi4ESF9cZe1AeVRph7qpBaq9Zh3u3v//2leoHnlksi2HtzotmopyhUeRZ7J+PjYA3toGjE4Nr50cwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995788; c=relaxed/simple;
	bh=dxCLuCLwcDdwFfvJW2XWs1uMaCiNHrx78KB2cLLydxQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=G0T3Yp+cNmtk6may9bTOIeu1zxW/pC1lTqNIAZYKTtecqBwgt3WQkP+WgJFDJzOQt9y+9kJeYA2KrJnKAYHAz4T8X8NtLg6DaNboL2kJCr6l2dPpiqMXCPNLtEwu0D+9vgV/XESWsCadPMRm2lMv3RWn7W6e37wdw9w2U6i1yjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dYyfyJyX; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1771995782; bh=HNapvol4PBxEv8pgie2lFi2oqbcT5slKezR/+r0zO0s=;
	h=From:To:Cc:Subject:Date;
	b=dYyfyJyXlvUjGlaATKwNcvRJ0Ju/Nlfp+u9/fU3cSbuZ1eSG/U7rOayLa6AZSBYf2
	 K+XyyC6O0SXRmavQYpKuEGdLqrv0KEN+vcHPh1yPLsUE4EeTeeZrMuMG4ZXWFR4Yq9
	 nCk1VDWyXeo+BVzmWEbTBX9BJDy853Oi7tY4vPcw=
Received: from 192.168.2.102 ([120.235.196.245])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id A233236; Wed, 25 Feb 2026 13:02:34 +0800
X-QQ-mid: xmsmtpt1771995754tdonvcxbk
Message-ID: <tencent_E9C5F1B2E9939B3037501FD04A7E9CF0C407@qq.com>
X-QQ-XMAILINFO: MKUhwZFKNyqx3LgaDvCnFs+e+rUs1hfmG+XQ/t3uBBnDyJWBaFUadYYRraRjSj
	 aGWw/z8V0zQpIvh0gz9dxvvDw4e2ENJsHwsgvL/W3AfI6mhDx3EDTQY1axTG8MnwKVabJWz1kg0n
	 7mF8Sgmxi8rCwIrTGW/GH8OX0C/2IUt//TXZPFy6hcZjBNZCU69uyXkxygDCqBGGk+9OB/+cgJPU
	 pLmgGIHWkb035+2DIVTzVNkbmjVLBaQrDa0HP9IV7ViPV/GSOTxcmceGP2hqzqeSgAQjo8k7wBWG
	 S6RMufgDf53vp1ziutNsXy4E258rInYsfNvsQ4mDt1R+2JAs6QYkkQKSHfq/qH4icv4FUc/IFiNK
	 zMWiyHH4tAuK3pP8xMF+XiUd0OMdpvXKO8qJ54V0MCox32X8r147fiPc0DujBf78XS8b80ffsnGe
	 4bSqcPinLMIP51UPuWnKtEfVTZBoWqEqIDOg/8a7qyCiqc5EV5RLxlu7lnkr/G9lcZ5t54XQAB8b
	 E8TPL0tkktzmxyWAfQ2RUSvdiX4YnI4MjJK4UDKKLyTvO5qsydREAZ686a2+ERxeXzgYFL6Q+UKI
	 PkODxcu5s3JEpFTVtqv74qs5//gYzw3KcaAXPYiw2JYmfoTHDczG+hcI4d8Saqp/hYbUXbHX0rW6
	 +EsITwJYYKw7LVsodYqxNhekjozLWX71x4j2lxf24G/VEUYm7d7jzziIgAF3JFGT38whtW7klqCp
	 SrDDPqjeMaUVdXQcx3efHglshxjZB0mDppvVFJS10AwndLgpkocnN/t/BpuRYQgUqaUGHKXl45Oq
	 PFC0Bh6MJtFTSguvNfG7Mu6Tz8qLKaecVParAkd6OKSywbGLYe1lpP1+HA2+YMfSyqZj8CMxepRy
	 NCxydsSDbwtEF96M8Y5T2GjfJBhZwiylzlT2LmkYWRV24FJsuFbQxSOPUqFezJy5scCYzp/evxe8
	 JjZozEObCflz6qwQNqrwMzP9KMmVYRIobm36ofV7H5RVKsVnG1/gWQ07QiaUAzMTESWLrF4dpOCP
	 +Kn3b/xOYrGanUbhlSJn6ivcxhMdhZjvK8W7zQdGx4wNpYqDvadiL533U1jp9NSr2TNus6/w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Weixie Cui <523516579@qq.com>
To: dilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weixie Cui <cuiweixie@gmail.com>,
	Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v4] ext4: simplify mballoc preallocation size rounding for small files
Date: Wed, 25 Feb 2026 13:02:31 +0800
X-OQ-MSGID: <20260225050231.35674-1-523516579@qq.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14003-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,dilger.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[523516579@qq.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dilger.ca:email,qq.com:mid,qq.com:dkim]
X-Rspamd-Queue-Id: 28F8C191D4F
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

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Weixie Cui <cuiweixie@gmail.com>

---
v4:
 - Drop unnecessary braces around single-line if/else as suggested
   by Andreas Dilger

v3:
 - Replace raw constants with SZ_1M/SZ_16K
 - Remove stale XXX comment
---
 fs/ext4/mballoc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 20e9fdaf4301..1d6efba97835 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4561,22 +4561,16 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
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
+		if (size <= (unsigned long)SZ_16K)
+			size = SZ_16K;
+		else
+			size = roundup_pow_of_two(size);
 	} else if (NRL_CHECK_SIZE(size, 4 * 1024 * 1024, max, 2 * 1024)) {
 		start_off = ((loff_t)ac->ac_o_ex.fe_logical >>
 						(21 - bsbits)) << 21;
-- 
2.39.5 (Apple Git-154)


