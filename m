Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724164DD7CD
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Mar 2022 11:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiCRKQJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Mar 2022 06:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiCRKQH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Mar 2022 06:16:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F8A114DF1
        for <linux-ext4@vger.kernel.org>; Fri, 18 Mar 2022 03:14:49 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KKfyF1kCCz1GCN6;
        Fri, 18 Mar 2022 18:14:45 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 18:14:47 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 18:14:46 +0800
Message-ID: <63bf116a-1e48-dae4-09bf-fc35bcfde0ce@huawei.com>
Date:   Fri, 18 Mar 2022 18:14:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: e2fsck: do not skip deeper checkers when s_last_orphan list has
 truncated inodes
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
References: <647cc60d-18d4-ab53-6c91-52c1f6d29c3a@huawei.com>
 <YjDS0SLV+jqHfgPm@mit.edu>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <YjDS0SLV+jqHfgPm@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100008.china.huawei.com (7.185.36.48) To
 dggpeml100016.china.huawei.com (7.185.36.216)
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



在 2022/3/16 1:54, Theodore Ts'o 写道:
> On Tue, Mar 15, 2022 at 04:01:45PM +0800, zhanchengbin wrote:
>> If the system crashes when a file is being truncated, we will get a
>> problematic inode,
>> and it will be added into fs->super->s_last_orphan.
>> When we run `e2fsck -a img`, the s_last_orphan list will be traversed and
>> deleted.
>> During this period, orphan inodes in the s_last_orphan list with
>> i_links_count==0 can
>> be deleted, and orphan inodes with  i_links_count !=0 (ex. the truncated
>> inode)
>> cannot be deleted. However, when there are some orphan inodes with
>> i_links_count !=0,
>> the EXT2_VALID_FS is still assigned to fs->super->s_state, the deeper
>> checkers are skipped
>> with some inconsistency problems.
> 
> That's not supposed to happen.  We regularly put inodes on the orphan
> list when they are being truncated so that if we crash, the truncation
> operation can be completed as part of the journal recovery and remount
> operation.  This is true regardles sof whether the recovery is done by
> e2fsck or by the kernel.

Yes, you are right.
Truncated has been completed，and file ACL has been set to zero in
release_inode_blocks(), but the i_blocks was not subtracted acl blocks.
So i_blocks is inconsistent。
Li Jinlin sent a patch yesterday to fix it.

> 
> If a crash during a truncate leads to an inconsistent file system
> after the file system is mounted, or after e2fsck does the journal
> replay and orphan inode list processing, that's a kernel bug, and we
> should fix the bug in the kernel.
> 
> Do you have a reliable reproducer for this situation?

I have a reproducer but it is not necessarily:
#!/bin/bash
disk_list=$(multipath -ll | grep filedisk | awk '{print $1}')

for disk in ${disk_list}
do
     mkfs.ext4 -F /dev/mapper/$disk
     mkdir ${disk}
done

function err_inject()
{
     iscsiadm -m node -p 127.0.0.1 -u &> /dev/null
     iscsiadm -m node -p 127.0.0.1 -l &> /dev/null
     sleep 1
     iscsiadm -m node -p 9.82.236.206 -u &> /dev/null
     iscsiadm -m node -p 9.82.236.206 -l &> /dev/null
     sleep 1

     iscsiadm -m node -p 127.0.0.1 -u &> /dev/null
     iscsiadm -m node -p 127.0.0.1 -l &> /dev/null
     iscsiadm -m node -p 9.82.236.206 -u &> /dev/null
     iscsiadm -m node -p 9.82.236.206 -l &> /dev/null
     sleep 1
}



count=0
while true
do
     ((count=count+1))
     for disk in ${disk_list}
     do
         while true
         do
             mount -o data_err=abort,errors=remount-ro /dev/mapper/$disk 
$disk && break
             sleep 0.1
         done
         nohup fsstress -d $(pwd)/$disk -l 10 -n 1000 -p 10 &>/dev/null &
     done

     sleep 5

     for disk in ${disk_list}
     do
         dm=$(multipath -ll | grep -w $disk | awk '{print $2}')
         aqu_sz=$(iostat -x 1 -d 2 | grep -w $dm | tail -1 | awk '{print 
$(NF-1)}')
         util=$(iostat -x 1 -d 2 | grep -w $dm | tail -1 | awk '{print 
$NF}')
         #if [ "${aqu_sz}" == "0.00" -o "$util" == "0.00" ];then
         #    iostat -x 1 -d 2
         #    exit 1
         #fi
         mount | grep $disk | grep '(ro' && exit 1
     done

     err_inject

     while [ -n "`pidof fsstress`" ]
     do
         sleep 1
     done

     for disk in ${disk_list}
     do
         umount $disk
         dm=$(multipath -ll | grep -w $disk | awk '{print $2}')
         aqu_sz=$(iostat -x 1 -d 2 | grep -w $dm | tail -1 | awk '{print 
$(NF-1)}')
         util=$(iostat -x 1 -d 2 | grep -w $dm | tail -1 | awk '{print 
$NF}')
         if [ "${aqu_sz}" != "0.00" -o "$util" != "0.00" ];then
             iostat -x 1 -d 2
             exit 1
         fi

         dd bs=1M if=/dev/mapper/$disk of=/root/dockerback

         fsck.ext4 -a /dev/mapper/$disk
             ret=$?
             if [ $ret -ne 0 -a $ret -ne 1 ]; then
                 exit 1
             fi

         fsck.ext4 -fn /dev/mapper/$disk
             ret=$?
             if [ $ret -ne 0 ]; then
                 exit 1
             fi
     done

     if [ $count -gt 5 ];then
         echo 3 > /proc/sys/vm/drop_caches
         sleep 1
         cat /proc/meminfo >> mem.txt
         echo "" >> mem.txt
         slabtop -o >> slab.txt
         echo "" >> slab.txt
         count=0
     fi
done

> 
> Thanks,
> 
> 						- Ted
> .
> 
