Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E46A42F748
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhJOPvn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Oct 2021 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbhJOPvn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Oct 2021 11:51:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB6AC061765
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 08:49:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso2024839pjw.2
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ph+oZ8UT4h1HTx6qQ3UwPOnmmXuejFlF+FpHdhVkhfw=;
        b=iSbFTO7hl5wsHi/v9726DpD3kjwHBmUweM5nSVDlyWBslMc3wVKEMvQCq5pVO/6MpZ
         QpL/26LdJe7GrULqRDxfawSnvbruhiXNd7VKIbgGj0HAHUSD4T22YVTuGUCVLgeYQ9DD
         YRPQKjchN3EU8Gz5xfRwkBHxJQvIPm4lQcdPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ph+oZ8UT4h1HTx6qQ3UwPOnmmXuejFlF+FpHdhVkhfw=;
        b=4B18pXWpII4iBJAs2v1BpLw8c8ls6rdiSsfFXwNcThYpz0YB1UAY3tqj+sr7SEjKNE
         mbT+BXngKodN4uK2J1i3raVkniIjdhAJ1o79008wYJQhTvMPVtqUykliDgzrsnWC8UW9
         5s9/nCUdrkJb7DyhPaAiIuIVmblLHEWzZ85Bf9xtEimjPKcilDjOlsCWsxAVcOwcaulA
         6CBNvb6U4WJBnpMCNK/wUUEoxFX9+MaMHVKE/vr04iCF1Kt8SXhhfMrfY0hl8pIWf374
         Q8eCYwRtAFDfw1UQwpfMbAn99tnGBMd9fKb4eSHdm2Zw+4ocaU3xZ4NegHGLf7f0zYTU
         xbgg==
X-Gm-Message-State: AOAM533Ac6Mi31bd7JBWAl37sghWO5s6c6qCoH678GShyQvnQ/JXXgLq
        oRszHjJPpkG7mJ6K36umhcoT8Q==
X-Google-Smtp-Source: ABdhPJz6i9tGVLgkq0eULPGyuk5x/dLn8xi+sif8q9XJ9Fat4Z2U3sGqOIlP99kszRnqXPDgBVaPnw==
X-Received: by 2002:a17:903:234d:b0:13f:3180:626a with SMTP id c13-20020a170903234d00b0013f3180626amr11815749plh.49.1634312976314;
        Fri, 15 Oct 2021 08:49:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v22sm5451930pff.93.2021.10.15.08.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 08:49:35 -0700 (PDT)
Date:   Fri, 15 Oct 2021 08:49:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
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
Subject: Re: [PATCH 02/30] block: add a bdev_nr_bytes helper
Message-ID: <202110150848.375151B3@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-3-hch@lst.de>
 <7C4AC4BD-B62D-41B3-AAF7-46125D1A1146@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7C4AC4BD-B62D-41B3-AAF7-46125D1A1146@tuxera.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 15, 2021 at 02:37:41PM +0000, Anton Altaparmakov wrote:
> Hi Christoph,
> 
> > On 15 Oct 2021, at 14:26, Christoph Hellwig <hch@lst.de> wrote:
> > 
> > Add a helpe to query the size of a block device in bytes.  This
> > will be used to remove open coded access to ->bd_inode.
> 
> Matthew already pointed out the return type for bdev_nr_bytes() but also your commit message has a typo: "Add a helpe" -> "Add a helper".

Right. With these fixed, I'm a fan. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
