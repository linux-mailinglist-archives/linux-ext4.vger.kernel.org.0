Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE195451B4E
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Nov 2021 00:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351295AbhKOX7l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Nov 2021 18:59:41 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:55083 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356851AbhKOX6T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Nov 2021 18:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1637020524; x=1668556524;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=Ps3MXWaiPS8rZKL+19qnLNuFdf8RVQAY82PrrkVN2LI=;
  b=UxzOeM2c4WdqiB4iPChNH9NVZ3UTrhiz3Iha3oQbSk0vC5W/GTu/jti3
   yVZNODuNf0d3qG5LluhFvjKNYkMhLSCbtNj+dSeOdn1fu0G0PMkYKj8EO
   ytlN4Zcu0GXnpFx8Hh+cswLJU5UN6lEMNNKGcifrwTO4+IPjBJ4hIQJ+h
   U=;
X-IronPort-AV: E=Sophos;i="5.87,237,1631577600"; 
   d="scan'208";a="159312216"
Subject: Re: Debugging ext4 corruption with nojournal & extents
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-204be258.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 15 Nov 2021 23:55:23 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-204be258.us-east-1.amazon.com (Postfix) with ESMTPS id 74FB6415B8;
        Mon, 15 Nov 2021 23:55:22 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Mon, 15 Nov 2021 23:55:22 +0000
Received: from localhost (10.43.160.106) by EX13d01UWA002.ant.amazon.com
 (10.43.160.74) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 15 Nov
 2021 23:55:21 +0000
Date:   Mon, 15 Nov 2021 15:55:21 -0800
From:   Samuel Mendoza-Jonas <samjonas@amazon.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <benh@amazon.com>
Message-ID: <20211115235521.hkxhil3xnvteki7m@u87e72aa3c6c25c.ant.amazon.com>
References: <20211108173520.xp6xphodfhcen2sy@u87e72aa3c6c25c.ant.amazon.com>
 <YYnnmQjrYii0dOYH@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YYnnmQjrYii0dOYH@mit.edu>
User-Agent: NeoMutt/20171215
X-Originating-IP: [10.43.160.106]
X-ClientProxiedBy: EX13D28UWB004.ant.amazon.com (10.43.161.56) To
 EX13d01UWA002.ant.amazon.com (10.43.160.74)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 08, 2021 at 10:14:33PM -0500, Theodore Ts'o wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Mon, Nov 08, 2021 at 09:35:20AM -0800, Samuel Mendoza-Jonas wrote:
> > Based on that what I think is happening is
> > - A file with separate (i.e. non-inline) extents is synced / written to disk
> >   (in this case, one of the large "compound" files)
> > - ext4_end_io_end() kicks off writeback of extent metadata
> >   - AIUI this marks the related buffers dirty but does not wait on them in the
> >     no-journal case
> > - The file is deleted, causing the extents to be "removed" and the blocks where
> >   they were stored are marked unused
> > - A new file is created (any file, separate extents not required)
> > - The new file is allocated the block that was just freed (the physical block
> >   where the old extents were located)
> >
> > Some time between this point and when the file is next read, the dirty extent
> > buffer hits the disk instead of the intended data for the new file.
> > A big-hammer hack in __ext4_handle_dirty_metadata() to always sync metadata
> > blocks appears to avoid the issue but isn't ideal - most likely a better
> > solution would be to ensure any dirty metadata buffers are synced before the
> > inode is dropped.
> >
> > Overall does this summary sound valid, or have I wandered into the
> > weeds somewhere?
> 
> Hmm... well, I can tell you what's *supposed* to happen.  When the
> extent block is freed, ext4_free_blocks() gets called with the
> EXT4_FREE_BLOCKS_FORGET flag set.  ext4_free_blocks() calls
> ext4_forget() in two places; one when bh passed to ext4_free_blocks()
> is NULL, and one where it is non-NULL.  And then ext4_free_blocks()
> calls bforget(), which should cause the dirty extent block to get
> thrown away.
> 
> This *should* have prevented your failure scenario from taking place,
> since after the call to bforget() the dirty extent buffer *shouldn't*
> have hit the disk.  If your theory is correct, the somehow either (a)
> the bforget() wasn't called, or (b) the bforget() didn't work, and
> then the page writeback for the new page happened first, and then
> buffer cache writeback happened second, overwriting the intended data
> for the new file.
> 
> Have you tried enabling the blktrace tracer in combination with some
> of the ext4 tracepoints, to see if you can catch the double write
> happening?  Another thing to try would be enabling some tracepoints,
> such as ext4_forget and ext4_free_blocks.  Unfortunately we don't have
> any tracepoints in fs/ext4/page-io.c to get a tracepoint which
> includes the physical block ranges coming from the writeback path.
> And the tracepoints in fs/fs-writeback.c won't have the physical block
> number (just the inode and logical block numbers).
> 
>                                          - Ted

