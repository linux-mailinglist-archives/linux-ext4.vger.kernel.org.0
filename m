Return-Path: <linux-ext4+bounces-2342-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9408BE210
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2024 14:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A22328A73F
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2024 12:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93182158D64;
	Tue,  7 May 2024 12:28:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDCF136E2D;
	Tue,  7 May 2024 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084915; cv=none; b=BseTC0wfo3w/TVAvHPvG5et2HHzJSk8sZnr4tqJ1tzLTAMTS/vts135UsnkDSpXdcPu5d9etVKIhpENX3YeAp4zxzqjTaQeccShGU4TbikffiWEocnqUOKptrn/i4Txtn0FjMH/GHKh1lmNwGyGYCFw/35eDHfQF4eIzp4yZOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084915; c=relaxed/simple;
	bh=3JOaCAMqGM8SN7hFZlLZhsfsb/fSBi2VfSkgmmLFYro=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qQ4ikBLeG5Fnp5gDFYyPy3dEtl9LpfRSAei/YkSDEnNq16iOScKnD2YLmBUddLYbodKH3law8xYs9jl63LcXb7vIoh88V1sNb4+mbmzzc2e9siCaV/IUYPwSTziF+fOHi8W0mHMr66Sj9DehMNZwitcSDb5euKwb+TOYJyLo4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VYcwh06TBzCrLN;
	Tue,  7 May 2024 20:27:16 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id ABE92180073;
	Tue,  7 May 2024 20:28:26 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 20:28:26 +0800
Subject: Re: [PATCH 3/9] jbd2: remove unnedded "need_copy_out" in
 jbd2_journal_write_metadata_buffer
To: Kemeng Shi <shikemeng@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <jack@suse.com>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-4-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <4c263b90-6226-c2bf-f3e5-3b15cd576aa7@huawei.com>
Date: Tue, 7 May 2024 20:28:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506141801.1165315-4-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/5/6 22:17, Kemeng Shi wrote:
> As we only need to copy out when we should do escape, need_copy_out
> could be simply replaced by "do_escape".
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Make sense, looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 068031f35aea..9a35d0c5b38c 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -327,7 +327,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  				  struct buffer_head **bh_out,
>  				  sector_t blocknr)
>  {
> -	int need_copy_out = 0;
>  	int done_copy_out = 0;
>  	int do_escape = 0;
>  	char *mapped_data;
> @@ -382,16 +381,14 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	/*
>  	 * Check for escaping
>  	 */
> -	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER)) {
> -		need_copy_out = 1;
> +	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
>  		do_escape = 1;
> -	}
>  	kunmap_local(mapped_data);
>  
>  	/*
>  	 * Do we need to do a data copy?
>  	 */
> -	if (need_copy_out && !done_copy_out) {
> +	if (do_escape && !done_copy_out) {
>  		char *tmp;
>  
>  		spin_unlock(&jh_in->b_state_lock);
> 

