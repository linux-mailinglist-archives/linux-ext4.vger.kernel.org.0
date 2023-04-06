Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942A76D8E03
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 05:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjDFDhb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 23:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjDFDh2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 23:37:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D01A7AA5;
        Wed,  5 Apr 2023 20:37:27 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PsRt90MNrzSqlF;
        Thu,  6 Apr 2023 11:33:37 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Apr 2023 11:36:48 +0800
Subject: Re: [PATCH] ubifs: remove unnecessary kobject_del()
To:     Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.com>,
        yangerkun <yangerkun@huawei.com>
References: <20230405130747.66006-1-frank.li@vivo.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <828681d9-153f-2499-baa6-9a5e782be586@huawei.com>
Date:   Thu, 6 Apr 2023 11:36:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230405130747.66006-1-frank.li@vivo.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Yangtao
> kobject_put() actually covers kobject removal automatically, which is
> single stage removal. So it is safe to kill kobject_del() directly.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/ubifs/sysfs.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
> index 1c958148bb87..1ffdc3c9b340 100644
> --- a/fs/ubifs/sysfs.c
> +++ b/fs/ubifs/sysfs.c
> @@ -130,7 +130,6 @@ int ubifs_sysfs_register(struct ubifs_info *c)
>   
>   void ubifs_sysfs_unregister(struct ubifs_info *c)
>   {
> -	kobject_del(&c->kobj);
>   	kobject_put(&c->kobj);
>   	wait_for_completion(&c->kobj_unregister);
>   
> 

This patch looks harmless at the view of ubifs, kobject_cleanup() 
finally invokes __kobject_del and releases parent just like 
kobject_del() does. A difference is that the releasing sequence of 
kobj's parent is put after releasing kobj.

About the use case of kobject_del(), we may refer to other filesystems' 
implementations, eg. ext4_put_super(). Firstly ext4_unregister_sysfs() 
removes all sysfs interfaces, then jbd2_journal_destroy() destroys 
sbi->s_journal, finally sbi->s_kobj is released. Here kobject_del() 
stops user accessing sbi->s_journal by sysfs interface 
journal_task£¬because sbi->s_journal will be released soon before 
kobject_put().

I think we should still reserve the 'redundant' kobject_del(), removing 
it won't bring any performance improvement.

BTW, in ext4_put_super(), flush_stashed_error_work(which could access 
sbi->s_kobj) is flushed after kobject removed. is it okay to replace 
kobject_del(&sbi->s_kobj) with kobject_put(&sbi->s_kobj)?

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a22417d113ca..9e3744099d1e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1296,8 +1296,6 @@ static void ext4_put_super(struct super_block *sb)
          * Now that we are completely done shutting down the
          * superblock, we need to actually destroy the kobject.
          */
-       kobject_put(&sbi->s_kobj);
-       wait_for_completion(&sbi->s_kobj_unregister);
         if (sbi->s_chksum_driver)
                 crypto_free_shash(sbi->s_chksum_driver);
         kfree(sbi->s_blockgroup_lock);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 12d6252e3e22..be92a09bb8a0 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -562,7 +562,8 @@ void ext4_unregister_sysfs(struct super_block *sb)

         if (sbi->s_proc)
                 remove_proc_subtree(sb->s_id, ext4_proc_root);
-       kobject_del(&sbi->s_kobj);
+       kobject_put(&sbi->s_kobj);
+       wait_for_completion(&sbi->s_kobj_unregister);
  }

  int __init ext4_init_sysfs(void)
