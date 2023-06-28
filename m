Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FF6741585
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjF1PpA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 11:45:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56873 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231890AbjF1Por (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 11:44:47 -0400
Received: from cwcc.thunk.org (pool-173-48-117-150.bstnma.fios.verizon.net [173.48.117.150])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35SFifHJ003118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 11:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687967082; bh=Wg8OOOcDkhMjjfEJxhQSQX+UxB2Da3wt7DFRGX6V3ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SF9+BXRcv2UPlzrATkLT2rkTXrH0DbRlkADiYpEVabSsakxaSQLRlWTUlhYJwwQoM
         Nlg1KX4NQxRWEgMKWrupNr8ZXj+qYwn2SCnibd1hBbd8rRfIFJ/ObncIDCozDpc0TQ
         R0l5cxhlT25PP853G7tYTU3+NPk6WZtaig0kRFVuJ4OWZmwMZmItbymbxi0fUAcmfj
         d6Qe9mzM6pFgIpFXlvIlSY51FlKHZEIlunxEizWmnQxK7T4BHPcdfdK4EJXuJak6vp
         CbPgYu08ONgptlZbX3eGCm4Wy1oSTkCVkIrdP/ur7k+TemV6uSrRXF71afLTpWSyiP
         qj+IzmB6wWXUw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6200815C027E; Wed, 28 Jun 2023 11:44:41 -0400 (EDT)
Date:   Wed, 28 Jun 2023 11:44:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Roberto Ragusa <mail@robertoragusa.it>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: packed_meta_blocks=1 incompatible with resize2fs?
Message-ID: <20230628154441.GA383202@mit.edu>
References: <49752bf2-71ec-7fbf-dcdf-93940cfa92c9@robertoragusa.it>
 <20230628000327.GG8954@mit.edu>
 <8b1464cf-833d-de2b-9c71-7732d65fc23f@robertoragusa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b1464cf-833d-de2b-9c71-7732d65fc23f@robertoragusa.it>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 28, 2023 at 04:35:50PM +0200, Roberto Ragusa wrote:
> On 6/28/23 02:03, Theodore Ts'o wrote:
> 
> > Unfortunately, (a) there is no place where the fact that the file
> > system was created with this mkfs option is recorded in the
> > superblock, and (b) once the file system starts getting used, the
> > blocks where the metadata would need to be allocated at the start of
> > the disk will get used for directory and data blocks.
> 
> Isn't resize2fs already capable of migrating directory and data blocks
> away? According to the comments at the beginning of resize2fs.c, I mean.

Yes, but (a) that can only be done off-line (while the file system is
unmounted), and (b) migrating directory and data blocks is quite slow
and inefficient, and it doesn't necessarily leave the data file in the
most optimal way (it didn't do as much as it could to minimize file
fragmentation during the mirgation process).  It was intended for
moving a very small number of blocks, and while it could be improved,
that would be additional software engineering investment.

> 1. reserve the bitmaps and inode table space since the beginning (with mke2fs
> option resize, for example)
> 3. do not add new inodes when expanding (impossible by design, right?)

This would require file system format changes in the kernel, the
kernel on-line resizing code, e2fsck, and the resized2fs for off-line
resizing.  And while we've considered doing (3) for other reasons,
that's not sufficient for this use case, because when we add new block
groups, we have to add block and inode allocation bitmaps, the inode
table, and the block group descriptor blocks.  It's not just the inode
table.

> 2. push things out of the way when the expansion is done
> 
> I could attempt to code something to do 2., but I would either have to
> study resize2fs code, which is not trivial, or write something from scratch,
> based only on the layout docs, which would be also complex and not easily
> mergeable in resize2fs.
> 
> 4. have an offline way (custom tool, or detecting conflicting files and
> temporarily removing them, ...) to free the needed blocks
> 
> At the moment the best option I have is to continue doing what I've been
> doing for years already: use dumpe2fs and debugfs to discover which bg
> contain metadata+journal and selectively use "pvmove" to migrate
> those extents (PE) to the fast PV. Automatable, but still messy.
> Discovering "packed_meta_blocks" turned out not a so great finding as I was
> hoping, if then you can't resize.

Honestly, suspect automating the code to determine which are the block
group descriptors, inode table blocks, and allocation bitmap blocks
represent the PE's that should be migrated to the fast PV is probably
the simplest thing to do.  You should be able to do this using just
dumpe2fs; the journal is generally not going to move while during a
migration.

						- Ted
