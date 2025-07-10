Return-Path: <linux-ext4+bounces-8913-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6AFAFFC69
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jul 2025 10:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83AD17A6D70
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jul 2025 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A0028DF27;
	Thu, 10 Jul 2025 08:30:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB708224B14;
	Thu, 10 Jul 2025 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136234; cv=none; b=oYTwtz1MN8bhYQc7bNTgpzl6K166FQehx3KeE+C2p5Mqzcv3jzLm5ioc+BTd8saGkPv0EMa3lz5JfCSVGyUR21r1Ts/X4ANJKPhTkGwvq/SP/r68AYBtzotXyia80mVFXRmKj1UvgfkhhZ7ejJf/H/q9Oy5klvl18qoS486IYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136234; c=relaxed/simple;
	bh=2vt98ZOkX2ZCprct/CZ38okaD2P1Rf8hMKqEpfH+MBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxmttxHJX5bULUOb+Au7quwwZ2r2kQkhkiIP5Z1Uk2N44VsKJkD6SlcTIEuQgJnoUmFnE/mkFA232MOdb/zLFOYVNvaMorr+2clwLjHKYX819MPNUlb+R2zesCw4i6BooZZiV+NFKP/AG7lNQv1TK6vf5wWFiwPmQoxmXPBY1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bd7MP3r7rzYQvM8;
	Thu, 10 Jul 2025 16:30:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 577E91A1C0C;
	Thu, 10 Jul 2025 16:30:24 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgCHNSMeem9oVU39BA--.55493S3;
	Thu, 10 Jul 2025 16:30:24 +0800 (CST)
Message-ID: <6c2445e9-5105-495f-a64a-3d6b1fb81a5f@huaweicloud.com>
Date: Thu, 10 Jul 2025 16:30:22 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix inode use after free in ext4_end_io_rsv_work()
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, libaokun1@huawei.com
References: <20250708111504.3208660-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250708111504.3208660-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCHNSMeem9oVU39BA--.55493S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw48Wry7CryxtFyUWr1Utrb_yoW5AFW7pF
	yY9FyUKF47Zwn2grs3JF1DXr4vqayxtF4UW34xWFy2yFZ3JFn8t3WIq3W5JF18CrWfua17
	ZF4rKrnxWa15trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/7/8 19:15, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_io_end_defer_completion(), check if io_end->list_vec is empty to
> avoid adding an io_end that requires no conversion to the
> i_rsv_conversion_list, which in turn prevents starting an unnecessary
> worker. An ext4_emergency_state() check is also added to avoid attempting
> to abort the journal in an emergency state.
> 
> Additionally, ext4_put_io_end_defer() is refactored to call
> ext4_io_end_defer_completion() directly instead of being open-coded.
> This also prevents starting an unnecessary worker when EXT4_IO_END_FAILED
> is set but data_err=abort is not enabled.
> 
> This ensures that the check in ext4_put_io_end_defer() is consistent with
> the check in ext4_end_bio(). Otherwise, we might add an io_end to the
> i_rsv_conversion_list and then call ext4_finish_bio(), after which the
> inode could be freed before ext4_end_io_rsv_work() is called, triggering
> a use-after-free issue.
> 
> Fixes: ce51afb8cc5e ("ext4: abort journal on data writeback failure if in data_err=abort mode")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/page-io.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 179e54f3a3b6..3d8b0f6d2dea 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -236,10 +236,12 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
>  
>  static bool ext4_io_end_defer_completion(ext4_io_end_t *io_end)
>  {
> -	if (io_end->flag & EXT4_IO_END_UNWRITTEN)
> +	if (io_end->flag & EXT4_IO_END_UNWRITTEN &&
> +	    !list_empty(&io_end->list_vec))
>  		return true;
>  	if (test_opt(io_end->inode->i_sb, DATA_ERR_ABORT) &&
> -	    io_end->flag & EXT4_IO_END_FAILED)
> +	    io_end->flag & EXT4_IO_END_FAILED &&
> +	    !ext4_emergency_state(io_end->inode->i_sb))
>  		return true;
>  	return false;
>  }
> @@ -256,6 +258,7 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
>  	WARN_ON(!(io_end->flag & EXT4_IO_END_DEFER_COMPLETION));
>  	WARN_ON(io_end->flag & EXT4_IO_END_UNWRITTEN &&
>  		!io_end->handle && sbi->s_journal);
> +	WARN_ON(!io_end->bio);
>  
>  	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
>  	wq = sbi->rsv_conversion_wq;
> @@ -318,12 +321,9 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
>  void ext4_put_io_end_defer(ext4_io_end_t *io_end)
>  {
>  	if (refcount_dec_and_test(&io_end->count)) {
> -		if (io_end->flag & EXT4_IO_END_FAILED ||
> -		    (io_end->flag & EXT4_IO_END_UNWRITTEN &&
> -		     !list_empty(&io_end->list_vec))) {
> -			ext4_add_complete_io(io_end);
> -			return;
> -		}
> +		if (ext4_io_end_defer_completion(io_end))
> +			return ext4_add_complete_io(io_end);
> +
>  		ext4_release_io_end(io_end);
>  	}
>  }


