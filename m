Return-Path: <linux-ext4+bounces-14621-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG5eJwg8qGl6rQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14621-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 15:04:56 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DEB200EF1
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 15:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAB5C3098898
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2026 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEB3256C61;
	Wed,  4 Mar 2026 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acXqQZdP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DEF156C6A
	for <linux-ext4@vger.kernel.org>; Wed,  4 Mar 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632603; cv=none; b=jf5ij40nJrcxVySU4XHP66iYJ6qWRTG3mGdWBk8//frhp8DWZkaYLpep/GN1VgU6uMONFtZiVHh9cbapD91fh2MV2aFE3Zbngfsef68D+KUN2m90VFo15Ef6Ddpy+36vGQeQ8AoIVtINsPnuxcuATOy9+rrGDpqTyrF/jnYSfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632603; c=relaxed/simple;
	bh=fXv0f3RdEiytf9JZHrG4GJRIpka7Emi4o09vOkW6cVY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aCpoktoNCkJjcPAIv0mAIHtbzppW3gUKkHBEYbAtauB6FatWoVXBIU3C+JwX9CqTLMcvGZF4c9icrUdJPa7w6w1WrWAcZc3547uTXMt9h12jvnN1zNQYFWrDusf3/10ZYfBzRohOrBQHNmbk/WVHDcbmIghsVyKnCG59hjUrYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acXqQZdP; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899f5d337f7so37835126d6.0
        for <linux-ext4@vger.kernel.org>; Wed, 04 Mar 2026 05:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772632601; x=1773237401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CoHK/7TBHUKGxi1yGVidKoKseNOEomnmuaQ/2YPZtBI=;
        b=acXqQZdPmgLk/UfYY5PM9yX3d7XqKz6LAp7kwGq0AtxQAzWLqGyPNzmIDJVedecYZr
         F2SE0feW8j3UieH720sQL8Qln4idvggj2lx+S86Dunk9Hb6KS/Xcb43lYoUIXiz4dR+a
         M3PHSn8EmSBA1qXVAM46Y8/dNlENJ3U78mf3jRu9FGL7ACSQmiv7GALwgveyaSftdQbD
         WEDbfGdqpc0HRkpFPx4FVJByFAcEsY03LYyFNgYOaMzBdS5AeyVatqWnZDRudDguLoNO
         NfHeiLgOVN27L86fsLUOSoqpI62Yc0nmV7lA2Otn2Y5szVWw2tzgNpSGq+pDA5cqQABt
         FdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772632601; x=1773237401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoHK/7TBHUKGxi1yGVidKoKseNOEomnmuaQ/2YPZtBI=;
        b=P1U8a1zUJMF4uoPS3GRPYMUEnPDWc5oeXe9F5sgSiB7iAAizgHghHwK0ldwp39Rrat
         3aeWhtv1yQjxfZI5Jog4rlqMgg80tOZ+RowUH/OO4tZRXqdnGESfUK1PyZd1I3MEc4Xz
         GjKqGHaQLp4exmoslMM2uqENM6u5gBrqAixzW5qsVdUER+ervJDKZlXMWQDrniMydM2i
         jZBjYmRJMT8BgF2SmbFBujfookwrEd7i17MLYO3V/iGpSb1tiuCeAFk1PwepPGH9HZPU
         v6VAgJ91yolBWxjeEOIH2fA1sH56WPH2pp8MSpMs1RH5xl6nTGtgeyLG/T2I/C5N7nRe
         1rcw==
X-Gm-Message-State: AOJu0YzF+6/kklek0nyq34iM7ANVBjUBNF82XUndTowV4EqAV7YxaK57
	Psw3Yad5XV0y6p+847sBn/k71EqyqGC3g9fIEWG008MX+h38Te2JChPo/rPD8g==
X-Gm-Gg: ATEYQzzeh/owOHyTI+6C8xtG6FCkfdZTTPbqF96qvMA9aVQMDxzTt2GnqgOq+GC440U
	leewIj3CJJryiMWkmRKQoj8YLzKvKVWjp1kBTx50FAGg6ntukpHwG82SsH3igGJymDkmOmcez+8
	Tg+gWSBgcfESK6tt7yU+jWhLtYl57qEE1rIqNR6jQGvCG7UY5UQROqRJSuAwxIQpB8gYvz4X0b7
	44XVAom9JvzsMzwZQuWTSFQqlK8h01EhufHZlMXU8Zkd1oEsbLpv8PEs3C1Tec8LtKZeIIA09uT
	D8kC+rr5TxG0y++DfSZLh/gJBF74DL8Jgou2gI9O9Ih+0XdkUbGAlSinmne+Xe+mTR5XpMFICfc
	cKEzyAOCYsYUWKF8snbH/QBjuN6wxh43u0PlDx+KGJ0HeydbnG2RV5EVIEqypS0OD1BP9Noz5fX
	igpU7ZO1TNXWLR4tnLn6N5Td5G1AgDCo08+DoTr/cZqayoXw66c8Bt
X-Received: by 2002:a05:6214:410c:b0:896:f42f:bf15 with SMTP id 6a1803df08f44-89a194cff09mr25101726d6.10.1772632601059;
        Wed, 04 Mar 2026 05:56:41 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.94.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm1760379285a.4.2026.03.04.05.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:56:40 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: linux-ext4@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH e2fsprogs] e2fsck: preen inline data no attr
Date: Wed, 04 Mar 2026 08:56:37 -0500
Message-ID: <3188418.mvXUDI8C0e@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 01DEB200EF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14621-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzgtgopensource@gmail.com,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,system.data:url]
X-Rspamd-Action: no action

I don't like being forcibly dropped into an emergency shell to truncate
pidfiles and other temporary files every time my tablet uncleanly shuts
down.

This seems safe. The only thing that should be erased is the size.
The removed inline data flag is remembered by the extent flag being
absent. There is no data to lose because there are no extents/blocks,
and the system.data attribute is already diagnosed missing.

Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
Link: https://github.com/tytso/e2fsprogs/pull/268
---
 e2fsck/problem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index e433281f..e6f055f2 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -1170,7 +1170,7 @@ static struct e2fsck_problem problem_table[] = {
 	{ PR_1_INLINE_DATA_NO_ATTR,
 	  /* xgettext:no-c-format */
 	  N_("@i %i has INLINE_DATA_FL flag but @a not found.  "),
-	  PROMPT_TRUNCATE, 0, 0, 0, 0 },
+	  PROMPT_TRUNCATE, PR_PREEN_OK, 0, 0, 0 },
 
 	/* Special (device/socket/fifo) file (inode num) has extents
 	 * or inline-data flag set */
-- 
2.51.0





