Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C71F1D33D4
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 17:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgENO7y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 10:59:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60212 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726216AbgENO7y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 May 2020 10:59:54 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04EExVqO009992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 10:59:32 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 952B0420304; Thu, 14 May 2020 10:59:31 -0400 (EDT)
Date:   Thu, 14 May 2020 10:59:31 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2] ext4: fix error pointer dereference
Message-ID: <20200514145931.GA2072305@mit.edu>
References: <1587628004-95123-1-git-send-email-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587628004-95123-1-git-send-email-jefflexu@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 23, 2020 at 03:46:44PM +0800, Jeffle Xu wrote:
> Don't pass error pointers to brelse().
> 
> commit 7159a986b420 ("ext4: fix some error pointer dereferences") has fixed
> some cases, fix the remaining one case.
> 
> Once ext4_xattr_block_find()->ext4_sb_bread() failed, error pointer is
> stored in @bs->bh, which will be passed to brelse() in the cleanup
> routine of ext4_xattr_set_handle(). This will then cause a NULL panic
> crash in __brelse().
> 
> BUG: unable to handle kernel NULL pointer dereference at 000000000000005b
> RIP: 0010:__brelse+0x1b/0x50
> Call Trace:
>  ext4_xattr_set_handle+0x163/0x5d0
>  ext4_xattr_set+0x95/0x110
>  __vfs_setxattr+0x6b/0x80
>  __vfs_setxattr_noperm+0x68/0x1b0
>  vfs_setxattr+0xa0/0xb0
>  setxattr+0x12c/0x1a0
>  path_setxattr+0x8d/0xc0
>  __x64_sys_setxattr+0x27/0x30
>  do_syscall_64+0x60/0x250
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> In this case, @bs->bh stores '-EIO' actually.
> 
> Fixes: fb265c9cb49e ("ext4: add ext4_sb_bread() to disambiguate ENOMEM cases")
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: stable@kernel.org # 2.6.19
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

						- Ted
