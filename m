Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C823F808
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Aug 2020 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHHPSX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 8 Aug 2020 11:18:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59997 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726233AbgHHPST (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 8 Aug 2020 11:18:19 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 078FI1iI007523
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 8 Aug 2020 11:18:02 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8BEB4420263; Sat,  8 Aug 2020 11:18:01 -0400 (EDT)
Date:   Sat, 8 Aug 2020 11:18:01 -0400
From:   tytso@mit.edu
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>,
        Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH v3 1/2] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize
 trim
Message-ID: <20200808151801.GA284779@mit.edu>
References: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
 <20200806044703.GC7657@mit.edu>
 <CAP9B-Qnv2LXva_szv+sDOiawQ6zRb9a8u-UAsbXqSqWiK+emiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP9B-Qnv2LXva_szv+sDOiawQ6zRb9a8u-UAsbXqSqWiK+emiQ@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Aug 08, 2020 at 09:29:50AM +0800, Wang Shilong wrote:
> > I suppose the question is whether the sysadmin really wants unused
> > blocks to be discarded, either to not leak blocks in some kind of
> > thin-provisioned storage device, or if the sysadmin is depending on
> > the discard for some kind of security/privacy application (because
> > they know that a particular storage device actually has reliable,
> > secure discards), and how does that get balanced with sysadmins think
> > performance of fstrim is more important, especially if the device is
> > really slow at doing discard.
> 
> Yup, that is good point, for our case, fstrim could take hours to complete
> as it needs extra IO for disk arrays, so we really want repeated fstrim.
> 
> So what do you think extra mount option or a feature bit in the superblock.
> In default, we still keep ext4 in previous behavior, but once turned
> on it, we have this optimized  "inaccurate" optimizations.

So what I was thinking was we could define a new flag which would be
set in es->s_flags in the on-disk superblock:

#define EXT2_FLAGS_PERSISTENT_TRIM_TRACKING 0x0008

If this flag is set, then the EXT4_BG_WAS_TRIMMED flags will be
honored; otherwise, they will be ignored when FITRIM is executed and
the block group will be unconditionally trimmed.

The advantage of doing this way is that we don't need to allocate a
new feature bit, and older versions of e2fsck won't have heartburn
over seeing a feature bit it doesn't understand.  I also suspect this
is something that the system administrator will either always want
enabled or disabled, so it's better to make it be a tunable to be set
via tune2fs.

The other thing we could do is to define a new variant of the FITRIM
ioctl which will also force the unconditional trimming of the block
groups, so that an administrator can force trim all of the block
groups without needing to mess with mounting and unmounting the
superblock.

What do you think?

						- Ted

