Return-Path: <linux-ext4+bounces-14675-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GjOEj1pqmlORAEAu9opvQ
	(envelope-from <linux-ext4+bounces-14675-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 06:42:21 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D615221BC54
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 06:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF3C7302524C
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 05:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5566036C0D9;
	Fri,  6 Mar 2026 05:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMohkKru"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A66176FB1
	for <linux-ext4@vger.kernel.org>; Fri,  6 Mar 2026 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775738; cv=pass; b=DOwsadPjjmEPQSmIeYGZBRqlYWea9h3wogKq2LhLcD3zaYU9nb8p52/G9MAioQKULUubzOL6m9uyEo7qYdPnVt1Imo8rgn/JPxJxFdejRMnbYz15kY7/s2Fdu++CY1SCy0xwYOTm672E7dL6XJRHeXbcgJ7EbI41SJ0tLxGwQXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775738; c=relaxed/simple;
	bh=Tx6xGtCsEqR8ulR7rnTo7nAJacfroyqUnQD4Hvdrn9s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IvFJdgNn4G1Df9JFvq69590VZnEG7EsOVGydvWEft5oBmpMsk+okwyKp/ZQlX++M5HfWQg45AzxqBk1YaswEQynrUQJ89FNIzUOqR24+k3QlJ49ICRrUlJMQnyPmaqj+q5/bpprPo3u3uRt422I7ioaoW0aIbRjmpuArEzShfSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMohkKru; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ffa277c115so1585818137.3
        for <linux-ext4@vger.kernel.org>; Thu, 05 Mar 2026 21:42:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772775736; cv=none;
        d=google.com; s=arc-20240605;
        b=QdSePAkmU6DHX0wOqJ+PdgIHwZLplGcduFcZsubAHtH1V2s4xC7gSXGZU7Rkk1QZis
         mfFMO15gVCEbQx+vwZJWAudTpDxqss18GnBBR4V+/Nw9pBlHafFieyAHdD68RG96WK44
         mHZo5PaM1azovpcpTweP/4bHtlSwDZgWhRNmn/VxjFDSvhc3plxVUEWRERo8uIDz1AZ9
         IOyCX9KZYKn7TWeaIXJmURXkjRIefnqirgpLxYedh9tuadRVtWAtoFGk6lQ3uioN8fxl
         FlSole+WOpBmAIcgn57rZhNdfdcVV5HpPI4N2A4Ba0CydzQc4eSgPS5/dZOh1OJVJ8JJ
         fK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Tx6xGtCsEqR8ulR7rnTo7nAJacfroyqUnQD4Hvdrn9s=;
        fh=iIqum7rtdLWpMI6fq+TuzpiLHiccG2gmNmcyEJYeeTA=;
        b=TNy+k7+QSRMpsFq8XTFHyU5uJRUJ1LcpzzHjzzdVoe9wiDRgII8q7fVxR3QGLBodM3
         uj6gidT2/Mc/VORn4LJuGfnlxniAdGsgW+4mM5jAzVta4yr/rVBDCNKk2kgHjrcyYEF3
         tvJSJE7vOeYAp0dSyl8n5hw5PuuvKQQnnN28qL2YESg+xYM2sU52s75rMTL1UMhyCJkF
         JBkLyKAFUz5MEy6erNN9og323N11+9Bi+AipGfndq7c0M2nxb0mOeRrEI++mqyCP3pam
         X/TljKpz4agOhPKQjeBM45seESkl4g4p0zapNExs2+9H4MxuGqtMNQjTXN0s/kN85P0k
         n6Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772775736; x=1773380536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tx6xGtCsEqR8ulR7rnTo7nAJacfroyqUnQD4Hvdrn9s=;
        b=lMohkKruMbo0IZoSpBlASWOxZUct5atK4PsT4U0mO9bgBt9nkI0NDk4x5CFWNdJOGN
         BIXA3Q0TJJF6tawI0FgbKuKnP5tRQbQ2VuM07HeXtBO0Ne9OEdpcE5sYlkNkXMn/bWbJ
         qmt7wPD70VMRRdeGtXpjgmT0eZoeHOcLdCHTIlAXbuOD9fxm8obg9abShl5yfoaqJ9H3
         ennFMxilS7fbe1Z5EfwDfcTFCZhyIFcN+UuOmsCTntoZxHNCuO+jbuxQwUnJIQLLiCMj
         tgtLI1HrZmKtj4eRxBj/YIUI98T0RQFMqfKKyux29u103F4EDKILv2C1ske52zrhl5Dq
         Atcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772775736; x=1773380536;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx6xGtCsEqR8ulR7rnTo7nAJacfroyqUnQD4Hvdrn9s=;
        b=t/gRqtLjx7Wggwxrz2mGU5MpZ+I8p9AMYQeZ9sjDBQmgaOdRqhuGOAwB6j3VfvKdkh
         +2/UXXzqX2D6VVGsWRrvzJMXolOnrlq8x2Z1o4VKzdM5sJdPplk5z8JQuDyjaA6DPILk
         O7E7y359OJyDkr+E2eRmVc6eM9wLtnK6svzsSYV86GRFotPt3UarXS4Z80t08DDG5ofS
         jQ7hxxtY4UY7rCZmB4aiJIjy0mPAO76Gt0C1/IC70PVer3nP7WNlLNaOiCEMAiVyBRYp
         j7wWZUBB4adPZqbAhbsy7BGaPiYuoyYkGkAiOXhqBBzgPeCXTN3t8ufOkWZXemZZBqSP
         qb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0S4legt3zfMxOpNIRUKKRz4N0hzuGVPCrp5uIU4WFgY83YIpP7aQCr2c1YF5d60q1C9WrCT2AVXpF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02r4zoWuIjqi4UpxhE8Zl68QD9QH+DVixyMN6FxOVNEHBAyqk
	mo/LjTkOcMoGu8x6D9R7vDN/umSLUMRqkBSZtVw+/4kxrVGh5EJ2MM97TJBbrjJncBamxJG7xo5
	FY+tQDzUhk6VqsixoiF88YZ8pr+yP8iQ=
X-Gm-Gg: ATEYQzza91yP7tr8KUJHhQeKJUSkWhY7bRcbTlgL4moOASEUtOV971KliE8D3SPr4fz
	ivbEiNzKclgYVYE4Mp7NlPltkW1EyczAmx6SOdqei/+ZrsaBfVuwA1LosUFG9UzvI0JcDR3m9lw
	59ZRJuUsMPyB70LFByvX1Lfx2RzNkMugKlDpe/le9rW0uiChCFjlZjor7e4Xkpf0gqhyvheCDhG
	gDcoyBPAxYyBUqJV+8smvptkLeEMiBo6vUiEN0iQnXRm6cPjPEg3XzhL7X9ZtUfZw/RcvSGCGVn
	GWrlLmrN/k+DJ70iNJNQAHofF6aITpZ1QSgmdmI=
X-Received: by 2002:a05:6102:3e93:b0:5f5:320c:4d36 with SMTP id
 ada2fe7eead31-5ffe639be56mr392574137.40.1772775735631; Thu, 05 Mar 2026
 21:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Fri, 6 Mar 2026 13:42:04 +0800
X-Gm-Features: AaiRm53_PqCIfa5pK0k1qFxDa6UGy3ZBMLVb-PKiHrR88buWt0F9yso6zddyoVo
Message-ID: <CAOU40uDHsLY6KOor1A-uuozEn8yJgF+gmQx_MLnkU6oSnyAERw@mail.gmail.com>
Subject: [BUG] kernel BUG in ext4_do_writepages
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D615221BC54
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14675-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangxianying546@gmail.com,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi,

I would like to report a kernel BUG triggered by a syzkaller
reproducer in the ext4 filesystem writeback path.

The issue was originally observed on Linux 6.19.0-rc8 and can also be
reproduced on Linux 7.0-rc2. The crash occurs in the ext4 writeback
routine while the background writeback worker is flushing dirty pages
to disk.

During the crash, the filesystem reports that no free blocks are
available while dirty pages and reserved blocks still exist. Under
this condition, the writeback worker continues processing pending
writeback operations and eventually reaches an internal consistency
check inside the ext4 writeback routine, which triggers a kernel BUG.

Based on the execution context, the issue appears to be related to the
interaction between delayed allocation and the writeback mechanism
when the filesystem runs out of available blocks. When the writeback
thread attempts to flush dirty pages in this state, ext4 enters an
unexpected internal state that causes the BUG to be triggered.

This can be reproduced on:

HEAD commit:

11439c4635edd669ae435eec308f4ab8a0804808

report: https://pastebin.com/raw/dNFvCatE

console output : https://pastebin.com/raw/LAPYKL5P

kernel config : https://pastebin.com/7hk2cU0G

C reproducer :https://pastebin.com/raw/v07yFCWP

Let me know if you need more details or testing.

Best regards,

Xianying

