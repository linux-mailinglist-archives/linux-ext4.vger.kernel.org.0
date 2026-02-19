Return-Path: <linux-ext4+bounces-13750-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAA5MEcrl2nmvQIAu9opvQ
	(envelope-from <linux-ext4+bounces-13750-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 16:24:55 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 793FF160172
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DDBF301410D
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691A73446C4;
	Thu, 19 Feb 2026 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rP+SJ6It"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B9340293
	for <linux-ext4@vger.kernel.org>; Thu, 19 Feb 2026 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514684; cv=none; b=t+cAbG/elfNLQ+lbrkaUxbRrssay3XwuXhtRBJyz/viQCInC+7KNHgMW7KKD5M3xp+DMW6WArwOdpG2fq6XQxNyEVk7BvXMrGbGFR4XXlSe9IlsShp+wHVtDUskD0Lx/W0egnOF53N81JMh2uqt4uWWIv2xbQG1h08avM8dRTxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514684; c=relaxed/simple;
	bh=lDifLTAx9n9Mk40OXQsRSz1vGqgpmvsXnNPyhYBsb2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoaTNuQVcpSJulCovDWaDGEYiRHiQOxSztyMi1EvClp1hjtJ8Pg2z3VwPTPLZycH6/hUphsqrJnVx13rfBHpTFts0L5EjnSyb8yk/k6Zn6z0etqUc13MO8f+7SrsWdy5w5bu7reP8i1nAd5UsaG2ufxqPuufzMWTj4vUyd+IP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rP+SJ6It; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40974bf7781so1502937fac.0
        for <linux-ext4@vger.kernel.org>; Thu, 19 Feb 2026 07:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771514682; x=1772119482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgHRaYW1iBhNDu18vHtaVid1O4fLAXLvbx6+OcL28Ko=;
        b=rP+SJ6ItQ9+0oGu8v1SHmgBL4tJPjuYcoaOv5KD+xlf3WnkdeLuTqOJ/ER1KI9Hiv0
         b5xbALEcDaZcaBaQl5lWsqZsKUTKvmDsssgoTAXxkyIYNsw4sFvAbuBrS108+yvOQUad
         ufv/VdRFxhOXTA9fnFMG2aptWNcOMGbFNFIKVtsPuPQ8wAqe5HQVw8bQ9r404Qq2//5q
         CnMJJxql8Zlz2BogV1j1RO3VQ2pIpu4LnAU0OSv76EEtD4Vs/T1m6Dm6nfO+nlDqxVxS
         k8QG3Qewz8+CgiotrlTtKA6BbBgBX915w4QJ/xpfzZmQstCXb4Nb+gITYVJu8cL+q94r
         I9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771514682; x=1772119482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgHRaYW1iBhNDu18vHtaVid1O4fLAXLvbx6+OcL28Ko=;
        b=ig/8/hEK7UlJut81npEj+I5Bg3XkdIsjE/RzoN5yI3tVATaVzi9xzCQG/l4w0bZxsz
         B2Fz/jm1Sf5k1M88tVpbPENFDNsFe5zxE1q9KB8C5sUx7A0PB/QN2L816wWGbqFAA22b
         FUa2aOPPl+Qwjw9FAp3Ph5s9SdWzD6Z653DHpOhu+v6BwiE7wP6pcpQoYJKpFTVX9sXG
         Hn8rDAyAoklFtZSHK8NIhk5LlGSI10RvqBtee3HD0Y9PETBgfCsz7vPqg/8N8t4Ztv2f
         Xzcgw0nhWh/LztCyy9WcRpdPv09PAwOR2av/P3KgaF7ca/ezUBQ1rl0lD0v5GFcUU4x2
         VdNA==
X-Forwarded-Encrypted: i=1; AJvYcCW8SS40paNA/Rnc6iHZlgkuPlPHpaMwOpanes4NpVABXOI3Kk6Lc9JCXauw9h4Rh5HChTt6fjIL6mGD@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMoU2JQXGnvBDWqyZwKH02VkgMMZZ5lmmx24a/jnVTwXy7Vkh
	w/YDKjKV7SbGNpP4dbU5GBxESHFZgaQp10jgHgUatlgHvhHo/GBrxhYbIA0LrvcsM2w=
X-Gm-Gg: AZuq6aKHuS5kRktTU1uC1P4t/rXHN9pE+lhNhB+tRPXwZLhjV/PkCpkoBYPk9j/M6yC
	qV4Yvat4lmWEeVXF9BLDJ3hBzTOP79zTzL5i8yzUnolesVnQzp/TFWTaF4/8v5UT3dyAO4OsBXS
	9mTe1GIqhcnE50fuMv/Ssca0ZylVXwiBYKeeBU42sLQ9fXyqF1uBd9KgMlHTJYOx3Hdfcn5DNeX
	raGI/8D5uXf7gyi5gvOeBZpvx181Zse8PtCPGj2dCe/SrG6sdzLsekTeNGhrZ7Qh8jMhc6mmVFc
	qe20WDH8HZ2C2KLwzip5AQKMcUvlm/JoBQk7tr5/Et02sYNjrL5wNvFqmCAt6GTcUNpEoKTHFHI
	k/AkipjL5M1BaZuPPyMMzOX9yFJETCdrtteBG7qiZTqJwtO7c2RcP8iKRasElrQojMT1Lknv8U4
	R7XazBoHvueQGYyaKPaxk7NjbYcYgWhHqNaIbvCbTFCOQ/exY8V5ChrDb5Z53XKCA9hv9eiD03c
	TNt4O1KR4E=
X-Received: by 2002:a05:6870:a0ad:b0:414:9285:c243 with SMTP id 586e51a60fabf-41545713115mr1093784fac.21.1771514681487;
        Thu, 19 Feb 2026 07:24:41 -0800 (PST)
Received: from [172.25.209.35] ([187.199.77.89])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40f062ee328sm17955312fac.4.2026.02.19.07.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 07:24:40 -0800 (PST)
Message-ID: <35866783-2312-4e31-904d-3746510eaf56@kernel.dk>
Date: Thu, 19 Feb 2026 08:24:38 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] block: enable RWF_DONTCACHE for block devices
To: Tal Zussman <tz2294@columbia.edu>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Bob Copeland <me@bobcopeland.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net
References: <20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260218-blk-dontcache-v1-1-fad6675ef71f@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13750-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[columbia.edu,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 793FF160172
X-Rspamd-Action: no action

On 2/18/26 2:13 PM, Tal Zussman wrote:
> Block device buffered reads and writes already pass through
> filemap_read() and iomap_file_buffered_write() respectively, both of
> which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
> by setting FOP_DONTCACHE in def_blk_fops.
> 
> For CONFIG_BUFFER_HEAD paths, thread the kiocb through
> block_write_begin() so that buffer_head-based I/O can use DONTCACHE
> behavior as well. Callers without a kiocb context (e.g. nilfs2 recovery)
> pass NULL, which preserves the existing behavior.
> 
> This support is useful for databases that operate on raw block devices,
> among other userspace applications.

OOO right now so I'll take a real look when I'm back, but when I
originally did this work, it's not the issue side that's the issue. It's
the pruning done from completion context, and you need to ensure that's
sane context for that (non-irq).

-- 
Jens Axboe

