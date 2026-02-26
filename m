Return-Path: <linux-ext4+bounces-14044-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7IYXFN43oGmOgwQAu9opvQ
	(envelope-from <linux-ext4+bounces-14044-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 13:09:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB8B1A5936
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 13:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8C9A30804DB
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 12:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE193803EC;
	Thu, 26 Feb 2026 12:08:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC485378D80;
	Thu, 26 Feb 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107729; cv=none; b=VtqTWptqr9aEUszZLCd/qoxpRGqAJbDQYnN6O2PaPLGuKY1o8BVxcefN347SqgqQf6lxicLbKHBqFdiFR7H9m6+1UcUilpUelWShpaRJPwOZgd1HoKxeiKF8466r3sFRJAoazHIrjvnCN5p90PtaONiDjhSpwR809RHaccHEhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107729; c=relaxed/simple;
	bh=wJH07GsSrk5aNgD5JNBTQ8pTvLhFhbcFCDwX7t8RET8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDiXYjA+4TKoqHvxn+dxfLwRnhgXI3sXCwo7D82hwjRhu2fosoJmqdT0E7pZAUNn7SJtc0xcEYEEM6TtPsPT+w4jf4KM05qK3QY5c3XM6XlWsCLfr7cZqZFdnBKnu1goULMaKGFpypwgOqE1ITNcWhKMv5+usO8hQbhz5BKeb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fM9GB140HzYQv8C;
	Thu, 26 Feb 2026 20:08:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7C16840574;
	Thu, 26 Feb 2026 20:08:43 +0800 (CST)
Received: from [10.174.178.253] (unknown [10.174.178.253])
	by APP4 (Coremail) with SMTP id gCh0CgBnFvfJN6Bp6r9RIw--.15725S3;
	Thu, 26 Feb 2026 20:08:43 +0800 (CST)
Message-ID: <248b3b7d-3f69-44db-8914-f2e187cc010c@huaweicloud.com>
Date: Thu, 26 Feb 2026 20:08:41 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4/move_extent: use folio_next_pos()
To: Julia Lawall <Julia.Lawall@inria.fr>, Theodore Ts'o <tytso@mit.edu>,
 Matthew Wilcox <willy@infradead.org>
Cc: kernel-janitors@vger.kernel.org, Andreas Dilger
 <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260222125049.1309075-1-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20260222125049.1309075-1-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnFvfJN6Bp6r9RIw--.15725S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw13uF43ZF13WF4rXF47Arb_yoW8Gw1fpr
	W0kFn09rWkAwnrCa17X3W2qr1UK390qr4DJa1a9a13AF98JF9Y9rZ8Ka1j9a4FkryDGryf
	Jana9a48X3ZxCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-14044-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 7BB8B1A5936
X-Rspamd-Action: no action

On 2/22/2026 8:50 PM, Julia Lawall wrote:
> A series of patches such as commit 60a70e61430b ("mm: Use
> folio_next_pos()") replace folio_pos() + folio_size() by
> folio_next_pos().  The former performs x << z + y << z while
> the latter performs (x + y) << z, which is slightly more
> efficient. This case was not taken into account, perhaps
> because the argument is not named folio.
> 
> The change was performed using the following Coccinelle
> semantic patch:
> 
> @@
> expression folio;
> @@
> 
> - folio_pos(folio) + folio_size(folio)
> + folio_next_pos(folio)
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Thank you for the patch. Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> 
> ---
>  fs/ext4/move_extent.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -u -p a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -224,8 +224,8 @@ static int mext_move_begin(struct mext_d
>  	}
>  
>  	/* Adjust the moving length according to the length of shorter folio. */
> -	move_len = umin(folio_pos(folio[0]) + folio_size(folio[0]) - orig_pos,
> -			folio_pos(folio[1]) + folio_size(folio[1]) - donor_pos);
> +	move_len = umin(folio_next_pos(folio[0]) - orig_pos,
> +			folio_next_pos(folio[1]) - donor_pos);
>  	move_len >>= blkbits;
>  	if (move_len < mext->orig_map.m_len)
>  		mext->orig_map.m_len = move_len;
> 
> 
> 


