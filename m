Return-Path: <linux-ext4+bounces-2328-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EE08BD085
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 16:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F711F2667E
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E9F15351C;
	Mon,  6 May 2024 14:42:10 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9D1534FC;
	Mon,  6 May 2024 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006530; cv=none; b=h7liOcoCC0xgevAU1HID1d144WkmaYvXZFoD62LrfyhuR9GgVdLBlyYAEMGJv20/ald5NJOSv7o+qdNumIELvSyDZ84Aqk6HS5fa0rjJJShb1zDBNkeMKQRo3On1nau+Pk33cSbu6+AQJgNycdDoG2i9fOsegkbbDjhl7jnQ8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006530; c=relaxed/simple;
	bh=mpA6pGIU8VJt7O65eli8d//jyThHUXVd66pNKG1SZn8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T3f2ZTZaykMe1vKoZgUlWEAyxoKdxAoZ7mlDKF1lYqjCQrXowGDhSq8d/u66ks4/P2UYidSsPRhNTsOU2UufqUg9V0/Ln5/me0rvdlHDFOEwOBQT7Ut8CO3wYqNN/80k6ednVu5Wa3n1fcoYvvZ6rx9KLn9fPR6LmSLvCa/zGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY3yV2GLDz4f3lD4;
	Mon,  6 May 2024 22:41:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 11A181A058D;
	Mon,  6 May 2024 22:42:04 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgC32w467Dhmz6nXMA--.56195S3;
	Mon, 06 May 2024 22:42:03 +0800 (CST)
Subject: Re: [PATCH 1/9] jbd2: avoid memleak in
 jbd2_journal_write_metadata_buffer
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-2-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <448062a9-43f8-c7ad-0b4d-ddf892713d9e@huaweicloud.com>
Date: Mon, 6 May 2024 22:42:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506141801.1165315-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgC32w467Dhmz6nXMA--.56195S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKw43Zr18JrWrJFy7ZF1UJrb_yoW3tFg_WF
	Z7Zrn7X398XFs7Aa1rCa47urn8Krs5Cr1kCa40gw17Gr15t3yrXFnrJw1DtF9ruan2gr4U
	Cas29F48Kr9xJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/6 22:17, Kemeng Shi wrote:
> The new_bh is from alloc_buffer_head, we should call free_buffer_head to
> free it in error case.

Oh, yeah, this is a separate bh, so it should be freed explicitly, it
looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/jbd2/journal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index b6c114c11b97..207b24e12ce9 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -399,6 +399,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
>  		if (!tmp) {
>  			brelse(new_bh);
> +			free_buffer_head(new_bh);
>  			return -ENOMEM;
>  		}
>  		spin_lock(&jh_in->b_state_lock);
> 


