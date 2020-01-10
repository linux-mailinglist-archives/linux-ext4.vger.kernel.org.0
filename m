Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CCE1374E1
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2020 18:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgAJReh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Jan 2020 12:34:37 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33268 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726700AbgAJReg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Jan 2020 12:34:36 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00AHYW3U009159
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 12:34:33 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BF7F14207DF; Fri, 10 Jan 2020 12:34:32 -0500 (EST)
Date:   Fri, 10 Jan 2020 12:34:32 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] libext2fs: Extends commit c9a8c53b, with the same fix
 for ext2fs_flush2() and ext2fs_image_super_write() on a Big Endian systems.
Message-ID: <20200110173432.GB304349@mit.edu>
References: <20200110085217.GA7307@yogzotot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110085217.GA7307@yogzotot>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 10, 2020 at 11:52:17AM +0300, Anatoly Pugachev wrote:
> 
> libext2fs: extends commit c9a8c53b, with the same fix for ext2fs_flush2() and
> ext2fs_image_super_write() on a Big Endian systems.
> 
> As follow-up to previous discussion 'dumpe2fs / mke2fs sigserv on sparc64'
> 
> Used find for files which refer to:
> 
> e2fsprogs.git$ find . -name \*.c | xargs grep -cl 'gdp = ext2fs_group_desc'
> ./lib/ext2fs/closefs.c
> ./lib/ext2fs/openfs.c
> ./lib/ext2fs/imager.c
> 
> And applied the same check for a null pointer.
> 
> Tested on a debian linux with sparc64 LDOM and ppc64 LPAR.
> 
> Fixes sigserv with test suite in "i_bitmaps" test.

As far as I know, the i_bitmaps test is passing on on sparc64 and
ppc64.  Search for i_bitmaps in:

https://buildd.debian.org/status/fetch.php?pkg=e2fsprogs&arch=sparc64&ver=1.45.5-2&stamp=1578527938&raw=0
   and
https://buildd.debian.org/status/fetch.php?pkg=e2fsprogs&arch=ppc64&ver=1.45.5-2&stamp=1578526270&raw=0

The bug in c9a8c53b was caused by SPARSE_SUPER being passed to
ext2fs_open().  But that doesn't happen in misc/e2image.

I can see optimizing ext2fs_flush() to skip byte-swapping the group
descriptors if the SUPER_ONLY flag is enabled.  And I can see
ext2fs_image_super_write() checking to see if the SUPER_ONLY flag is
set, and returning an error in that case.

But I don't think any of the current e2fsprogs are crashing at the
moment.  Am I missing something?

Regards,

					- Ted
