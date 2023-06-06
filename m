Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D8D723CA1
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjFFJL3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 05:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjFFJL2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 05:11:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14269E8
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 02:11:26 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qb4Rp6rfFz1c0Gk;
        Tue,  6 Jun 2023 17:09:42 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 17:11:24 +0800
Message-ID: <229e0949-0d71-209e-228f-3bab816c21bd@huawei.com>
Date:   Tue, 6 Jun 2023 17:11:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] tune2fs/fuse2fs/debugfs: save error information
 during journal replay
To:     Baokun Li <libaokun1@huawei.com>, <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>
References: <20230217100922.588961-1-libaokun1@huawei.com>
 <20230217100922.588961-3-libaokun1@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230217100922.588961-3-libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100013.china.huawei.com (7.185.36.238) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2023/2/17 18:09, Baokun Li wrote:
> Saving error information during journal replay, as in the kernel,
> prevents information loss from making problems difficult to locate.
> We save these error information until someone uses e2fsck to check
> for and fix possible errors.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: zhanchengbin <zhanchengbin1@huawei.com>

  - bin.

> ---
>   debugfs/journal.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/debugfs/journal.c b/debugfs/journal.c
> index 5bac0d3b..79e3fff8 100644
> --- a/debugfs/journal.c
> +++ b/debugfs/journal.c
> @@ -789,6 +789,8 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
>   	char *fsname;
>   	int fsflags;
>   	int fsblocksize;
> +	char *save;
> +	__u16 s_error_state;
>   
>   	if (!(fs->flags & EXT2_FLAG_RW))
>   		return EXT2_ET_FILE_RO;
> @@ -808,6 +810,12 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
>   	if (stats && stats->bytes_written)
>   		kbytes_written = stats->bytes_written >> 10;
>   
> +	save = malloc(EXT4_S_ERR_LEN);
> +	if (save)
> +		memcpy(save, ((char *) fs->super) + EXT4_S_ERR_START,
> +		       EXT4_S_ERR_LEN);
> +	s_error_state = fs->super->s_state & EXT2_ERROR_FS;
> +
>   	ext2fs_mmp_stop(fs);
>   	fsname = fs->device_name;
>   	fs->device_name = NULL;
> @@ -818,11 +826,15 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
>   	retval = ext2fs_open(fsname, fsflags, 0, fsblocksize, io_ptr, fsp);
>   	ext2fs_free_mem(&fsname);
>   	if (retval)
> -		return retval;
> +		goto outfree;
>   
>   	fs = *fsp;
>   	fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
>   	fs->super->s_kbytes_written += kbytes_written;
> +	fs->super->s_state |= s_error_state;
> +	if (save)
> +		memcpy(((char *) fs->super) + EXT4_S_ERR_START, save,
> +		       EXT4_S_ERR_LEN);
>   
>   	/* Set the superblock flags */
>   	ext2fs_clear_recover(fs, recover_retval != 0);
> @@ -832,6 +844,9 @@ errcode_t ext2fs_run_ext3_journal(ext2_filsys *fsp)
>   	 * the EXT2_ERROR_FS flag in the fs superblock if needed.
>   	 */
>   	retval = ext2fs_check_ext3_journal(fs);
> +
> +outfree:
> +	free(save);
>   	return retval ? retval : recover_retval;
>   }
>   
> 
