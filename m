Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE186F10DB
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 05:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345112AbjD1DjT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Apr 2023 23:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345044AbjD1DjS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Apr 2023 23:39:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399F426B1
        for <linux-ext4@vger.kernel.org>; Thu, 27 Apr 2023 20:39:15 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q6ysT53hZzSsMy;
        Fri, 28 Apr 2023 11:34:53 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 11:39:13 +0800
Subject: Re: [PATCH 2/3] ext4: reflect error codes from
 ext4_multi_mount_protect() to its callers
To:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
CC:     Andreas Dilger <adilger@dilger.ca>,
        Andreas Dilger <adilger.kernel@dilger.ca>
References: <20230428031602.242297-1-tytso@mit.edu>
 <20230428031602.242297-3-tytso@mit.edu>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <0f866806-cc6a-c0f0-c3cc-3e5e231c8604@huawei.com>
Date:   Fri, 28 Apr 2023 11:39:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230428031602.242297-3-tytso@mit.edu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/4/28 11:16, Theodore Ts'o wrote:
> This will allow more fine-grained errno codes to be returned by the
> mount system call.
> 
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>   fs/ext4/mmp.c   |  9 ++++++++-
>   fs/ext4/super.c | 14 +++++++++-----
>   2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 4681fff6665f..4022bc713421 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -282,6 +282,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
>   	if (mmp_block < le32_to_cpu(es->s_first_data_block) ||
>   	    mmp_block >= ext4_blocks_count(es)) {
>   		ext4_warning(sb, "Invalid MMP block in superblock");
> +		retval = -EINVAL;
>   		goto failed;
>   	}
>   
> @@ -307,6 +308,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
>   
>   	if (seq == EXT4_MMP_SEQ_FSCK) {
>   		dump_mmp_msg(sb, mmp, "fsck is running on the filesystem");
> +		retval = -EBUSY;
>   		goto failed;
>   	}
>   
> @@ -320,6 +322,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
>   
>   	if (schedule_timeout_interruptible(HZ * wait_time) != 0) {
>   		ext4_warning(sb, "MMP startup interrupted, failing mount\n");
> +		retval = -ETIMEDOUT;
>   		goto failed;
>   	}
>   
> @@ -330,6 +333,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
>   	if (seq != le32_to_cpu(mmp->mmp_seq)) {
>   		dump_mmp_msg(sb, mmp,
>   			     "Device is already active on another node.");
> +		retval = -EBUSY;
>   		goto failed;
>   	}
>   
> @@ -349,6 +353,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
>   	 */
>   	if (schedule_timeout_interruptible(HZ * wait_time) != 0) {
>   		ext4_warning(sb, "MMP startup interrupted, failing mount");
> +		retval = -ETIMEDOUT;
>   		goto failed;
>   	}
>   
> @@ -359,6 +364,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
>   	if (seq != le32_to_cpu(mmp->mmp_seq)) {
>   		dump_mmp_msg(sb, mmp,
>   			     "Device is already active on another node.");
> +		retval = -EBUSY;
>   		goto failed;
>   	}
>   
> @@ -378,6 +384,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
>   		EXT4_SB(sb)->s_mmp_tsk = NULL;
>   		ext4_warning(sb, "Unable to create kmmpd thread for %s.",
>   			     sb->s_id);
> +		retval = -ENOMEM;
>   		goto failed;
>   	}
>   
> @@ -385,5 +392,5 @@ int ext4_multi_mount_protect(struct super_block *sb,
>   
>   failed:
>   	brelse(bh);
> -	return 1;
> +	return retval;
>   }
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b11907e1fab2..9a8af70815b1 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5329,9 +5329,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>   			  ext4_has_feature_orphan_present(sb) ||
>   			  ext4_has_feature_journal_needs_recovery(sb));
>   
> -	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb))
> -		if (ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block)))
> +	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb)) {
> +		err = ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block));
> +		if (err)
>   			goto failed_mount3a;
> +	}
>   
>   	/*
>   	 * The first inode we look at is the journal inode.  Don't try
> @@ -6566,12 +6568,14 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>   				goto restore_opts;
>   
>   			sb->s_flags &= ~SB_RDONLY;
> -			if (ext4_has_feature_mmp(sb))
> -				if (ext4_multi_mount_protect(sb,
> -						le64_to_cpu(es->s_mmp_block))) {
> +			if (ext4_has_feature_mmp(sb)) {
> +				err = ext4_multi_mount_protect(sb,
> +						le64_to_cpu(es->s_mmp_block));
> +				if (err) {
>   					err = -EROFS;

So shall we return the fine-grained errno from 
ext4_multi_mount_protect() instead of -EROFS here?

Thanks,
Jason
