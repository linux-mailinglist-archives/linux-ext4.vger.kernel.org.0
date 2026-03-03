Return-Path: <linux-ext4+bounces-14576-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO63Lq4qp2nSfAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14576-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 19:38:38 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 314201F563E
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 19:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 088523010BB2
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ACC3CB2FB;
	Tue,  3 Mar 2026 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="o7bN5tno"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F6382F06
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563115; cv=none; b=QD7stq9nzbFOmgjJzMrBRNOPTRyzykm6V7KBCHqplXXidiSIBpDPkhZ/EYf6mbz1h8Sxp0iPPC7Ce3arhmKy2xg+MlX/W+4ygV2fhYfEv8gOZpIuXEgNfQ/iBH+kpdudJ9X6AOMqQ0uqrHPCPMkGUwUA7d15VB7w33hEE7dBVCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563115; c=relaxed/simple;
	bh=kiTK4rHfOL3QhVqin5WZZ1wmOh/hB7rK3J7Kr7t5Otw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ys2qKnU+8aHc8pZ8pEcNxGLfVIqpG1B5UWmWi9BO3tYWhiR2RAoNIrFC7NVsNrFLpZRKrFKRjazC6eVmeq4mNGy4+1jeSvt0cRHmgI5xzk/x+xX3diTr/91/2+hRI40WnVKGqaOvBrFpwlgfmnwRis7bjXJ+exT2DGUXIp/Da5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=o7bN5tno; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae43042ea7so33386675ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 03 Mar 2026 10:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1772563114; x=1773167914; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJPHr58XJoOjF4oWsM5xXqTpCc5Yqk6AU7WaoOd8DYM=;
        b=o7bN5tnoB1du/9jSz3NXo53WVjEYQTYl4nFfR6D1/kE5tyD+R2zl5uxPdQJLHyxN0X
         fMyegtdE30NF9npyhNTp4NGVHmPRmWL4piuDmG8gwuEJG9MuUOSsXCRfNP+xCQYy5xyg
         9K+DbJP5YLFuif5fGPHThfBNf8oXuWGaHm7wlFnEQj2gMGMirF+GC+Qr+0T5zk0j3NPJ
         ZmI1fHRTpt25W/wGov72Zsf5DebrzD+ykd79WbnUY+fSWmszRDQae09cHk26VI1TXZi3
         2/FyUIztwaTRzkLBIfezZDdqv/TX+FodfrLB9pzaKlm7NWRxs8HapA+mwbzG1BWmi/nz
         gkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563114; x=1773167914;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJPHr58XJoOjF4oWsM5xXqTpCc5Yqk6AU7WaoOd8DYM=;
        b=g9hse5yeZYJlGbo4KOqJu0HsDO1N/aWMeC5uHBTVak5apUNR4mFlKjxB8aK8maMj8g
         Dlxg6Yq4qiVthaNW6YRs/tdSXy8B4Xm3HOhBmoZSVc+Kgnbq0keLVs34cI717gm7sYyO
         w1YkXVxnyv7RSFrJnC9XUypXRENwKXMZZ9OFF+INKbK2Jn215GspidMvdFHXj24sfwTA
         V6R9sVGtAyBHlDJJP8e1qnCvmQnf9h2CHJ6uPbN47IDHx7GXZjF8eDixQhLw1dtvECrd
         cLdwNGPzjLYCGda7xes98S5gLd/OvNy4OulwgFQ95TCow2KF/1+ETasr6c517BNCvd6U
         Nyhg==
X-Gm-Message-State: AOJu0YxVWnF5/cEvOTSp4iUaDFi3tm9W59OR0nGHkA0ZycZmxGAYXHri
	gJMqAwBYaoijgPhX3G2VeyUpQNrwV0fJ2usGID0O9+y/3mcZ0OPbR5K2WZTxd0WxWlJOPDxg99i
	uJHOHJS8=
X-Gm-Gg: ATEYQzyeTPLsbpwgRxIOOoJyh1gJtmKD/R/VmYN2EmBIwGxRbTr/RURv3ifHNQU+4Ar
	KsN54D6iap8oPBDlpIgfrlL5kB7gmsfBPvWDyAujmddnkxxeRKmyWXlTFYvlATJs7Cjxpi2oWJC
	ko4FxgqC/lV43J9mH6veqDuWnCX6bNNSqi4jNFNntv7KAI2QArwUX295vpx+3SBbH5gtgBIKvZm
	DzKL7jGVr9esTwDXIqtuF9yaSireNn56yUerB21hxRjEMsQy7w8Qo0/oLyEGtyJts7GjmdPOPH3
	SlvHXnGHbcJWdNGf9868PaZsyMz7j6TZlBru9bAHopLKGq3fep2LH/PPiO20NEYGlA5TwvSXpp4
	kgOMLLTiQczXw/6tyLQRxk3NXWt8zXMIv4QeGCrF4gFkZMNRO3v0spFJXmqNCp6r5VhCiRp4+m2
	f7WxFoNgDRPaRWLiOrxazX7N2zBqWwvpdN078Gui7w1Gpn0V9q5qaAjDuPCZ3jbbjcViQaqlEVr
	3StgQ==
X-Received: by 2002:a17:903:4b47:b0:2ae:57e2:9b44 with SMTP id d9443c01a7336-2ae57e29d83mr55320635ad.43.1772563113671;
        Tue, 03 Mar 2026 10:38:33 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4b782c53sm77205495ad.41.2026.03.03.10.38.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2026 10:38:33 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH 1/1] filefrag: fix fibmap error message
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260303115637.453629-2-dxdt@dev.snart.me>
Date: Tue, 3 Mar 2026 11:38:22 -0700
Cc: linux-ext4@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EADED599-9316-41A9-B5CD-7C8869DEDD95@dilger.ca>
References: <20260303115637.453629-1-dxdt@dev.snart.me>
 <20260303115637.453629-2-dxdt@dev.snart.me>
To: David Timber <dxdt@dev.snart.me>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Queue-Id: 314201F563E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14576-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[dilger.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dilger-ca.20230601.gappssmtp.com:dkim,snart.me:email,dilger.ca:mid,dilger.ca:email]
X-Rspamd-Action: no action

On Mar 3, 2026, at 04:55, David Timber <dxdt@dev.snart.me> wrote:
> 
> When an errno other than EINVAL, ENOTTY or EPERM is returned from FIBMAP
> ioctl, the negative errno is passsed to strerror(), which only accepts
> positive errno values.
> 
> Signed-off-by: David Timber <dxdt@dev.snart.me>

Reviewed-by: Andreas Dilger <adilger@dilger.ca <mailto:adilger@dilger.ca>>

> ---
> misc/filefrag.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/misc/filefrag.c b/misc/filefrag.c
> index 4641714c..d45288cd 100644
> --- a/misc/filefrag.c
> +++ b/misc/filefrag.c
> @@ -517,7 +517,7 @@ static int frag_report(const char *filename)
> filename);
>  			} else {
>  				fprintf(stderr, "%s: FIBMAP error: %s",
> -					filename, strerror(expected));
> +					filename, strerror(-expected));
>  			}
>  			rc = expected;
>  			goto out_close;
> -- 
> 2.53.0.1.ga224b40d3f.dirty
> 
> 


