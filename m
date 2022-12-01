Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A4663F4E8
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 17:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiLAQMj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 11:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiLAQMg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 11:12:36 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48379F4;
        Thu,  1 Dec 2022 08:12:32 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NNLg3168gzHw3L;
        Fri,  2 Dec 2022 00:11:43 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 00:12:25 +0800
Subject: Re: [PATCH v2] ext4: fix WARNING in ext4_expand_extra_isize_ea
To:     Theodore Ts'o <tytso@mit.edu>, Ye Bin <yebin@huaweicloud.com>
References: <20221201145923.73028-1-yebin@huaweicloud.com>
 <Y4jPuoJsW5+t9UUn@mit.edu>
CC:     <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        <syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <6388D268.7030601@huawei.com>
Date:   Fri, 2 Dec 2022 00:12:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <Y4jPuoJsW5+t9UUn@mit.edu>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/12/2 0:00, Theodore Ts'o wrote:
> On Thu, Dec 01, 2022 at 10:59:23PM +0800, Ye Bin wrote:
>> Reason is allocate 16M memory by kmalloc, but MAX_ORDER is 11, kmalloc
>> can allocate maxium size memory is 4M.
>> XATTR_SIZE_MAX is currently 64k, but EXT4_XATTR_SIZE_MAX is '(1 << 24)',
>> so 'ext4_xattr_check_entries()' regards this length as legal. Then trigger
>> warning in 'ext4_xattr_move_to_block()'.
>> To solve above issue, according to Jan Kara's suggestion use kvmalloc()
>> to allocate memory in ext4_xattr_move_to_block().
> See my comment to the v1 version of the patch.  I suspect the real
> problem is that the e_value_size is completely bogus, and we should
> have checked it much earlier in the stack call trace, via a call to
> xattr_check_inode().
Yes, Not only the e_value_size is wrong, but also the inode is wrong:
EXT4-fs: Ignoring removed nobh option
EXT4-fs error (device loop0): ext4_xattr_inode_iget:389: comm rep: inode 
#1: comm rep: iget: illegal inode #
EXT4-fs error (device loop0): ext4_xattr_inode_iget:392: comm rep: error 
while reading EA inode 1 err=-117
EXT4-fs warning (device loop0): ext4_expand_extra_isize_ea:2788: Unable 
to expand inode 15. Delete some EAs or run e2fsck.

Maybe we can do follow check  in ext4_xattr_check_entries() when 
"entry->e_value_inum != 0".
···
err = ext4_xattr_inode_iget(inode, le32_to_cpu(entry->e_value_inum),
                             le32_to_cpu(entry->e_hash), &ea_inode);
if (err) {
         ea_inode = NULL;
         goto out;
}

if (i_size_read(ea_inode) != size) {
         ext4_warning_inode(ea_inode,
                            "ea_inode file size=%llu entry size=%zu",
                            i_size_read(ea_inode), size);
         err = -EFSCORRUPTED;
         goto out;
}
···
>
> Cheers,
>
> 					- Ted
>
> .
>

