Return-Path: <linux-ext4+bounces-5976-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B84FA0518F
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 04:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750CD3A29B5
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 03:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31192199FB2;
	Wed,  8 Jan 2025 03:28:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3A3FBB3;
	Wed,  8 Jan 2025 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736306885; cv=none; b=W/P1X13VELoHC3kTziiZhYsRBg8QjL1MzI5D66rgPTqMdUT5vQgXLqDK0lOTxrm89NxI0xdaqNXSCMpun4IvVsshM6qiPixq38CeZt0tH+JTwONs0I8PStWbGM/MIQ7MzQoO31f3YtkHUOWrTXipNH07qRUsqloFgsdWC1LnzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736306885; c=relaxed/simple;
	bh=lX4oGx8sgKz//+nP2vuXuyeF6YRprPclEIpEvkKWlig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqfA16IGczhbkLS2Ey/JX4ofFaXcLfr2Ifj2uWKYdc0dvprAfYDvrDFb43qoKAQYmDhPM2A/T0+9Yzq1JTlSEVFF/9W6R9C/sbL49Z2LK/ZhOm78W6gj70O8kikgr6WrMnsQ74PEiHwZf4AlQEF5m5DmWBguunVArgbJS78Pmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YSYJP51vLz4f3jMx;
	Wed,  8 Jan 2025 11:27:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D78FA1A0E66;
	Wed,  8 Jan 2025 11:27:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXul658H1nfKlnAQ--.53519S3;
	Wed, 08 Jan 2025 11:27:53 +0800 (CST)
Message-ID: <ba8be54a-5293-495d-adae-87d119cff951@huaweicloud.com>
Date: Wed, 8 Jan 2025 11:27:53 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] jbd2: Correct stale comment of release_buffer_page
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-7-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241224202707.1530558-7-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXul658H1nfKlnAQ--.53519S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XryDArWruw1xKFyrKFWxZwb_yoWDZrc_Za
	s29r97Ww12vFs7A3WIk3W5XrWxK393ZrZ7uFW8ta4Y934UJ395K3WktF98K3srWF4jgr17
	ZFn2yr48Kry3CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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
> Update stale lock info in comment of release_buffer_page.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/commit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 9153ff3a08e7..d812d15f295e 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -57,8 +57,8 @@ static void journal_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
>   * So here, we have a buffer which has just come off the forget list.  Look to
>   * see if we can strip all buffers from the backing page.
>   *
> - * Called under lock_journal(), and possibly under journal_datalist_lock.  The
> - * caller provided us with a ref against the buffer, and we drop that here.
> + * Called under j_list_lock. The caller provided us with a ref against the
> + * buffer, and we drop that here.
>   */
>  static void release_buffer_page(struct buffer_head *bh)
>  {


