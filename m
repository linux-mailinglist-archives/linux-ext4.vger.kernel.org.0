Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B82A47CAA4
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Dec 2021 02:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbhLVBG0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Dec 2021 20:06:26 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15958 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhLVBGZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Dec 2021 20:06:25 -0500
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJZnb1JxqzZdkN;
        Wed, 22 Dec 2021 09:03:15 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 09:06:23 +0800
Subject: Re: [PATCH -next] ext4: Fix remount with 'abort' option isn't
 effective
To:     Lukas Czerner <lczerner@redhat.com>
References: <20211221123214.2410593-1-yebin10@huawei.com>
 <20211221144305.nlryh7q2cgdbpmi5@work>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jack@suse.cz>
From:   yebin <yebin10@huawei.com>
Message-ID: <61C27A0E.9050900@huawei.com>
Date:   Wed, 22 Dec 2021 09:06:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20211221144305.nlryh7q2cgdbpmi5@work>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/12/21 22:43, Lukas Czerner wrote:
> Hi,
>
> nice catch. This is a bug indeed. However I am currently in a process of
> changing the ctx_set/clear/test_ helpers because currently it generates
> functions that are unused.
>
> While I am at it I can just create a custom ctx_set_mount_flags()
> helper that would behave as expected so that we won't have to specify
> "1 < EXT4_MF_FS_ABORTED" which is not really obvious and hence error
> prone.
Actually, I fixed the first version as follows:

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b72d989b77fb..199920ffc7d3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2049,8 +2049,8 @@ struct ext4_fs_context {
  	unsigned int	mask_s_mount_opt;
  	unsigned int	vals_s_mount_opt2;
  	unsigned int	mask_s_mount_opt2;
-	unsigned int	vals_s_mount_flags;
-	unsigned int	mask_s_mount_flags;
+	unsigned long	vals_s_mount_flags;
+	unsigned long	mask_s_mount_flags;
  	unsigned int	opt_flags;	/* MOPT flags */
  	unsigned int	spec;
  	u32		s_max_batch_time;
@@ -2166,7 +2166,12 @@ static inline bool ctx_test_##name(struct ext4_fs_context *ctx, int flag)\
  EXT4_SET_CTX(flags);
  EXT4_SET_CTX(mount_opt);
  EXT4_SET_CTX(mount_opt2);
-EXT4_SET_CTX(mount_flags);
+
+static inline void ctx_set_mount_flags(struct ext4_fs_context *ctx, int bit)
+{
+	set_bit(bit, &ctx->mask_s_mount_flags);
+	set_bit(bit, &ctx->vals_s_mount_flags);
+}


I think 'mask_s_mount_flags' is useless now.
>
> My plan is to send my patch set including this one tomorrow, will that
> be fine with you ?
>
> -Lukas
>
> On Tue, Dec 21, 2021 at 08:32:14PM +0800, Ye Bin wrote:
>> We test remount with 'abort' option as follows:
>> [root@localhost home]# mount  /dev/sda test
>> [root@localhost home]# mount | grep test
>> /dev/sda on /home/test type ext4 (rw,relatime)
>> [root@localhost home]# mount -o remount,abort test
>> [root@localhost home]# mount | grep test
>> /dev/sda on /home/test type ext4 (rw,relatime)
>>
>> Obviously, remount 'abort' option isn't effective.
>> After 6e47a3cc68fc commit we process abort option with 'ctx_set_mount_flags':
>> static inline void ctx_set_mount_flags(struct ext4_fs_context *ctx, int flag)
>> {
>> 	ctx->mask_s_mount_flags |= flag;
>> 	ctx->vals_s_mount_flags |= flag;
>> }
>>
>> But we test 'abort' option with 'ext4_test_mount_flag':
>> static inline int ext4_test_mount_flag(struct super_block *sb, int bit)
>> {
>>          return test_bit(bit, &EXT4_SB(sb)->s_mount_flags);
>> }
>>
>> To solve this issue, pass (1 <<  EXT4_MF_FS_ABORTED) to 'ctx_set_mount_flags'.
>>
>> Fixes:6e47a3cc68fc("ext4: get rid of super block and sbi from handle_mount_ops()")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/super.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index b72d989b77fb..071b7b3c5678 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -2236,7 +2236,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>   			 param->key);
>>   		return 0;
>>   	case Opt_abort:
>> -		ctx_set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
>> +		ctx_set_mount_flags(ctx, 1 << EXT4_MF_FS_ABORTED);
>>   		return 0;
>>   	case Opt_i_version:
>>   		ctx_set_flags(ctx, SB_I_VERSION);
>> -- 
>> 2.31.1
>>
> .
>

