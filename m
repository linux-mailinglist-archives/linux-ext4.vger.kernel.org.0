Return-Path: <linux-ext4+bounces-3207-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A592E994
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79ECB2617B
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627F315EFC1;
	Thu, 11 Jul 2024 13:33:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12D4CE09;
	Thu, 11 Jul 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704785; cv=none; b=VVWIU60/voQWtRG6misuzy8M7hpxMEhn7LMbXy+xQFJ9GyqkWe+SifaGxdMsAyu0SL3h3fnK0DJBZNIuIMDwGBO7W6+cecV8ALIvEqTphU/oKIXVRE4QxJ5Uv+zHQyp39b+AtZx0U++qNnRWR5rkP0O6UCD7zjgiOfmtV8tb5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704785; c=relaxed/simple;
	bh=Avkb30PRdUlac2ai5AaEn9yduRB8QqSAkcEZ2aaOQ18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nnWrFBg0dDEzF8PATwCGrV0xebolIbFzj6tbd+tGWAABe62f8NMa73qgm8PLo12exoYsTSoYcFmthIbstkVQQ1O6qqirZgjhH3GtZ6Dq16kKnxygFsAZ6ZJzMcEskLhJfUFRqu16tgUOQOdbY0Dzz6dwDsQAVk4+xPRfjpZV9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WKbCv5VSRzQlMm;
	Thu, 11 Jul 2024 21:28:59 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id C7830140361;
	Thu, 11 Jul 2024 21:32:56 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Jul 2024 21:32:55 +0800
Message-ID: <4f9d5881-11e6-4064-ab69-ca6ef81582b3@huawei.com>
Date: Thu, 11 Jul 2024 21:32:55 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ext4: fix fast commit inode enqueueing during a full
 journal commit
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>, Theodore Ts'o
	<tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240711083520.6751-1-luis.henriques@linux.dev>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <20240711083520.6751-1-luis.henriques@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2024/7/11 16:35, Luis Henriques (SUSE) wrote:
> When a full journal commit is on-going, any fast commit has to be enqueued
> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
> is done only once, i.e. if an inode is already queued in a previous fast
> commit entry it won't be enqueued again.  However, if a full commit starts
> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
> be done into FC_Q_STAGING.  And this is not being done in function
> ext4_fc_track_template().
> 
> This patch fixes the issue by re-enqueuing an inode into the STAGING queue
> during the fast commit clean-up callback if it has a tid (i_sync_tid)
> greater than the one being handled.  The STAGING queue will then be spliced
> back into MAIN.
> 
> This bug was found using fstest generic/047.  This test creates several 32k
> bytes files, sync'ing each of them after it's creation, and then shutting
> down the filesystem.  Some data may be loss in this operation; for example a
> file may have it's size truncated to zero.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
> Hi!
> 
> v4 of this patch enqueues the inode into STAGING *only* if the current tid
> is non-zero.  It will be zero when doing an fc commit, and this would mean
> to always re-enqueue the inode.  This fixes the regressions caught by Ted
> in v3 with fstests generic/472 generic/496 generic/643.
> 
> Also, since 2nd patch of v3 has already been merged, I've rebased this patch
> to be applied on top of it.
> 
>   fs/ext4/fast_commit.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 3926a05eceee..facbc8dbbaa2 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1290,6 +1290,16 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>   				       EXT4_STATE_FC_COMMITTING);
>   		if (tid_geq(tid, iter->i_sync_tid))
>   			ext4_fc_reset_inode(&iter->vfs_inode);
> +		} else if (tid) {
> +			/*
> +			 * If the tid is valid (i.e. non-zero) re-enqueue the
one quick question about tid, if one disk is using long time and its tid 
  get wrapped to 0, is it a valid seq? I don't find code handling this 
situation.
> +			 * inode into STAGING, which will then be splice back
> +			 * into MAIN
> +			 */
> +			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
> +				      &sbi->s_fc_q[FC_Q_STAGING]);
> +		}
> +
>   		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
>   		smp_mb();
>   #if (BITS_PER_LONG < 64)
> 
-- 
Regards


