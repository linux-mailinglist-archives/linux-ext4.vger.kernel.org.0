Return-Path: <linux-ext4+bounces-4210-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED0297BCF8
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 15:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AD71F21EB3
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692D18A6B7;
	Wed, 18 Sep 2024 13:20:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED018952A
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665600; cv=none; b=fl9hqmXKmqV56ouuld8eeffDZDch+OcqSZsA1He698XrUR1MXo31W5pphjNkE10/fqvoV5yzpbFIVUWKwEZXEp3Yn9YHZDgLhuNUMS+gyEUBuLukh1QDLV751zO2CKWc+MeAfEvHKzIW8sSbfDHbg6zRtxBpMOuBXAHYMqch5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665600; c=relaxed/simple;
	bh=6Sm+n2tHl5EwMAvcPEB9cJR3RBPAFperRbulCjQgPYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZEj2qcVAdRgkzeVNl0FA0EAJYjOOb2fw+RVK5S9Ui09/CW9wlbqtIQu9CNbsW7OdTfVgn3TemYfUIbinLk5LVY0EGVdceavWXVPpZ8cUSCdsYRZeliZpxXmwN+VoLvBvCPsROP+UOAayR5kK5naVGlgmEQ+GcacMxm5fxFjN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X7zlD4rjjz4f3lVP
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 21:19:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 48F061A092F
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 21:19:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCXysZ30+pmzp+xBg--.51338S3;
	Wed, 18 Sep 2024 21:19:53 +0800 (CST)
Message-ID: <1c52c8c2-43a0-43e1-8fca-18ac21581391@huaweicloud.com>
Date: Wed, 18 Sep 2024 21:19:51 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] jbd2: remove useless 'block_error' variable
To: Ye Bin <yebin@huaweicloud.com>, tytso@mit.edu, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org
Cc: jack@suse.cz, zhangxiaoxu5@huawei.com
References: <20240918113604.660640-1-yebin@huaweicloud.com>
 <20240918113604.660640-6-yebin@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240918113604.660640-6-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXysZ30+pmzp+xBg--.51338S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF47WF4DXFWUAFWrXry3XFb_yoW8ur1Dpr
	WUCa1kKFyDCry8JF9rJFWDXFyj9a1jyFyUGr1qk3Z3tay5JrnFgr1rKr1aqFyjkr929ayj
	qFW0va4kGw1Ik3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/18 19:36, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> The judgement 'if (block_error && success == 0)' is never valid. Just
> remove useless 'block_error' variable.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/jbd2/recovery.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 05ea449b95c4..0bcbb58d634b 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -490,7 +490,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  					  struct buffer_head *bh,
>  					  unsigned long *next_log_block,
>  					  unsigned int next_commit_ID,
> -					  int *success, int *block_error)
> +					  int *success)

I wonder an unrelated question, why do we need this 'success' variable? Now we
keep on replaying later log blocks even if some bad things happened(read I/O
error or checksum error) instead of just quit, is it to replay as many log
blocks as possible, and then to reduce the data lose and also reduce e2fsck's
workload?

Thanks,
Yi.

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


