Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA816D83AA
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 18:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjDEQ2Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDEQ2Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 12:28:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77EE198D
        for <linux-ext4@vger.kernel.org>; Wed,  5 Apr 2023 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680712053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xpkEDS6jt39qufg3GMcbXZKRt5qOSbn/1OJhbiuzI9E=;
        b=IofOlEqACMOcCzuQ8zDo5dyqBOLvXdb0QvuYAKZrtfen6rJemfyHcn0NzhYfrMe90AlLgw
        sCXlDbXL5AfxkB8L5tN7WQZjNBjcTD4zvgK1uGeauIk2xCLMzXyltZzqAigdMU2MFWboC3
        kBA0yYlZD3JoeCQK1YgJw9KbBIxHoOc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-PYuCAmrPOhaocdASQc_MLQ-1; Wed, 05 Apr 2023 12:27:32 -0400
X-MC-Unique: PYuCAmrPOhaocdASQc_MLQ-1
Received: by mail-qt1-f199.google.com with SMTP id r22-20020ac85c96000000b003e638022bc9so12724854qta.5
        for <linux-ext4@vger.kernel.org>; Wed, 05 Apr 2023 09:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpkEDS6jt39qufg3GMcbXZKRt5qOSbn/1OJhbiuzI9E=;
        b=bLSLwlg552Y6reBVoD5GXiSJKG8YOOIG0/hWpGaOSdxQvWKnXCbhmJYel7Wi/26o0E
         uzBhn/QKGmAZ34CiXf0eGKwGHMpiVRDwtJiqSXeADcAmJsFJPJH3qpVk6xRq0GX+m9oa
         kvy5nFKG36BmdcqBYTVIpXsOF3NRkafTDTniPL3B/FyPZnKn3UVVaEhRkbFVMpoNacQU
         NX6L0v4evXybMbOTvifZF1jMEYiOd5QBUJ531iGIZW4P9YypDAg6ctXlIYUANszNQBQ9
         XVbKRKLPEKBGt4Ph4sVm4LCXyC4cTB9GjRirEnb+O28Dc4iyiTpeQRFzSYy3BJ4EOI21
         ZfWQ==
X-Gm-Message-State: AAQBX9enCw+rT9zPJ0+ModqQzv2DvrcLzROEwFoMRI0dQ5QQj9T/76aJ
        2tNZoLeaALH90nKKtxRQfSr1Cxzi4tT01kTViuNQO5ug7Cg0PW+AR1fMoTkViEc/VpCFMEK9qoa
        XiXwkfS+akm8qacCX5yFn
X-Received: by 2002:a05:6214:1c8d:b0:5bb:eefc:1624 with SMTP id ib13-20020a0562141c8d00b005bbeefc1624mr9853060qvb.27.1680712051497;
        Wed, 05 Apr 2023 09:27:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZZl4q26mcUoNHuCokraSI3hi88peqAYHPpgY7Wvk0Gvn/BxgeqpN4NaYegoUGQwHkcsJ0yow==
X-Received: by 2002:a05:6214:1c8d:b0:5bb:eefc:1624 with SMTP id ib13-20020a0562141c8d00b005bbeefc1624mr9853021qvb.27.1680712051206;
        Wed, 05 Apr 2023 09:27:31 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id r206-20020a3744d7000000b0074a0051fcd4sm4559684qka.88.2023.04.05.09.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:27:30 -0700 (PDT)
Date:   Wed, 5 Apr 2023 18:27:26 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     dchinner@redhat.com, ebiggers@kernel.org, hch@infradead.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <20230405162726.4d7bu3uz63w4cdkz@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404163942.GD109974@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404163942.GD109974@frogsfrogsfrogs>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Darrick,

On Tue, Apr 04, 2023 at 09:39:42AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 04, 2023 at 04:52:56PM +0200, Andrey Albershteyn wrote:
> > Hi all,
> > 
> > This is V2 of fs-verity support in XFS. In this series I did
> > numerous changes from V1 which are described below.
> > 
> > This patchset introduces fs-verity [5] support for XFS. This
> > implementation utilizes extended attributes to store fs-verity
> > metadata. The Merkle tree blocks are stored in the remote extended
> > attributes.
> > 
> > A few key points:
> > - fs-verity metadata is stored in extended attributes
> > - Direct path and DAX are disabled for inodes with fs-verity
> > - Pages are verified in iomap's read IO path (offloaded to
> >   workqueue)
> > - New workqueue for verification processing
> > - New ro-compat flag
> > - Inodes with fs-verity have new on-disk diflag
> > - xfs_attr_get() can return buffer with the attribute
> > 
> > The patchset is tested with xfstests -g auto on xfs_1k, xfs_4k,
> > xfs_1k_quota, and xfs_4k_quota. Haven't found any major failures.
> > 
> > Patches [6/23] and [7/23] touch ext4, f2fs, btrfs, and patch [8/23]
> > touches erofs, gfs2, and zonefs.
> > 
> > The patchset consist of four parts:
> > - [1..4]: Patches from Parent Pointer patchset which add binary
> >           xattr names with a few deps
> > - [5..7]: Improvements to core fs-verity
> > - [8..9]: Add read path verification to iomap
> > - [10..23]: Integration of fs-verity to xfs
> > 
> > Changes from V1:
> > - Added parent pointer patches for easier testing
> > - Many issues and refactoring points fixed from the V1 review
> > - Adjusted for recent changes in fs-verity core (folios, non-4k)
> > - Dropped disabling of large folios
> > - Completely new fsverity patches (fix, callout, log_blocksize)
> > - Change approach to verification in iomap to the same one as in
> >   write path. Callouts to fs instead of direct fs-verity use.
> > - New XFS workqueue for post read folio verification
> > - xfs_attr_get() can return underlying xfs_buf
> > - xfs_bufs are marked with XBF_VERITY_CHECKED to track verified
> >   blocks
> > 
> > kernel:
> > [1]: https://github.com/alberand/linux/tree/xfs-verity-v2
> > 
> > xfsprogs:
> > [2]: https://github.com/alberand/xfsprogs/tree/fsverity-v2
> 
> Will there any means for xfs_repair to check the merkle tree contents?
> Should it clear the ondisk inode flag if it decides to trash the xattr
> structure, or is it ok to let the kernel deal with flag set and no
> verity data?

The fsverity-util can calculate merkle tree offline, so, it's
possible for xfs_repair to do the same and compare, also it can
check that all merkle tree blocks are there. The flag without tree
is probably bad as all reading ops will fail and it won't be
possible to regenerate the tree (enable also checks for flag).

-- 
- Andrey

