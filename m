Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA42D26255A
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Sep 2020 04:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgIICpG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Sep 2020 22:45:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47740 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgIICpF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Sep 2020 22:45:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892U4bQ171809;
        Wed, 9 Sep 2020 02:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=YusHDyph8KZqg5CWbHsk1YC4pyif7QVsWoaoLcpvyW8=;
 b=ljjeqiQHw8UZ24mxDHZwsQJfIV8zV9i8+4iOObt9viC8dxCLdJ+yljE9Yd7whfcnENQx
 FC72KMfSa55sKKv7en0YWtKgJLZS+fFezPib45X/SlSDpi0wqUXChCE4tkCFVJHki9R+
 j5AjsD2vdvBap/6jei846g2CWns5KG0XeGWb5ukrAXNm1wIL1xIRR9PGWF5miNB81I6G
 z8GFsXbFanXzjNtBcdwo3IUqaaxI28rxRwWbEw4tBllVEceuwqsWHRe/DwQqzUKEpuxy
 XzA/skpBWJ8wOOjZxPKs7uSPl9xXcFxGF5QTPIX1ey39b+aR3ZS3JWYyR1OsCXgBhy2W jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 33c23qy2rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 02:44:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892UL3u060379;
        Wed, 9 Sep 2020 02:44:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33cmkwxe1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 02:44:59 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0892iwBA029471;
        Wed, 9 Sep 2020 02:44:58 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 19:44:52 -0700
Date:   Tue, 8 Sep 2020 19:44:50 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Gong, Sishuai" <sishuai@purdue.edu>
Cc:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "adilger@dilger.ca" <adilger@dilger.ca>
Subject: Re: PROBLEM: another potential concurrency bug in
 swap_inode_boot_loader()
Message-ID: <20200909024450.GA7948@magnolia>
References: <CBFCE964-34D6-47ED-BB71-E8975C16F808@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CBFCE964-34D6-47ED-BB71-E8975C16F808@purdue.edu>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090022
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 09, 2020 at 12:28:36AM +0000, Gong, Sishuai wrote:
> Hi,
> 
> We found a potential concurrency bug in linux kernel 5.3.11. We were able to reproduce this bug in x86 under specific thread interleavings. This bug causes a “bad header/extent” EXT4-fs error. 
> 
> In addition, we think this bug may be related to another bug we reported earlier. Similar to a concern mentioned in your reply, this time the inode had a correct checksum but a wrong header data.
> 
> https://lore.kernel.org/linux-ext4/459EE6E3-1CB2-4898-8C5F-283E821B2A75@dilger.ca/T/#t
> 
> 
> ------------------------------------------
> Kernel console output
> 
> EXT4-fs error (device sda1): ext4_ext_check_inode:498: inode #5: comm ski-executor: pblk 0 bad header/extent: invalid magic - magic 0, entries 0, max 0(0), depth 0(0)
> 
> ------------------------------------------
> Test input
> 
> This bug occurs when a kernel test program is executed twice in different threads and ran concurrently. Our analysis has located that it happens when syscall ioctl with the EXT4_IOC_SWAP_BOOT flag is called twice and interleaves with itself. 
> The test program is generated by Syzkaller as follows:
> r0 = creat(&(0x7f0000000080)='./file0\x00', 0x0)
> ioctl$FS_IOC_SETFLAGS(r0, 0x40046602, &(0x7f0000000040)) 
> r1 = creat(&(0x7f0000000000)='./file0\x00', 0x0)
> pwrite64(r1, &(0x7f00000000c0)='\x00', 0x1, 0x1010000)
> r2 = creat(&(0x7f0000000000)='./file0\x00', 0x0)
> ioctl$EXT4_IOC_SWAP_BOOT(r2, 0x6611)
> 
> ------------------------------------------
> Thread interleaving
> 
> Our analysis revealed that the following interleaving triggers this bug.
> 
> CPU0																CPU1
> swap_inode_boot_loader()
> …
> -- ext4_mark_inode_dirty() [fs/ext4/ioctl.c:207]
> [context switch]
> 																	swap_inode_boot_loader()
> 																	-- ext4_iget()
> 																	---- ext4_isize()
> 																	[context switch]			


How do you end up in this state?  CPU0 has already ext4_iget()'d a
reference to the bootloader inode, right?  Which means that I_NEW is no
longer set on the incore inode, right, because we clear that flag when
we unlock the inode.i_lock at the end of the iget function.  So
shouldn't CPU1's call to ext4_iget to get the same bootloader inode end
up with the same incore inode?  And won't I_NEW be clear by then?

--D

> …
> -- ext4_mark_inode_dirty() [fs/ext4/ioctl.c:223]
> ---- ext4_mark_iloc_dirty()
> ------ ext4_do_update_inode()
>           for (block = 0; block < EXT4_N_BLOCKS; block++) [fs/ext4/inode.c:5337]
>             raw_inode->i_block[block] = ei->i_data[block];
> …
> [syscall finishes]
> [context switch]
> 																	…
> 											        						for (block = 0; block < EXT4_N_BLOCKS; block++) [fs/ext4/inode.c:5002]
> 																	          ei->i_data[block] = raw_inode->i_block[block];
> 																	…
> 																	---- ext4_ext_check_inode(inode)
> 																	[EXT4-fs error]				
> 
> 
> Thanks,
> Sishuai
> 
