Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847486AFBB5
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 02:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCHBEX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 20:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCHBEW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 20:04:22 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA07A224D;
        Tue,  7 Mar 2023 17:04:20 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PWYt34p8Sz16Nxd;
        Wed,  8 Mar 2023 09:01:31 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 09:04:18 +0800
Message-ID: <0f0ac9eb-1432-a61f-717f-88bd3d6fa7fc@huawei.com>
Date:   Wed, 8 Mar 2023 09:04:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v5 1/2] ext4: commit super block if fs record error when
 journal record without error
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
References: <20230307061703.245965-1-yebin@huaweicloud.com>
 <20230307061703.245965-2-yebin@huaweicloud.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230307061703.245965-2-yebin@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/7 14:17, Ye Bin wrote:
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
>   fs/ext4/super.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 88f7b8a88c76..dfa31eea1346 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5920,6 +5920,7 @@ static int ext4_load_journal(struct super_block *sb,
>   		err = jbd2_journal_wipe(journal, !really_read_only);
>   	if (!err) {
>   		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
> +
>   		if (save)
>   			memcpy(save, ((char *) es) +
>   			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
> @@ -5928,6 +5929,14 @@ static int ext4_load_journal(struct super_block *sb,
>   			memcpy(((char *) es) + EXT4_S_ERR_START,
>   			       save, EXT4_S_ERR_LEN);
>   		kfree(save);
> +		es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state &
> +					   EXT4_ERROR_FS);
> +		/* Write out restored error information to the superblock */
> +		if (!bdev_read_only(sb->s_bdev)) {
> +			int err2;
> +			err2 = ext4_commit_super(sb);
> +			err = err ? : err2;
> +		}
>   	}
>   
>   	if (err) {
-- 
With Best Regards,
Baokun Li
.
