Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0D16BF849
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Mar 2023 07:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCRGNu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Mar 2023 02:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCRGNt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Mar 2023 02:13:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32884A1D1
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 23:13:47 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PdrH76tm2zHwYw;
        Sat, 18 Mar 2023 14:11:31 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 18 Mar 2023 14:13:45 +0800
Subject: Re: [PATCH v4 1/2] jbd2: continue to record log between each mount
To:     Theodore Ts'o <tytso@mit.edu>,
        "wangjianjian (C)" <wangjianjian3@huawei.com>
CC:     Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yukuai3@huawei.com>
References: <20230317090926.4149399-1-yi.zhang@huaweicloud.com>
 <20230317090926.4149399-2-yi.zhang@huaweicloud.com>
 <021bd760-a3f5-14fa-ca64-27882803abab@huawei.com>
 <20230317152521.GA3270589@mit.edu>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <0d680f4b-92ed-6715-01c3-9f455772a186@huawei.com>
Date:   Sat, 18 Mar 2023 14:13:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230317152521.GA3270589@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/17 23:25, Theodore Ts'o wrote:
> On Fri, Mar 17, 2023 at 06:33:50PM +0800, wangjianjian (C) wrote:
>> Do we need update document/filesystems/ext4/journal.rst ?
>>
>> On 2023/3/17 17:09, Zhang Yi wrote:
>>> -	__u32	s_padding[41];
>>> +	__be32	s_head;			/* blocknr of head of log, only uptodate
>>> +					 * while the filesystem is clean */
>>> +/* 0x005C */
>>> +	__u32	s_padding[40];
>>>   	__be32	s_checksum;		/* crc32c(superblock) */
> 
> Yes, please update journal.rst in the patch.
> 
Yes, thanks for pointing this out. I will update it in journal.rst

Thanks,
Yi.
