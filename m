Return-Path: <linux-ext4+bounces-11697-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9953AC42646
	for <lists+linux-ext4@lfdr.de>; Sat, 08 Nov 2025 04:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127393B705F
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Nov 2025 03:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667302D3A7B;
	Sat,  8 Nov 2025 03:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="z+OFQe8c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9607D098
	for <linux-ext4@vger.kernel.org>; Sat,  8 Nov 2025 03:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762574119; cv=none; b=Qs/RZ9dxGrVGcYq9bZUQG9yFsOhA3oRudrMheUXHOMRkbTdtDuiQMPaZycUWlyRavWrQAYijiGaE7FuFTm+FFQnYXJvz+LFNtw+jS6ujNQsIwakGtahDavyx+22oPS4odW3w1JpY3YDW8DQaGvHbJhfCvVlS/4JjuxfejeRArDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762574119; c=relaxed/simple;
	bh=KR+X32PpwVpEOO08zVik+s6kP9+lVgZQEjyjHdu1Kfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iPmomodLnhcJvJQiaQpeLMbxq1lc48XYbUD4qtm2Va+DH/YeVTTurnEWy0DVuqmLvvBMYIjZwvjVlJMs8y6k/MvJ9MSbH8ZeLBZb6RoIfiMYqInIB95SMawR6A4nzTJGsCEWb73BahuVlwSXrI8/EfhJboQUOMurgJEarG2Lkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=z+OFQe8c; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=d6RxkWxtdTbMtb/K0EZCVnhRx0xGZ+mRRTv6q61zDK8=;
	b=z+OFQe8cRdHA0B1at6t14IF8yBealNzi/Bd4o+KGKEtIeZYHAAUrujHzz8OOaetNomzO5eW0I
	5HneTNviHAaPiSkCky78LmcvUhy4KTO02tlTt0PTc8AGON/W+yAT9R564arEPTYY9mo044xrQ7w
	HoNHUazz9OMCvKczGknAZp8=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d3MV770jMz1cyT1;
	Sat,  8 Nov 2025 11:53:35 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 40DCE140142;
	Sat,  8 Nov 2025 11:55:13 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Nov
 2025 11:55:12 +0800
Message-ID: <212cc909-0236-44b1-b492-2e148f0d1546@huawei.com>
Date: Sat, 8 Nov 2025 11:55:11 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] jbd2: fix the inconsistency between checksum and data
 in memory for journal sb
Content-Language: en-GB
To: Ye Bin <yebin@huaweicloud.com>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-ext4@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20251103010123.3753631-1-yebin@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251103010123.3753631-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-03 09:01, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> Copying the file system while it is mounted as read-only results in
> a mount failure:
> [~]# mkfs.ext4 -F /dev/sdc
> [~]# mount /dev/sdc -o ro /mnt/test
> [~]# dd if=/dev/sdc of=/dev/sda bs=1M
> [~]# mount /dev/sda /mnt/test1
> [ 1094.849826] JBD2: journal checksum error
> [ 1094.850927] EXT4-fs (sda): Could not load journal inode
> mount: mount /dev/sda on /mnt/test1 failed: Bad message
>
> The process described above is just an abstracted way I came up with to
> reproduce the issue. In the actual scenario, the file system was mounted
> read-only and then copied while it was still mounted. It was found that
> the mount operation failed. The user intended to verify the data or use
> it as a backup, and this action was performed during a version upgrade.
> Above issue may happen as follows:
> ext4_fill_super
>  set_journal_csum_feature_set(sb)
>   if (ext4_has_metadata_csum(sb))
>    incompat = JBD2_FEATURE_INCOMPAT_CSUM_V3;
>   if (test_opt(sb, JOURNAL_CHECKSUM)
>    jbd2_journal_set_features(sbi->s_journal, compat, 0, incompat);
>     lock_buffer(journal->j_sb_buffer);
>     sb->s_feature_incompat  |= cpu_to_be32(incompat);
>     //The data in the journal sb was modified, but the checksum was not
>       updated, so the data remaining in memory has a mismatch between the
>       data and the checksum.
>     unlock_buffer(journal->j_sb_buffer);
>
> In this case, the journal sb copied over is in a state where the checksum
> and data are inconsistent, so mounting fails.
> To solve the above issue, update the checksum in memory after modifying
> the journal sb.
>
> Fixes: 4fd5ea43bc11 ("jbd2: checksum journal superblock")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Updating features on a read-only mount looks strange, but we still need
to update the checksum when touching the jbd2 superblock.

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/jbd2/journal.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..bf255f8b5eeb 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2349,6 +2349,12 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
>  	sb->s_feature_compat    |= cpu_to_be32(compat);
>  	sb->s_feature_ro_compat |= cpu_to_be32(ro);
>  	sb->s_feature_incompat  |= cpu_to_be32(incompat);
> +	/*
> +	 * Update the checksum now so that it is valid even for read-only
> +	 * filesystems where jbd2_write_superblock() doesn't get called.
> +	 */
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		sb->s_checksum = jbd2_superblock_csum(sb);
>  	unlock_buffer(journal->j_sb_buffer);
>  	jbd2_journal_init_transaction_limits(journal);
>  
> @@ -2378,9 +2384,17 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
>  
>  	sb = journal->j_superblock;
>  
> +	lock_buffer(journal->j_sb_buffer);
>  	sb->s_feature_compat    &= ~cpu_to_be32(compat);
>  	sb->s_feature_ro_compat &= ~cpu_to_be32(ro);
>  	sb->s_feature_incompat  &= ~cpu_to_be32(incompat);
> +	/*
> +	 * Update the checksum now so that it is valid even for read-only
> +	 * filesystems where jbd2_write_superblock() doesn't get called.
> +	 */
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		sb->s_checksum = jbd2_superblock_csum(sb);
> +	unlock_buffer(journal->j_sb_buffer);
>  	jbd2_journal_init_transaction_limits(journal);
>  }
>  EXPORT_SYMBOL(jbd2_journal_clear_features);



