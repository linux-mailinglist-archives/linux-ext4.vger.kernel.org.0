Return-Path: <linux-ext4+bounces-5973-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7933DA050F9
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 03:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E4B7A1F28
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 02:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A911632D9;
	Wed,  8 Jan 2025 02:46:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743E2594B9;
	Wed,  8 Jan 2025 02:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304372; cv=none; b=XkbFS7hJ1SpW3nv0FDbqlIptsskSFzLvI141rU45+kdi9byzwfcHXColDg9yKR8LWtATX9FW1z5Ks9v+yilgXdLUn5lx8hfH8ZIIxpZ51PShoUGP/dLClrfTthp0P3TOOFEliR6Ak4n0C9uv9vfHt+/OebUnDO6RsKiQSTMpjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304372; c=relaxed/simple;
	bh=4QLVpUvIo78RGWWlydmvjB7MKHaJnEr2+s94lopxKgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YgqReBvMhDuwHtIAO5TZS8EKcRuunZIhAQABeide/aZyf3RL5zrSSo2jjxS8enzemUyT/+XXKtC/Hso1LRMTTCeiGB6NRS53YkvsCJ+xauVeGzUpCVD4s1XqRkUsshjLrHj+HUS5Fo0WQ6sDfmtCps2oLX2GcepfjlcZiigYTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YSXK54zVMz2Djyk;
	Wed,  8 Jan 2025 10:43:05 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id A72F81400CB;
	Wed,  8 Jan 2025 10:46:06 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Jan 2025 10:46:05 +0800
Message-ID: <ed2fa122-4907-4463-a38c-3544ffd00440@huawei.com>
Date: Wed, 8 Jan 2025 10:46:05 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] jbd2: remove unused return value of do_readahead
To: Kemeng Shi <shikemeng@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <jack@suse.com>
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-4-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20241224202707.1530558-4-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/12/25 4:27, Kemeng Shi wrote:
> Remove unused return value of do_readahead.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/recovery.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 9192be7c19d8..a671f8ee7dd2 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -65,9 +65,8 @@ static void journal_brelse_array(struct buffer_head *b[], int n)
>   */
>  
>  #define MAXBUF 8
> -static int do_readahead(journal_t *journal, unsigned int start)
> +static void do_readahead(journal_t *journal, unsigned int start)
>  {
> -	int err;
>  	unsigned int max, nbufs, next;
>  	unsigned long long blocknr;
>  	struct buffer_head *bh;
> @@ -85,7 +84,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
>  	nbufs = 0;
>  
>  	for (next = start; next < max; next++) {
> -		err = jbd2_journal_bmap(journal, next, &blocknr);
> +		int err = jbd2_journal_bmap(journal, next, &blocknr);
>  
>  		if (err) {
>  			printk(KERN_ERR "JBD2: bad block at offset %u\n",
> @@ -94,10 +93,8 @@ static int do_readahead(journal_t *journal, unsigned int start)
>  		}
>  
>  		bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
> -		if (!bh) {
> -			err = -ENOMEM;
> +		if (!bh)
>  			goto failed;
> -		}
>  
>  		if (!buffer_uptodate(bh) && !buffer_locked(bh)) {
>  			bufs[nbufs++] = bh;
> @@ -112,12 +109,10 @@ static int do_readahead(journal_t *journal, unsigned int start)
>  
>  	if (nbufs)
>  		bh_readahead_batch(nbufs, bufs, 0);
> -	err = 0;
>  
>  failed:
>  	if (nbufs)
>  		journal_brelse_array(bufs, nbufs);
> -	return err;
>  }
>  
>  #endif /* __KERNEL__ */


