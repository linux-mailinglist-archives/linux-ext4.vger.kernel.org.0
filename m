Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894AFF4F61
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2019 16:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfKHPWC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Nov 2019 10:22:02 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:56234 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbfKHPWC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Nov 2019 10:22:02 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 6AB452E14DB;
        Fri,  8 Nov 2019 18:21:58 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id Bl9ncq3Znd-LuA8X05E;
        Fri, 08 Nov 2019 18:21:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573226518; bh=adnC/iTxUcrhGYGRJutoOIWeXUNVcuANsBlpJP0jmzM=;
        h=Message-ID:Subject:Date:References:To:From:In-Reply-To:Cc;
        b=cJJINX1VarLT0RZcxQNSQojC4uzvQvfMKWzYV4qAhD6ffS3HmRnxdZtnz4aupS/ze
         OpUjyhVk6MuN8+4btQQljUcaRnRbm7Mmyiabxmnxlg1/oZUCZYbclxDEw9zztK22mS
         pr6Iy/gElh6cu1vVxnwnIyQv7sLpfGkmyIg+RRbo=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by vla1-5826f599457c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id n8aAsXwaGV-LuWC47Ma;
        Fri, 08 Nov 2019 18:21:56 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix extent_status fragmentation for plain files
In-Reply-To: <20191107153819.GI26959@mit.edu>
References: <20191106122502.19986-1-dmonakhov@gmail.com> <20191107153819.GI26959@mit.edu>
Date:   Fri, 08 Nov 2019 18:21:56 +0300
Message-ID: <874kze4cmj.fsf@dmws.yandex.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--=-=-=
Content-Type: text/plain


"Theodore Y. Ts'o" <tytso@mit.edu> writes:

> On Wed, Nov 06, 2019 at 12:25:02PM +0000, Dmitry Monakhov wrote:
>> It is appeared that extent are not cached for inodes with depth == 0
>> which result in suboptimal extent status populating inside ext4_map_blocks()
>> by map's result where size requested is usually smaller than extent size so
>> cache becomes fragmented
>> 
>> # Example: I have plain file:
>> File size of /mnt/test is 33554432 (8192 blocks of 4096 bytes)
>>  ext:     logical_offset:        physical_offset: length:   expected: flags:
>>    0:        0..    8191:      40960..     49151:   8192:             last,eof
>> 
>> $ perf record -e 'ext4:ext4_es_*' /root/bin/fio --name=t --direct=0 --rw=randread --bs=4k --filesize=32M --size=32M --filename=/mnt/test
>> $ perf script | grep ext4_es_insert_extent | head -n 10
>>              fio   131 [000]    13.975421:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [494/1) mapped 41454 status W
>>              fio   131 [000]    13.976467:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [6907/1) mapped 47867 status W
>
> So this is certainly bad behavior, but the original intent was to not
> cached extents that were in the inode's i_blocks[] array because the
> information was already in the inode cache, and so we could save
> memory but just pulling the information out of the i_blocks away and
> there was no need to cache the extent in the es cache.
>
> There are cases where we do need to track the extent in the es cache
> --- for example, if we are writing the file and we need to track its
> delayed allocation status.
>
> So I wonder if we might be better off defining a new flag
> EXT4_MAP_INROOT, which gets set by ext4_ext_map_blocks() and
> ext4_ind_map_blocks() if the mapping is exclusively found in the
> i_blocks array, and if EXT4_MAP_INROOT is set, and we don't need to
> set EXTENT_STATUS_DELAYED, we skip the call to
> ext4_es_insert_extent().
>
> What do you think?  This should significantly reduce the memory
> utilization of the es_cache, which would be good for low-memory
> workloads, and those where there are a large number of inodes that fit
> in the es_cache, which is probably true for most desktops, especially
> those belonging kernel developers.  :-)

Sound reasonable, same happens in ext4_ext_precache()
See my patch below.

But this also means that on each ext4_map_blocks()
will fallback to regular block lookup:

down_read(&EXT4_I(inode)->i_data_sem)
ext4_ext_map_blocks (
 ->ext4_find_extent
   path = kcalloc(depth + 2, sizeof(struct ext4_ext_path), GFP_NOFS)
   kfree(path)
up_read(&EXT4_I(inode)->i_data_sem)
I thought that we can neglect this, but curiosity is a good thing
That it why I've tested nocache(see patch below) vs cache(first path)  approach

## Production server ##
# CPU: Intel-Gold-6230
# DEV: /dev/ram0 
# TEST: fio --direct=1 --rw=randread --bs=1k --filesize=64M
IOPS(nocache/cache): 729k vs 764k  => +5%
# DEV: /dev/nvme0n1 (Samsung DC grade)
# TEST: fio --direct=1 --rw=randread --bs=4k --filesize=64M --ioengine=libaio --iodepth=128
IOPS(nocache/cache): 366k vs 378k => +3%

## My notebook Carbon/X1 ##
# CPU: i7-7600U
# DEV: /dev/nvme0n1 (Samsung MZVLB512HAJQ-000L7)
# TEST: fio --direct=1 --rw=randread --bs=4k --filesize=64M --ioengine=libaio --iodepth=128
IOPS(nocache/cache): 270k vs 270k => No difference

Difference is invisiable for my laptop, but visiable on fast NVME dev.
From other point of view unconditional caching result in memory
overhead  sizeof(struct extent_status)/sizeof(ext4_inode_info) => 3.5% for everybody.
>
> 						- Ted

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-ext4-Don-t-cache-clean-inline-extents.patch

From 779e1322d47a5f28364343446853f24ac145e9ff Mon Sep 17 00:00:00 2001
From: Dmitry Monakhov <dmonakhov@gmail.com>
Date: Fri, 8 Nov 2019 18:08:49 +0300
Subject: [PATCH] ext4:  Don't cache clean inline extents

Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
---
 fs/ext4/inode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index abaaf7d..6839ac4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -45,6 +45,7 @@
 #include "xattr.h"
 #include "acl.h"
 #include "truncate.h"
+#include "ext4_extents.h"
 
 #include <trace/events/ext4.h>
 
@@ -584,11 +585,13 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
 				       map->m_lblk + map->m_len - 1))
 			status |= EXTENT_STATUS_DELAYED;
-		ret = ext4_es_insert_extent(inode, map->m_lblk,
-					    map->m_len, map->m_pblk, status);
-		if (ret < 0)
-			retval = ret;
+		/* Don't cache if there are no external extent blocks */
+		if ((status & EXTENT_STATUS_DELAYED) || ext_depth(inode)) {
+			ret = ext4_es_insert_extent(inode, map->m_lblk,
+						    map->m_len, map->m_pblk, status);
+			if (ret < 0)
+				retval = ret;
+		}
 	}
 	up_read((&EXT4_I(inode)->i_data_sem));
 
-- 
2.7.4


--=-=-=--
