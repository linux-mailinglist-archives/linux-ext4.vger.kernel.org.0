Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F98D28044F
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 18:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgJAQxs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 12:53:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52452 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732274AbgJAQxs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 12:53:48 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 091GrgR2028888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Oct 2020 12:53:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 40B7C42003C; Thu,  1 Oct 2020 12:53:42 -0400 (EDT)
Date:   Thu, 1 Oct 2020 12:53:42 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Hongxu Jia <hongxu.jia@windriver.com>
Cc:     linux-ext4@vger.kernel.org, wshilong@ddn.com, adilger@dilger.ca
Subject: Re: [PATCH] mke2fs: fix up check for hardlinks always false if inode
 > 0xFFFFFFFF
Message-ID: <20201001165342.GK23474@mit.edu>
References: <20200722012503.42711-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722012503.42711-1-hongxu.jia@windriver.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 21, 2020 at 06:25:03PM -0700, Hongxu Jia wrote:
> While file has a large inode number (> 0xFFFFFFFF), mkfs.ext4 could
> not parse hardlink correctly.
> 
> Prepare three hardlink files for mkfs.ext4
> 
> $ ls -il rootfs_ota/a rootfs_ota/boot/b rootfs_ota/boot/c
> 11026675846 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 rootfs_ota/a
> 11026675846 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 rootfs_ota/boot/b
> 11026675846 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 rootfs_ota/boot/c
> 
> $ truncate -s 1M rootfs_ota.ext4
> 
> $ mkfs.ext4 -F -i 8192 rootfs_ota.ext4 -L otaroot -U fd5f8768-c779-4dc9-adde-165a3d863349 -d rootfs_ota
> 
> $ mkdir mnt && sudo mount rootfs_ota.ext4 mnt
> 
> $ ls -il mnt/a mnt/boot/b mnt/boot/c
> 12 -rw-r--r-- 1 hjia users 0 Jul 20 17:44 mnt/a
> 14 -rw-r--r-- 1 hjia users 0 Jul 20 17:44 mnt/boot/b
> 15 -rw-r--r-- 1 hjia users 0 Jul 20 17:44 mnt/boot/c
> 
> After applying this fix
> $ ls -il mnt/a mnt/boot/b mnt/boot/c
> 12 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 mnt/a
> 12 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 mnt/boot/b
> 12 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 mnt/boot/c
> 
> Since commit [382ed4a1 e2fsck: use proper types for variables][1]
> applied, it used ext2_ino_t instead of ino_t for referencing inode
> numbers, but the type of is_hardlink's `ino' should not be instead,
> The ext2_ino_t is 32bit, if inode > 0xFFFFFFFF, its value will be
> truncated.
> 
> Add a debug printf to show the value of inode, when it check for hardlink
> files, it will always return false if inode > 0xFFFFFFFF
> |--- a/misc/create_inode.c
> |+++ b/misc/create_inode.c
> |@@ -605,6 +605,7 @@ static int is_hardlink(struct hdlinks_s *hdlinks, dev_t dev, ext2_ino_t ino)
> | {
> |        int i;
> |
> |+       printf("%s %d, %lX, %lX\n", __FUNCTION__, __LINE__, hdlinks->hdl[i].src_ino, ino);
> |        for (i = 0; i < hdlinks->count; i++) {
> |                if (hdlinks->hdl[i].src_dev == dev &&
> |                    hdlinks->hdl[i].src_ino == ino)
> 
> Here is debug message:
> is_hardlink 608, 2913DB886, 913DB886
> 
> The length of ext2_ino_t is 32bit (typedef __u32 __bitwise ext2_ino_t;),
> and ino_t is 64bit on 64bit system (such as x86-64), recover `ino' to ino_t.
> 
> [1] https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/commit/?id=382ed4a1c2b60acb9db7631e86dda207bde6076e
> 
> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

Applied, thanks.

						- Ted
