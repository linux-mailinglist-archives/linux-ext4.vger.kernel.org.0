Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3744F9D1
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Nov 2021 18:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhKNRrL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 Nov 2021 12:47:11 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54767 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233755AbhKNRrI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 Nov 2021 12:47:08 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AEHi78V023133
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Nov 2021 12:44:07 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0E5D515C2F02; Sun, 14 Nov 2021 12:44:07 -0500 (EST)
Date:   Sun, 14 Nov 2021 12:44:07 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mark Hills <mark@xwax.org>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: Maildir quickly hitting max htree
Message-ID: <YZFK56zBKXpnIncI@mit.edu>
References: <2111121900560.16086@stax.localdomain>
 <36FABD31-B636-4D94-B14D-93F3D2B4C148@dilger.ca>
 <d1f5c468-4afa-accc-7843-83b484dc081@xwax.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f5c468-4afa-accc-7843-83b484dc081@xwax.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Nov 13, 2021 at 12:05:07PM +0000, Mark Hills wrote:
> 
> Interesting! The 1Kb block size was not explicitly chosen. There was no 
> plan other than using the defaults.
> 
> However I did forget that this is a VM installed from a base image. The 
> root cause is likely to be that the /home partition has been enlarged from 
> a small size to 32Gb.

How small was the base image?  As documented in the man page for
mke2fs.conf, for file systems that are smaller than 3mb, mke2fs use
the parameters in /etc/mke2fs.conf for type "floppy" (back when 3.5
inch floppies were either 1.44MB or 2.88MB).  So it must have been a
really tiny base image to begin with.

> These days I think VMs make it more common to enlarge a filesystem from a 
> small size. We could have picked this up earlier with a warning from 
> resize2fs; eg. if the block size will no longer match the one that would 
> be chosen by default. That would pick it up before anyone puts 1Kb block 
> size into production.

It's would be a bit tricky for resize2fs to do that, since it doesn't
know what might be in the mke2fs.conf file at the time when the file
system when the file system was creaeted.  Distributions or individual
system adminsitrators are free to modify that config file.

It is a good idea for resize2fs to give a warning, though.  What I'm
thinking that what might sense is if resize2fs is expanding the file
system by more than, say a factor of 10x (e.g., expanding a file
system from 10mb to 100mb, or 3mb to 20gb) to give a warning that
inflating file systems is an anti-pattern that will not necessarily
result in the best file system performance.  Even if the blocksize
isn't 1k, when a file system is shrunk to a very small size, and then
expanded to a very large size, the file system will not be optimal.

For example, the default size of the journal is based on the file
system size.  Like the block size, it can be overridden on the
command-line, but it's unlikely that most people preparing the file
image will remember to consider this.

More importantly, when a file system is shrunk, the data blocks are
moved without a whole lot of optimizations, and then when the file
system is expanded, files that are were pre-loaded to the image, and
were located in the parts of the file system that had to be evacuated
as part of the shrinking process remain in whatever fragmented form
that they were after the shrink operation.

The way things work for Amazon's and Google's cloud is that the image
is created with a size of 8GB and 10GB, and best practice would be
create a separate EBS volume for the data partition.  This would allow
the easy upgrade or replacement of the root file system, for example,
after you check in your project keys into a public repo (or you fail
to apply a security upgrade to an actively exploited zero-day), and
your system gets rooted to a fair-thee-well, it's much simpler to
completely throw away the root image, and reinstall it with a fresh
system image, without having to separate your data files from the
system image.

						- Ted
