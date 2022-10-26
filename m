Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9F860E2C8
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Oct 2022 15:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiJZN7v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Oct 2022 09:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiJZN7k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Oct 2022 09:59:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0901BEA4;
        Wed, 26 Oct 2022 06:59:37 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4My9Kh11fpzVj5T;
        Wed, 26 Oct 2022 21:54:48 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 21:59:35 +0800
Subject: Re: [PATCH v3 3/4] ext4: add EXT4_IGET_BAD flag to prevent unexpected
 bad inode
To:     Baokun Li <libaokun1@huawei.com>, <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
References: <20221026042310.3839669-1-libaokun1@huawei.com>
 <20221026042310.3839669-4-libaokun1@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <1cb8a9de-5fb1-a6c0-3d38-479d57ae3e15@huawei.com>
Date:   Wed, 26 Oct 2022 21:59:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221026042310.3839669-4-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2022/10/26 12:23, Baokun Li wrote:
> There are many places that will get unhappy (and crash) when ext4_iget()
> returns a bad inode. However, if iget the boot loader inode, allows a bad
> inode to be returned, because the inode may not be initialized. This
> mechanism can be used to bypass some checks and cause panic. To solve this
> problem, we add a special iget flag EXT4_IGET_BAD. Only with this flag
> we'd be returning bad inode from ext4_iget(), otherwise we always return
> the error code if the inode is bad inode.(suggested by Jan Kara)
> 
> Signed-off-by: Baokun Li<libaokun1@huawei.com>
> ---
>   fs/ext4/ext4.h  | 3 ++-
>   fs/ext4/inode.c | 8 +++++++-
>   fs/ext4/ioctl.c | 3 ++-
>   3 files changed, 11 insertions(+), 3 deletions(-)

Looks good,
Reviewed-by: Jason Yan <yanaijie@huawei.com>
