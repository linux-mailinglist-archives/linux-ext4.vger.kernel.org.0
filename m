Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D45C307CF1
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jan 2021 18:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhA1Rrl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Jan 2021 12:47:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231904AbhA1RqM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 28 Jan 2021 12:46:12 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10SHVlue161872;
        Thu, 28 Jan 2021 12:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pHp0k+ApY2lP3WzVLuYRidIYP3byq0tqwTAE6VaIpU8=;
 b=e0PhOodRplM+9WKiM3uv/oVltczuuXdXqTa8ff43NLZxVNT0ZY+7SfFNqxdES5mtHAVK
 7qGtjmaOT40TVDBA1ge+MIKL/G5Kng7+C1KYXNdsmYYUH87kotSwKG5Ha13RZLRREH7A
 5x43Xn1NfOd+uKtVJ6M2NcvN7dRF93leNPja99yCm4SXCJ08JpJjPRiHG9kXKtNYt9xQ
 2VCRWGiwhQv0lW8MzH6LPiJaeF4USyCk7F2SfKudTxbD3J+//PIAaMZBnWAcJz90E1qK
 xUw/+tZgXdwoApzcczb9dGq0+qx1/sAWUfWGqZ/e8pCdtPV7hYSw3DwMHmo8Zs5yPJf2 lw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36c136huq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 12:45:25 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10SHbB1x012266;
        Thu, 28 Jan 2021 17:45:22 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 369jjshxuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 17:45:22 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10SHjKoQ40174018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 17:45:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A2104204B;
        Thu, 28 Jan 2021 17:45:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7218C42041;
        Thu, 28 Jan 2021 17:45:19 +0000 (GMT)
Received: from [9.199.44.49] (unknown [9.199.44.49])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jan 2021 17:45:19 +0000 (GMT)
Subject: Re: [Bug 211315] New: [aarch64][xfstests/ext3 generic/472] swapon:
 Invalid argument
To:     bugzilla-daemon@bugzilla.kernel.org, linux-ext4@vger.kernel.org
References: <bug-211315-13602@https.bugzilla.kernel.org/>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Message-ID: <977e1b58-b1f3-01bf-2dfd-5b9a7f1e74d4@linux.ibm.com>
Date:   Thu, 28 Jan 2021 23:15:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bug-211315-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_12:2021-01-28,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280082
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Thanks for reporting this.
Ok, so earlier I thought I tested this on Power (pagesize=64K).
But it seems I had only tested with 1K blocksize but not with 2K.
On retrying it again with ext3 with 2K blocksize, I see it could be 
reproduced on latest kernel on Power as well (where pagesize is 64K).
(gcc version 8.4.0)

I will look more into what is causing this, but it seems it may be
coming from below path :-

static int setup_swap_map_and_extents()
<...>

	if (!nr_good_pages) {
		pr_warn("Empty swap-file\n");
		return -EINVAL;
	}
<...>


BTW, is ext3 with 2K bs some default configuration you use often on 
arch64. Or was it mostly for testing purpose only?

-ritesh


