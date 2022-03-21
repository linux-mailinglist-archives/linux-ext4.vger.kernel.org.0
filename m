Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF14E27BC
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Mar 2022 14:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348000AbiCUNgw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 09:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiCUNgb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 09:36:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2294474B;
        Mon, 21 Mar 2022 06:35:05 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KMbDB4F2FzfZMc;
        Mon, 21 Mar 2022 21:33:30 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 21:35:02 +0800
Subject: Re: [PATCH -next] ext4: Fix symlink file size not match to file
 content
To:     Jan Kara <jack@suse.cz>
References: <20220321113408.4112428-1-yebin10@huawei.com>
 <20220321113703.cibgeac5ipslg3df@quack3.lan>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lczerner@redhat.com>
From:   yebin <yebin10@huawei.com>
Message-ID: <62387F05.2090408@huawei.com>
Date:   Mon, 21 Mar 2022 21:35:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20220321113703.cibgeac5ipslg3df@quack3.lan>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/3/21 19:37, Jan Kara wrote:
> On Mon 21-03-22 19:34:08, Ye Bin wrote:
>> We got issue as follows:
>> [home]# fsck.ext4  -fn  ram0yb
>> e2fsck 1.45.6 (20-Mar-2020)
>> Pass 1: Checking inodes, blocks, and sizes
>> Pass 2: Checking directory structure
>> Symlink /p3/d14/d1a/l3d (inode #3494) is invalid.
>> Clear? no
>> Entry 'l3d' in /p3/d14/d1a (3383) has an incorrect filetype (was 7, should be 0).
>> Fix? no
>>
>> As symlink file size not match to file content. If symlink data block
>> writback failed, will call ext4_finish_bio to end io. In this path don't
>> mark buffer error. When umount do checkpoint can't detect buffer error,
>> then will cleanup jounral. Actually, correct data maybe in journal area.
>> To solve this issue, mark buffer error when detect bio error in
>> ext4_finish_bio.
> Thanks for the patch! Let me rephrase the text a bit:
>
> As the symlink file size does not match the file content. If the writeback
> of the symlink data block failed, ext4_finish_bio() handles the end of IO.
> However this function fails to mark the buffer with BH_write_io_error and
> so when unmount does journal checkpoint it cannot detect the writeback
> error and will cleanup the journal. Thus we've lost the correct data in the
> journal area. To solve this issue, mark the buffer as BH_write_io_error in
> ext4_finish_bio().
>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/page-io.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
>> index 495ce59fb4ad..14695e2b5042 100644
>> --- a/fs/ext4/page-io.c
>> +++ b/fs/ext4/page-io.c
>> @@ -134,8 +134,10 @@ static void ext4_finish_bio(struct bio *bio)
>>   				continue;
>>   			}
>>   			clear_buffer_async_write(bh);
>> -			if (bio->bi_status)
>> +			if (bio->bi_status) {
>> +				set_buffer_write_io_error(bh);
> Why don't you use mark_buffer_write_io_error()? It will also update other IO
> error counters properly so that e.g. fsync(2) or sync_filesystem() can properly
> report IO error etc. Granted we'll abort the journal in response to
> checkpointing error so the failure will be hard to miss anyway but still
> :).
>
> 								Honza

'ext4_finish_bio' already call 'mapping_set_error' set mapping error , I think fsync
and sync_filesystem can report IO error.

static inline void mapping_set_error(struct address_space *mapping, int error)
{
         if (likely(!error))
                 return;

         /* Record in wb_err for checkers using errseq_t based tracking */
         __filemap_set_wb_err(mapping, error);

         /* Record it in superblock */
         if (mapping->host)
                 errseq_set(&mapping->host->i_sb->s_wb_err, error);

         /* Record it in flags for now, for legacy callers */
         if (error == -ENOSPC)
                 set_bit(AS_ENOSPC, &mapping->flags);
         else
                 set_bit(AS_EIO, &mapping->flags);
}


