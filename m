Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960BBC9D59
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 13:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfJCLc5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 07:32:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38119 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfJCLc4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Oct 2019 07:32:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so1583213pfe.5
        for <linux-ext4@vger.kernel.org>; Thu, 03 Oct 2019 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Jm85ztTw6loR+224Tv9cB/n0utlhi6GT8VW3M5n6AjE=;
        b=oVR6bnX98C4ThAwx5Lbs+x477cjllNQuTDTk1YD8TtAL+MhxFl+LwHhpdHrA+GTxqs
         dIE5trm/6OHEvaNOKdjJEcY3YMPLTEvt1X4n7aBcq0U7dpJ+ImQbZpe8tUBPwoJb9qkq
         DNHc/nqZAmP3ICy7hjjQh0ZjVNiS34DgaYJGDVaje2ahjKeHhFQ+Y8EDBzVr6+352I6O
         q/hg/ZnZ9tV6Y9Owpg5WdhZzH7wORjtY8/gSV2WtfSa03E4GdAvvpU0a31qZ7bY14Xi0
         dAIhSALgm+QRH1qrbZ8PVhUxVlQ6fAJFzY+amq6f9/xFaoah02rT/VIJyS6OyYIoEj0E
         wQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Jm85ztTw6loR+224Tv9cB/n0utlhi6GT8VW3M5n6AjE=;
        b=NUJiY+QelzWyZTc1y8maLdC78t1y4ycArgYwZZ+ipA5osvDn7djqa57xxPuPqjrqGa
         AVRMxC29Nh2JDgHZ67aDrwsgZZws/Mr/jvbUWEmkEGWFAik6Jm7bj2LG7lz2qYr2bnVE
         HbDT/5JNcZuddkZJAnxguX5DqIa98PeELSnpX82ZEIk5yaXG50PtXZMo1Lmfb6Qh6e9E
         d++jtyEUjMZXm3AODN+v1TQRKpBJXV0NRBIVLvQOxAAlwdDLQ56mpzEe2yPnQiNgrwEC
         nYBs51uhQiKTZI5QvjhNSCBcQqNYlPRyCZwimFnbm0xDoQY8WnFwtsE5xjgeitGTkFH5
         PyPA==
X-Gm-Message-State: APjAAAXFSA/Fi066Z9rt8Pu71Qy4XpFwD4C7axDK5UReQkGHd9Jso8Yd
        xIDppmCC7uzI2ZNfVFrAOg9cvfkABs1w
X-Google-Smtp-Source: APXvYqyD54ONlQLVF1ccr3hbQp3x5ECfWVqd9JkpwYA/z0HUvSCWEijRVg+kaXN8su+WmPLQ6bcabg==
X-Received: by 2002:a65:6858:: with SMTP id q24mr8995208pgt.236.1570102375382;
        Thu, 03 Oct 2019 04:32:55 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id j128sm3345936pfg.51.2019.10.03.04.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:32:54 -0700 (PDT)
Date:   Thu, 3 Oct 2019 21:32:48 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v4 0/8] ext4: port direct I/O to iomap infrastructure
Message-ID: <cover.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch series ports the ext4 direct I/O paths over to the iomap
infrastructure. The legacy buffer_head based direct I/O paths have
subsequently been removed as they're no longer in use. The result of
this change is that ext4 now uses the newer iomap framework for direct
I/O operations, which results in an overall cleaner implementation and
keeps the code isolated from buffer_head internals. In addition to
this, a slight performance boost may be expected while using O_SYNC |
O_DIRECT I/O.

The changes within this patch series have been tested via xfstests in
both DAX and non-DAX modes using the various filesystem configuration
options i.e. 4k, dioread_nolock, etc.

Changes since v3:

 - Introduced a couple preparation patches around refactoring the ext4
   iomap code. This involved splitting chunks of the existing
   ->iomap_begin() callback into separate helpers.

 - Moved out the orphan handling code into a higher level caller. It
   used to be within ext4_iomap_begin(), but is now within
   ext4_dio_write_iter() and similarily ext4_dax_write_iter().

 - Renamed the helper function from ext4_dio_checks() to
   ext4_dio_supported(). Overall, it just reads better when using this
   helper throughout the code.

 - Cleaned up the ->end_io() handler. This was a result of refactoring
   ext4_handle_inode_extension() and allowing it to perform clean up
   routines for extension cases rather than calling
   ext4_handle_failed_inode_extension() explicitly.

 - Added a couple comments here and there to bits of logic that aren't
   immediately obvious.

 - Rather than having the clean up code in a separate patch at the end
   of the series, I've incorporated the clean up into the patches
   directly.

Thank you to all that took the time to review the patch series and
provide very valuable feedback. This includes Jan Kara, Christoph
Hellwig, Ritesh Harjani, and anybody else that I may have missed.

Matthew Bobrowski (8):
  ext4: move out iomap field population into separate helper
  ext4: move out IOMAP_WRITE path into separate helper
  ext4: introduce new callback for IOMAP_REPORT operations
  ext4: introduce direct I/O read path using iomap infrastructure
  ext4: move inode extension/truncate code out from ->iomap_end()
    callback
  ext4: move inode extension checks out from ext4_iomap_alloc()
  ext4: reorder map.m_flags checks in ext4_set_iomap()
  ext4: introduce direct I/O write path using iomap infrastructure

 fs/ext4/ext4.h    |   4 +-
 fs/ext4/extents.c |  11 +-
 fs/ext4/file.c    | 387 ++++++++++++++++++++-----
 fs/ext4/inode.c   | 709 +++++++++++-----------------------------------
 4 files changed, 484 insertions(+), 627 deletions(-)

-- 
2.20.1

