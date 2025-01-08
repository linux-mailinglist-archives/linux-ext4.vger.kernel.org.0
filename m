Return-Path: <linux-ext4+bounces-5972-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A1A050F5
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 03:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D90B3A932A
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 02:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B2C1632C8;
	Wed,  8 Jan 2025 02:43:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA1158D96;
	Wed,  8 Jan 2025 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304209; cv=none; b=D0s6F7mPCHaNfeDdcl08dS0ZAzZ/45EzOa0xcgOQAr0aJIAd/+6s0Y54Y7p3McSBArfU/N5Sj+1cyLDMkv1SU86zjztJH6BUJ51L6oB+1CD9m0/qsUT+YUJnfI6p5EyWKwmaPMqfIBPwYoWAYxELlUIDxnBNjfWjewtyZiHe0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304209; c=relaxed/simple;
	bh=JQNO338dPpNXR5LpcQ7V5U5nv5QItZcpdY5r5KZB4O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+NkZjweRDS2LJvcwRZLAhGxglTokJVB5xxC4u8CTTBDyy8Afrok3TH25hytFCBOZSLx770Bj9Zoe8051QkuhQOfkE0q5ndagu0fAUzKZA2z68gGeMih0zmNy8kNsJ5lAGwR8NHUHZBeusMjpYv6ngqvPw7NmOvqg8ECBdSxHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YSXK2690pz4f3jsH;
	Wed,  8 Jan 2025 10:43:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 08FAC1A0932;
	Wed,  8 Jan 2025 10:43:23 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAni19K5n1ndMNkAQ--.53636S3;
	Wed, 08 Jan 2025 10:43:22 +0800 (CST)
Message-ID: <35533fd7-2e74-4551-8d2e-c89e688d055b@huaweicloud.com>
Date: Wed, 8 Jan 2025 10:43:22 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] jbd2: remove unused return value of
 jbd2_journal_cancel_revoke
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-3-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241224202707.1530558-3-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAni19K5n1ndMNkAQ--.53636S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWftw45Cr4fXw45Jw43Jrb_yoW8tFy7pF
	98C34rCrWvkryj9F1DWa1UJFW7Xr97C3yjgFWq93srKw4IgF97tr4UGr1jqFyYqFZFga15
	Zr4UG395Cw4jgFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBmhwUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/25 4:27, Kemeng Shi wrote:
> Remove unused return value of jbd2_journal_cancel_revoke.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/revoke.c     | 5 +----
>  include/linux/jbd2.h | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index 4556e4689024..af0208ed3619 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -420,12 +420,11 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
>   * do not trust the Revoked bit on buffers unless RevokeValid is also
>   * set.
>   */
> -int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
> +void jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  {
>  	struct jbd2_revoke_record_s *record;
>  	journal_t *journal = handle->h_transaction->t_journal;
>  	int need_cancel;
> -	int did_revoke = 0;	/* akpm: debug */
>  	struct buffer_head *bh = jh2bh(jh);
>  
>  	jbd2_debug(4, "journal_head %p, cancelling revoke\n", jh);
> @@ -450,7 +449,6 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  			list_del(&record->hash);
>  			spin_unlock(&journal->j_revoke_lock);
>  			kmem_cache_free(jbd2_revoke_record_cache, record);
> -			did_revoke = 1;
>  		}
>  	}
>  
> @@ -473,7 +471,6 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  			__brelse(bh2);
>  		}
>  	}
> -	return did_revoke;
>  }
>  
>  /*
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index c7fdb2b1b9a6..e2d1426d3e06 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1635,7 +1635,7 @@ extern int __init jbd2_journal_init_revoke_table_cache(void);
>  
>  extern void	   jbd2_journal_destroy_revoke(journal_t *);
>  extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, struct buffer_head *);
> -extern int	   jbd2_journal_cancel_revoke(handle_t *, struct journal_head *);
> +extern void	   jbd2_journal_cancel_revoke(handle_t *, struct journal_head *);
>  extern void	   jbd2_journal_write_revoke_records(transaction_t *transaction,
>  						     struct list_head *log_bufs);
>  


