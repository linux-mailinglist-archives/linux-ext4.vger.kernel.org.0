Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E794935A858
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 23:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhDIV3S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 17:29:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47402 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234333AbhDIV3R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 17:29:17 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 139LSsO7004914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 17:28:55 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 787AA15C3B12; Fri,  9 Apr 2021 17:28:54 -0400 (EDT)
Date:   Fri, 9 Apr 2021 17:28:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext4: Fix fs can't panic when abort by user
Message-ID: <YHDHFv99m3A6jQjP@mit.edu>
References: <20210401081903.3421208-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401081903.3421208-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 01, 2021 at 04:19:03PM +0800, Ye Bin wrote:
> Test steps:
> 1. mount /dev/sda -o errors=panic test
> 2. mount /dev/sda -o remount,ro test
> 3. mount /dev/sda -o remount,abort test
> 
> Before 014c9caa29d3 not been merged there will trigger panic. But
> 014c9caa29d3 change this behavior.

This makes sense, but I'll note this behavior has changed over time.

root@kvm-xfstests:~# mount -o errors=panic /dev/vdc /vdc
[   20.252713] EXT4-fs (vdc): mounted filesystem with ordered data mode. Opts: errors=panic
root@kvm-xfstests:~# mount -o remount,ro /dev/vdc
[   24.832448] EXT4-fs (vdc): re-mounted. Opts: (null)
root@kvm-xfstests:~# mount -o remount,abort /dev/vdc
[   30.833543] EXT4-fs error (device vdc): ext4_remount:5340: Abort forced by user
mount: /vdc: cannot remount /dev/vdc read-write, is write-protected.
root@kvm-xfstests:~# mount -o remount,abort,ro /dev/vdc
[   34.545549] EXT4-fs error (device vdc): ext4_remount:5340: Abort forced by user
[   34.555475] EXT4-fs (vdc): re-mounted. Opts: abort
root@kvm-xfstests:~# uname -a
Linux kvm-xfstests 4.19.163-xfstests #1 SMP Sat Dec 19 23:55:11 EST 2020 x86_64 GNU/Linux
root@kvm-xfstests:~#

The same is true for the 5.4 kernel.

I do agree that it *should* force a panic, and the fact that
superblock is read-only shouldn't make a difference as to how
errors=panic is handled.

So I think the patch is correct, but I'll note that it also changes
this case:

1)  mount -o /dev/sda -o ro,errors=panic test
2)  echo test > /sys/fs/ext4/sda/trigger_fs_error

With this patch, this will also now panic, whereas before, an
ext4_error() would not trigger a panic.  I think that's better because
it makes things more consistent --- but it is a change in behavior
which could potentially surprise some people.  But since they can
easily get the previous behavior with an explicit "mount -o
ro,errors=continue", I think that's acceptable.

I'll apply the patch with a modified commit description to warn of
this particular change in behavior.

						- Ted
