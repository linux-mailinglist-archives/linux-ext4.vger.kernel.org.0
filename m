Return-Path: <linux-ext4+bounces-14299-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBJEEgh+pWm6CAYAu9opvQ
	(envelope-from <linux-ext4+bounces-14299-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 13:09:44 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBAA1D8182
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 13:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2873630293CF
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573223624D2;
	Mon,  2 Mar 2026 12:09:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE6284686;
	Mon,  2 Mar 2026 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453376; cv=none; b=tv6rOPYVlWhZGSAux3pQwr8gTuN7PNHW9/FvO++D7rsKjlfRRc6PZILggIzVUMOhJt8pMb+TCaNAmSVbku59OMIZsGBGIAyk7Bo1bH+N5gl5Q3pUofrmZi3txreeAPrOeJXLZDvweKongO8CeRh49zuxImuwo9tsJxlCqgiDIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453376; c=relaxed/simple;
	bh=SdKl2vCW7BNOcnzNoBnbypiyTH+FX+rlONTO2K2mitY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRTakR0ZV5MZm7y5EtAkF1uj5iBLlhxP8i36YKgprTg/25CXU3nUqtCt9IY5tDjkw9hQEDg+7iosxYXBgFYs0XjlLr9dztwZ3XPdkA3fWlYItdiMf89x1/ibaFVT5KSPeW+KOe8nXH/GpGO08yjGnwCQRj2LBAhgX1Y89tWP/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fPd555N0zzYQtmQ;
	Mon,  2 Mar 2026 20:08:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DAC9440539;
	Mon,  2 Mar 2026 20:09:29 +0800 (CST)
Received: from [10.174.178.253] (unknown [10.174.178.253])
	by APP4 (Coremail) with SMTP id gCh0CgBnE_T3faVpIMM6JQ--.684S3;
	Mon, 02 Mar 2026 20:09:29 +0800 (CST)
Message-ID: <c72a6c95-d06d-413c-8f9e-34e26610a39f@huaweicloud.com>
Date: Mon, 2 Mar 2026 20:09:27 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: gracefully abort instead of panicking on unlocked
 buffer
To: Milos Nikic <nikic.milos@gmail.com>, jack@suse.com, tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302003135.93802-1-nikic.milos@gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20260302003135.93802-1-nikic.milos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnE_T3faVpIMM6JQ--.684S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4Dtr4fZFyUZF17Cw15Arb_yoW8Xr1rpr
	ZYkay2vryvva4fAFnFqa1UWF4jg3Wvg34UGrZY9wn3Aa1UKwn3Wry7Kr1qgr1vyFW3Kw45
	Xr1UKrZ8G3y2ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14299-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,mit.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.830];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: ABBAA1D8182
X-Rspamd-Action: no action

On 3/2/2026 8:31 AM, Milos Nikic wrote:
> In jbd2_journal_get_create_access(), if the caller passes an unlocked
> buffer, the code currently triggers a fatal J_ASSERT.
> 
> While an unlocked buffer here is a clear API violation and a bug in the
> caller, crashing the entire system is an overly severe response. It brings
> down the whole machine for a localized filesystem inconsistency.
> 
> Replace the J_ASSERT with a WARN_ON_ONCE to capture the offending caller's
> stack trace, and return an error (-EINVAL). This allows the journal to
> gracefully abort the transaction, protecting data integrity without
> causing a kernel panic.
> 
> Signed-off-by: Milos Nikic <nikic.milos@gmail.com>

Thank you for the patch, this makes sense to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/transaction.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index dca4b5d8aaaa..04d17a5f2a82 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1302,7 +1302,12 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
>  		goto out;
>  	}
>  
> -	J_ASSERT_JH(jh, buffer_locked(jh2bh(jh)));
> +	if (WARN_ON_ONCE(!buffer_locked(jh2bh(jh)))) {
> +		err = -EINVAL;
> +		spin_unlock(&jh->b_state_lock);
> +		jbd2_journal_abort(journal, err);
> +		goto out;
> +	}
>  
>  	if (jh->b_transaction == NULL) {
>  		/*


