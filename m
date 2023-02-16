Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60226698DA8
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 08:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBPHSD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 02:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBPHSC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 02:18:02 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F32D176;
        Wed, 15 Feb 2023 23:18:01 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PHR6x3T6Mz16Nd7;
        Thu, 16 Feb 2023 15:15:37 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Thu, 16 Feb 2023 15:17:56 +0800
Message-ID: <bcc1639b-d063-8508-baf2-3bee3c192314@huawei.com>
Date:   Thu, 16 Feb 2023 15:17:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 2/2] ext4: make sure fs error flag setted before clear
 journal error
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
References: <20230214022905.765088-1-yebin@huaweicloud.com>
 <20230214022905.765088-3-yebin@huaweicloud.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230214022905.765088-3-yebin@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/2/14 10:29, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> Now, jounral error number maybe cleared even though ext4_commit_super()
> failed. This may lead to error flag miss, then fsck will miss to check
> file system deeply.
>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
Looks good to me.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/super.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b94754ba8556..619ef6d021d4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6163,11 +6163,13 @@ static int ext4_clear_journal_err(struct super_block *sb,
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
