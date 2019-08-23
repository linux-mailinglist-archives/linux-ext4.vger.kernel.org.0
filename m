Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 884B89B1B8
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2019 16:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391696AbfHWOQy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Aug 2019 10:16:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40603 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388188AbfHWOQy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Aug 2019 10:16:54 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7NEGjPq023423
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 10:16:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0C42042049E; Fri, 23 Aug 2019 10:16:45 -0400 (EDT)
Date:   Fri, 23 Aug 2019 10:16:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ayush Ranjan <ayushr2@illinois.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Ext4 documentation fixes.
Message-ID: <20190823141644.GG8130@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ayush Ranjan <ayushr2@illinois.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+UE=SPyMXZUhHFm0KgvihPdaE=yH5ra6n1C4XhKgM6aGheo=A@mail.gmail.com>
 <20190823031801.GD8130@mit.edu>
 <71dfe444-3efb-5f1c-d8a1-bb0e98002fd1@mixmax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71dfe444-3efb-5f1c-d8a1-bb0e98002fd1@mixmax.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 23, 2019 at 04:56:42AM +0000, Ayush Ranjan wrote:
> Hey Ted!
> Thanks for reviewing! The comment in fs/ext4/ext4.h:ext4_group_desc:bg_checksum
> says that the crc16 checksum formula should be crc16(sb_uuid+group+desc). I
> think group over here denotes group number.
> 
> Briefly looking through fs/ext4/super.c:ext4_group_desc_csum() suggests that:
> - For the new metadata_csum algorithm, only the group number and the block
> descriptor are included in the checksum. So the formula should be
> crc32c(group+desc) & 0xFFF (this looks like a bug as this should also include sb
> UUID?)
> - For the old crc16 algorithm, the sb UUID, group number and the block
> descriptor are included in the checksum. So the formula should be
> crc16(sb\_uuid+group+desc). (should remain unchanged)

Thanks for the research and explanation.  I think I'm going to change
that to be:

crc{16,32c}(sb_uuid + group_num + bg_desc)

That should make it clearer what is meant.

     	    	    	    	 - Ted








> 
> Ayush Ranjan
> University of Illinois - Urbana Champaign | May 2020
> Bachelors of Science in Computer Science and Mathematics
> Business Minor | Gies College of Business
> 
> 
> On Fri, Aug 23, 2019 at 8:48 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Thu, Aug 15, 2019 at 09:11:51AM -0700, Ayush Ranjan wrote:
> > > This commit aims to fix the following issues in ext4 documentation:
> > > - Flexible block group docs said that the aim was to group block
> > >   metadata together instead of block group metadata.
> > > - The documentation consistly uses "location" instead of "block number".
> > >   It is easy to confuse location to be an absolute offset on disk. Added
> > >   a line to clarify all location values are in terms of block numbers.
> > > - Dirent2 docs said that the rec_len field is shortened instead of the
> > >   name_len field.
> > > - Typo in bg_checksum description.
> > > - Inode size is 160 bytes now, and hence i_extra_isize is now 32.
> > > - Cluster size formula was incorrect, it did not include the +10 to
> > >   s_log_cluster_size value.
> > > - Typo: there were two s_wtime_hi in the superblock struct.
> > > - Superblock struct was outdated, added the new fields which were part
> > >   of s_reserved earlier.
> > > - Multiple mount protection seems to be implemented in fs/ext4/mmp.c.
> > >
> > > Signed-off-by: Ayush Ranjan <ayushr2@illinois.edu>
> >
> > Fixed with one minor typo fix:
> >
> > > diff --git a/Documentation/filesystems/ext4/group_descr.rst
> > > b/Documentation/filesystems/ext4/group_descr.rst
> > > index 0f783ed88..feb5c613d 100644
> > > --- a/Documentation/filesystems/ext4/group_descr.rst
> > > +++ b/Documentation/filesystems/ext4/group_descr.rst
> > > @@ -100,7 +100,7 @@ The block group descriptor is laid out in ``struct
> > > ext4_group_desc``.
> > >       - \_\_le16
> > >       - bg\_checksum
> > >       - Group descriptor checksum; crc16(sb\_uuid+group+desc) if the
> > > -       RO\_COMPAT\_GDT\_CSUM feature is set, or
> crc32c(sb\_uuid+group\_desc) &
> > > +       RO\_COMPAT\_GDT\_CSUM feature is set, or crc32c(sb\_uuid+group+desc)
> &
> > >         0xFFFF if the RO\_COMPAT\_METADATA\_CSUM feature is set.
> >
> > The correct checksum should be "crc16(sb\_uuid+group\_desc)" or
> > "crc32c(sb\_uuid+group\_desc)".  That is, it's previous line which
> > needed modification.
> >
> >                                         - Ted
