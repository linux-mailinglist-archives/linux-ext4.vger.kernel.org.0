Return-Path: <linux-ext4+bounces-7820-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B46FBAB4BD7
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 08:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6440119E2D1B
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 06:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEED1E5B68;
	Tue, 13 May 2025 06:21:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3ADF49
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747117294; cv=none; b=BCn54AF4V9fLQsVl4lfgfqiyshRNfv2zvcN41fJSC0iv8/BrZH0DAx8o8YO/nnjddxrDYV8MNpOr2GxG17lcOK979wbhFdTUwQmJtUXqFQ61EidQpL8xcKkrBJlWoQoqDRVLppIGtoxEf8mu/gLR5C/NsDm5XDx65ZK+1yF8LZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747117294; c=relaxed/simple;
	bh=srnjUcbVXVAyv8hyPlCTeuoBirIuZGAA+Mj/Avwc71Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=MbOBEmnj+6oT5xIbFODbR356PwI/HbemChAR2CtFZsfRK9+4P6H+yfyu5Ie9L/BIJ+EQqbOxwSTMSOd+S9OLn+5lt7m8e9T8o9cyCoe3Emempi38mdYDRRTFQpK9TC6EQ6ZmtjDVGpm5zk73abdYh8bB4W3sgBd6uioiFnpGQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZxRCt5mNlznfgJ;
	Tue, 13 May 2025 14:20:10 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 01BC4180B41;
	Tue, 13 May 2025 14:21:28 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 13 May
 2025 14:21:27 +0800
Message-ID: <7b7413b5-5e70-43bf-9d01-914d5cc33c21@huawei.com>
Date: Tue, 13 May 2025 14:21:26 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] jbd2: remove journal_t argument from
 jbd2_superblock_csum()
To: Eric Biggers <ebiggers@kernel.org>
References: <20250513053809.699974-1-ebiggers@kernel.org>
 <20250513053809.699974-5-ebiggers@kernel.org>
Content-Language: en-US
CC: <linux-ext4@vger.kernel.org>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250513053809.699974-5-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/5/13 13:38, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Since jbd2_superblock_csum() no longer uses its journal_t argument,
> remove it.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/jbd2/journal.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 255fa03031d8..46a09744e27a 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -113,11 +113,11 @@ void __jbd2_debug(int level, const char *file, const char *func,
>   	va_end(args);
>   }
>   #endif
>   
>   /* Checksumming functions */
> -static __be32 jbd2_superblock_csum(journal_t *j, journal_superblock_t *sb)
> +static __be32 jbd2_superblock_csum(journal_superblock_t *sb)
>   {
>   	__u32 csum;
>   	__be32 old_csum;
>   
>   	old_csum = sb->s_checksum;
> @@ -1384,11 +1384,11 @@ static int journal_check_superblock(journal_t *journal)
>   			printk(KERN_ERR "JBD2: Unknown checksum type\n");
>   			return err;
>   		}
>   
>   		/* Check superblock checksum */
> -		if (sb->s_checksum != jbd2_superblock_csum(journal, sb)) {
> +		if (sb->s_checksum != jbd2_superblock_csum(sb)) {
>   			printk(KERN_ERR "JBD2: journal checksum error\n");
>   			err = -EFSBADCRC;
>   			return err;
>   		}
>   	}
> @@ -1819,11 +1819,11 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
>   		       journal->j_devname);
>   		clear_buffer_write_io_error(bh);
>   		set_buffer_uptodate(bh);
>   	}
>   	if (jbd2_journal_has_csum_v2or3(journal))
> -		sb->s_checksum = jbd2_superblock_csum(journal, sb);
> +		sb->s_checksum = jbd2_superblock_csum(sb);
>   	get_bh(bh);
>   	bh->b_end_io = end_buffer_write_sync;
>   	submit_bh(REQ_OP_WRITE | write_flags, bh);
>   	wait_on_buffer(bh);
>   	if (buffer_write_io_error(bh)) {