I got unlucky and my test took about a week to hit the issue - in any
case, I did manage to pull out some blktrace info. Pulling out some
interesting bits it looks like there's a point where some amount of
actual data is being written to that block:

253,0    0 35872893 186704.840109354 15324  Q   W 746864240 + 912 [mandb]
253,0    0 35872934 186704.861662488 15324  C   W 746864240 + 912 [0]
253,0    1 35959519 187579.674191021 16452  Q  RA 746864240 + 256 [elasticsearch[i]
253,0    1 35959520 187579.675556807 12335  C  RA 746864240 + 256 [0]
253,0    3 10900958 188058.929475561 15532  Q   W 746864240 + 784 [kworker/u8:5]
253,0    1 36047096 188059.058090710  4331  C   W 746864240 + 784 [0]
253,0    1 36062826 188207.602295365 15865  Q   W 746864240 + 960 [kworker/u8:6]
253,0    1 36062874 188207.657179910 16261  C   W 746864240 + 960 [0]
253,0    0 38087456 198349.655260245  4346  Q  WS 746864240 + 8 [elasticsearch[i]
253,0    0 38087457 198349.655735664  4331  C  WS 746864240 + 8 [0]
253,0    0 38847537 202142.902362813 22525  Q  RA 746864240 + 88 [elasticsearch[i]
253,0    0 38847538 202142.902870365 21686  C  RA 746864240 + 88 [0]
253,0    1 38837970 202413.537374242 21099  Q   W 746864240 + 8 [kworker/u8:6]
253,0    0 38917625 202413.560449306 21686  C   W 746864240 + 8 [0]
253,0    3 11752576 202500.553085492 21858  Q   W 746864240 + 8 [esrally]
253,0    0 38926880 202500.579232976 20195  C   W 746864240 + 8 [0]
253,0    0 40475924 210529.224170625 19908  Q   W 746864240 + 8 [kworker/u8:2]
253,0    1 40376745 210529.261411675  4329  C   W 746864240 + 8 [0]
253,0    1 40410932 210831.620562489 26075  Q   W 746864240 + 8 [elasticsearch[i]
253,0    0 40507813 210831.652311756 26102  C   W 746864240 + 8 [0]
253,0    0 40517885 210930.628927045 23308  Q   W 746864240 + 8 [elasticsearch[i]
253,0    1 40422327 210930.649373285 26075  C   W 746864240 + 8 [0]
253,0    0 40549442 211195.656050786 26075  Q   W 746864240 + 8 [elasticsearch[i]
253,0    1 40452319 211195.694039437  4330  C   W 746864240 + 8 [0]
253,0    2 12367808 211371.325361922  4331  Q WSM 746864240 + 8 [elasticsearch[i]
253,0    0 40573575 211371.325815019 23887  C WSM 746864240 + 8 [0]
253,0    0 40573606 211371.595792860  4329  Q WSM 746864240 + 8 [elasticsearch[i]
253,0    0 40573607 211371.596251886 23887  C WSM 746864240 + 8 [0]

Those sync operations are repeated quite a bit which would seem to line
up with the fsync+check that elasticsearch does, and then some of the
last operations before detecting the issue are:

253,0    0 40575124 211388.516004566  4330  Q WSM 746864240 + 8 [elasticsearch[i]
253,0    1 40477703 211388.516615080 25975  C WSM 746864240 + 8 [0]
253,0    3 12268358 211388.842309745  4329  Q WSM 746864240 + 8 [elasticsearch[i]
253,0    1 40478089 211388.842725344  4319  C WSM 746864240 + 8 [0]
253,0    0 40601789 211508.676476007 19908  Q  WM 746864240 + 8 [kworker/u8:2]
253,0    0 40601985 211508.763710372 19908  Q   W 746864240 + 8 [kworker/u8:2]
253,0    1 40508182 211508.945657647 25975  C   W 746864240 + 8 [0]
253,0    1 40508191 211508.946310947   574  C  WM 746864240 + 8 [0]
253,0    1 40557027 211648.172734351  4345  Q  RA 746864240 + 8 [elasticsearch[i]
253,0    1 40557028 211648.173102632 26203  C  RA 746864240 + 8 [0]

Which could be a case of the "extent" being written, and then being read
by the checking program.

My script that was watching the tracepoints failed somewhere along the
way unfortunately, I'll set up the repro again and see if I can line
them up with the operations seen in the trace.

Cheers,
Sam
