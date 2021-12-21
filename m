Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BAC47C87B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Dec 2021 21:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhLUU5z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Dec 2021 15:57:55 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47333 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234101AbhLUU5y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Dec 2021 15:57:54 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BLKvgTT015930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 15:57:43 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 232C215C33A4; Tue, 21 Dec 2021 15:57:42 -0500 (EST)
Date:   Tue, 21 Dec 2021 15:57:42 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] resize2fs : resize2fs failed due to the same name of
 tmpfs
Message-ID: <YcI/xt1IiJKLN/Bw@mit.edu>
References: <54d44dbc-861d-8c49-9b29-2621c201ca4f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d44dbc-861d-8c49-9b29-2621c201ca4f@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 30, 2021 at 12:04:48PM +0800, zhanchengbin wrote:
> If there is a tmpfs with the same name as the disk, and mount before the
> disk,example:
> 	/dev/sdd /root/tmp tmpfs rw,seclabel,relatime 0 0
> 	/dev/sdd /root/mnt ext4 rw,seclabel,relatime 0 0

This should already be fixed e2fsprogs 1.45.5+ via this commit:

commit ea4d53b7b9079fd6e2cc34cf569a993a183bfbd2
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sun Nov 10 12:11:49 2019 -0500

    libext2fs/ismounted.c: check device id in advance to skip false device names
    
    If there is a trickster which tries to use device names as the mount
    device for pseudo-file systems, the resulting /proc/mounts can confuse
    ext2fs_check_mount_point().  (So far as I can tell, there's no good
    reason to do this, but sysadmins do the darnest things.)
    
    An example of this might be the following /proc/mounts excerpt:
    
    /dev/sdb /mnt2 tmpfs rw,relatime 0 0
    /dev/sdb /mnt ext4 rw,relatime 0 0
    
    This is created via "mount -t tmpfs /dev/sdb /mnt2" followed via
    "mount -t ext4 /dev/sdb /mnt".  (Normally, a sane mount of tmpfs would
    use something like "mount -t tmpfs tmpfs /mnt2".)
    
    Fix this by double checking the st_rdev of the claimed mountpoint and
    match it with the dev_t of the device.  (Note that the GNU HURD
    doesn't support st_rdev, so we can't solve this problem for the HURD.)
    
    Reported-by: GuiYao <guiyao@huawei.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

I've tested via tst_ismounted and I can't replicate the issue you've described.

% cd /build/e2fsprogs-maint/lib/ext2fs
% make tst_ismounted
% sudo ./tst_ismounted /dev/dm-7
Bogus entry in /proc/mounts!  (/dev/dm-7 is not mounted on /root/tmp)
Device /dev/dm-7 reports flags 11
        /dev/dm-7 is apparently in use.
        /dev/dm-7 is mounted.
        /dev/dm-7 is mounted on /root/mnt.

Cheers,

							- Ted
