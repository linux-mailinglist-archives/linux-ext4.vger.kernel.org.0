Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0583772923B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jun 2023 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbjFIIGv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Jun 2023 04:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbjFIIGj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Jun 2023 04:06:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE53335BD;
        Fri,  9 Jun 2023 01:05:17 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qctly6kJpz18Lnb;
        Fri,  9 Jun 2023 15:59:58 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 16:04:47 +0800
Subject: Re: [PATCH v3 0/6] ext4: Fix stale buffer loading from last failed
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230315013128.3911115-1-chengzhihao1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f67f0b5c-d02b-7a72-e723-a10336739249@huawei.com>
Date:   Fri, 9 Jun 2023 16:04:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230315013128.3911115-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ÔÚ 2023/3/15 9:31, Zhihao Cheng Ð´µÀ:
> Patch 1 fixes reusing stale buffer heads from last failed mounting.
> Patch 2~4 reconstructs 'j_format_version' initialization and checking
> in loading process.
> 
> v1->v2:
>    Adopt suggestions from Tudor, add fix tag and corrupt 'stable' field
>    in patch 1.
>    Reserve empty lines in patch 4.
> v2->v3:
>    Split block device checking cleanup into a new patch (2th).
>    Add 'Reviewed-by' tag in patch 3-6.
> 
> 
> Zhang Yi (4):
>    jbd2: remove unused feature macros
>    jbd2: switch to check format version in superblock directly
>    jbd2: factor out journal initialization from journal_get_superblock()
>    jbd2: remove j_format_version
> 
> Zhihao Cheng (2):
>    ext4: Fix reusing stale buffer heads from last failed mounting
>    ext4: ext4_put_super: Remove redundant checking for
>      'sbi->s_journal_bdev'
> 
>   fs/ext4/super.c      | 15 +++++++------
>   fs/jbd2/journal.c    | 53 +++++++++++++++++---------------------------
>   include/linux/jbd2.h | 33 ++++++++++++---------------
>   3 files changed, 42 insertions(+), 59 deletions(-)
> 

Hi Ted, will this patchset be merged in next window?
