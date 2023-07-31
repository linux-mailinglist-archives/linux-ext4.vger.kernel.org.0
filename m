Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB51769655
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jul 2023 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGaMa1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jul 2023 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGaMa0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 Jul 2023 08:30:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31818B2;
        Mon, 31 Jul 2023 05:30:25 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RDyD04VMjzNmcQ;
        Mon, 31 Jul 2023 20:26:56 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 20:30:21 +0800
Subject: Re: [PATCH v2] ext4: Fix rec_len verify error
To:     zhangshida <starzhangzsd@gmail.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhangshida@kylinos.cn>
References: <20230731010104.1781335-1-zhangshida@kylinos.cn>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <558eed4b-3817-671e-48f1-3f9933486876@huawei.com>
Date:   Mon, 31 Jul 2023 20:30:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230731010104.1781335-1-zhangshida@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/7/31 9:01, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
> a problem occurred when more than 13 million files were directly created
> under a directory:
> 
> EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
> EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xxxxx: Directory index failed checksum
> 
> When enough files are created, the fake_dirent->reclen will be 0xffff.
> it doesn't equal to the blocksize 65536, i.e. 0x10000.
> 
> But it is not the same condition when blocksize equals to 4k.
> when enough file are created, the fake_dirent->reclen will be 0x1000.
> it equals to the blocksize 4k, i.e. 0x1000.
> 
> The problem seems to be related to the limitation of the 16-bit field
> when the blocksize is set to 64k. To address this, Modify the check so
> as to handle it properly.
> 

Thanks for the patch. It works and looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
> v1->v2:
>   Use a better way to check the condition, as suggested by Andreas.
> 
>  fs/ext4/namei.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 0caf6c730ce3..fffed95f8531 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -445,8 +445,9 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
>  	struct ext4_dir_entry *dp;
>  	struct dx_root_info *root;
>  	int count_offset;
> +	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
>  
> -	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
> +	if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) == blocksize)
>  		count_offset = 8;
>  	else if (le16_to_cpu(dirent->rec_len) == 12) {
>  		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
> 
