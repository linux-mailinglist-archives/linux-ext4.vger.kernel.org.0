Return-Path: <linux-ext4+bounces-1262-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1D4858F2C
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Feb 2024 12:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD031C20CBA
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Feb 2024 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DBE6A011;
	Sat, 17 Feb 2024 11:54:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FB69D3A
	for <linux-ext4@vger.kernel.org>; Sat, 17 Feb 2024 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708170840; cv=none; b=iN8dl35TNaHjK1EiNjveVlclvgd8MIWVsNImGWNJzd1oXWSmjkf8SRw52quOTx/SMk2iLF0ipiHW5z/JqjjxL4L85IUyHvPQ1smTxgcxJJL2bXhhvAt6CVqITjPsDbLaOCA4LTP4UXGDlO9Rk09QA38VOQumec4bjtfxw5ArSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708170840; c=relaxed/simple;
	bh=88cz6DznqWfqUTaCB+8gM+sK3rPSemLz/6lakdJp33s=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JahiukK/wKCWby12JcPAsFEkopAzTrFfWj3wkVnEVUDzvWmbUyF3eWEk0Z4P7htiIfG5Y8A3PdkrJWROFuewZVl/eNwf/irSjPE6xkhvnM6WuMWVPKS/y13Nl2Bp1/RpEZMUMc6oxp67p3ET4cavx9ISqYMcUNCFQwHXAFhiRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TcRsZ4Rrpz1FKhk;
	Sat, 17 Feb 2024 19:49:06 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 189321400D2;
	Sat, 17 Feb 2024 19:53:54 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 19:53:53 +0800
Subject: Re: [PATCH] ext4: Don't report EOPNOTSUPP errors from discard
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, Ted Tso <tytso@mit.edu>
References: <20240213101601.17463-1-jack@suse.cz>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <9acdeec0-e5d6-4139-329d-57f1f4dee1a5@huawei.com>
Date: Sat, 17 Feb 2024 19:53:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240213101601.17463-1-jack@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/2/13 18:16, Jan Kara wrote:
> When ext4 is mounted without journal, with discard mount option, and on
> a device not supporting trim, we print error for each and every freed
> extent. This is not only useless but actively harmful. Instead ignore
> the EOPNOTSUPP error. Trim is only advisory anyway and when the
> filesystem has journal we silently ignore trim error as well.
> 

Make sense, call ext4_std_error() since EOPNOTSUPP is really harmful.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/mballoc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e4f7cf9d89c4..aed620cf4d40 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6488,7 +6488,13 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  		if (test_opt(sb, DISCARD)) {
>  			err = ext4_issue_discard(sb, block_group, bit,
>  						 count_clusters, NULL);
> -			if (err && err != -EOPNOTSUPP)
> +			/*
> +			 * Ignore EOPNOTSUPP error. This is consistent with
> +			 * what happens when using journal.
> +			 */
> +			if (err == -EOPNOTSUPP)
> +				err = 0;
> +			if (err)
>  				ext4_msg(sb, KERN_WARNING, "discard request in"
>  					 " group:%u block:%d count:%lu failed"
>  					 " with %d", block_group, bit, count,
> 

