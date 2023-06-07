Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265CF7259D6
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jun 2023 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbjFGJOg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jun 2023 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbjFGJOQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jun 2023 05:14:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EDC19B6
        for <linux-ext4@vger.kernel.org>; Wed,  7 Jun 2023 02:13:38 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QbhNH6dVCzqTRg;
        Wed,  7 Jun 2023 17:08:47 +0800 (CST)
Received: from [10.174.179.254] (10.174.179.254) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 17:13:35 +0800
Subject: Re: [PATCH] tune2fs: check whether filesystem is in use for I_flag
 and Q_flag test
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>, <adilger@whamcloud.com>,
        Jan Kara <jack@suse.cz>, linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>, <libaokun1@huawei.com>
References: <28455341-ca26-d203-8b54-792bae002251@huawei.com>
Message-ID: <46beb688-7f39-7184-1b83-5d14743fd083@huawei.com>
Date:   Wed, 7 Jun 2023 17:13:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <28455341-ca26-d203-8b54-792bae002251@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

friendly ping...

On 2023/3/20 13:04, Zhiqiang Liu wrote:
> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> For changing inode size (-I) and setting quota fearture (-Q), tune2fs
> only check whether the filesystem is umounted. Considering mount
> namepspaces, the filesystem is umounted, however it already be left
> in other mount namespace.
> So we add one check whether the filesystem is not in use with using
> EXT2_MF_BUSY flag, which can indicate the device is already opened
> with O_EXCL, as suggested by Ted.
> 
> Reported-by: Baokun Li <libaokun1@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> ---
>  misc/tune2fs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 458f7cf6..d75f4d94 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -3520,9 +3520,9 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
>  	}
> 
>  	if (Q_flag) {
> -		if (mount_flags & EXT2_MF_MOUNTED) {
> +		if (mount_flags & (EXT2_MF_BUSY | EXT2_MF_MOUNTED)) {
>  			fputs(_("The quota feature may only be changed when "
> -				"the filesystem is unmounted.\n"), stderr);
> +				"the filesystem is unmounted and not in use.\n"), stderr);
>  			rc = 1;
>  			goto closefs;
>  		}
> @@ -3673,10 +3673,10 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
>  	}
> 
>  	if (I_flag) {
> -		if (mount_flags & EXT2_MF_MOUNTED) {
> +		if (mount_flags & (EXT2_MF_BUSY | EXT2_MF_MOUNTED)) {
>  			fputs(_("The inode size may only be "
>  				"changed when the filesystem is "
> -				"unmounted.\n"), stderr);
> +				"unmounted and not in use.\n"), stderr);
>  			rc = 1;
>  			goto closefs;
>  		}
> 
