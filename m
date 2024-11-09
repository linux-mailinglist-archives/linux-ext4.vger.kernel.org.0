Return-Path: <linux-ext4+bounces-5012-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16479C29CC
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Nov 2024 05:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2741F2234A
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Nov 2024 04:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755874D8AD;
	Sat,  9 Nov 2024 04:03:59 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A161114;
	Sat,  9 Nov 2024 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731125039; cv=none; b=EjRN0BNVnjVkPGddrGXUBRpM35tNdFRhqK4KLQ37O2T4peWAVFvr/NpiFTk3fD6oLM2Cg8dLT4cEc5fN1xuD5yNAPnGfllZ6do0JnU0ICYtVCmyoai7jLQ8P9IG4XC3yKNEB6vfNRdNiSc4HOZ/dJh8egGxlmIgaeaBLDwGgvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731125039; c=relaxed/simple;
	bh=1IujQTESAU16KQl+LWt5+jEW2o5CVvoRXLTwQXtJ6Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWWP67iu91Q8gXFFoQ7R8wcO1x5m87Y+cxYgRtIyr9/qWratsxuH36DHaDiRgRE9QQ2kSQDXKQZxaxFWpUqn+f58c6QpfKX6+441rC0CNoRtDhgBVbZ8ge2AQ2p3918kIEzfj6zTrIEalv9ctnrNJ0hxNoXa7P0272qCqWp5FKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XlhbK5t31z4f3jMv;
	Sat,  9 Nov 2024 11:47:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E09591A0359;
	Sat,  9 Nov 2024 11:47:59 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCHYoZu2y5nB7YNBQ--.63026S3;
	Sat, 09 Nov 2024 11:47:59 +0800 (CST)
Message-ID: <4f4f0b29-cf6e-447d-9a41-ff75bc0fa3db@huaweicloud.com>
Date: Sat, 9 Nov 2024 11:47:57 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: Fix comment describing journal_init_common()
To: =?UTF-8?B?RGFuaWVsIE1hcnTDrW4gR8OzbWV6?= <dalme@riseup.net>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241107144538.3544-1-dalme@riseup.net>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241107144538.3544-1-dalme@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYoZu2y5nB7YNBQ--.63026S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF43Ar1fWF4UCr17Wr15Jwb_yoW8AF4DpF
	97Ga40yrWUuryxuF4kCa18WFW0qw10kay7Gr1DCrn5tw4UJrn3Ar1Utr43JryUtFW7Kw10
	vF109a93G3Z0y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/11/7 22:45, Daniel Martín Gómez wrote:
> The code indicates that journal_init_common() fills the journal_t object
> it returns while the comment incorrectly states that only a few fields are
> initialised. Also, the comment claims that journal structures could be
> created from scratch which isn't possible as journal_init_common() calls
> journal_load_superblock() which loads and checks journal superblock from
> disk.
> 
> Signed-off-by: Daniel Martín Gómez <dalme@riseup.net>

Ha, thank you for the fix. This comment became stale after commit
c30713084ba5 ("jbd2:move load_superblock() into journal_init_common()") in
the "ext4,jbd2: cleanup journal load and initialization process" series.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 97f487c3d8fc..3c1d42133687 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1518,9 +1518,10 @@ static int journal_load_superblock(journal_t *journal)
>   * destroy journal_t structures, and to initialise and read existing
>   * journal blocks from disk.  */
>  
> -/* First: create and setup a journal_t object in memory.  We initialise
> - * very few fields yet: that has to wait until we have created the
> - * journal structures from from scratch, or loaded them from disk. */
> +/* The journal_init_common() function creates and fills a journal_t object
> + * in memory. It calls journal_load_superblock() to load the on-disk journal
> + * superblock and initialize the journal_t object.
> + */
>  
>  static journal_t *journal_init_common(struct block_device *bdev,
>  			struct block_device *fs_dev,


