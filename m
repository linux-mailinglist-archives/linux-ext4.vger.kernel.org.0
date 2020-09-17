Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C3326D1D2
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Sep 2020 05:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgIQDjl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 23:39:41 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36635 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725987AbgIQDjl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Sep 2020 23:39:41 -0400
X-IronPort-AV: E=Sophos;i="5.76,434,1592841600"; 
   d="scan'208";a="99336411"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Sep 2020 11:29:51 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id B0DCD48990D9;
        Thu, 17 Sep 2020 11:29:47 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 17 Sep 2020 11:29:45 +0800
Message-ID: <5F62D829.3040805@cn.fujitsu.com>
Date:   Thu, 17 Sep 2020 11:29:45 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     <tytso@mit.edu>
CC:     Andreas Dilger <adilger@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <darrick.wong@oracle.com>, <ira.weiny@intel.com>, <jack@suse.cz>
Subject: Re: [PATCH v2] ext4: Disallow modifying DAX inode flag if inline_data
 has been set
References: <20200828084330.15776-1-yangx.jy@cn.fujitsu.com> <900D8400-83F4-464A-88A4-32235B9A0DC8@dilger.ca>
In-Reply-To: <900D8400-83F4-464A-88A4-32235B9A0DC8@dilger.ca>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: B0DCD48990D9.AB9E2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Ping :-)

Best Regards,
Xiao Yang
On 2020/8/29 15:27, Andreas Dilger wrote:
> On Aug 28, 2020, at 2:43 AM, Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
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
>> Fixes: b383a73f2b83 ("fs/ext4: Introduce DAX inode flag")
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> Reviewed-by: Jan Kara<jack@suse.cz>
> Reviewed-by: Andreas Dilger<adilger@dilger.ca>
>
>> ---
>> fs/ext4/ext4.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 523e00d7b392..69187b6205b2 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -492,7 +492,7 @@ struct flex_groups {
>>
>> /* Flags which are mutually exclusive to DAX */
>> #define EXT4_DAX_MUT_EXCL (EXT4_VERITY_FL | EXT4_ENCRYPT_FL |\
>> -			   EXT4_JOURNAL_DATA_FL)
>> +			   EXT4_JOURNAL_DATA_FL | EXT4_INLINE_DATA_FL)
>>
>> /* Mask out flags that are inappropriate for the given type of inode. */
>> static inline __u32 ext4_mask_flags(umode_t mode, __u32 flags)
>> --
>> 2.25.1
>>
>>
>>
>
> Cheers, Andreas
>
>
>
>
>



