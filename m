Return-Path: <linux-ext4+bounces-13612-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJiFJFCQhmlwOwQAu9opvQ
	(envelope-from <linux-ext4+bounces-13612-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 02:07:28 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D231046A2
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 02:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EB763019078
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Feb 2026 01:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E6E23F26A;
	Sat,  7 Feb 2026 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddc4Isqa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C45522B8C5
	for <linux-ext4@vger.kernel.org>; Sat,  7 Feb 2026 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770426381; cv=none; b=VsU7PF2XlCbOCfEIZy+jcHKtj1GYhWaLPWyACM5fViMvWNWFhX9c2xQZOEEcQv5KEZezACSI37ySqFiqDE6JTEdshg9nCIx0dl4LytDaVdm4dny8XkDjqMgw91z5qks5q6B1woMMFbCJe6zAHMyUkcnj0JCoRq66bDXNsj41oVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770426381; c=relaxed/simple;
	bh=CjoRwzUH4R8x/n/7y1CkznKIRCyKpv3yTyXgli5U4wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NiOws1Fws+yWwayDbW3z4Y1vdASUs216ytKsI0Bpn4bls5WTSrGaCl0IciM5QU2snFpmMFYz6jZCJ9bvII7+gYqtlH8jrI2SkzMJM4LZNjDY5J9pS5b/FRn1W/TzoFb8jgBzA7RMgDzS2Q4UKctqqRYXZImAxK+h3lCr/GRI9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddc4Isqa; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1249b9f5703so1761097c88.0
        for <linux-ext4@vger.kernel.org>; Fri, 06 Feb 2026 17:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770426381; x=1771031181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dawYaSkjSeeyfXPo6xA5YUh2ssPoeMLLOdZBaaBhvAU=;
        b=ddc4IsqasYXu2GabntQJdkV9EtvgP6+CXHue9xCRuYA3AsBv8qqnn2m2qxGJp/zrfU
         IkFDsHS5pkPJ3Po9het5zE2Cl7dcAwYUhJETtoo8juQuVJcUDGt0WeVaQ5y1imaaYkRp
         XUaaWDz7LY3ltDiqVyr3ZA2TM+Hz47jpoMkB1Tobij+gI7h4dETDrBTDdPtqpPO6H3/G
         LVBU5NGqUPYzuXf8HsUWl/AOlqoh719co1nTZmx210z/Lqm6oJDi5P/ynlhfYn4I4aVI
         FPOZZ4x0dzpeBldUqRGSouztRcpl9DIafxb8LR8S5yTzCjIMuCJew79iUIsDOingNA27
         BCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770426381; x=1771031181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dawYaSkjSeeyfXPo6xA5YUh2ssPoeMLLOdZBaaBhvAU=;
        b=Vz7M78EVmjx+vkLfsr9o+V8sTf/NuUYaXh6R8ucJ8LNPIwpoXx/dmUJ8ztWlQubca9
         mkQBW9nJHu/OEpAfS03U0p3LGcO897Unzzngr7HU+XLTVa8+8hSxZBGpEU92TIjDc2mf
         +jIDvjlrzDzAFbgx3SA/3oOFkpn1A/5XkPwA5i9cYFOc14XJqUtqZjZrSMqA+0JPm6UW
         OinPT3UKRwoiujYpT/h8K/qCXkFU2uxsTbyROTuSUaKbAk0QSMfMFrhBiSxrSgFJ2UhZ
         Cm0X93I8gtAhfp+SELSMe2SJa8ggEES+kSiKXpgEwTHYCxczPvC3S8cZ0h6aop3/dZ0N
         IYww==
X-Gm-Message-State: AOJu0YzNgm3xdVT7GBxlJHQZFRNWA6WNxVjKlccs8OuZoydbTVNA8tkv
	C6/P7k9dLTF8A3XiqvliMlLlgpbGT6wcfN/dNAt9SYuWTrLaO4bVO0YZ
X-Gm-Gg: AZuq6aIVYMcZ4FaTHM7fhqgyv/KrxSUifb74I4HroHdAu+iA2N1wyKKy/fs1Kd5U5Kn
	LzFfxrg2dkI7fgSSc0W4UEomahLOwAThP3Bzk/8/tjwpTq7v93kjd7meDD1vzKPaju2HxpOpsdW
	XckIpFqr+mGc2WHxfh+Zi57qtBPRwrT5CCve1k5la7ctuxQhcN6oISbQnX54QM7AcQUiOKsJrCR
	F/1vgzVbNade23nBIiEpCk09iz/pgC8MA8jHebDP/uFVHENzP45VSvqSTZN5lb8Fs+KFsTGTbrZ
	9EYmh3C+rGgXVCO6eWIscNnE8V1KZY41GgflSdx5U0lpTMIFwaZ9LyPetxGttFodGKpc4H9zUvt
	9QCOMePXF3JdX0Xvlp+ClhEPJIncUpos1rklH5mXq5bIcrEZjIaoGw7WjrGXfeRgzNiooul75pc
	Iw5Z13ZQnaKqYCMXMevtSh73jYAYdVeBzJKBsd2RHn0K3zMJ8SErmiMV9r1chB5q43TT5ve2jYb
	GomTQ+/RP22wwF6FkRTUiG1rQJbeRiBFfyF
X-Received: by 2002:a05:7022:250e:b0:11a:2f10:fa46 with SMTP id a92af1059eb24-12703e569femr2185435c88.0.1770426380622;
        Fri, 06 Feb 2026 17:06:20 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041d9c91sm3690236c88.2.2026.02.06.17.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:06:20 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: [PATCH] ext2: replace BUG_ON with WARN_ON_ONCE in ext2_get_blocks
Date: Fri,  6 Feb 2026 17:06:17 -0800
Message-ID: <20260207010617.216675-1-nikic.milos@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13612-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33D231046A2
X-Rspamd-Action: no action

If ext2_get_blocks() is called with maxblocks == 0, it currently triggers
a BUG_ON(), causing a kernel panic.

While this condition implies a logic error in the caller, a filesystem
should not crash the system due to invalid arguments.

Replace the BUG_ON() with a WARN_ON_ONCE() to provide a stack trace for
debugging, and return -EINVAL to handle the error gracefully.

Signed-off-by: Milos Nikic <nikic.milos@gmail.com>
---
 fs/ext2/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index dbfe9098a124..18bf1a91dbc2 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -638,7 +638,8 @@ static int ext2_get_blocks(struct inode *inode,
 	int count = 0;
 	ext2_fsblk_t first_block = 0;
 
-	BUG_ON(maxblocks == 0);
+	if (WARN_ON_ONCE(maxblocks == 0))
+		return -EINVAL;
 
 	depth = ext2_block_to_path(inode,iblock,offsets,&blocks_to_boundary);
 
-- 
2.52.0


