Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76236BE6DD
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 11:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCQKeE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 06:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCQKeC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 06:34:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB27C62FD8
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 03:33:53 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PdL4q3Vh5znXnl;
        Fri, 17 Mar 2023 18:30:51 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 18:33:51 +0800
Message-ID: <021bd760-a3f5-14fa-ca64-27882803abab@huawei.com>
Date:   Fri, 17 Mar 2023 18:33:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 1/2] jbd2: continue to record log between each mount
Content-Language: en-US
To:     Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
References: <20230317090926.4149399-1-yi.zhang@huaweicloud.com>
 <20230317090926.4149399-2-yi.zhang@huaweicloud.com>
From:   "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <20230317090926.4149399-2-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.234.194]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Do we need update document/filesystems/ext4/journal.rst ?

On 2023/3/17 17:09, Zhang Yi wrote:
> -	__u32	s_padding[41];
> +	__be32	s_head;			/* blocknr of head of log, only uptodate
> +					 * while the filesystem is clean */
> +/* 0x005C */
> +	__u32	s_padding[40];
>   	__be32	s_checksum;		/* crc32c(superblock) */
>   