On 1/22/21 4:19 PM, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=211315
> 
>              Bug ID: 211315
>             Summary: [aarch64][xfstests/ext3 generic/472] swapon: Invalid
>                      argument
>             Product: File System
>             Version: 2.5
>      Kernel Version: 5.11.0-0.rc4.20210120git45dfb8a5659a.131.eln108.aarch6
>                      4
>            Hardware: ARM
>                  OS: Linux
>                Tree: Mainline
>              Status: NEW
>            Severity: normal
>            Priority: P1
>           Component: ext3
>            Assignee: fs_ext3@kernel-bugs.osdl.org
>            Reporter: neolorry+bugzilla.kernel.org@googlemail.com
>          Regression: No
> 
> xfstests generic/472 fails on ext3 on the latest kernel
> (kernel-5.11.0-0.rc4.20210120git45dfb8a5659a.131.eln108.aarch64 from
> https://koji.fedoraproject.org/koji/buildinfo?buildID=1671933). This only
> happens on aarch64 and ext3 with 2048 block size. I can reproduce it on
> kernel-4.18 based RHEL-8 kernel as well.
> 
> log
> ```
> # ./check -d -T generic/472
> FSTYP         -- ext3
> PLATFORM      -- Linux/aarch64 15-vm-16
> 5.11.0-0.rc4.20210120git45dfb8a5659a.131.eln108.aarch64 #1 SMP Wed Jan 20
> 23:39:54 UTC 2021
> MKFS_OPTIONS  -- -b 2048 /dev/vda3
> MOUNT_OPTIONS -- -o rw,relatime,seclabel -o context=system_u:object_r:root_t:s0
> /dev/vda3 /scratch
> 
> generic/472 103s ...    [05:31:22]QA output created by 472
> regular swap
> too long swap
> tiny swap
> swapon: Invalid argument
>   [05:32:15]- output mismatch (see
> /tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.out.bad)
>      --- tests/generic/472.out   2021-01-22 01:31:23.045484313 -0500
>      +++ /tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.out.bad
> 2021-01-22 05:32:15.217684365 -0500
>      @@ -2,3 +2,4 @@
>       regular swap
>       too long swap
>       tiny swap
>      +swapon: Invalid argument
>      ...
>      (Run 'diff -u /tmp/tmp.6xoJizCZKc/repo_xfstests/tests/generic/472.out
> /tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.out.bad'  to see the
> entire diff)
> Ran: generic/472
> Failures: generic/472
> Failed 1 of 1 tests
> ```
> 
> 472.full
> ```
> # cat /tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.full
> Creating filesystem with 5767168 2k blocks and 720896 inodes
> Filesystem UUID: 97619060-f6ec-4ed0-8984-01b4aefe86f8
> Superblock backups stored on blocks:
>          16384, 49152, 81920, 114688, 147456, 409600, 442368, 802816, 1327104,
>          2048000, 3981312, 5619712
> 
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (32768 blocks): done
> Writing superblocks and filesystem accounting information: done
> 
> regular swap
> /usr/bin/chattr: Operation not supported while setting flags on /scratch/swap
> wrote 2097152/2097152 bytes at offset 0
> 2 MiB, 512 ops; 0.1898 sec (10.534 MiB/sec and 2696.7097 ops/sec)
> too long swap
> /usr/bin/chattr: Operation not supported while setting flags on /scratch/swap
> wrote 2097155/2097155 bytes at offset 0
> 2 MiB, 513 ops; 0.1231 sec (16.241 MiB/sec and 4165.7531 ops/sec)
> tiny swap
> /usr/bin/chattr: Operation not supported while setting flags on /scratch/swap
> wrote 196608/196608 bytes at offset 0
> 192 KiB, 48 ops; 0.0130 sec (14.338 MiB/sec and 3670.5666 ops/sec)
> swapoff: /scratch/swap: swapoff failed: Invalid argument
> ```
> 
> xfstests local.config
> ```
> FSTYP="ext3"
> TEST_DIR="/test"
> TEST_DEV="/dev/vda4"
> SCRATCH_MNT="/scratch"
> SCRATCH_DEV="/dev/vda3"
> LOGWRITES_MNT="/logwrites"
> LOGWRITES_DEV="/dev/vda6"
> MKFS_OPTIONS="-b 2048"
> MOUNT_OPTIONS="-o rw,relatime,seclabel"
> TEST_FS_MOUNT_OPTS="-o rw,relatime,seclabel"
> ```
> 
> 64k page size
> ```
> # getconf PAGESIZE
> 65536
> ```
> 
> fdisk -l
> ```
> # fdisk -l /dev/vda
> Disk /dev/vda: 100 GiB, 107374182400 bytes, 209715200 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: gpt
> ```
> 
> xfstests version
> ```
> # git rev-parse HEAD
> 4767884aff19e042ee3be51c88cf2c27a111707e
> # cat .git/config
> [core]
>          repositoryformatversion = 0
>          filemode = true
>          bare = false
>          logallrefupdates = true
> [remote "origin"]
>          url = git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>          fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>          remote = origin
>          merge = refs/heads/master
> ```
> 
> e2fsprogs version
> ```
> # rpm -q e2fsprogs
> e2fsprogs-1.45.6-1.el8.aarch64
> ```
> 
