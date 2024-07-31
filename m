Return-Path: <linux-ext4+bounces-3546-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2BA942658
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 08:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C063B24A52
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 06:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCE516CD18;
	Wed, 31 Jul 2024 06:17:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248E61FDF;
	Wed, 31 Jul 2024 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406656; cv=none; b=s+6flaNfFBSFZ24SzATt/eKrB5TcuLUF1mJEoBSQGiBqKTyXLMOFxNTpPvEq9sRXP75aJ9lOlMjU4JhIo2RWiuUG6YE0DB3FsL+a5JYpnrabfTLpAT5mU03bVdwqJp8xf7rZvAE4aKlGpEECVCFrnkMiZwhj8KEa5pz6NzFwriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406656; c=relaxed/simple;
	bh=YM/SgtpE2smUDyS2bmA9l0A/LX9fLBtn3R6YCrgqOgM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZMBo5fiUAF4Gc5+4ubP/9NoTD+cshc1KZFOWQ0LDGsSlmmNuZB5BE77407SIde+/clwikTBvSvL8WFlnE0huBQwRXTftgts4Jf84aMtSUYDsgp4KH0nkfQUHod/ml3aFaYsNQKlPSSFvY1ZbE0qrxxf6k1taxURgrCiqokKBB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WYhhT4y9Yz4f3jrq;
	Wed, 31 Jul 2024 14:17:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 945071A018D;
	Wed, 31 Jul 2024 14:17:26 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoT01qlmsONnAQ--.46040S3;
	Wed, 31 Jul 2024 14:17:26 +0800 (CST)
Subject: Re: [PATCH 7/7] jbd2: remove unneeded check of ret in jbd2_fc_get_buf
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-8-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <a5da8406-ed52-b71f-4766-a16e8d175496@huaweicloud.com>
Date: Wed, 31 Jul 2024 14:17:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240730113335.2365290-8-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXPoT01qlmsONnAQ--.46040S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy5ZF4kGw4kZr1rKFyDJrb_yoWDCrc_Xr
	W8Zr9rZrZxWF1rAF4rC3y8WrnIqws7Zr1kW34xt397KF1Uta1Yq348trW5K39rJF92yr43
	A3Wa9w40kr9rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7
	UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/7/30 19:33, Kemeng Shi wrote:
> Simply return -EINVAL if j_fc_off is invalid to avoid repeated check of
> ret.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/jbd2/journal.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index dc18b9f7c999..6f90f7b8e9e5 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -842,12 +842,8 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
>  		fc_off = journal->j_fc_off;
>  		blocknr = journal->j_fc_first + fc_off;
>  		journal->j_fc_off++;
> -	} else {
> -		ret = -EINVAL;
> -	}
> -
> -	if (ret)
> -		return ret;
> +	} else
> +		return -EINVAL;
>  

I'd like this style, just a suggestion.

	if (journal->j_fc_off + journal->j_fc_first >= journal->j_fc_last)
		return -EINVAL;

	fc_off = journal->j_fc_off;
	blocknr = journal->j_fc_first + fc_off;
	journal->j_fc_off++;

	...

Thanks,
Yi.


>  	ret = jbd2_journal_bmap(journal, blocknr, &pblock);
>  	if (ret)
> 


