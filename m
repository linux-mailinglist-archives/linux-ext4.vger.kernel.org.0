Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A7242B6A0
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Oct 2021 08:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbhJMGQc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Oct 2021 02:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbhJMGQ1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Oct 2021 02:16:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2148CC061714
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 23:14:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x4so1092294pln.5
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cU/dcevRRiOMyYUwUWALBmXmlvE8es1M77S7S7Vy3hg=;
        b=V/PklmmvmwB6oF28+X9W5oSqUy3MEBQUnBb4J2bRKEg/eIXO/xXpeqqwQGZrKIWhNv
         T8ctXe4hPipGRmAP9ugd0bC7MXlyH2K83qjMXuuXIhufHwq0vvnSHMGq1LP/1SN2Yv7x
         bKng84M/wOhI7OL1CmIwsfNERqhd12BkP84hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cU/dcevRRiOMyYUwUWALBmXmlvE8es1M77S7S7Vy3hg=;
        b=kdO1YjwOPB9JknclfqOac3Sbz0EPnJK4qT/QzIwIDOOTv7oyCexptn+mwAytJvquK/
         Pmp/qvSU8lqXPNSlGwtzArgjtzx2nscYur60ioVPUteSmDTx3W+893w0Ef7Rpr26e+7Z
         l+ECIYggUz2ccMo61qYtLqT8tXr30YAa+tZdNHpjguh7Z69H4a88ZT5xowavcAsP8Kzb
         ekCI1esDsAucxICpgy+5shXajgraMAA3jcLfBXRM/k/h/HqctLCRzct1bFOyU4gGSyKb
         eXMLvsYno0kDQXKDd+wQyXj9uQ+IoosEMFCGqydYDMcNRxkzdieN5riblIU5+jPR235+
         OdEQ==
X-Gm-Message-State: AOAM531XRSWn4Yh6Y0qbQ/JnwV/JBsdQQv8eLEQjSc8FHJUVNIk6lmQ3
        Ng/3zeVMtnnyfBx4ZuGGnJFZOQ==
X-Google-Smtp-Source: ABdhPJzB9T5WPRLBzlHsv86tToIXEU4uRcFKAiECkCtvwz0iUp/WDY5ZssCw0V4lwGrfF5Bgew0Phw==
X-Received: by 2002:a17:90a:8912:: with SMTP id u18mr10958091pjn.69.1634105664752;
        Tue, 12 Oct 2021 23:14:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o6sm12981960pfp.79.2021.10.12.23.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:14:24 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:14:23 -0700
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
Subject: Re: [PATCH 10/29] affs: use bdev_nr_sectors instead of open coding it
Message-ID: <202110122314.6BE3F05AA3@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-11-hch@lst.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:23AM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
