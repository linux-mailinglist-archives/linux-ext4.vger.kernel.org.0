Return-Path: <linux-ext4+bounces-14702-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TDwlCkjfq2k6hgEAu9opvQ
	(envelope-from <linux-ext4+bounces-14702-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Mar 2026 09:18:16 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F52422AB83
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Mar 2026 09:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06DF302A07F
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Mar 2026 08:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425C1384256;
	Sat,  7 Mar 2026 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyad9ST6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE629ACDB
	for <linux-ext4@vger.kernel.org>; Sat,  7 Mar 2026 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772871490; cv=none; b=J3FK7XNyE3bq8c03CGcounchlmgeUBfSm0vWt6/+0elTwYWCbxpuvIDk4C11OoznQj0yAnEYxAOlzS0DRk6d1PJmbeiLONx82KZIIYpijpQzYD/g9NJ6qFhOQvQ/FzlW7Va99oALqk9edF03KLDed3ckvcXaid0C7FDm/iBqyy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772871490; c=relaxed/simple;
	bh=hBuyGwL0xhe6KROE2uMJRmU1RUe4/vpRVEVsq3Onkc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBB9CvIFN9pxF6Tx9t8zNGNovPnlS2W+rx75MWzV4KE23hyr5vEvqTdrivkrejBdS486OaDe4xmJMCiPT+3ReaP8ntoY23ErN8BbAAmRy2iHuEITPwLdoedIRHv6WRJVjjjzG9i4aa5uCiYk5ssN8fO3cRfyBl7T0yUUm5Vn3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyad9ST6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaed195901so46223985ad.0
        for <linux-ext4@vger.kernel.org>; Sat, 07 Mar 2026 00:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772871489; x=1773476289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3MB1ODOedj3u5IFZ/ZLKUJ3VFXUi8vUhgRffRp8hIwE=;
        b=iyad9ST6k6DHPq3mfYnoOlA4JyDCyRsZnuElFTAJK5PUILnfyJTR/OK+oZOBA8EEtx
         ux/m87TqiCvODAYTZpe+eBW1KxDXkUf/j9pgCNma0thAUDSolaKRWj+UtbxNNiebbWNh
         aUAYcbCyBkY9nIOdpDUv8VoJN087T9ipacexng7GlyGoNJPEhRY7eeJFNlVIzhm9PB9+
         GdMPnUgw93sDuBzzv/1RPAVubbubGSStEOvBg5robWveUQJnKlUwrgdAhDYQLhfwLY5T
         MFX7t93ZJoZJOVX4vkQzWDjj1/BGL4BwarqWOX3zfZ4aPFElmsjGhFZNEkON6GINtgPi
         NxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772871489; x=1773476289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MB1ODOedj3u5IFZ/ZLKUJ3VFXUi8vUhgRffRp8hIwE=;
        b=LNMWKZBja4iVPGeLGbYoZoEggwWaUPNDoD3bOcFtKuoZqFMELpaXNZ8w38K6SQr2g7
         iq3N4V8uJBqb6xSFej30AfVswEZGl8rjoHoTTDU+IC6EtS0Za7N+1d9HqQI3Hiw37zcO
         wbZsY1NZkMYmsl1XuNbuF74e5NP7yaAH5Dg/Bp0cMbrqINCWYH8fUYd7/wOfUY83JHz3
         M2LmnqooSJk7lqCMs27PEyQLLylGkADZIqrOtT4rsKLDmSpz+rfON8GQpunLRmFH7b9s
         ZgQx0bPDOs26IjmuCYznxhChvQ41Nm7SyPBcMmRd+DT6R7tfqp0MDoYY35yLcQERlEQT
         DshA==
X-Forwarded-Encrypted: i=1; AJvYcCWzOMJFySVuYxT8oMTtuVUpKalqjj5P1E3iXBgCnAxL6ZCK25RPu4qf+v9KQ8IFrhNoaasFk7utTryr@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKR7UdIfoc1ss/j7nkxcknohfbxTM8oR99zgz+osm4tlUXjwT
	MUAzzHUY0oWXuQsj7OFHoKN6VYCAAtCwYkAYbCOutJSMw4q6uicIDzyr
X-Gm-Gg: ATEYQzxqx+CVTXoGL7QnnMHEyrsdUPCwSAd32XiV883VQbPQy4RojEVZc3SfUzfsh/z
	ktHZyiYFG6kfekWpvbri6O2EbCORvc5OCgABKYy3gjcf4G23UNIb1HuOtK5zJehiaQyZYHaDp4s
	0an5OrfcL3p4WXotarxvv9OxI5UQSOpw86BoXkssWDe1duleYdRvO6K7uA8d7Ot1r14st337SAv
	5SbKbdSMTGQsOwS12YpsLoGTqoLQ8oOGbqaiQYzc45WaeCJ2NdjXGzZv6MZpMVR5K8HNrA7K+MA
	PVslY8cC+nRtYRohCoc98O2XwvdHeJsncq+tjR0TfvMOeClQm/YV6OTU/m6QT4M3zlDTma0Q7AL
	o3/ODjfWa6rWGdLhv4uuLTHv3QvIFMdNJ3zOU8nXFjTARWUtm8JEzuSSdfH2nUuXe1nuwA4zlmr
	C1vMOLQalwZZCz/i9C0PATWg5zKn372hcO3LE66rPfy8taQOVVezW19XbWoDwLERj/IWMD83o=
X-Received: by 2002:a17:902:d54f:b0:2a9:e8b:5326 with SMTP id d9443c01a7336-2ae823a4d58mr50118705ad.23.1772871488753;
        Sat, 07 Mar 2026 00:18:08 -0800 (PST)
Received: from ?IPV6:240e:390:a95:2e11:18d:20df:3e54:826f? ([240e:390:a95:2e11:18d:20df:3e54:826f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840adb42sm58708915ad.81.2026.03.07.00.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 00:18:08 -0800 (PST)
Message-ID: <68b57b78-6ae4-4bef-86ce-63a4d9540f5e@gmail.com>
Date: Sat, 7 Mar 2026 16:18:02 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: Minor fix for ext4_split_extent_zeroout()
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <20260302143811.605174-1-ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20260302143811.605174-1-ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6F52422AB83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14702-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhang089@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email,huawei.com:email]
X-Rspamd-Action: no action

On 3/2/2026 10:38 PM, Ojaswin Mujoo wrote:
> We missed storing the error which triggerd smatch warning:
> 
> 	fs/ext4/extents.c:3369 ext4_split_extent_zeroout()
> 	warn: duplicate zero check 'err' (previous on line 3363)
> 
> fs/ext4/extents.c
>      3361
>      3362         err = ext4_ext_get_access(handle, inode, path + depth);
>      3363         if (err)
>      3364                 return err;
>      3365
>      3366         ext4_ext_mark_initialized(ex);
>      3367
>      3368         ext4_ext_dirty(handle, inode, path + depth);
> --> 3369         if (err)
>      3370                 return err;
>      3371
>      3372         return 0;
>      3373 }
> 
> Fix it by correctly storing the err value from ext4_ext_dirty().
> 
> Link: https://lore.kernel.org/all/aYXvVgPnKltX79KE@stanley.mountain/
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: a985e07c26455 ("ext4: refactor zeroout path and handle all cases")
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/extents.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3630b27e4fd7..5579e0e68c0f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3365,7 +3365,7 @@ static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
>   
>   	ext4_ext_mark_initialized(ex);
>   
> -	ext4_ext_dirty(handle, inode, path + depth);
> +	err = ext4_ext_dirty(handle, inode, path + depth);
>   	if (err)
>   		return err;
>   


