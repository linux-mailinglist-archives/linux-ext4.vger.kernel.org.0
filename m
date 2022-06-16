Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A52754D6BC
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 03:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbiFPBHB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jun 2022 21:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbiFPBG7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jun 2022 21:06:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804693586A;
        Wed, 15 Jun 2022 18:06:58 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LNkVr5qKrzjY5V;
        Thu, 16 Jun 2022 09:05:24 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 09:06:55 +0800
Message-ID: <57de3897-3428-c241-2d1e-13d42a037864@huawei.com>
Date:   Thu, 16 Jun 2022 09:06:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/4] ext4: add EXT4_INODE_HAVE_XATTR_SPACE macro in
 xattr.h
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <lczerner@redhat.com>, <enwlinux@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220615040630.808783-1-libaokun1@huawei.com>
 <20220615040630.808783-2-libaokun1@huawei.com>
 <20220615124633.6uddzv5msnmwi7c4@quack3.lan>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20220615124633.6uddzv5msnmwi7c4@quack3.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

在 2022/6/15 20:46, Jan Kara 写道:
> On Wed 15-06-22 12:06:27, Baokun Li wrote:
>> When adding an xattr to an inode, we must ensure that the inode_size is
>> not less than EXT4_GOOD_OLD_INODE_SIZE + extra_isize + pad. Otherwise,
>> the end position may be greater than the start position, resulting in UAF.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ...
>
>> +/*
>> + * If we want to add an xattr to the inode, we should make sure that
>> + * i_extra_isize is not 0 and that the inode size is not less than
>> + * EXT4_GOOD_OLD_INODE_SIZE + extra_isize + pad.
>> + *   EXT4_GOOD_OLD_INODE_SIZE   extra_isize header   entry   pad  data
>> + * |--------------------------|------------|------|---------|---|-------|
>> + */
>> +#define EXT4_INODE_HAVE_XATTR_SPACE(inode)				\
> Gramatically correct would be EXT4_INODE_**HAS**_XATTR_SPACE and I'd be for
> using that. Otherwise the whole series looks good so feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza

I'm sorry, I didn't notice it was "HAS." Thank you very much for your 
correction.

I will send a patch V3 with the changes suggested by you. Thanks again!

-- 
With Best Regards,
Baokun Li
.

