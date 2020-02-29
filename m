Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F526174A10
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2020 00:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgB2X0N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Feb 2020 18:26:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56689 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726786AbgB2X0N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Feb 2020 18:26:13 -0500
Received: from callcc.thunk.org (205.220.128.199.nw.nuvox.net [205.220.128.199])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01TNQ2qv003743
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 18:26:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1FE1D42045B; Sat, 29 Feb 2020 18:25:59 -0500 (EST)
Date:   Sat, 29 Feb 2020 18:25:59 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/9] e2fsck: fix e2fsck_allocate_memory() overflow
Message-ID: <20200229232559.GA38945@mit.edu>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 06, 2020 at 06:09:38PM -0700, Andreas Dilger wrote:
> e2fsck_allocate_memory() takes an "unsigned int size" argument, which
> will overflow for allocations above 4GB.  This happens for dir_info
> and dx_dir_info arrays when there are more than 350M directories in a
> filesystem, and for the dblist array above 180M directories.
> 
> There is also a risk of overflow during the binary search in both
> e2fsck_get_dir_info() and e2fsck_get_dx_dir_info() when the midpoint
> of the array is calculated, if there would be more than 2B directories
> in the filesystem and working above the half way point.
> 
> Also, in some places inode numbers are "int" instead of "ext2_ino_t",
> which can also cause problems with the array size calculations, and
> makes it hard to identify where inode numbers are used.
> 
> Fix e2fsck_allocate_memory() to take an "unsigned long" argument to
> match ext2fs_get_mem(), so that it can do single memory allocations
> over 4GB.
> 
> Fix e2fsck_get_dir_info() and e2fsck_get_dx_dir_info() to temporarily
> use an unsigned long long value to calculate the midpoint (which will
> always fit into an ext2_ino_t again afterward).
> 
> Change variables that hold inode numbers to be ext2_ino_t, and print
> them as unsigned values instead of printing negative inode numbers.
> 
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
> Reviewed-by: Shilong Wang <wshilong@ddn.com>
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197

Applied, thanks.

					- Ted
