Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B732542F950
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbhJOQ72 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Oct 2021 12:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbhJOQ70 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Oct 2021 12:59:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D81C061765
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 09:57:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q19so8874102pfl.4
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 09:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/eOYGY8U37n2MZu0N4BHYKivX4HrXVHyr5D+KqaWhQU=;
        b=DmViUCP42ryk0/zjuuQaBiRmRe/mzSHK6WDkRvPw/tFoCT41pzGsk6sbtBTGe4K1S5
         OLN5lTFSJc9JHAwBNbm8/vlAKnFBSpj8DIDLl39Onh8N7+06YtLNNZRfLZuy7Z8xH+qc
         GC7tjeAZF2U3l2PkPMfgIzPMHYdB7TC28kw18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/eOYGY8U37n2MZu0N4BHYKivX4HrXVHyr5D+KqaWhQU=;
        b=72KpGar+gUOJ3UY1rKIvy2wAaBrK5oPnxqDOgpuDyEXEMpToV057qxAuMYVLQDRDN+
         Dy1nU2U72d01wODAip6yGCnevnXEy/g2W7q0PGBrzYpYi4YZj98t+GHGLUMSmpknEVSY
         CqbLRVer8Gm5tJNiAGq8iLamfKszjIo4fN0wevUUdWSDVwygCS9tuNGfTT2V/NJLK20H
         DEInZYeB4iIpVQiO9dPAx5ArtmoBkwO1+Od60H8aUJBL/cpbk9IZ1LI2Q+ffAISnwr/d
         BRx4WqQNVtE4Ex1WqnJJSW2lry6jyrQrxUufitHezLNe0POYjzZ8GeKPFGfVPGCeMUG9
         V/fg==
X-Gm-Message-State: AOAM5309fesbzdNe3pOJsIQmtNrxs/z10vKd2PE2htlJXrKIonSqwQhg
        hcr1o3GP0iUqSlLTU24mi5qsRw==
X-Google-Smtp-Source: ABdhPJyzpBRnickMzNbIwiNU4SlM0+KvU9N1DSuPdJJGXTy9zuESs+0VnjHyi75qB2n8UZERvww2Xg==
X-Received: by 2002:a63:b950:: with SMTP id v16mr5917773pgo.361.1634317039225;
        Fri, 15 Oct 2021 09:57:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a20sm11450710pjh.46.2021.10.15.09.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:57:18 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:57:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 24/30] block: use bdev_nr_bytes instead of open coding it
 in blkdev_fallocate
Message-ID: <202110150957.C90F687@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-25-hch@lst.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 15, 2021 at 03:26:37PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
