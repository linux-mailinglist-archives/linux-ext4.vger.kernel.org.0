Return-Path: <linux-ext4+bounces-4381-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D1E989948
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 04:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C101C20B57
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 02:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09361CD2B;
	Mon, 30 Sep 2024 02:41:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE992904
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727664101; cv=none; b=MbmTbJUdbPvf0ChSsxY9Hu6t9tf3nWV/ftVrnrJ1DPyj3vSCAy/43eUI0PEwOzpp0L6WwcQX7VJppmTSow9qMfGeLLgrMWs9XHT1zRmifiXnwgb6J/3085ln3HNe80ad6fti8XcjR5FXMGu0U2Go3kakgu8BZqbX4MqQjmLXNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727664101; c=relaxed/simple;
	bh=ikfwdPPnhSV/p9CNaiAL/yv2ip7Y3+hL4b/Rey6eWiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9PBBcOOYb0UOMT7CbSBVMPeNrnA5oUatybeZnK1q8dV41YCEqKKVBjmgpYp8ygE4riSD0CgiAr6CqdLQY6AaOct6RV7XYK3boW4Z7hUHFnO01i03J8S5Vf0USutcNXTQ+DIjY7O7NWNAbtjAxHg1qLu4mokZ9xPXF1i0DjprSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XH51C5BC8z4f3kvP
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:41:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DDCBC1A0359
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:41:36 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMjgD_pm_HnzCg--.57531S3;
	Mon, 30 Sep 2024 10:41:36 +0800 (CST)
Message-ID: <009237b3-9472-4fc5-bd99-5f4d432fc3a1@huaweicloud.com>
Date: Mon, 30 Sep 2024 10:41:35 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] jbd2: remove useless 'block_error' variable
To: Ye Bin <yebin@huaweicloud.com>
Cc: jack@suse.cz, zhangxiaoxu5@huawei.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <20240930005942.626942-1-yebin@huaweicloud.com>
 <20240930005942.626942-6-yebin@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240930005942.626942-6-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXTMjgD_pm_HnzCg--.57531S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJryDuFy7Kr18CF4DAr1xGrg_yoW8Cryrp3
	yUCa1kKFyDAry09F9rJFWDXFWj9a1jyryUWr1qk3Z3tFW5Jr9rKr18Kr15tFy0krZ29ay7
	JFW8ZFykGw1293DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1hSdDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/30 8:59, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> The judgement 'if (block_error && success == 0)' is never valid. Just
> remove useless 'block_error' variable.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/recovery.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 046744d6239c..4f1e9ca34503 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -490,7 +490,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  					  struct buffer_head *bh,
>  					  unsigned long *next_log_block,
>  					  unsigned int next_commit_ID,
> -					  int *success, int *block_error)
> +					  int *success)
>  {
>  	char *tagp;
>  	int flags;
> @@ -542,7 +542,6 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  				*success = -EFSBADCRC;
>  				pr_err("JBD2: Invalid checksum recovering data block %llu in journal block %lu\n",
>  				      blocknr, io_block);
> -				*block_error = 1;
>  				goto skip_write;
>  			}
>  
> @@ -596,7 +595,6 @@ static int do_one_pass(journal_t *journal,
>  	unsigned int		sequence;
>  	int			blocktype;
>  	__u32			crc32_sum = ~0; /* Transactional Checksums */
> -	int			block_error = 0;
>  	bool			need_check_commit_time = false;
>  	__u64			last_trans_commit_time = 0, commit_time;
>  
> @@ -721,8 +719,7 @@ static int do_one_pass(journal_t *journal,
>  			 * done here!
>  			 */
>  			err = jbd2_do_replay(journal, info, bh, &next_log_block,
> -					     next_commit_ID, &success,
> -					     &block_error);
> +					     next_commit_ID, &success);
>  			if (err)
>  				goto failed;
>  
> @@ -913,8 +910,6 @@ static int do_one_pass(journal_t *journal,
>  			success = err;
>  	}
>  
> -	if (block_error && success == 0)
> -		success = -EIO;
>  	return success;
>  
>   failed:


