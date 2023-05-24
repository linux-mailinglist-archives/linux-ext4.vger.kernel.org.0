Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D47870EF6B
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 09:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbjEXHam (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 May 2023 03:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjEXHal (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 May 2023 03:30:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF858F;
        Wed, 24 May 2023 00:30:40 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QR2p574FHzLpvb;
        Wed, 24 May 2023 15:27:41 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 15:30:37 +0800
Message-ID: <80efff2a-17e5-c5bd-3e61-59c207cc2343@huawei.com>
Date:   Wed, 24 May 2023 15:30:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 00/12] ext4: fix WARNING in
 ext4_da_update_reserve_space
Content-Language: en-US
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230424033846.4732-1-libaokun1@huawei.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230424033846.4732-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A gentle ping too.

On 2023/4/24 11:38, Baokun Li wrote:
> V1->V2:
>          Modify the patch 1 description and add the Fixes tag.
>          Add the patch 2 as suggested by Jan Kara.
> V2->V3:
>          Remove the redundant judgment of count in Patch [1].
>          Rename ext4_es_alloc_should_nofail to ext4_es_must_keep.
>          Split Patch [2].
>          Make some functions return void to simplify the code.
> V3->V4:
>          using nofail preallocation.
>
> This patch set consists of three parts:
> 1. Patch [1] fix WARNING in ext4_da_update_reserve_space.
> 2. Patch [2]-[8] fix extent tree inconsistencies that may be caused
>     by memory allocation failures.
> 3. Patch [9]-[12] is cleanup.
>
> Baokun Li (12):
>    ext4: only update i_reserved_data_blocks on successful block
>      allocation
>    ext4: add a new helper to check if es must be kept
>    ext4: factor out __es_alloc_extent() and __es_free_extent()
>    ext4: use pre-allocated es in __es_insert_extent()
>    ext4: use pre-allocated es in __es_remove_extent()
>    ext4: using nofail preallocation in ext4_es_remove_extent()
>    ext4: using nofail preallocation in ext4_es_insert_delayed_block()
>    ext4: using nofail preallocation in ext4_es_insert_extent()
>    ext4: make ext4_es_remove_extent() return void
>    ext4: make ext4_es_insert_delayed_block() return void
>    ext4: make ext4_es_insert_extent() return void
>    ext4: make ext4_zeroout_es() return void
>
>   fs/ext4/extents.c        |  49 +++------
>   fs/ext4/extents_status.c | 207 ++++++++++++++++++++++++---------------
>   fs/ext4/extents_status.h |  14 +--
>   fs/ext4/indirect.c       |   8 ++
>   fs/ext4/inline.c         |  12 +--
>   fs/ext4/inode.c          |  49 ++-------
>   6 files changed, 169 insertions(+), 170 deletions(-)
>

