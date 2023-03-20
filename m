Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0180D6C09D9
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Mar 2023 06:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCTFFd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 01:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCTFFc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 01:05:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2E61E9EA
        for <linux-ext4@vger.kernel.org>; Sun, 19 Mar 2023 22:05:29 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pg2hc3gNxzrVCw;
        Mon, 20 Mar 2023 13:04:16 +0800 (CST)
Received: from [10.174.179.254] (10.174.179.254) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 13:05:14 +0800
Subject: Re: tune2fs: check whether filesystem is in use for I_flag and Q_flag
 test
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>, <adilger@whamcloud.com>,
        <jack@suse.cz>, linfeilong <linfeilong@huawei.com>,
        wuguanghao <wuguanghao3@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>, <libaokun1@huawei.com>
References: <3a908642-b2ff-b4c3-b0c9-add71f764267@huawei.com>
Message-ID: <073cd819-a7a0-b32b-a7cb-c0068de4cdce@huawei.com>
Date:   Mon, 20 Mar 2023 13:05:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3a908642-b2ff-b4c3-b0c9-add71f764267@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

please ignore the patch.
sorry for that.

On 2023/3/20 13:03, Zhiqiang Liu wrote:
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
