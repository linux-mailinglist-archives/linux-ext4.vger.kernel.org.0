Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727266A78DF
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Mar 2023 02:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjCBBaK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 20:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCBBaK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 20:30:10 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC43E1B33E;
        Wed,  1 Mar 2023 17:30:08 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PRth32ct2zKmSx;
        Thu,  2 Mar 2023 09:25:07 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 09:30:06 +0800
Message-ID: <7d83b111-3fd0-f410-6904-17c830496621@huawei.com>
Date:   Thu, 2 Mar 2023 09:30:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 1/2] ext4: commit super block if fs record error when
 journal record without error
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
References: <20230301115909.184772-1-yebin@huaweicloud.com>
 <20230301115909.184772-2-yebin@huaweicloud.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230301115909.184772-2-yebin@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
> Now, 'es->s_state' maybe covered by recover journal. And journal errno
> maybe not recorded in journal sb as IO error. ext4_update_super() only
> update error information when 'sbi->s_add_error_count' large than zero.
> Then 'EXT4_ERROR_FS' flag maybe lost.
> To solve above issue just recover 'es->s_state' error flag after journal
> replay like error info.
>
> Signed-off-by: Ye Bin <yebin10@huawei.com>


Looks good to me.

Reviewed-by: Baokun Li <libaokun1@huawei.com>


> ---
>   fs/ext4/super.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index faae05493471..9df8fada2dce 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5910,7 +5910,9 @@ static int ext4_load_journal(struct super_block *sb,
>   	if (!ext4_has_feature_journal_needs_recovery(sb))
>   		err = jbd2_journal_wipe(journal, !really_read_only);
>   	if (!err) {
> +		int err2;
>   		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
> +
>   		if (save)
>   			memcpy(save, ((char *) es) +
>   			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
> @@ -5919,6 +5921,11 @@ static int ext4_load_journal(struct super_block *sb,
>   			memcpy(((char *) es) + EXT4_S_ERR_START,
>   			       save, EXT4_S_ERR_LEN);
>   		kfree(save);
> +		es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state &
> +					   EXT4_ERROR_FS);
> +		/* Write out restored error information to the superblock */
> +		err2 = ext4_commit_super(sb);
> +		err = err ? : err2;
>   	}
>   
>   	if (err) {
-- 
With Best Regards,
Baokun Li
.
