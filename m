Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4138C18DDC8
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Mar 2020 04:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCUDWv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Mar 2020 23:22:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgCUDWv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Mar 2020 23:22:51 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L33lLi158695
        for <linux-ext4@vger.kernel.org>; Fri, 20 Mar 2020 23:22:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu7wg0842-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Fri, 20 Mar 2020 23:22:49 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Sat, 21 Mar 2020 03:22:47 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 21 Mar 2020 03:22:45 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02L3MipV34210210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Mar 2020 03:22:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AEAE11C04A;
        Sat, 21 Mar 2020 03:22:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B43A711C06F;
        Sat, 21 Mar 2020 03:22:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.88.52])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 21 Mar 2020 03:22:42 +0000 (GMT)
Subject: Re: Ext4 corruption with VM images as 3 > drop_caches
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <87pndagw7s.fsf@linux.ibm.com>
 <20200320053451.B7AD0AE04D@d06av26.portsmouth.uk.ibm.com>
 <20200320114940.GA20455@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 21 Mar 2020 08:52:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200320114940.GA20455@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032103-0028-0000-0000-000003E88BF2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032103-0029-0000-0000-000024ADEC89
Message-Id: <20200321032242.B43A711C06F@d06av25.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_08:2020-03-20,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003210013
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 3/20/20 5:19 PM, Jan Kara wrote:
> On Fri 20-03-20 11:04:50, Ritesh Harjani wrote:
>> On 3/19/20 6:54 PM, Ritesh Harjani wrote:
>>> On 3/18/20 9:17 AM, Aneesh Kumar K.V wrote:
>>>> Hi,
>>>>
>>>> With new vm install I am finding corruption with the vm image if I
>>>> follow up the install with echo 3 > /proc/sys/vm/drop_caches
>>>>
>>>> The file system reports below error.
>>>>
>>>> Begin: Running /scripts/local-bottom ... done.
>>>> Begin: Running /scripts/init-bottom ...
>>>> [    4.916017] EXT4-fs error (device vda2): ext4_lookup:1700: inode
>>>> #787185: comm sh: iget: checksum invalid
>>>> done.
>>>> [    5.244312] EXT4-fs error (device vda2): ext4_lookup:1700: inode
>>>> #917954: comm init: iget: checksum invalid
>>>> [    5.257246] EXT4-fs error (device vda2): ext4_lookup:1700: inode
>>>> #917954: comm init: iget: checksum invalid
>>>> /sbin/init: error while loading shared libraries: libc.so.6: cannot
>>>> open shared object file: Error 74
>>>> [    5.271207] Kernel panic - not syncing: Attempted to kill init!
>>>> exitcode=0x00007f00
>>>>
>>>> And debugfs reports
>>>>
>>>> debugfs:  stat <917954>
>>>> Inode: 917954   Type: bad type    Mode:  0000   Flags: 0x0
>>>> Generation: 0    Version: 0x00000000
>>>> User:     0   Group:     0   Size: 0
>>>> File ACL: 0
>>>> Links: 0   Blockcount: 0
>>>> Fragment:  Address: 0    Number: 0    Size: 0
>>>> ctime: 0x00000000 -- Wed Dec 31 18:00:00 1969
>>>> atime: 0x00000000 -- Wed Dec 31 18:00:00 1969
>>>> mtime: 0x00000000 -- Wed Dec 31 18:00:00 1969
>>>> Size of extra inode fields: 0
>>>> Inode checksum: 0x00000000
>>>> BLOCKS:
>>>> debugfs:
>>>>
>>>> Bisecting this finds
>>>> Commit 244adf6426ee31a83f397b700d964cff12a247d3("ext4: make
>>>> dioread_nolock the default")
>>>> as bad. If I revert the same on top of linus
>>>> upstream(fb33c6510d5595144d585aa194d377cf74d31911)
>>>> I don't hit the corrupttion anymore.
>>>
>>> Tried replicating this and could easily replicate it on Power box.
>>> I tried to reproduce this on x86 too, but could not reproduce on x86.
>>> Now one difference on Power could be that pagesize is 64K and fs
>>> blocksize is 4K.
>>>
>>> The issue looks like the guest qemu image file is not properly written
>>> back, after host does echo 3 > drop_caches. (correct me if this is not
>>> the case).
>>
>> Ok. So tried this issue with passing "cache=directsync" parameter to
>> drive file. This parameter says it should bypass the host side page
>> cache. With this parameter, I don't see this issue on Power box.
> 
> OK, so this likely means that there is something hosed in the writeback
> path using unwritten extents when blocksize < pagesize. Maybe we miss some
> conversion of unwritten extent to a written one and thus after dropping
> caches we effectively loose data?
> 

Yes, that seems like it. I will try and create a small test case
considering this. Also will go over the unwritten to written path and
check what did I miss there.

Thanks
ritesh





> 
>>> I tried replicating via below test, but it could not reproduce.
>>>
>>> Any idea what kind of unit test could be written for this?
>>> I am not sure how exactly qemu is writing to it's image file.
>>>
>>>
>>> 1. Create 2 files. "mmap-file", "mmap-data".
>>> 2. "mmap-file" is a 2GB sparse file. Then at some random offsets (tried
>>> with both 64KB align and 4KB align offsets), try to write
>>> pagesize/blocksize amount of known data pattern.
>>> 3. These offsets (which are pagesize/blocksize align) are recorded into
>>> "mmap-data" file via normal read/write calls.
>>> 4. Then after we wrote to both files, we munmap the "mmap-file" and
>>> close both of these files.
>>> 5. Then we do echo 3 > drop_caches.
>>> 6. Then in the verify phase, using the offsets written in "mmap-data"
>>> file, I read the "mmap-file" to verify if it's contents are proper or
>>> not.
>>> With that could not reproduce this issue.
>>>
>>>
>>> -ritesh
>>>
>>>
>>

