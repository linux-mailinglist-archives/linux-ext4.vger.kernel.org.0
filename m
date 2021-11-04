Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E584144511B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Nov 2021 10:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhKDJcw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Nov 2021 05:32:52 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:52342 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhKDJcv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Nov 2021 05:32:51 -0400
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 577391008CBC0;
        Thu,  4 Nov 2021 17:30:12 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 2FAB42007EC6E;
        Thu,  4 Nov 2021 17:30:09 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8E93ccPlxdbj; Thu,  4 Nov 2021 17:30:06 +0800 (CST)
Received: from [192.168.11.167] (unknown [202.120.40.82])
        (Authenticated sender: sunrise_l@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id ADE4D200B8923;
        Thu,  4 Nov 2021 17:29:59 +0800 (CST)
Subject: Re: [PATCH] ext4: remove unnecessary ext4_inode_datasync_dirty in
 read path
To:     Dave Chinner <david@fromorbit.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingkaidong@gmail.com
References: <20211102024258.210439-1-sunrise_l@sjtu.edu.cn>
 <20211103002843.GC418105@dread.disaster.area>
From:   Zhongwei Cai <sunrise_l@sjtu.edu.cn>
Message-ID: <ffb199dc-f7ae-ba03-db57-bf7acc3d0636@sjtu.edu.cn>
Date:   Thu, 4 Nov 2021 17:29:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211103002843.GC418105@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11/3/21 8:28 AM, Dave Chinner wrote:
 > IOWs, we expect the IOMAP_F_DIRTY flag to be set on all types of
 > iomap mapping calls if the inode is dirty, not just IOMAP_WRITE
 > calls.

Thanks for correction!

 > /*
 >  * Flags reported by the file system from iomap_begin:
 >  *
 >  * IOMAP_F_NEW indicates that the blocks have been newly allocated
 >  * and need zeroing for areas that no data is copied to.
 >  *
 >  * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed
 >  * to access written data and requires fdatasync to commit them to
 >  * persistent  storage. This needs to take into account metadata
 >  * changes that  *may* be made at IO completion, such as file size
 >  * updates from direct IO.
 >  *
 >  * IOMAP_F_SHARED indicates that the blocks are shared, and will
 >  * need to be unshared as part a write.
 >  *
 >  * IOMAP_F_MERGED indicates that the iomap contains the merge of
 >  * multiple block mappings.
 >  *
 >  * IOMAP_F_BUFFER_HEAD indicates that the file system requires the
 >  * use of buffer heads for this mapping.
 >  */

According to the comments in include/linux/iomap.h, it seems other
flags in the iomap indicates the iomap-related status, but the
IOMAP_F_DIRTY flag only indicates the status of the inode. So can
I_DIRTY_INODE or I_DIRTY_PAGES flags in the inode replace it?

And for ext4 at least we can do

    /*
     * Writes that span EOF might trigger an I/O size update on completion,
     * so consider them to be dirty for the purpose of O_DSYNC, even if
     * there is no other metadata changes being made or are pending.
     */
     if (ext4_inode_datasync_dirty(inode) ||
-       offset + length > i_size_read(inode))
+       ((flags & IOMAP_WRITE) && offset + length > i_size_read(inode)))
         iomap->flags |= IOMAP_F_DIRTY;

, since only writes that span EOF might trigger an update. How
do you feel about it?

Best,

Zhongwei.
