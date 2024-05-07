Return-Path: <linux-ext4+bounces-2343-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0168BE25D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2024 14:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1C31F2211C
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2024 12:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5D9158D9C;
	Tue,  7 May 2024 12:41:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE26CDB1;
	Tue,  7 May 2024 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085712; cv=none; b=fNcDGDBDexuZnavXrBdnY56kvZ3O8B2vc68k2ZJZFV8rvvp7HCYPInBC8N8aNFuKvOCSZGNiNJJqgaaRzInUnoqGUfCAKTtKtXRiaa0Sn/UZQZJqOYaULRq8C+jdO13gFuSiPeEV3m9DIMIdDGaEFNEo5nphpZkbA14+a+B2Xhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085712; c=relaxed/simple;
	bh=7KEcsbmaA7aD57rmrMuDbLkNyccMo7sXPpbR11JklnE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ura5Ldm43iNBNP6vztFQk3JeEeYuUd2WnHjEROCF7FopELbjpul6v+7axVnWCvBlBjwmIm1gBvAY8St/kKkiH5L6Ri6zb+RXqPULpxzTuUtNCJWR1h+MgOujp++x5k9aJYkU9YH7X9oC6uwCQnrmQgyMufxyTA32EK7xQwuis/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VYdFF1c3Yz4f3jXg;
	Tue,  7 May 2024 20:41:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 767DC1A0572;
	Tue,  7 May 2024 20:41:45 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAXPA+HITpmNyEvMQ--.45588S3;
	Tue, 07 May 2024 20:41:45 +0800 (CST)
Subject: Re: [PATCH 4/9] jbd2: move repeat tag around to remove a repeat check
 of b_frozen_data
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-5-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <b2fa97c7-3f1c-321d-038e-7fb46420d24b@huaweicloud.com>
Date: Tue, 7 May 2024 20:41:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506141801.1165315-5-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXPA+HITpmNyEvMQ--.45588S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr4fCrW3Kr4UXrW3CFW7urg_yoW8Jr1xpr
	93KF1jkFyvg3s2yFs7ua1DuFy09ws5WFy8KFnxCr1ayay3Xw1xWryjvw15Kw12yrZ7G3y8
	Zryq93yxW3ZIvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/6 22:17, Kemeng Shi wrote:
> We make sure b_frozen_data is not NULL before jump to "repeat" tag, move
> "repeat" tag around to remove repeat check of b_frozen_data.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/jbd2/journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 9a35d0c5b38c..77fcdc76fdfd 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -353,12 +353,12 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	atomic_set(&new_bh->b_count, 1);
>  
>  	spin_lock(&jh_in->b_state_lock);
> -repeat:
>  	/*
>  	 * If a new transaction has already done a buffer copy-out, then
>  	 * we use that version of the data for the commit.
>  	 */
>  	if (jh_in->b_frozen_data) {
> +repeat:
>  		done_copy_out = 1;
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> 

I suppose we could drop the repeat tag entirely, just set the new_folio and
new_offset, and then goto handle do_escape. We don't need to call
jbd2_buffer_frozen_trigger() and check for escaping again, is that right?

Thanks,
Yi.


