Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C26DE7C5
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 11:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfJUJR0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 05:17:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37956 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJUJR0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 05:17:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so8028349pfe.5
        for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2019 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qISfTpqtP680Y0LloQsjV/f6rhEUWSVksU9JQACJTk8=;
        b=hN8UFHRsdjZTaq//B3qi3Y+IIzpJ0okL905WkKYRNT43m7dgE772o9/0oz5W5zg1Cy
         hRWMabZZZGhFqFnRyXgd7FCu8qpncy22LInA3V+WNm/OY1ZTdGdSh9NZSePnTyZOTQ6w
         SHTeQZlkZv8FxV6pJ+oNQyom32rZDfxwY0FukaUCipS4YTTHoeIIpv48/hkIglS3NFTc
         Z2kMzEAp/o17nCSg2LTe3BOoSj3aAzLqi7PaAZchYvCZoUH+WvA0dCUwMEKlKbnwgCoy
         /23JC/pW+nIelObriEDTLYE8IG5khpEKIboHqj8wOpoGTxDRVtaQ/2b42ipj+U4IFoQ+
         sC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qISfTpqtP680Y0LloQsjV/f6rhEUWSVksU9JQACJTk8=;
        b=LnKA3iDAjGAuwm2fX+dj/fua2DnanqjZKmnZ4VJgRBB++t67N0U2j/3duc7Va0qYdn
         O+WKde3SDPe5hPhZMc0sUbMhkkpcXCIh4ZQTh4hX2cz9xd7p/po4jinW3HqKxSX3ciHR
         VdWt01Mdzv9wdh1gPBF4qaCIaKY02m2cKW46Z7YWW3W6k5yzUbpL4dvrhuGxm2VURven
         RdVJPd5MIStuBqhKrSowDfrZP8UuyTPDuXUjF2ks43Yvv3/rKq05/AGRtSGm5pkfuvx6
         48obr9HUOsK+RsZNSa9FvgL7ZTJw3dTvYtI3Wb/kK9XM7OdnrAfDCKThHJaDulXhTABf
         1r/A==
X-Gm-Message-State: APjAAAU5fTvepdoJNoojODXa7NF05kFFpDa/0M50QcuH9cUQtu0/GqjK
        wdWsFpsbGkjSPxvKFBzdwLa5
X-Google-Smtp-Source: APXvYqx+1Ya+y/3UeuMXv7ALXT+ufyzG2yQEHKugD/4N7sD55QLbVP6M7XG63EhmcaGkO+osEX4dPg==
X-Received: by 2002:a63:ba57:: with SMTP id l23mr6922996pgu.208.1571649445309;
        Mon, 21 Oct 2019 02:17:25 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id h186sm17720849pfb.63.2019.10.21.02.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:17:24 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:17:18 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 00/12] ext4: port direct I/O to iomap infrastructure
Message-ID: <cover.1571647178.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

I managed to get some time over the weekend to fix up the stuff that
came out from the last review. Please feel free to review and provide
any necessary constructive criticism.

This patch series ports the ext4 direct I/O paths over to the iomap
infrastructure. The legacy buffer_head based direct I/O implementation
has subsequently been removed as it's no longer in use. The result of
this change is that ext4 now uses the newer iomap framework for direct
I/O read/write operations. Overall, this results in a much cleaner
direct I/O implementation and keeps this code isolated from the
buffer_head internals. In addition to this, a slight performance boost
may be expected while using O_SYNC | O_DIRECT.

The changes within this patch series have been tested via xfstests in
both DAX and non-DAX modes using the various filesystem configuration
options i.e. 4k, dioread_nolock, etc.

Changes since v4:

- Removed the ext4_handle_inode_extension() function out from the
  ->end_io() callback so that we can realiably truncate any allocated
  blocks as we have all the information we need in
  ext4_dio_write_iter().

- Fixed a couple comment formatting issues in addition to spelling
  mistakes here and there.

- Incorporated the fix for the issue that Dave Chinner found around
  writes extending beyond and not marking the iomap dirty.

Thank you all who took the time to review and provide feedback. :)

Jan Kara (2):
  iomap: Allow forcing of waiting for running DIO in iomap_dio_rw()
  xfs: Use iomap_dio_rw_wait()

Matthew Bobrowski (10):
  ext4: move set iomap routines into separate helper ext4_set_iomap()
  ext4: iomap that extends beyond EOF should be marked dirty
  ext4: split IOMAP_WRITE branch in ext4_iomap_begin() into helper
  ext4: introduce new callback for IOMAP_REPORT
  ext4: introduce direct I/O read using iomap infrastructure
  ext4: update direct I/O read to do trylock in IOCB_NOWAIT cases
  ext4: move inode extension/truncate code out from ->iomap_end()
    callback
  ext4: move inode extension check out from ext4_iomap_alloc()
  ext4: reorder map->m_flags checks in ext4_set_iomap()
  ext4: introduce direct I/O write using iomap infrastructure

 fs/ext4/ext4.h        |   4 +-
 fs/ext4/extents.c     |   4 +-
 fs/ext4/file.c        | 378 +++++++++++++++++-----
 fs/ext4/inode.c       | 716 +++++++++++-------------------------------
 fs/gfs2/file.c        |   6 +-
 fs/iomap/direct-io.c  |   7 +-
 fs/xfs/xfs_file.c     |  13 +-
 include/linux/iomap.h |   3 +-
 8 files changed, 498 insertions(+), 633 deletions(-)

-- 
2.20.1

--<M>--
