Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40EC118B62C
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Mar 2020 14:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgCSNYn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 09:24:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730513AbgCSNYl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 19 Mar 2020 09:24:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JD8cAk039575
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 09:24:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yuxx1fd32-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 09:24:40 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 19 Mar 2020 13:24:38 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Mar 2020 13:24:35 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02JDOYWl62849232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 13:24:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9D1CA4059;
        Thu, 19 Mar 2020 13:24:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2A88A404D;
        Thu, 19 Mar 2020 13:24:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.65.63])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Mar 2020 13:24:33 +0000 (GMT)
Subject: Re: Ext4 corruption with VM images as 3 > drop_caches
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
References: <87pndagw7s.fsf@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jan Kara <jack@suse.cz>
Date:   Thu, 19 Mar 2020 18:54:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87pndagw7s.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031913-0008-0000-0000-00000360038F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031913-0009-0000-0000-00004A816175
Message-Id: <20200319132433.A2A88A404D@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_04:2020-03-19,2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190058
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 3/18/20 9:17 AM, Aneesh Kumar K.V wrote:
> Hi,
> 
> With new vm install I am finding corruption with the vm image if I
> follow up the install with echo 3 > /proc/sys/vm/drop_caches
> 
> The file system reports below error.
> 
> Begin: Running /scripts/local-bottom ... done.
> Begin: Running /scripts/init-bottom ...
> [    4.916017] EXT4-fs error (device vda2): ext4_lookup:1700: inode #787185: comm sh: iget: checksum invalid
> done.
> [    5.244312] EXT4-fs error (device vda2): ext4_lookup:1700: inode #917954: comm init: iget: checksum invalid
> [    5.257246] EXT4-fs error (device vda2): ext4_lookup:1700: inode #917954: comm init: iget: checksum invalid
> /sbin/init: error while loading shared libraries: libc.so.6: cannot open shared object file: Error 74
> [    5.271207] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> 
> And debugfs reports
> 
> debugfs:  stat <917954>
> Inode: 917954   Type: bad type    Mode:  0000   Flags: 0x0
> Generation: 0    Version: 0x00000000
> User:     0   Group:     0   Size: 0
> File ACL: 0
> Links: 0   Blockcount: 0
> Fragment:  Address: 0    Number: 0    Size: 0
> ctime: 0x00000000 -- Wed Dec 31 18:00:00 1969
> atime: 0x00000000 -- Wed Dec 31 18:00:00 1969
> mtime: 0x00000000 -- Wed Dec 31 18:00:00 1969
> Size of extra inode fields: 0
> Inode checksum: 0x00000000
> BLOCKS:
> debugfs:
> 
> Bisecting this finds
> Commit 244adf6426ee31a83f397b700d964cff12a247d3("ext4: make dioread_nolock the default")
> as bad. If I revert the same on top of linus upstream(fb33c6510d5595144d585aa194d377cf74d31911)
> I don't hit the corrupttion anymore.

Tried replicating this and could easily replicate it on Power box.
I tried to reproduce this on x86 too, but could not reproduce on x86.
Now one difference on Power could be that pagesize is 64K and fs
blocksize is 4K.

The issue looks like the guest qemu image file is not properly written
back, after host does echo 3 > drop_caches. (correct me if this is not
the case).

I tried replicating via below test, but it could not reproduce.

Any idea what kind of unit test could be written for this?
I am not sure how exactly qemu is writing to it's image file.


1. Create 2 files. "mmap-file", "mmap-data".
2. "mmap-file" is a 2GB sparse file. Then at some random offsets (tried 
with both 64KB align and 4KB align offsets), try to write
pagesize/blocksize amount of known data pattern.
3. These offsets (which are pagesize/blocksize align) are recorded into
"mmap-data" file via normal read/write calls.
4. Then after we wrote to both files, we munmap the "mmap-file" and
close both of these files.
5. Then we do echo 3 > drop_caches.
6. Then in the verify phase, using the offsets written in "mmap-data"
file, I read the "mmap-file" to verify if it's contents are proper or
not.
With that could not reproduce this issue.


-ritesh


