Return-Path: <linux-ext4+bounces-3072-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C65719238BC
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jul 2024 10:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64CD8B210C4
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jul 2024 08:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF7D14883E;
	Tue,  2 Jul 2024 08:48:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416484D39
	for <linux-ext4@vger.kernel.org>; Tue,  2 Jul 2024 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910104; cv=none; b=kL5IPlxQTCTGQpO7mEnjDDwElkcgttXk5GwtbAhlPICdLri4pbLi2nXoaEKsXkdj629nEeoNhm/VpeoxPmBdZMukkCfaNoUwLM84gwpaVxUzOpfgmAV0Q6P8u6EescDWOoAXOFrr7sjAF47fUOoMgaHJ0mW7CNUbMgLzOb889Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910104; c=relaxed/simple;
	bh=4edfhMyF5LHKAjSC0yvGfsFzRyHFDDt8kSPqa+fik5c=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J/sOzfKCDxnd9DheHbwVMzIDrTXqsaMFZxLPe35uzwx9hO+e2G9KFo8fW6/xODqI6QHyE6I7Yz2A/FK535mDs2Vtb9P5HVjD/socY0zbeOmotJOVBIY7IJ+FDWYg3Emr+zgEhFU1Ig5IuTQB62/HMq50C9fhc3p0DYqAKVdGa8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WCxKN53gzz2Cknx;
	Tue,  2 Jul 2024 16:44:08 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id F013418002B;
	Tue,  2 Jul 2024 16:48:13 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jul 2024 16:48:13 +0800
Subject: Re: [PATCH] jbd2: Increase maximum transaction size
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, Ted Tso <tytso@mit.edu>
References: <20240701132800.7158-1-jack@suse.cz>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <163ae0a0-f0c7-de10-0810-50b60c00651e@huawei.com>
Date: Tue, 2 Jul 2024 16:48:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240701132800.7158-1-jack@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/7/1 21:28, Jan Kara wrote:
> Originally, we were quite conservative in limiting maximum transaction
> size to a quarter of the journal because we were not accounting
> transaction descriptor and revoke blocks. These days we do properly
> account them and reserve space for them from the total transaction
> credits. Thus there's no need to be so conservative and we can increase
> the maximum transaction size to one third of the journal (even half
> should work fine in principle but the performance will likely suffer in
> that case). This also fixes failures to grow filesystems with tiny
> journals.
> 

This looks straightforward and reasonable to me. I've done some metadata
intensive performance tests with fs_mark, no obvious degradation and
fluctuation has been found.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Thanks,
Yi.

> Link: CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/jbd2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index ab04c1c27fae..7273ef1732bf 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1662,7 +1662,7 @@ int jbd2_fc_release_bufs(journal_t *journal);
>  
>  static inline int jbd2_journal_get_max_txn_bufs(journal_t *journal)
>  {
> -	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
> +	return (journal->j_total_len - journal->j_fc_wbufsize) / 3;
>  }
>  
>  /*
> 

