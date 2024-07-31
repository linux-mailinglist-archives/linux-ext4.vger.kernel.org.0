Return-Path: <linux-ext4+bounces-3574-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7E942DCB
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 14:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322981C23869
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E6C1AE843;
	Wed, 31 Jul 2024 12:08:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E11AD9F4;
	Wed, 31 Jul 2024 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427712; cv=none; b=OkgDv5NSfwMlk43J+K0Lnl9llOzYKT3lavEce4aWkoJn56FaqyhXcRcwf+0Qb6R405BEO8iAc3v9FPKkpOOLpdZY/Cvphl68Z93SECby1+NHzPBQ7SixYwEAG3omBnsApHUm0Z2AU6rMkIkP02x+ACE4QJ0FkOolNgWPtwtz5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427712; c=relaxed/simple;
	bh=sNUu1HDN1FlTXipUtefdEZ4bTSifsdjWWIskfulLvzQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H/0pcMvbyMR6Ge126rr0AYMgEbuU5gR/H7n7AEIOWJzMObraPr+BAtlC4ikbI3DJbxLZVQ3c7CV1DI907P0Hqjdai/P5jnW6u8u8ZOa6qyUXnogpY6QhlkeTUgLdDDxq1d7w9Eq+9Sv/h+r2a2Q+OpEYchairHdR5lt39DJkLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WYrTV0qHZzxSRy;
	Wed, 31 Jul 2024 20:08:14 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id BF453180AE3;
	Wed, 31 Jul 2024 20:08:25 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 31 Jul 2024 20:08:25 +0800
Subject: Re: [PATCH v3 8/8] jbd2: remove unneeded check of ret in
 jbd2_fc_get_buf
To: Kemeng Shi <shikemeng@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <jack@suse.com>
References: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
 <20240731092910.2383048-9-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <5567bcc4-08e4-9fae-df1d-10bda50efef4@huawei.com>
Date: Wed, 31 Jul 2024 20:08:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240731092910.2383048-9-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/7/31 17:29, Kemeng Shi wrote:
> Simply return -EINVAL if j_fc_off is invalid to avoid repeated check of
> ret.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index e89d777ded34..c5179aa38111 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -837,17 +837,12 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
>  
>  	*bh_out = NULL;
>  
> -	if (journal->j_fc_off + journal->j_fc_first < journal->j_fc_last) {
> -		fc_off = journal->j_fc_off;
> -		blocknr = journal->j_fc_first + fc_off;
> -		journal->j_fc_off++;
> -	} else {
> -		ret = -EINVAL;
> -	}
> -
> -	if (ret)
> -		return ret;
> +	if (journal->j_fc_off + journal->j_fc_first >= journal->j_fc_last)
> +		return -EINVAL;
>  
> +	fc_off = journal->j_fc_off;
> +	blocknr = journal->j_fc_first + fc_off;
> +	journal->j_fc_off++;
>  	ret = jbd2_journal_bmap(journal, blocknr, &pblock);
>  	if (ret)
>  		return ret;
> @@ -856,7 +851,6 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
>  	if (!bh)
>  		return -ENOMEM;
>  
> -
>  	journal->j_fc_wbuf[fc_off] = bh;
>  
>  	*bh_out = bh;
> 

