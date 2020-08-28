Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FBE255701
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Aug 2020 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgH1I7M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Aug 2020 04:59:12 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50749 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728555AbgH1I7M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Aug 2020 04:59:12 -0400
X-IronPort-AV: E=Sophos;i="5.76,363,1592841600"; 
   d="scan'208";a="98664050"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Aug 2020 16:59:08 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id BC70D48990C5;
        Fri, 28 Aug 2020 16:59:04 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 28 Aug 2020 16:59:05 +0800
Message-ID: <5F48C756.9080406@cn.fujitsu.com>
Date:   Fri, 28 Aug 2020 16:59:02 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <darrick.wong@oracle.com>,
        <ira.weiny@intel.com>, <tytso@mit.edu>
Subject: Re: [PATCH] ext4: Disallow modifying DAX inode flag if inline_data
 has been set
References: <20200828071501.8402-1-yangx.jy@cn.fujitsu.com> <20200828084921.GB7072@quack2.suse.cz>
In-Reply-To: <20200828084921.GB7072@quack2.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: BC70D48990C5.A97BA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/8/28 16:49, Jan Kara wrote:
> On Fri 28-08-20 15:15:01, Xiao Yang wrote:
>> inline_data is mutually exclusive to DAX so enabling both of them triggers
>> the following issue:
>> ------------------------------------------
>> # mkfs.ext4 -F -O inline_data /dev/pmem1
>> ...
>> # mount /dev/pmem1 /mnt
>> # echo 'test'>/mnt/file
>> # lsattr -l /mnt/file
>> /mnt/file                    Inline_Data
>> # xfs_io -c "chattr +x" /mnt/file
>> # xfs_io -c "lsattr -v" /mnt/file
>> [dax] /mnt/file
>> # umount /mnt
>> # mount /dev/pmem1 /mnt
>> # cat /mnt/file
>> cat: /mnt/file: Numerical result out of range
>> ------------------------------------------
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Thanks. The patch looks good to me. You can add:
>
> Reviewed-by: Jan Kara<jack@suse.cz>
>
> Please also add the following tag to the changelog:
>
> Fixes: b383a73f2b83 ("fs/ext4: Introduce DAX inode flag")
>
> so that the patch gets properly picked up to stable trees etc.
Hi Jan,

Thanks for your quick reply. :-)
I will send v2 patch shortly as you suggested.

Best Regards,
Xiao Yang
> Thanks!
>
> 								Honza
>
>> ---
>>   fs/ext4/ext4.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 523e00d7b392..69187b6205b2 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -492,7 +492,7 @@ struct flex_groups {
>>
>>   /* Flags which are mutually exclusive to DAX */
>>   #define EXT4_DAX_MUT_EXCL (EXT4_VERITY_FL | EXT4_ENCRYPT_FL |\
>> -			   EXT4_JOURNAL_DATA_FL)
>> +			   EXT4_JOURNAL_DATA_FL | EXT4_INLINE_DATA_FL)
>>
>>   /* Mask out flags that are inappropriate for the given type of inode. */
>>   static inline __u32 ext4_mask_flags(umode_t mode, __u32 flags)
>> -- 
>> 2.25.1
>>
>>
>>



