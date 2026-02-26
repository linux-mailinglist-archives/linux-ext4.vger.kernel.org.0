Return-Path: <linux-ext4+bounces-14029-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKq7Adm6n2n5dQQAu9opvQ
	(envelope-from <linux-ext4+bounces-14029-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 04:15:37 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF891A066A
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 04:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 098253046120
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 03:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D238552F;
	Thu, 26 Feb 2026 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Pt3QESqe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB5311C38
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 03:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075734; cv=none; b=m50Lv6dFnLc1pN0hTvEtpZYWFaAaivzANliE/2bBgQAgS/C6Agj2Az04RLpYd1FWHmduLFJeQ/pYk5uVRsZzlD79jTvjlTNrTYiO0B+ckmCqydWTTEdtnHSpRCM3S4ReGqJEz+ZHDolOApMjIPaRG4s4cI5TqfmtN5T9Sue7HcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075734; c=relaxed/simple;
	bh=3Uj98JRcjkXg45L932sgBQ4jyAOkKnrA4eVXq0Mc2RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMPCGXbl2jhPEvUmcC5OcnOTP9TvLzHwXlht4Vs8ua4YT5ysFygBgxJok+19NfNFNJS3GfXQcS0tf41Zi++dVYCBBcbLmZfDfLCkfZUTqB0SznA0gT5MBhCYO4K2yNQoyUMVJccs7KdaBXOI/kMk+Q+i1AoseJlUMjpP0nqJdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Pt3QESqe; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f194e9a98so155587b6e.3
        for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 19:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772075731; x=1772680531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myOpzKKufRrzTXzkKkTioHHnRh1Fxba9oHbsZ8bSehI=;
        b=Pt3QESqeGYGEyfcbtu599/TaELTldNHt9ng7MdkbQscEZnkRuSh25I41b9c9dvwbs0
         pbRiegVYVhXxN6kv/Eg0EFcqolSkF8sW2dHcoxou+89/W6wTpoKs3MeS5dRmlnq0QHLz
         beD0NKXnUFkxdzpurznywZsv0jcAXSFUEZlDVEaGEZX/fH8nT2ZLRuRzU4wRZYWgAJYK
         HjXy/ScGA0aB6TeNRft1Dvn6Qb35HEKMPwb1Y7g7J2FWEhFtSj7eArl0e01dC8zPx26E
         xYJnhHsEiybj+rxDtRCtjALwF7rqZEnbad8aUzCkCd2gR90/cfeFhG91HuY5K4g9N7cT
         grQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772075731; x=1772680531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myOpzKKufRrzTXzkKkTioHHnRh1Fxba9oHbsZ8bSehI=;
        b=eLZkakgBZb+itfBJmUG37x9t5KiCUHIEbh/bkLXqxoHHb6ChBVk6Z0ECyRUZTgvjAt
         8Y7ywmMmfKTBBIsGtl3Jr8/uNlXyR2zMMAKoe1OaRHlN/oOjZ2Jra4+W8rBnILPupbgQ
         HwSw5/5d0Mwd6GhrQvSwq72ex7I4EoYf+qpqfgoK51Ks6CEL/W+qBM/M+nu0cE8oYnWx
         2bn8Nm6WUMrkW+GvWmi/LZ95IcKTifwr73AMmi/82QyX6OU01MsNC/8W+NYo/4TRkqbH
         Efj7ZpCxwPDaJSvILfNsl3l3fbbgUIoREQREeBbDHMpZyWsaA/Y4zLjOIBzyu5A96Ulr
         JG6g==
X-Forwarded-Encrypted: i=1; AJvYcCVH7cRVasP0d43qpWzbQbrSFUjvU/kaq3RDd3ThlzOSAY8zX05TSH4a8BkKmISW9fmQwar/tcuSLIPR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ie6cGXe+qsgW1JcEurn7UAsWfUG7lS90sqT73XjPfo8IUM12
	P+e1cYoI19cSvtgR2vEL5FY0+JD04gNT8QHluKVNTR9fMYs5JDmDEcT6NTHAlFRRE/o=
X-Gm-Gg: ATEYQzzp0XjeavKrdp3K265IVi+pbdLNSWOU+sJJEo/lQfHZ35B92ZJ2p3/VEHMMhfa
	gN4mdykJLB3mf/A53cid0zlqpXpDPkyYAh7ZAd9e0KRWpZR7FBpM0IC0k3SBIfUYAjuQiPNzTO/
	4c8g45veBZi78x+rllPzt0WSJSaMcH4ch3IZGOGxIO89NqiDC1lu6yQPIKt7xvWaV8otye/kz6/
	m1NfNDJ3WPrzHuGO/DgDCl/0+H6doL0dyJSqldMNUUkCG4cHFW3s+KNNKi8onU+LmqwRXC539HV
	gN3guT3JFCwGGZssnu3Gt21x7iJ0z3zuFxLxH2PR7otN7I+3tUFP2EA9/N/nuFp/m4B3j7RMDcG
	T0KgVf1mw8qAne6/I9egq9XlrcPcKx2jMANpSNPulxjfGhkO3aXwuH89GHZOYV0Sx5qX8gqaUTA
	haU6MpmvVoDxK9SrB9+nKwv7ndjFP0p9Uj/s/Pr1gCBWDqRmIv6lFZenf2opyJO0BQ0mpWJXvcC
	W+htQPDyQ==
X-Received: by 2002:a05:6808:320b:b0:462:d9a2:84e1 with SMTP id 5614622812f47-464463ef61fmr8794809b6e.60.1772075731397;
        Wed, 25 Feb 2026 19:15:31 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b240sm786090fac.8.2026.02.25.19.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 19:15:30 -0800 (PST)
Message-ID: <44e3e9ea-350b-4357-ba50-726e506feab5@kernel.dk>
Date: Wed, 25 Feb 2026 20:15:28 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] filemap: defer dropbehind invalidation from
 IRQ context
