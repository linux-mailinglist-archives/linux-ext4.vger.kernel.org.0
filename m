Return-Path: <linux-ext4+bounces-4379-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4731B989946
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C858E2826EB
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175431CABA;
	Mon, 30 Sep 2024 02:37:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D8288BD
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727663845; cv=none; b=N3i1QcSsWiuqAejLzJ6GtQLNml15B+ASNe48RAm8Rbk7kgyErfGQzdiviPUm33fjckP9RHIZrI0GttOYVmGJzr60t0II8wGxs1Wvl24egrijAYZl637Vnxx1DBxjeWUdn6aLANwZLksC7cVo0MBKJ3pUoygCyAiOYX3kHk04sqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727663845; c=relaxed/simple;
	bh=evRGLCBQTkjCwGl6706mtVcK5qSjct34otuK2bFZBMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfuhI8/F7GXHprCgx/P0yB/vv/6z3CD97fJep1xb+2717DLP6kwCBDXnsA3tb1gh4o9n3q8hAlCtJYlYxrKgZ5zTtWiYskYwR0ry9KZmn1THlvOBLVQ3YcIyfguz66mnRHGpMMgj6mDRSHyiMBfsKV/K20DeKnYvpN8ljHc+f9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XH4wP3mrhz4f3jjx
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:37:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E9E2E1A092F
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:37:20 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8fgDvpmnTLzCg--.55444S3;
	Mon, 30 Sep 2024 10:37:20 +0800 (CST)
Message-ID: <1c7936ea-7bbc-49b7-bc85-b877129272f9@huaweicloud.com>
Date: Mon, 30 Sep 2024 10:37:19 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] jbd2: refactor JBD2_COMMIT_BLOCK process in
 do_one_pass()
To: Ye Bin <yebin@huaweicloud.com>
Cc: jack@suse.cz, zhangxiaoxu5@huawei.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <20240930005942.626942-1-yebin@huaweicloud.com>
 <20240930005942.626942-4-yebin@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240930005942.626942-4-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDH+8fgDvpmnTLzCg--.55444S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4xZr4xtrWDtryrAr1UKFg_yoW5WF4kpw
	s0k3ZxKrWUJr129Fn3XF4UZFWUW3W0y3WUuw12kwn7Xas8twnFgw4Iqr1ftry5AF93u3yr
	uF15Ar1DKw1Sk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aZX5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/



On 2024/9/30 8:59, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> To make JBD2_COMMIT_BLOCK process more clean, no functional change.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/recovery.c | 55 ++++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 0adf0cb31a03..0d697979d83e 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -728,6 +728,11 @@ static int do_one_pass(journal_t *journal,
>  			continue;
>  
>  		case JBD2_COMMIT_BLOCK:
> +			if (pass != PASS_SCAN) {
> +				next_commit_ID++;
> +				continue;
> +			}
> +
>  			/*     How to differentiate between interrupted commit
>  			 *               and journal corruption ?
>  			 *
> @@ -790,8 +795,7 @@ static int do_one_pass(journal_t *journal,
>  			 * much to do other than move on to the next sequence
>  			 * number.
>  			 */
> -			if (pass == PASS_SCAN &&
> -			    jbd2_has_feature_checksum(journal)) {
> +			if (jbd2_has_feature_checksum(journal)) {
>  				struct commit_header *cbh =
>  					(struct commit_header *)bh->b_data;
>  				unsigned found_chksum =
> @@ -815,34 +819,33 @@ static int do_one_pass(journal_t *journal,
>  					goto chksum_error;
>  
>  				crc32_sum = ~0;
> +				goto chksum_ok;
>  			}
> -			if (pass == PASS_SCAN &&
> -			    !jbd2_commit_block_csum_verify(journal,
> -							   bh->b_data)) {
> -				if (jbd2_commit_block_csum_verify_partial(
> -								  journal,
> -								  bh->b_data)) {
> -					pr_notice("JBD2: Find incomplete commit block in transaction %u block %lu\n",
> -						  next_commit_ID, next_log_block);
> -					goto chksum_ok;
> -				}
> -			chksum_error:
> -				if (commit_time < last_trans_commit_time)
> -					goto ignore_crc_mismatch;
> -				info->end_transaction = next_commit_ID;
> -				info->head_block = head_block;
>  
> -				if (!jbd2_has_feature_async_commit(journal)) {
> -					journal->j_failed_commit =
> -						next_commit_ID;
> -					break;
> -				}
> +			if (jbd2_commit_block_csum_verify(journal, bh->b_data))
> +				goto chksum_ok;
> +
> +			if (jbd2_commit_block_csum_verify_partial(journal,
> +								  bh->b_data)) {
> +				pr_notice("JBD2: Find incomplete commit block in transaction %u block %lu\n",
> +					  next_commit_ID, next_log_block);
> +				goto chksum_ok;
>  			}
> -			if (pass == PASS_SCAN) {
> -			chksum_ok:
> -				last_trans_commit_time = commit_time;
> -				head_block = next_log_block;
> +
> +chksum_error:
> +			if (commit_time < last_trans_commit_time)
> +				goto ignore_crc_mismatch;
> +			info->end_transaction = next_commit_ID;
> +			info->head_block = head_block;
> +
> +			if (!jbd2_has_feature_async_commit(journal)) {
> +				journal->j_failed_commit = next_commit_ID;
> +				break;
>  			}
> +
> +chksum_ok:
> +			last_trans_commit_time = commit_time;
> +			head_block = next_log_block;
>  			next_commit_ID++;
>  			continue;
>  


