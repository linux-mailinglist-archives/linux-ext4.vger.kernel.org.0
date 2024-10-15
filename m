Return-Path: <linux-ext4+bounces-4585-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB41599DC32
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Oct 2024 04:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A20B1F23A4E
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Oct 2024 02:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CDC16C6A1;
	Tue, 15 Oct 2024 02:23:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F15E1684A1;
	Tue, 15 Oct 2024 02:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728958982; cv=none; b=bhVRStWdJAYJh654Q55mLvJ8vrRrbbIvokUtKuMvxFq3xuwTRDI7UpmrQJE5kIPqdmdkPErYjnFO1XXJJFMzDoW1UxuWzmRN12wtTTJ0esHKGz2QFWlrOtk85/clO60OjmKZd6pAgJzSPwPHMx/yvt1a39Cof7S+aYdpiD4OSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728958982; c=relaxed/simple;
	bh=rdYOTdpztT1U6d2yi8Lx6TA9bl1Cndl899vpp4ZpFbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M2RThDN4KR6DDKPEryQtv77Df4e6TDZGgtrcvtDVY8Cv30JjeKQT6bIVCyDk+0vQRByUzMZ5Mq/Wv4ae522AW7FpXefB5fNDL0M9+qrnAzSdRN9JxTUQn3U38x8+dZmmJXM6uc7vdNTJaOBRZa+6khITs6gCG3fnGtPht1E7fL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XSHtF36Vrz20qFt;
	Tue, 15 Oct 2024 10:22:13 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D9E81A0171;
	Tue, 15 Oct 2024 10:22:56 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Oct 2024 10:22:55 +0800
Message-ID: <1cb1b78b-6431-4e70-89b8-2c6b0fc10090@huawei.com>
Date: Tue, 15 Oct 2024 10:22:54 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: Make b_frozen_data allocation always succeed
To: Zhihao Cheng <chengzhihao@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <tytso@mit.edu>, <jack@suse.com>
References: <20241012085530.2147846-1-chengzhihao@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20241012085530.2147846-1-chengzhihao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/10/12 16:55, Zhihao Cheng wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> The b_frozen_data allocation should not be failed during journal
> committing process, otherwise jbd2 will abort.
> Since commit 490c1b444ce653d("jbd2: do not fail journal because of
> frozen_buffer allocation failure") already added '__GFP_NOFAIL' flag
> in do_get_write_access(), just add '__GFP_NOFAIL' flag for all allocations
> in jbd2_journal_write_metadata_buffer(), like 'new_bh' allocation does.
> Besides, remove all error handling branches for do_get_write_access().
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/commit.c  | 4 ----
>  fs/jbd2/journal.c | 8 +-------
>  2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 4305a1ac808a..9153ff3a08e7 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -662,10 +662,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		JBUFFER_TRACE(jh, "ph3: write metadata");
>  		escape = jbd2_journal_write_metadata_buffer(commit_transaction,
>  						jh, &wbuf[bufs], blocknr);
> -		if (escape < 0) {
> -			jbd2_journal_abort(journal, escape);
> -			continue;
> -		}
>  		jbd2_file_log_bh(&io_bufs, wbuf[bufs]);
>  
>  		/* Record the new block's tag in the current descriptor
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 97f487c3d8fc..29d30eddf727 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -318,7 +318,6 @@ static inline void jbd2_data_do_escape(char *data)
>   *
>   *
>   * Return value:
> - *  <0: Error
>   *  =0: Finished OK without escape
>   *  =1: Finished OK with escape
>   */
> @@ -386,12 +385,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  			goto escape_done;
>  
>  		spin_unlock(&jh_in->b_state_lock);
> -		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
> -		if (!tmp) {
> -			brelse(new_bh);
> -			free_buffer_head(new_bh);
> -			return -ENOMEM;
> -		}
> +		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS | __GFP_NOFAIL);
>  		spin_lock(&jh_in->b_state_lock);
>  		if (jh_in->b_frozen_data) {
>  			jbd2_free(tmp, bh_in->b_size);


