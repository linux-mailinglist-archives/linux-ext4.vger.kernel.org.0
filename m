Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC30740704
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 02:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjF1ADh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jun 2023 20:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF1ADg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jun 2023 20:03:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF923DE
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jun 2023 17:03:34 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-246.bstnma.fios.verizon.net [173.48.119.246])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35S03RG5018436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 20:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687910609; bh=wF+G3Lq2kec3bJVqf0AVo/0AiRHcHBdxI9d53Vn2kgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EyJYB6+ckjup4Sx9ZwMj9U9Dw7rL09hJ6jn49QMBJOGIjFqZdzNm448og+1wIAT5v
         JDy5pk6Dclv8FxEwEHva5F8qQSSh7yQ0ZVGbkEoXKcH1Z7L9IoDaicF78pXB6yjbMB
         JBKVR2pASrbABV4F1T200HMdkqBLy+r0Q0aArrbEATHvSY6ZkxjrJ+jo6SmAI+oEGt
         tdqoSbThEj033uhbb8rgz2FTXPr9jqQaBh6G+PVx1yGerhXM0wCoT9brpOw6EHGpl6
         W7w/cyATooico6nxTXD3Ywn2Rbrz65Y49dC/he2F5kPPoWpFvJdK46Oa3UqEcsLqBM
         JD2C1q1bDRQMw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4030115C027E; Tue, 27 Jun 2023 20:03:27 -0400 (EDT)
Date:   Tue, 27 Jun 2023 20:03:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Roberto Ragusa <mail@robertoragusa.it>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: packed_meta_blocks=1 incompatible with resize2fs?
Message-ID: <20230628000327.GG8954@mit.edu>
References: <49752bf2-71ec-7fbf-dcdf-93940cfa92c9@robertoragusa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49752bf2-71ec-7fbf-dcdf-93940cfa92c9@robertoragusa.it>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 26, 2023 at 11:15:14AM +0200, Roberto Ragusa wrote:
> 
> mkfs.ext4 -E packed_meta_blocks=1
> 
> all the fs metadata is placed at the start of the disk.
> Unfortunately I have not found a way to enlarge the fs
> and maintain this property, new metadata is allocated from the
> added space.

Yeah, sorry, there isn't a way of doing this.  packed_meta_blocks=1 is
an mkfs.ext4 (aka mke2fs) option, and it influences where it choose to
allocate the metadata blocks when the file system is created.
Unfortunately, (a) there is no place where the fact that the file
system was created with this mkfs option is recorded in the
superblock, and (b) once the file system starts getting used, the
blocks where the metadata would need to be allocated at the start of
the disk will get used for directory and data blocks.

> Is there a way to have metadata at the beginning of the disk
> and be able to enlarge the fs later?
> Planning to do this on big filesystems, placing the initial part
> on SSD extents; reformat+copy is not an option.

OK, so I think what you're trying to do is to create a RAID0 device
where the first part of the md raid device is stored on SSD, and after
that there would be one or more HDD devices.  Is that right?

In theory, it would be possible to add a file system extension where
the first portion of the MD device is not allowed to be used for
normal block allocations, so that when you later grow the raid0
device, the SSD blocks are available for use for the extended
metadata.  This would require adding support for this in the
superblock format, which would have to be an RO_COMPAT feature (that
is, kernels that didn't understand the meaning of the feature bit
would be prohibited from mounting the file system read/write, and
older versions of fsck.ext4 would be prohibited from touching the file
system at all).  We would then have to add support for off-line and
on-line resizing for using the reserved SSD space for this use case.

The downside of this particular approach is that the SSD space would
be "wasted" until the file system is resized, and you have to know up
front how big you might want to grow the file system eventually.  I
could imagine another approach might be that when you grow the file
system, if you are using an LVM-type approach, you would append a
certain number of LVM stripes backed by SSD, and a certain number
backed by HDD's, and then give a hint to the resizing code where the
metadata blocks should be allocated, and you would need to know ahead
of time how many SSD-backed LV stripes to allocate to support the
additional number of HDD-backed LV stripes.

This would require a bunch of abstraction violations, and it's a
little bit gross.  More to the point, it would require a bunch of
development work, and I'm not sure there is interest in the ext4
development community, or the companies that back those developers,
for implementing such a feature.

Cheers,

						- Ted
