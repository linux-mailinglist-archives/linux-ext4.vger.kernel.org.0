Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7C37776DC
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 13:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjHJLZH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 07:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjHJLZG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 07:25:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A8610D
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 04:25:05 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RM4Jh2RqhzqT12;
        Thu, 10 Aug 2023 19:22:12 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 19:25:03 +0800
Subject: Re: [bug report] ext4: convert symlink external data block mapping to
 bdev
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     <linux-ext4@vger.kernel.org>
References: <797feb23-f8c8-4ce7-b25c-b4f591be1387@moroto.mountain>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <7f69ac7e-bfad-ec37-f48b-0633583838d5@huawei.com>
Date:   Thu, 10 Aug 2023 19:25:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <797feb23-f8c8-4ce7-b25c-b4f591be1387@moroto.mountain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/8/10 18:31, Dan Carpenter wrote:
> Hello Zhang Yi,
> 
> The patch 6493792d3299: "ext4: convert symlink external data block
> mapping to bdev" from Apr 24, 2022 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	fs/ext4/namei.c:3353 ext4_init_symlink_block()
> 	error: potential NULL/IS_ERR bug 'bh'
> 
> fs/ext4/namei.c
>     3337 static int ext4_init_symlink_block(handle_t *handle, struct inode *inode,
>     3338                                    struct fscrypt_str *disk_link)
>     3339 {
>     3340         struct buffer_head *bh;
>     3341         char *kaddr;
>     3342         int err = 0;
>     3343 
>     3344         bh = ext4_bread(handle, inode, 0, EXT4_GET_BLOCKS_CREATE);
>     3345         if (IS_ERR(bh))
>     3346                 return PTR_ERR(bh);
> 
>>From reading the code, it looks like ext4_bread() can return both error
> pointers and NULL.  (Second return statement).

Hello, Dan,

After checking the code, we have passed in EXT4_GET_BLOCKS_CREATE to
ext4_bread(), the return value must be an error code or a valid
buffer_head, it's impossible to return NULL. So I think the warning
is a false positive.

Thanks,
Yi.

> 
>     3347 
>     3348         BUFFER_TRACE(bh, "get_write_access");
>     3349         err = ext4_journal_get_write_access(handle, inode->i_sb, bh, EXT4_JTR_NONE);
>     3350         if (err)
>     3351                 goto out;
>     3352 
> --> 3353         kaddr = (char *)bh->b_data;
>                                  ^^^^
> Unchecked dereference
> 
>     3354         memcpy(kaddr, disk_link->name, disk_link->len);
>     3355         inode->i_size = disk_link->len - 1;
>     3356         EXT4_I(inode)->i_disksize = inode->i_size;
>     3357         err = ext4_handle_dirty_metadata(handle, inode, bh);
>     3358 out:
>     3359         brelse(bh);
>     3360         return err;
>     3361 }
> 
> regards,
> dan carpenter
> .
> 
