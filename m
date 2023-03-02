Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074336A78D9
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Mar 2023 02:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjCBB0P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 20:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBB0P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 20:26:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DA0498A1;
        Wed,  1 Mar 2023 17:26:13 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PRtfB6fcTznWQ7;
        Thu,  2 Mar 2023 09:23:30 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 09:26:10 +0800
Message-ID: <287af40c-4ac9-d773-830a-6daa1f16102a@huawei.com>
Date:   Thu, 2 Mar 2023 09:26:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 2/2] ext4: make sure fs error flag setted before clear
 journal error
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
References: <20230301115909.184772-1-yebin@huaweicloud.com>
 <20230301115909.184772-3-yebin@huaweicloud.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230301115909.184772-3-yebin@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/1 19:59, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> Now, jounral error number maybe cleared even though ext4_commit_super()
> failed. This may lead to error flag miss, then fsck will miss to check
> file system deeply.
>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>


Looks good to me.

Reviewed-by: Baokun Li <libaokun1@huawei.com>


> ---
>   fs/ext4/super.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9df8fada2dce..7736c96d5a78 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6152,11 +6152,13 @@ static int ext4_clear_journal_err(struct super_block *sb,
>   		errstr = ext4_decode_error(sb, j_errno, nbuf);
>   		ext4_warning(sb, "Filesystem error recorded "
>   			     "from previous mount: %s", errstr);
> -		ext4_warning(sb, "Marking fs in need of filesystem check.");
>   
>   		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
>   		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
> -		ext4_commit_super(sb);
> +		j_errno = ext4_commit_super(sb);
> +		if (j_errno)
> +			return j_errno;
> +		ext4_warning(sb, "Marked fs in need of filesystem check.");
>   
>   		jbd2_journal_clear_err(journal);
>   		jbd2_journal_update_sb_errno(journal);
-- 
With Best Regards,
Baokun Li
.
