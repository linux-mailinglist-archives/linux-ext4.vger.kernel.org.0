Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E422E75D2
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Dec 2020 04:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgL3DaH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Dec 2020 22:30:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10096 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL3DaH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Dec 2020 22:30:07 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D5Gvp10zMzMBhj;
        Wed, 30 Dec 2020 11:28:22 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 30 Dec 2020 11:29:15 +0800
Subject: Re: [PATCH v2] ext4: fix bug for rename with RENAME_WHITEOUT
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <jack@suse.cz>, <yi.zhang@huawei.com>, <lihaotian9@huawei.com>,
        <lutianxiong@huawei.com>, <linfeilong@huawei.com>
References: <20201229090208.1113218-1-yangerkun@huawei.com>
 <X+ushgURuSXY4Lz9@mit.edu>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <867df7f3-ac50-11ab-7531-59a95b4cd55b@huawei.com>
Date:   Wed, 30 Dec 2020 11:29:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <X+ushgURuSXY4Lz9@mit.edu>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



ÔÚ 2020/12/30 6:24, Theodore Ts'o Ð´µÀ:
> On Tue, Dec 29, 2020 at 05:02:08PM +0800, yangerkun wrote:
>> ext4_rename will create a special inode for whiteout and use this 'ino'
>> to replace the source file's dir entry 'ino'. Once error happens
>> latter(small ext4 img, and consume all space, so the rename with dst
>> path not exist will fail due to the ENOSPC return from ext4_add_entry in
>> ext4_rename), the cleanup do drop the nlink for whiteout, but forget to
>> restore 'ino' with source file. This will lead to "deleted inode
>> referenced".
> 
> Could you sendhave instructions how to reproduce this failure?  Many thanks!!

Hi,

Follow step will reproduce it easily!

cd /dev/shm
mkdir test/
fallocate -l 128M img
mkfs.ext4 -b 1024 img
mount img test/
dd if=/dev/zero of=test/foo bs=1M count=128
mkdir test/dir/ && cd test/dir/
for ((i=0;i<1000;i++)); do touch file$i; done # consume all block
cd ~ && renameat2(AT_FDCWD, /dev/shm/test/dir/file1, AT_FDCWD, 
/dev/shm/test/dir/dst_file, RENAME_WHITEOUT) # ext4_add_entry in 
ext4_rename will return ENOSPC!!
cd /dev/shm/ && mount img test/ && ls -li test/dir/file1
We will get the output:
"ls: cannot access 'test/dir/file1': Structure needs cleaning"
and the dmesg show:
"EXT4-fs error (device loop0): ext4_lookup:1626: inode #2049: comm ls: 
deleted inode referenced: 139"



static int ext4_rename(...)
{
	...
	whiteout = ext4_whiteout_for_rename(&old, credits, &handle);
	...
	retval = ext4_setent(handle, &old, whiteout->i_ino, EXT4_FT_CHRDEV); // 
will replace dir entry with
	...
	if (!new.bh) {
		retval = ext4_add_entry(handle, new.dentry, old.inode); // will fail 
with ENOSPC
		if (retval)
			goto end_rename;
	...
end_rename:
	...
	if (whiteout) { // forget to restore the dir entry's ino
		if (retval)
			drop_nlink(whiteout);
		unlock_new_inode(whiteout);
		iput(whiteout);
	}
	...
}

Thanks,
Kun.

> 
>        	  	   		    - Ted
> .
> 
