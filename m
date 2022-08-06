Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734BB58B3A3
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Aug 2022 06:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiHFEDG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 6 Aug 2022 00:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbiHFEDF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 6 Aug 2022 00:03:05 -0400
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643A214014;
        Fri,  5 Aug 2022 21:03:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08715575|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.154924-0.00444291-0.840633;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.OnDAFCd_1659758542;
Received: from 192.168.220.136(mailfrom:michael@allwinnertech.com fp:SMTPD_---.OnDAFCd_1659758542)
          by smtp.aliyun-inc.com;
          Sat, 06 Aug 2022 12:02:25 +0800
Message-ID: <ff062259-3c94-ddd2-4376-53b4cbd25e7d@allwinnertech.com>
Date:   Sat, 6 Aug 2022 12:02:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] ext4: fix error when itable blocks is greater than
 s_itb_per_group
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Lukas Czerner <lczerner@redhat.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
References: <20220802021029.16046-1-michael@allwinnertech.com>
 <20220803071859.elywnni2yfol4bea@fedora> <Yussl4uRWAAO3TtT@mit.edu>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <Yussl4uRWAAO3TtT@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/4/2022 10:19 AM, Theodore Ts'o wrote:
> On Wed, Aug 03, 2022 at 09:18:59AM +0200, Lukas Czerner wrote:
>>
>> Hi Michael,
>>
>> mke2fs is making sure that we completely fill the inote table blocks.
>> This is a corrupted image and so AFAICT ext4 is doing the right thing
>> here. There does not seem to be a problem to fix, unless you can somehow
>> trick mke2fs to make a file system like this.
> 
> Several years ago, android was shipping a bogus/busted
> reimeplementation of mke2fs, reportedly because a certain founder of
> Android (cough, Andy Rubin, cough) was alergic to the GPL.  ("The
> problem with GPL in embedded systems [such as smartphones and tablets]
> is that it's viral...")  This bogus reimplementation would create file
> systems where the number of inodes per block group was a multiple of 4
> instead of 8.  But, it was under the BSD license, so it was all good!   :-/
> 
> This bogus reimplementation of mkfs would, 50% of the time, create
> busted file systems which couldn't be fixed, if they got corrupted, by
> e2fsck.  This is because e2fsprogs' allocation bitmap code assumes
> that you can back the bitarray into a single contiguous memory block
> --- and this doesn't work if the number of inodes per block group is
> not a multiple of 8.  If the file system got corrupted, the only
> recourse was to wipe the user partition and the user would lose any
> data that wasn't backed up to the cloud.
> 
> This has since been fixed for quite some time, but if there is some
> low-end Android manufacturer is using an ancient version of AOSP, this
> could be happening even in 2022 --- but that doesn't mean we need to
> support such broken file systems.  As far as I'm concerned the only
> way to make valid Android ext4 system images is the combination of
> mke2fs and e2fsdroid, which is what modern versions of AOSP do.
> 
>      	       	     	     	    	     	- Ted

Dear Ted & Lukas,
Thanks for your clarification. I did several tests, turned outs Ted was 
right. I'm clear now.

-- 
Regards,
Michael Wu
