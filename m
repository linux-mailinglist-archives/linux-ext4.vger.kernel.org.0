Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3055E87A0
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Sep 2022 04:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiIXCvJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Sep 2022 22:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiIXCu6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Sep 2022 22:50:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159301075A3
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 19:50:56 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MZD3s6WsjzHpW8;
        Sat, 24 Sep 2022 10:48:41 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 10:50:54 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 10:50:53 +0800
Subject: Re: [PATCH] tune2fs: fix a NULL dereference on failed journal replay
To:     Lubomir Rintel <lkundrak@v3.sk>, Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>
References: <20220923132735.1701587-1-lkundrak@v3.sk>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <2bb44e20-d4a8-a176-34ab-0c5c74d755c6@huawei.com>
Date:   Sat, 24 Sep 2022 10:50:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20220923132735.1701587-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Nice catch
But Li Jinlin has also found this problem, and sent a patch:
"[PATCH] tune2fs: exit directly when fs freed in ext2fs_run_ext3_journal"

On 2022/9/23 21:27, Lubomir Rintel wrote:
> Got a crash:
> 
>   Starting program: e2fsprogs-1.46.5/misc/tune2fs -O ^has_journal -ff /dev/sdh2
>   tune2fs 1.46.5 (30-Dec-2021)
>   Recovering journal.
>   tune2fs: Unknown code ____ 251 while recovering journal.
>   Please run e2fsck -fy /dev/sdh2.
> 
>   Program received signal SIGSEGV, Segmentation fault.
>   0x00007ffff7f8565a in ext2fs_mmp_stop (fs=0x0) at ../mmp.c:405
>   405		if (!ext2fs_has_feature_mmp(fs->super) ||
>   (gdb) bt
>   #0  0x00007ffff7f8565a in ext2fs_mmp_stop (fs=0x0) at ../mmp.c:405
>   #1  0x000055555555acd8 in main (argc=<optimized out>, argv=<optimized out>) at /home/lkundrak/fedora/e2fsprogs/e2fsprogs-1.46.5/misc/tune2fs.c:3441
>   (gdb)
> 
> Turns out, ext2fs_run_ext3_journal() can close fs and then fail. If that
> happened, we shall not jump to closefs:, quit right away instead.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  misc/tune2fs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 088f87e5..96cfd001 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -3345,7 +3345,10 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
>  				"while recovering journal.\n");
>  			printf(_("Please run e2fsck -fy %s.\n"), argv[1]);
>  			rc = 1;
> -			goto closefs;
> +			if (fs)
> +				goto closefs;
> +			else
> +				return 1;
>  		}
>  		sb = fs->super;
>  	}
> 

