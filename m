Return-Path: <linux-ext4+bounces-14471-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHxUHLA/pmkZNAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14471-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 02:56:00 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1B81E7DBA
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 02:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9337230743CE
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 01:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4FD373BE4;
	Tue,  3 Mar 2026 01:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EHRbEgKC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BF2282F27
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 01:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502956; cv=none; b=bGxwn06b9/IxioA71y+MDUJlw7ln6ZGdAVuEK79lLmUGottJLT1fErCKbHOcCdN/4f5CkQoZhMI+qyHOv+KkEv3XiHAaOrYSDzA4jxxh8PDQSjtSbSGTDlKY2TxWm8437WRQMM1O2QM7SDQ17IU2rAqIKvPEc5uhBHDRjrjdYts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502956; c=relaxed/simple;
	bh=7xMQmdykjNEjdwemZwhaQn5gi/74+H9bg1NU0yjB2tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfEboulv9q1I1/NryO7Is8ONzfEoKXyykRAWX620miag1D0Sx7UclYuZaCJmrQvCFsgyLKGmh4ITpNOTSIjZsHnZmlXDb7E0ct4ImhMXw2uopy6Tk4yFsRUnSpwC3v1jQ/xRKBO+tvp6ThHBGY215k/AJAQkmn7uVa0L5pf/Tco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EHRbEgKC; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772502950; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BU9i7ek1rGiqJNvhWqYgIHcjwcXJLXQu5iL1st1pQ0g=;
	b=EHRbEgKCvJkifmYBlmY0ADZOS+Z0ZSaf+azI8iG5NmxHgouDF3oCp6cXYYlYw8Ff7/znqqetiZOFjGu7PuFaDJO16EQCPgkEyrdPe8wpQqTLRMrXV9kpH67Kx3vq907Q2e9O85KPAAKCgo76dY2z9UQS2vWEUOEt+UKiNpbIvG8=
Received: from 30.221.146.232(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X-80Zrx_1772502948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 09:55:49 +0800
Message-ID: <765b1b39-3043-4a24-ba74-5e018071455e@linux.alibaba.com>
Date: Tue, 3 Mar 2026 09:55:48 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: Minor fix for ext4_split_extent_zeroout()
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
References: <20260302143811.605174-1-ojaswin@linux.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260302143811.605174-1-ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AF1B81E7DBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14471-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,vger.kernel.org,mit.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[libaokun@linux.alibaba.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Action: no action


On 3/2/26 10:38 PM, Ojaswin Mujoo wrote:
> We missed storing the error which triggerd smatch warning:
>
> 	fs/ext4/extents.c:3369 ext4_split_extent_zeroout()
> 	warn: duplicate zero check 'err' (previous on line 3363)
>
> fs/ext4/extents.c
>     3361
>     3362         err = ext4_ext_get_access(handle, inode, path + depth);
>     3363         if (err)
>     3364                 return err;
>     3365
>     3366         ext4_ext_mark_initialized(ex);
>     3367
>     3368         ext4_ext_dirty(handle, inode, path + depth);
> --> 3369         if (err)
>     3370                 return err;
>     3371
>     3372         return 0;
>     3373 }
>
> Fix it by correctly storing the err value from ext4_ext_dirty().
>
> Link: https://lore.kernel.org/all/aYXvVgPnKltX79KE@stanley.mountain/
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: a985e07c26455 ("ext4: refactor zeroout path and handle all cases")
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Looks good to me.

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
> ---
>  fs/ext4/extents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3630b27e4fd7..5579e0e68c0f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3365,7 +3365,7 @@ static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
>  
>  	ext4_ext_mark_initialized(ex);
>  
> -	ext4_ext_dirty(handle, inode, path + depth);
> +	err = ext4_ext_dirty(handle, inode, path + depth);
>  	if (err)
>  		return err;
>  

