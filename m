Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5762D1FD9
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Dec 2020 02:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgLHBR7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Dec 2020 20:17:59 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58924 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726250AbgLHBR6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Dec 2020 20:17:58 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B81H5RR032732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Dec 2020 20:17:06 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A497D420136; Mon,  7 Dec 2020 20:17:05 -0500 (EST)
Date:   Mon, 7 Dec 2020 20:17:05 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>
Subject: Re: [PATCH RFC 2/5] libext2fs: add threading support to the I/O
 manager abstraction
Message-ID: <20201208011705.GB52960@mit.edu>
References: <20201205045856.895342-1-tytso@mit.edu>
 <20201205045856.895342-3-tytso@mit.edu>
 <2EFCA6FE-60CC-47BA-A403-592122D5FBCB@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2EFCA6FE-60CC-47BA-A403-592122D5FBCB@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 07, 2020 at 11:15:30AM -0700, Andreas Dilger wrote:
> 
> Do you know how often we get into the "bounce_read" IO path?  It seems like
> locking around the read would kill parallelism, but this code path also
> looks like a fallback, but maybe 100% used for blocksize != PAGE_SIZE?

It should be extremely rare.  It only happens when Direct I/O is
requested (which is rare to begin with, although it looks like there
are people who are playing with some out of tree patchets to force
e2image to use Direct I/O?), and the offset or the size of I/O isn't
aligned with the system's direct I/O alignment requirements.  (See
ext2fs_get_dio_alignment() in lib/ext2fs/getsectsize.c)

> At one point you talked about using dlopen() or similar to link in the
> pthread library only if it is actually needed?  Or is the linkage of
> the pthread library avoided by these functions not being called unless
> IO_FLAG_THREADS is set? 

So what I'm doing is just not trying to call those functions unless
threading is required (e.g., IO_FLAG_THREADS is set, which would imply
that EXT2_FLAG_THREADS was passed to ext2fs_open()).  This won't help
if the application is using static linking, but if the application is
compiled statically, dlopen(3) is not guaranteed to work in any case.

So it's not perfect, and there may be some ancient AIX machine for
which this might be problematic.  But for all modern OS's that are
linking to want to compile e2fsprogs, it should work.  And I don't
have access to an AIX machine these days, and I don't work for IBM
anymore, so....  ¯\_(ツ)_/¯

:-)

					- Ted
