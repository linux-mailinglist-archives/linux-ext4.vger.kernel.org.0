Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FDE4C5378
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Feb 2022 03:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiBZC5G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Feb 2022 21:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiBZC5E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Feb 2022 21:57:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7827B5939F;
        Fri, 25 Feb 2022 18:56:30 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K5B4T61Mczbbsw;
        Sat, 26 Feb 2022 10:51:53 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Feb 2022 10:56:27 +0800
Subject: Re: [PATCH -next v2] ext4:fix file system corrupted when rmdir non
 empty directory with IO error
To:     Theodore Ts'o <tytso@mit.edu>
References: <20220211093527.3335518-1-yebin10@huawei.com>
 <YhmPKVrVHhTeKOzl@mit.edu>
CC:     <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        <lczerner@redhat.com>
From:   yebin <yebin10@huawei.com>
Message-ID: <621996DB.1030501@huawei.com>
Date:   Sat, 26 Feb 2022 10:56:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <YhmPKVrVHhTeKOzl@mit.edu>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/2/26 10:23, Theodore Ts'o wrote:
> On Fri, Feb 11, 2022 at 05:35:27PM +0800, Ye Bin wrote:
>> Now if read directory block failed, 'ext4_empty_dir' will return true, assume
>> directory is empty. Obviously, it will lead to above issue.
>> To solve this issue, if read directory block failed 'ext4_empty_dir' just assume
>> directory isn't empty. To avoid making things worse when file system is already
>> corrupted, 'ext4_empty_dir' also assume directory isn't empty.
>> To distinguish the error type, return the exact error code to the caller.
>>
> Does the same issue exist for f2fs and ubifs?  We could solve the
> specific bug much more simply by having ext4_empty_dir() return FALSE
> if we aren't able to read the directory block.  Yes, it means that we
> don't return as specific an error code in the case of an I/O error ---
> although I believe we do syslog a warning --- but it makes for a much
> simpler patch that doesn't requiring getting acked-by's from the
> fscrypt, f2fs and ubifs folks.
>
> 							- Ted
> .
In fact,  I only modified ext4 as you suggested in my v1 patch.
[-next] ext4:fix file system corrupted when rmdir non empty directory 
with IO error :
https://patchwork.ozlabs.org/project/linux-ext4/patch/20220209112819.3072220-1-yebin10@huawei.com/

>

