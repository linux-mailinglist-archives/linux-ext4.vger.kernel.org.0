Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7442065E3D
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2019 19:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfGKRLJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jul 2019 13:11:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34377 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728639AbfGKRLJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Jul 2019 13:11:09 -0400
Received: from callcc.thunk.org (guestnat-104-133-8-97.corp.google.com [104.133.8.97] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6BHAlKL001626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jul 2019 13:10:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 75987420036; Thu, 11 Jul 2019 13:10:46 -0400 (EDT)
Date:   Thu, 11 Jul 2019 13:10:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Geoffrey Thomas <Geoffrey.Thomas@twosigma.com>
Cc:     "'Jan Kara'" <jack@suse.cz>,
        Thomas Walker <Thomas.Walker@twosigma.com>,
        "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Message-ID: <20190711171046.GA13966@mit.edu>
References: <9abbdde6145a4887a8d32c65974f7832@exmbdft5.ad.twosigma.com>
 <20181108184722.GB27852@magnolia>
 <c7cfeaf451d7438781da95b01f21116e@exmbdft5.ad.twosigma.com>
 <20190123195922.GA16927@twosigma.com>
 <20190626151754.GA2789@twosigma.com>
 <20190711092315.GA10473@quack2.suse.cz>
 <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Can you try using "df -i" when the file system looks full, and then
reboot, and look at the results of "df -i" afterwards?

Also interesting would be to grab a metadata-only snapshot of the file
system when it is in its mysteriously full state, writing that
snapshot on some other file system *other* than on /dev/sda3:

     e2image -r /dev/sda3 /mnt/sda3.e2i

Then run e2fsck on it:

e2fsck -fy /mnt/sda3.e2i

What I'm curious about is how many "orphaned inodes" are reported, and
how much space they are taking up.  That will look like this:

% gunzip < /usr/src/e2fsprogs/tests/f_orphan/image.gz  > /tmp/foo.img
% e2fsck -fy /tmp/foo.img
e2fsck 1.45.2 (27-May-2019)
Clearing orphaned inode 15 (uid=0, gid=0, mode=040755, size=1024)
Clearing orphaned inode 17 (uid=0, gid=0, mode=0100644, size=0)
Clearing orphaned inode 16 (uid=0, gid=0, mode=040755, size=1024)
Clearing orphaned inode 14 (uid=0, gid=0, mode=0100644, size=69)
Clearing orphaned inode 13 (uid=0, gid=0, mode=040755, size=1024)
...

It's been theorized the bug is in overlayfs, where it's holding inodes
open so the space isn't released.  IIRC somewhat had reported a
similar problem with overlayfs on top of xfs.  (BTW, are you using
overlayfs or aufs with your Docker setup?)

		     	       	      - Ted
