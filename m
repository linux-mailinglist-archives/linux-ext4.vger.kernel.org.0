Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 791C412AC55
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 14:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfLZNJk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 08:09:40 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59229 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726236AbfLZNJk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 08:09:40 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBQD9akm023002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Dec 2019 08:09:37 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D25AB420485; Thu, 26 Dec 2019 08:09:35 -0500 (EST)
Date:   Thu, 26 Dec 2019 08:09:35 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: the side effect of enlarger max mount count in ext4 superblock
Message-ID: <20191226130935.GA3158@mit.edu>
References: <CAAJeciUWm9W-AyFwJdUqC3W6n4bBDHMrzBF=V2d_iMywDW2+uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAJeciUWm9W-AyFwJdUqC3W6n4bBDHMrzBF=V2d_iMywDW2+uQ@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 26, 2019 at 06:25:01PM +0800, xiaohui li wrote:
> so i wonder the reason why set EXT4_DFL_MAX_MNT_COUNT value to 20 in
> fs/ext4/ext4.h and not set a large value to it ?

It sounds like you're still using the old make_ext4fs program that is
in the older versions of AOSP?  More recently, AOSP uses mke2fs to
create the file system, in combination with e2fsdroid.  And newer
versions mke2fs sets the max count value to 0, which means it doesn't
automatically check the file system after 20 reboots.  This is for the
reason that you stated; for larger storage devices, a forced e2fsck
run can take a long time, and if it's not necessary we can skip it.

> is there any reason or any condition when file system data error or
> stability problems happens and ext4 can't get this information, can't
> set the error flag in superblock, and so will not call the e2fsck full
> check during next e2fsck check？
> and because of this reason or condition, it will have to do periodic
> e2fsck full check.

The reason why we used to set max mount count to 20 is because there
are indeed many kinds of file system inconsistencies which the kernel
can not detect at runtime or when it tries to mount the file system,
and that can lead to data loss or corruption.  So setting a max mount
count of 20 was way of trying to catch that early, hopefully before
*too* much data was lost.

Metadata inconsistencies should *not* be happening normally.  Typical
causes of inconsistencies are kernel bugs or media problems (e.g.,
eMMC, HDD, SSD failures of some sort; sometimes because they don't do
the right thing on power drops).

Unfortunately, many Android devices, especially the cheaper priced
versions, are using older SOC's, with older kernels, which are missing
a lot of bug fixes.  Even if they have been fixed upstream, kernel
coming from an old Board Support Package may not have those bug fixes.
This is one of the reasons my personal advice to friends is get higher
end Pixels and not some of the cheaper, low-quality Android devices
coming out of Asia.  (Sorry.)

If you're using one of those older, crappier BSP kernels, one of the
ways you can find out how horrible it is to see how many tests fail if
you use something like android-xfstests[1].  In some cases, especially
with an older kernel (for example, a 3.10 or 3.18 kernel), running
file system stress tests can cause the kernel to crash.

[1] https://thunk.org/android-xfstests

If you are using high quality eMMC flash (as opposed to the cheapest
possible grade flash to maximize profits), and you have tested your
flash to make sure they handle power drops correctly (e.g., that the
FTL metadata never gets corrupted on a power drop, and all data
written after a FLUSH CACHE command is retained after a power drop),
and you are using a kernel which is regularly getting updated to get
the latest security and bug fixes, then there is no need to set max
mount count to a non-zero value.

If you are not in that ideal state, then question really boils down to
"do you feel lucky?".  Although that's probably true with or without
max mount count set to 20.   :-)

Cheers,

					- Ted
