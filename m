Return-Path: <linux-ext4+bounces-2341-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BD8BE16A
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2024 13:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74722821DE
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4071158A22;
	Tue,  7 May 2024 11:51:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91A152516;
	Tue,  7 May 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082681; cv=none; b=Rw6aJH8pNjX8wuXLcCyYJo1C0ShlMHopq9PZIo/ic1Th3kpUAVOWL7Ynxrk2fwgcsyMf12VZIU8IN0zyRFR9a0P25BCV6EV+VqwEPrQnVBj8TPqPO3G/UEnEEsaFHIkCpfUHu9EUe6bXIuLEhjuHofIM8Wg2xj2qxtyO7IkCrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082681; c=relaxed/simple;
	bh=3zh4fm2pBOcJE+WMFqYzK+s/MF28H7REWA4k3nloj6A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bssr0Ry+aSd8rqO2i9S7Ifn+X9bFigtrg2r57cnSpItBlKZ5xMwO8+RxfJ3k1aRN/vvsW7U2cLHy+fBz6QvdxMUSwwPGCiBpFHWywseyF25LNlceBvEsJJ6nGDU8sMuZz/hRpc8wtLM9XHWG/GnPJf/PIA1uI5vgeTgKpaE8Ed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VYc6x74MMz4f3tPY;
	Tue,  7 May 2024 19:51:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C3F821A0572;
	Tue,  7 May 2024 19:51:15 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDnCw+yFTpmSQksMQ--.19787S3;
	Tue, 07 May 2024 19:51:15 +0800 (CST)
Subject: Re: [PATCH 2/9] jbd2: remove unused return info from
 jbd2_journal_write_metadata_buffer
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-3-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <97dbc0cd-5676-9e92-931c-5873f2e207cd@huaweicloud.com>
Date: Tue, 7 May 2024 19:51:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506141801.1165315-3-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnCw+yFTpmSQksMQ--.19787S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4DWrW7GF48Jw13KFWrAFb_yoW8GF4rpr
	9Yka48ZF90vry8AFn7XFWDXFW09r4I9FWjkr4qkwn5tw43Xw1I9ry0kr1qgr1YyF9aka18
	JF4kCaykGws0va7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/6 22:17, Kemeng Shi wrote:
> The done_copy_out info from jbd2_journal_write_metadata_buffer is not
> used. Simply remove it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/jbd2/journal.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 207b24e12ce9..068031f35aea 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -320,7 +320,6 @@ static void journal_kill_thread(journal_t *journal)
>   *
>   * On success:
>   * Bit 0 set == escape performed on the data
> - * Bit 1 set == buffer copy-out performed (kfree the data after IO)
>   */
>  
>  int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
> @@ -455,7 +454,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	set_buffer_shadow(bh_in);
>  	spin_unlock(&jh_in->b_state_lock);
>  
> -	return do_escape | (done_copy_out << 1);
> +	return do_escape;
>  }
>  

I checked the history, it seems that this bit has not been used since
the very beginning when the jbd code was merged in, I suppose we could
drop it. Since there is only one flag that is still in use, why not just
drop the flag and pass out do_escape through an output parameter, or
directly pass tag_flag, after that we could also drop the weird
"if (flags & 1)" check in jbd2_journal_commit_transaction()?

Thanks,
Yi.


