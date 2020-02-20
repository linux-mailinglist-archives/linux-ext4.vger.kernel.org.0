Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780C7166165
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgBTPua (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 10:50:30 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45407 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728387AbgBTPua (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Feb 2020 10:50:30 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01KFoNHO009229
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 10:50:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C43FA4211EF; Thu, 20 Feb 2020 10:50:22 -0500 (EST)
Date:   Thu, 20 Feb 2020 10:50:22 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jean-Louis Dupond <jean-louis@dupond.be>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Filesystem corruption after unreachable storage
Message-ID: <20200220155022.GA532518@mit.edu>
References: <c829a701-3e22-8931-e5ca-2508f87f4d78@dupond.be>
 <20200124203725.GH147870@mit.edu>
 <3a7bc899-31d9-51f2-1ea9-b3bef2a98913@dupond.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a7bc899-31d9-51f2-1ea9-b3bef2a98913@dupond.be>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 20, 2020 at 10:08:44AM +0100, Jean-Louis Dupond wrote:
> dumpe2fs -> see attachment

Looking at the dumpe2fs output, it's interesting that it was "clean
with errors", without any error information being logged in the
superblock.  What version of the kernel are you using?  I'm guessing
it's a fairly old one?

> Fsck:
> # e2fsck -fy /dev/mapper/vg01-root
> e2fsck 1.44.5 (15-Dec-2018)

And that's a old version of e2fsck as well.  Is this some kind of
stable/enterprise linux distro?

> Pass 1: Checking inodes, blocks, and sizes
> Inodes that were part of a corrupted orphan linked list found.  Fix? yes
> 
> Inode 165708 was part of the orphaned inode list.  FIXED.

OK, this and the rest looks like it's relating to a file truncation or
deletion at the time of the disconnection.

 > > > On KVM for example there is a unlimited timeout (afaik) until the
> > > storage is
> > > back, and the VM just continues running after storage recovery.
> > Well, you can adjust the SCSI timeout, if you want to give that a try....
> It has some other disadvantages? Or is it quite safe to increment the SCSI
> timeout?

It should be pretty safe.

Can you reliably reproduce the problem by disconnecting the machine
from the SAN?

						- Ted
