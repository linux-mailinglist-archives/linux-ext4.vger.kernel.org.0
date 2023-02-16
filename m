Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB86A698DBC
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 08:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBPH0B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 02:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPH0A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 02:26:00 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208301165E
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 23:25:59 -0800 (PST)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PHRHt2Dc7zRryZ;
        Thu, 16 Feb 2023 15:23:22 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Feb 2023 15:25:23 +0800
Message-ID: <6e6bb868-7107-3528-db6d-0ddc275f6326@huawei.com>
Date:   Thu, 16 Feb 2023 15:25:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v5 2/2] ext4: clear the verified flag of the modified leaf
 or idx if error
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <jack@suse.com>, <linux-ext4@vger.kernel.org>,
        <yi.zhang@huawei.com>, <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>, kernel test robot <lkp@intel.com>
References: <20230213080514.535568-1-zhanchengbin1@huawei.com>
 <20230213080514.535568-3-zhanchengbin1@huawei.com>
 <20230214125211.o2j3vpkopvas2niq@quack3>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230214125211.o2j3vpkopvas2niq@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500019.china.huawei.com (7.185.36.137) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The last patch did not take into account path[0].p_bh == NULL, so I
reworked the code.

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0f95e857089e..05585afae0db 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1750,13 +1750,19 @@ static int ext4_ext_correct_indexes(handle_t 
*handle, struct inode *inode,
                         break;
                 err = ext4_ext_get_access(handle, inode, path + k);
                 if (err)
-                       break;
+                       goto clean;
                 path[k].p_idx->ei_block = border;
                 err = ext4_ext_dirty(handle, inode, path + k);
                 if (err)
-                       break;
+                       goto clean;
         }
+       return 0;

+clean:
+       while (k++ < depth) {
+               /* k here will not be 0, so don't consider the case 
where path[0].p_bh is NULL */
+               clear_buffer_verified(path[k].p_bh);
+       }
         return err;
  }

@@ -2304,6 +2310,7 @@ static int ext4_ext_rm_idx(handle_t *handle, 
struct inode *inode,
  {
         int err;
         ext4_fsblk_t leaf;
+       int b_depth = depth;

         /* free index block */
         depth--;
@@ -2339,11 +2346,18 @@ static int ext4_ext_rm_idx(handle_t *handle, 
struct inode *inode,
                 path--;
                 err = ext4_ext_get_access(handle, inode, path);
                 if (err)
-                       break;
+                       goto clean;
                 path->p_idx->ei_block = (path+1)->p_idx->ei_block;
                 err = ext4_ext_dirty(handle, inode, path);
                 if (err)
-                       break;
+                       goto clean;
+       }
+       return 0;
+
+clean:
+       while (depth++ < b_depth - 1) {
+               /* depth here will not be 0, so don't consider the case 
where path[0].p_bh is NULL */
+               clear_buffer_verified(path[depth].p_bh);
         }
         return err;
  }


On 2023/2/14 20:52, Jan Kara wrote:
> 
> This would be more understandable as:
> 
> 	if (k >= 0)
> 		while (k++ < depth)
> 			...
> 
> Also the loop is IMO wrong because it will run with k == depth as well (due
> to post-increment) and that is not initialized. Furthermore it will run
> also if we exit the previous loop due to:
> 
>                  /* change all left-side indexes */
>                  if (path[k+1].p_idx != EXT_FIRST_INDEX(path[k+1].p_hdr))
>                          break;
> 
> which is unwanted as well. Which suggests that you didn't test your changes
> much (if at all...). So please make sure your changes are tested next time.
> Thank you!
> 
> 								Honza
I only ran xfstest locally. Do you have any better suggestions?

Thanks,
  - bin.
> 
>>   
>>   	return err;
>>   }
>> @@ -2304,6 +2306,7 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
>>   {
>>   	int err;
>>   	ext4_fsblk_t leaf;
>> +	int b_depth = depth;

