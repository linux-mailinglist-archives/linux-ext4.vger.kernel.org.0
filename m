Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1082242DDD0
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Oct 2021 17:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhJNPQi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbhJNPQh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Oct 2021 11:16:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271EC061755
        for <linux-ext4@vger.kernel.org>; Thu, 14 Oct 2021 08:14:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f21so4401839plb.3
        for <linux-ext4@vger.kernel.org>; Thu, 14 Oct 2021 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kk58q1N6iOKJV9MmXM4g94KiVUwgBacQdDgb8dq+Hqc=;
        b=mlZB9Nj4m8jk1JFv+iCH7Znrwanh3CDPQczVzomtmeQ5BLbFN1inwmhXkfQwL1sdEQ
         hih7m3SNinxkOxv1CMzByR9lFDUUB4oAxo3E3cDYo/S67L6xZfuz5zRsWVJKP1+73Scy
         QCwjhJQjGzKf7SNt+QV8U3nYErgEHf4yODN/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kk58q1N6iOKJV9MmXM4g94KiVUwgBacQdDgb8dq+Hqc=;
        b=ZivNG1OM3aKms5Sd4jSVXB+1DwIi9Hpf0RVjUR+79rMCP/D/Vypf01+caPIyWI6K7G
         A4fZ040GELAo0GyRUIbHck9bKJe3GYV+wTG/ZdfpzrBgenhpTkK+BLMI1W9/j1SDWz9m
         9R3g+sKD5Rj+24cZ2aEdcC5G4hppynumFrKAavS2AHQJLT76NLT2F/ch9HU1uzymwUOp
         lSTgl+2CyffXneFk3rWBT90AWgv5g0a7lVq9CwJunNuVp/POq9uPc4dO9SWXDtXz0ybu
         PXudImUnCQEXb5RSUmL482kmI4YMaJ3ranlOUXJl8ZF2enIKCQtFDFwYuHwxcG49jUoU
         iqHA==
X-Gm-Message-State: AOAM533lL5MiEASUc3qaubGAqgsBgkHRa/vL3u2YWXvweUrRbKX6qagm
        gUe8nqI8iVRH+b1gkBxQbRPVbg==
X-Google-Smtp-Source: ABdhPJz+A28iMSsGMew00w4bTffNulDM4PlP1p1A1+RouZBKHQoPJUsZrDvvxCBzVTavFWwP5kdepA==
X-Received: by 2002:a17:90a:86:: with SMTP id a6mr20774739pja.190.1634224472530;
        Thu, 14 Oct 2021 08:14:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w4sm2822114pfb.3.2021.10.14.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:14:32 -0700 (PDT)
Date:   Thu, 14 Oct 2021 08:14:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>
Subject: Re: don't use ->bd_inode to access the block device size
Message-ID: <202110140813.44C95229@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211014062844.GA25448@lst.de>
 <3AB8052D-DD45-478B-85F2-BFBEC1C7E9DF@tuxera.com>
 <a5eb3c18-deb2-6539-cc24-57e6d5d3500c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5eb3c18-deb2-6539-cc24-57e6d5d3500c@oracle.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 14, 2021 at 08:13:59AM -0500, Dave Kleikamp wrote:
> On 10/14/21 4:32AM, Anton Altaparmakov wrote:
> > Hi Christoph,
> > 
> > > On 14 Oct 2021, at 07:28, Christoph Hellwig <hch@lst.de> wrote:
> > > 
> > > On Wed, Oct 13, 2021 at 07:10:13AM +0200, Christoph Hellwig wrote:
> > > > I wondered about adding a helper for looking at the size in byte units
> > > > to avoid the SECTOR_SHIFT shifts in various places.  But given that
> > > > I could not come up with a good name and block devices fundamentally
> > > > work in sector size granularity I decided against that.
> > > 
> > > So it seems like the biggest review feedback is that we should have
> > > such a helper.  I think the bdev_size name is the worst as size does
> > > not imply a particular unit.  bdev_nr_bytes is a little better but I'm
> > > not too happy.  Any other suggestions or strong opinions?
> > 
> > bdev_byte_size() would seem to address your concerns?
> > 
> > bdev_nr_bytes() would work though - it is analogous to bdev_nr_sectors() after all.
> > 
> > No strong opinion here but I do agree with you that bdev_size() is a bad choice for sure.  It is bound to cause bugs down the line when people forget what unit it is in.
> 
> I don't really mind bdev_size since it's analogous to i_size, but
> bdev_nr_bytes seems good to me.

I much prefer bdev_nr_bytes(), as "size" has no units.

-- 
Kees Cook
