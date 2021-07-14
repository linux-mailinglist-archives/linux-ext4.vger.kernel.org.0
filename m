Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB583C8A43
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jul 2021 19:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhGNR7F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jul 2021 13:59:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37695 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229701AbhGNR7B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jul 2021 13:59:01 -0400
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net [96.65.121.81])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16EHu2bs002918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 13:56:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2D3B44202F5; Wed, 14 Jul 2021 13:56:02 -0400 (EDT)
Date:   Wed, 14 Jul 2021 13:56:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext4_xattr_ibody_find:2180: inode #2669312: comm
 systemd-journal: corrupted in-inode xattr
Message-ID: <YO8lMpNOUsLjBqIG@mit.edu>
References: <CAMdYzYqvT+X9C_YZ+DtspgHLSeb=RVHLeS2-0pEHeotyvb+iXQ@mail.gmail.com>
 <20210713154310.GE24271@quack2.suse.cz>
 <CAMdYzYroicgDkWuiQ7Xaw_5aYD9mLkrz8qvE9WwS6mPw9uWe8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYroicgDkWuiQ7Xaw_5aYD9mLkrz8qvE9WwS6mPw9uWe8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 13, 2021 at 04:52:11PM -0400, Peter Geis wrote:
> > This seems to have fallen through the cracks. Have you managed to fix your
> > filesystem? If not, please obtain filesystem image using e2image (it will
> > contain only fs metadata, not any data), compress it and put it somewhere for
> > download so that we can better diagnose the issue. Thanks!
> 
> Unfortunately no I don't have the file system anymore.
> I put about two weeks into trying to fix it, but in the end I had to
> nuke it from orbit.

Sorry we didn't get back to you right away.  As Jan said, if this
happens again, it would be really helpful to use e2image.  There is a
discussion about this in the e2fsck man page, in the "REPORTING BUGS"
section.

In this specific case where there was an inode with a corrupted
extended attribute stored in the inode, you can use debugfs to print
out the inode data structure:

debugfs:  inode_dump testfile
0000  a481 0000 0000 0000 cf23 ef60 d523 ef60  .........#.`.#.`
0020  cf23 ef60 0000 0000 0000 0100 0000 0000  .#.`............
0040  0000 0800 0100 0000 0af3 0000 0400 0000  ................
0060  0000 0000 0000 0000 0000 0000 0000 0000  ................
*
0140  0000 0000 6867 c27f 0000 0000 0000 0000  ....hg..........
0160  0000 0000 0000 0000 0000 0000 9fbc 0000  ................
0200  2000 e8f9 34cc 39ec fcaf ee61 fcaf ee61   ...4.9....a...a
0220  cf23 ef60 fcaf ee61 0000 0000 0000 0000  .#.`...a........
0240  0000 02ea 0401 5400 0000 0000 0600 0000  ......T.........
0260  0000 0000 7465 7374 0000 0000 0000 0000  ....test........
0300  0000 0000 0000 0000 0000 0000 0000 0000  ................
*
0360  0000 0000 0000 0000 7473 7476 616c 0000  ........tstval..

debugfs:  inode_dump -x testfile
magic = ea020000, length = 96, value_start =4 

offset = 4 (0004), name_len = 4, name_index = 1
value_offset = 84 (0130), value_inum = 0, value_size = 6
name = test
value = tstval

last entry found at offset 24 (0030)

(And if you don't have the pathname to the file, you can also specify
the inode using the inode number in angle brackers, e.g., "inode_dump <12>")

Hopefully this won't happen to you again, but if it does, please do
let us know.

Cheers,

						- Ted