To: Matthew Wilcox <willy@infradead.org>
Cc: Tal Zussman <tz2294@columbia.edu>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Bob Copeland <me@bobcopeland.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
 <20260225-blk-dontcache-v2-1-70e7ac4f7108@columbia.edu>
 <c8078a80-f801-4f8a-b3cd-e2ccbfca1def@kernel.dk>
 <aZ-2G_6lDZePLSyx@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aZ-2G_6lDZePLSyx@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14029-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[columbia.edu,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,linux-foundation.org,vger.kernel.org,lists.sourceforge.net,lists.linux.dev,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel.dk:mid]
X-Rspamd-Queue-Id: 9FF891A066A
X-Rspamd-Action: no action

On 2/25/26 7:55 PM, Matthew Wilcox wrote:
> On Wed, Feb 25, 2026 at 03:52:41PM -0700, Jens Axboe wrote:
>> How well does this scale? I did a patch basically the same as this, but
>> not using a folio batch though. But the main sticking point was
>> dropbehind_lock contention, to the point where I left it alone and
>> thought "ok maybe we just do this when we're done with the awful
>> buffer_head stuff". What happens if you have N threads doing IO at the
>> same time to N block devices? I suspect it'll look absolutely terrible,
>> as each thread will be banging on that dropbehind_lock.
>>
>> One solution could potentially be to use per-cpu lists for this. If you
>> have N threads working on separate block devices, they will tend to be
>> sticky to their CPU anyway.
> 
> Back in 2021, I had Vishal look at switching the page cache from using
> hardirq-disabling locks to softirq-disabling locks [1].  Some of the
> feedback (which doesn't seem to be entirely findable on the lists ...)
> was that we'd be better off punting writeback completion from interrupt
> context to task context and going from spin_lock_irq() to spin_lock()
> rather than going to spin_lock_bh().
> 
> I recently saw something (possibly XFS?) promoting this idea again.
> And now there's this.  Perhaps the time has come to process all
> write-completions in task context, rather than everyone coming up with
> their own workqueues to solve their little piece of the problem?

Perhaps, even though the punting tends to suck... One idea I toyed with
but had to abandon due to fs freezeing was letting callers that process
completions in task context anyway just do the necessary work at that
time. There's literally nothing worse than having part of a completion
happen in IRQ, then punt parts of that to a worker, and need to wait for
the worker to finish whatever it needs to do - only to then wake the
target task. We can trivially do this in io_uring, as the actual
completion is posted from the task itself anyway. We just need to have
the task do the bottom half of the completion as well, rather than some
unrelated kthread worker.

I'd be worried a generic solution would be the worst of all worlds, as
it prevents optimizations that happen in eg iomap and other spots, where
only completions that absolutely need to happen in task context get
punted. There's a big difference between handling a completion inline vs
needing a round-trip to some worker to do it.

-- 
Jens Axboe

