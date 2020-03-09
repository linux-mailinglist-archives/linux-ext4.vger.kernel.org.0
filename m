Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8416617EC1B
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 23:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCIWcq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 18:32:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56607 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726536AbgCIWcq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 18:32:46 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 029MWctU010734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Mar 2020 18:32:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AB97542045B; Mon,  9 Mar 2020 18:32:38 -0400 (EDT)
Date:   Mon, 9 Mar 2020 18:32:38 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jean-Louis Dupond <jean-louis@dupond.be>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Filesystem corruption after unreachable storage
Message-ID: <20200309223238.GC4852@mit.edu>
References: <20200124203725.GH147870@mit.edu>
 <3a7bc899-31d9-51f2-1ea9-b3bef2a98913@dupond.be>
 <20200220155022.GA532518@mit.edu>
 <7376c09c-63e3-488f-fcf8-89c81832ef2d@dupond.be>
 <adc0517d-b46e-2879-f06c-34c3d7b7c5f6@dupond.be>
 <20200225172355.GA14617@mit.edu>
 <d19e44af-585f-e4a2-5546-7a3345a0ee66@dupond.be>
 <50f93ccb-2b2c-15c5-8b08-facc3a25068a@dupond.be>
 <20200309151838.GA4852@mit.edu>
 <93e74f9f-6694-a3e9-4fac-981389522d25@dupond.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93e74f9f-6694-a3e9-4fac-981389522d25@dupond.be>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 09, 2020 at 04:33:52PM +0100, Jean-Louis Dupond wrote:
> On 9/03/2020 16:18, Theodore Y. Ts'o wrote:
> > Did the panic happen immediately, or did things hang until the storage
> > recovered, and*then*  it rebooted.  Or did the hard reset and reboot
> > happened before the storage network connection was restored?
> 
> The panic (well it was just frozen, no stacktrace or automatic reboot) did
> happen *after* storage came back online.
> So nothing happens while the storage is offline, even if we wait until the
> scsi timeout is exceeded (180s * 6).
> It's only when the storage returns that the filesystem goes read-only /
> panic (depending on the error setting).

So I under why the scsi timeout isn't sufficient to keep the panic
from hanging.

> If we do reset the VM before storage is back, the filesystem check just goes
> fine in automatic mode.
> So I think we should (in some cases) not try to update the superblock
> anymore on I/O errors, but just go read-only/panic.
> Cause it seems like updating the superblock makes things worse.

The problem is that from the file system's perspective, we don't know
why the I/O error has happened.  Is it because of timeout, or is it
because of a media error?

In the case where an SSD really was unable to write to a metadata
block, we *do* want to update the superblock.

There is a return status that the block device could send back,
BLK_STS_TIMEOUT, but it's not set by the SCSI layer.  It is by the
network block device (nbd), but it looks like the SCSI layer just
returns BLK_STS_IOERR if I'm reading the code correctly.

> Or changes could be made to e2fsck to allow automatic repair of this kind of
> error for example?

The fundamental problem is we don't know what "kind of error" has
taken place.  If we did, we could theoretically have some kind of
mount option which means "in case of timeout, reboot the system
without setting some kind of file system error".  But we need to know
that the I/O error was caused by a timeout first.

     	     	       	      	 - Ted
