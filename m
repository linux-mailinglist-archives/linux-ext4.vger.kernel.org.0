Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9F42B65D
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Oct 2021 08:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhJMGLX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Oct 2021 02:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhJMGLW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Oct 2021 02:11:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4CAC061714
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 23:09:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m21so1268141pgu.13
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 23:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qqwh23O6V/63P0yRnTO77bOtLRcytQL2fAyeRI5kB34=;
        b=CXM9rJHHK73rEQgm0mgdKmXS/wAofOl4OFPnwKac/DX3XFO3SZF+VUOO6mlfTZkIDy
         UTW+b9/6/6WoMA5ZI2y3esBG93Aw5k00FZrNw4PEm0iPy6yRGylzqCSKEzZCYiYZiEa0
         Gvi4MQ98yBAEGpxPU0vceWRTRPKnOulu8VFrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qqwh23O6V/63P0yRnTO77bOtLRcytQL2fAyeRI5kB34=;
        b=zOruvNxs+jzoc5cf4FjFGD4CgYfuOGVciunjgzTQtc2kPXzsFS42ewlorJpNXNR7mX
         053f0NIjPEKdKOeF1OVLtlDIIlKWQ8U2bcnZWQp2k4PiHpkiRDqekZGaCM35NDK4pC9T
         R31XCRC3cfi1agOXrygTudiFsT1MkoVcpic/k8wBqUStdSIjmHr4TNov1N0xy7Xx0oKj
         CKotrfldL3FIW50+rqrq2EKkzBx31Z7bxgaJRYtnX4FZz4xlpTTCtw+Aoq5Sx7tDxRuc
         1qBJeT01SnlC9d14u7KUXFRH0WW6FfZL1bJ7UdEb6aVRTICFHYWyXBw1TmkhMeErxvXP
         vIjg==
X-Gm-Message-State: AOAM532h82+3D5inPKQs+aiPMsYYr6lEx629vqvoPwfhPivl0b6eC9Ti
        E1/u/S1l+ORzP6Iati9LyRh3SA==
X-Google-Smtp-Source: ABdhPJzPVB6suksbrVxsW8arxDgbrt+zmZKpBhbvkmkjyXI+mBKX9gJNh2h2afCA7c0GFA7FKUgXzA==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr26426089pgh.7.1634105359458;
        Tue, 12 Oct 2021 23:09:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e6sm12787858pfm.212.2021.10.12.23.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:09:18 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:09:17 -0700
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
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 01/29] bcache: remove bdev_sectors
Message-ID: <202110122309.010F81F49A@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:14AM +0200, Christoph Hellwig wrote:
> Use the equivalent block layer helper instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
