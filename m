Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7120F6B34E5
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 04:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCJDmm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Mar 2023 22:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCJDml (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Mar 2023 22:42:41 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A02C80A9;
        Thu,  9 Mar 2023 19:42:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VdVlEJ2_1678419754;
Received: from 30.97.48.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdVlEJ2_1678419754)
          by smtp.aliyun-inc.com;
          Fri, 10 Mar 2023 11:42:36 +0800
Message-ID: <2fa31829-03f0-7bfb-a89b-e3917c479733@linux.alibaba.com>
Date:   Fri, 10 Mar 2023 11:42:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/6] erofs: convert to use i_blockmask()
To:     Al Viro <viro@zeniv.linux.org.uk>, Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        brauner@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org
References: <20230309152127.41427-1-frank.li@vivo.com>
 <20230309152127.41427-2-frank.li@vivo.com> <20230310031547.GD3390869@ZenIV>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230310031547.GD3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Al,

On 2023/3/10 11:15, Al Viro wrote:
> On Thu, Mar 09, 2023 at 11:21:23PM +0800, Yangtao Li wrote:
>> Use i_blockmask() to simplify code.
> 
> Umm...  What's the branchpoint for that series?  Not the mainline -
> there we have i_blocksize() open-coded...

Actually Yue Hu sent out a clean-up patch and I applied to -next for
almost a week and will be upstreamed for 6.3-rc2:

https://lore.kernel.org/r/a238dca1-256f-ae2f-4a33-e54861fe4ffb@kernel.org/T/#t

And then Yangtao would like to wrap this as a new VFS helper, I'm not
sure why it's necessary since it doesn't save a lot but anyway, I'm open
to it if VFS could have such new helper.

Thanks,
Gao Xiang

> 
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>> v3:
>> -none
>> v2:
>> -convert to i_blockmask()
>>   fs/erofs/data.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 7e8baf56faa5..e9d1869cd4b3 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>   		if (bdev)
>>   			blksize_mask = bdev_logical_block_size(bdev) - 1;
>>   		else
>> -			blksize_mask = i_blocksize(inode) - 1;
>> +			blksize_mask = i_blockmask(inode);
>>   
>>   		if ((iocb->ki_pos | iov_iter_count(to) |
>>   		     iov_iter_alignment(to)) & blksize_mask)
>> -- 
>> 2.25.1
>>
