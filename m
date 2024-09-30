Return-Path: <linux-ext4+bounces-4382-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037C498994C
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 04:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F13282A99
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 02:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B131F957;
	Mon, 30 Sep 2024 02:43:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23771CABA
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727664207; cv=none; b=rzzyskBrwrWyQRHYIDb/PisJXjLB1LPX5rwuhiLG28hcP1grLP0betG6yhn/jplYfRpVocY6G+2112VEKAVVP6/d+FrvZ7NvNUIRjke4cHvgZx4BKIqq2SIXTc1jhTpBzb7785ARYPRS4pmXwINRAtlPdUYvmefb1cSWGuahX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727664207; c=relaxed/simple;
	bh=QUd3/tNgliqV/qTovrqwdpElzo1RvoSbw7jNF4UbQI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qc2AMYa062xh2b91zK+kt5xbwV8cFgaNkv8LFUwQh8NsYESMiIFv4tmNNMcumxgBqlG0nNQDPTE5FGN+2ACiJPcby4qCTdbA8ktoD3tXmkq02u0g/vhIisoydiV95jhvB1x3rDuIJ3FeYcl5G4TW2Hux3vCVVxQRa33McDOP7Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XH53D6dlWz4f3jMt
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:43:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 669661A0359
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:43:21 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCHusZIEPpmsJfzCg--.10993S3;
	Mon, 30 Sep 2024 10:43:21 +0800 (CST)
Message-ID: <6961cc1b-6d24-427c-afb5-2751e804ad9a@huaweicloud.com>
Date: Mon, 30 Sep 2024 10:43:20 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] jbd2: remove the 'success' parameter from the
 jbd2_do_replay() function
To: Ye Bin <yebin@huaweicloud.com>
Cc: jack@suse.cz, zhangxiaoxu5@huawei.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <20240930005942.626942-1-yebin@huaweicloud.com>
 <20240930005942.626942-7-yebin@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240930005942.626942-7-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHusZIEPpmsJfzCg--.10993S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW5tr4ruFyrJr1xJw43KFg_yoW5Gr15pw
	45Cay2kFyqvF17KF93XFyUXrW29w1ayFyUWrnF9wnayay5tryDt34Sgw13tFyYyr929ayr
	JFW0v3s7KwnrK3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1hSdDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/30 8:59, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Keep 'success' internally to track if any error happened and then
> return it at the end in do_one_pass(). If jbd2_do_replay() return
> -ENOMEM then stop replay journal.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/recovery.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 4f1e9ca34503..9192be7c19d8 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -489,12 +489,11 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  					  struct recovery_info *info,
>  					  struct buffer_head *bh,
>  					  unsigned long *next_log_block,
> -					  unsigned int next_commit_ID,
> -					  int *success)
> +					  unsigned int next_commit_ID)
>  {
>  	char *tagp;
>  	int flags;
> -	int err;
> +	int ret = 0;
>  	int tag_bytes = journal_tag_bytes(journal);
>  	int descr_csum_size = 0;
>  	unsigned long io_block;
> @@ -508,6 +507,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  	tagp = &bh->b_data[sizeof(journal_header_t)];
>  	while (tagp - bh->b_data + tag_bytes <=
>  	       journal->j_blocksize - descr_csum_size) {
> +		int err;
>  
>  		memcpy(&tag, tagp, sizeof(tag));
>  		flags = be16_to_cpu(tag.t_flags);
> @@ -517,7 +517,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  		err = jread(&obh, journal, io_block);
>  		if (err) {
>  			/* Recover what we can, but report failure at the end. */
> -			*success = err;
> +			ret = err;
>  			pr_err("JBD2: IO error %d recovering block %lu in log\n",
>  			      err, io_block);
>  		} else {
> @@ -539,7 +539,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  					(journal_block_tag3_t *)tagp,
>  					obh->b_data, next_commit_ID)) {
>  				brelse(obh);
> -				*success = -EFSBADCRC;
> +				ret = -EFSBADCRC;
>  				pr_err("JBD2: Invalid checksum recovering data block %llu in journal block %lu\n",
>  				      blocknr, io_block);
>  				goto skip_write;
> @@ -580,7 +580,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  			break;
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int do_one_pass(journal_t *journal,
> @@ -719,9 +719,12 @@ static int do_one_pass(journal_t *journal,
>  			 * done here!
>  			 */
>  			err = jbd2_do_replay(journal, info, bh, &next_log_block,
> -					     next_commit_ID, &success);
> -			if (err)
> -				goto failed;
> +					     next_commit_ID);
> +			if (err) {
> +				if (err == -ENOMEM)
> +					goto failed;
> +				success = err;
> +			}
>  
>  			continue;
>  


