Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3E6D8B24
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 01:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjDEXiB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 19:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjDEXiA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 19:38:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4DA3C0E
        for <linux-ext4@vger.kernel.org>; Wed,  5 Apr 2023 16:37:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id kq3so35881656plb.13
        for <linux-ext4@vger.kernel.org>; Wed, 05 Apr 2023 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1680737878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KeGD4MyOApqEcxE+Vz2Xa5S1sUVL6ion9IBrFVNam5c=;
        b=D9eCnKz/gG785yZ8Q0D0djMKMM/E6/FuIQMZkQe8yluN15Jtjl0WWLOX4IStp1C08L
         ItwEOh3AAXqKT/go24yRu3jS9GEYP+RP1nIZ+ZUZ+36mLFGGnPtXnVp01qMubeetVlAT
         b1hUJBs9OwkoomuM/1FLNornI+OpXF5L4L2+EHnE4nGJkMzNH6gzX39Mc7QTt2rtNoBb
         CsEf1v/fsFm5Z4vQaq6Oj8nYtZDTfrfkrYDIuJzfPNYQKkUbyMT8xJAr1SONze5Mr4dD
         dAIDN3VJ7CZcdTCJWV8kuCxhdA4u3XpgHMql+i+7pGTnpuEnDUYZzncmOgq7jMsH5S04
         G4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680737878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeGD4MyOApqEcxE+Vz2Xa5S1sUVL6ion9IBrFVNam5c=;
        b=VksuDKTtxu0hrJaLZVSrpgHd1556d8j8wMxuubCeNvQX8qU2ENkaYQRUXILhP4xxyf
         Yh1fkO8SiLNrlCJrew5zPCEO6U9/33S53b605YRgrgQVZapCrAEGa6OpiTEsyX6+96Nc
         0goDPugk4CWmuU42cWbQ4AhVj0H/GG38zApviaTuaD3oGWxbDJ884Sa6QbD2lSILRgsX
         0jjw26dG4QJgLGriXTQLj5S2RaRwzqKmQOHtBRJINIJDiBF88FD/MUsQC28HqrASHa1y
         3PPgHJJVcUALIhqj0ogyib5gO/1XgkiGtHyHJIO+kwBuUpjceOvV80zTT2k360kIFx6z
         jVkw==
X-Gm-Message-State: AAQBX9f2Q9fNXZv5Xr8DU/uqmcvUIZBnFJ4fa8nslV0Oy+kKwpg6L6LT
        UE7AfXh6InGWSOikKO6MD/1ZoA==
X-Google-Smtp-Source: AKy350YPpczm2kLshRHm378imxeqOrGuMhMZKLP5TqBhKu/vDXjqcxQbAmKQSkLGeQMyYt/kagueXA==
X-Received: by 2002:a05:6a20:bc96:b0:d9:18ab:16be with SMTP id fx22-20020a056a20bc9600b000d918ab16bemr883843pzb.29.1680737878121;
        Wed, 05 Apr 2023 16:37:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id m37-20020a635825000000b00502dc899394sm9641716pgb.66.2023.04.05.16.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 16:37:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pkChN-00HVv9-Mh; Thu, 06 Apr 2023 09:37:53 +1000
Date:   Thu, 6 Apr 2023 09:37:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrey Albershteyn <aalbersh@redhat.com>, dchinner@redhat.com,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <20230405233753.GU3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
 <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
 <20230405163847.GG303486@frogsfrogsfrogs>
 <ZC264FSkDQidOQ4N@gmail.com>
 <20230405222646.GR3223426@dread.disaster.area>
 <ZC38DkQVPZBuZCZN@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC38DkQVPZBuZCZN@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 10:54:06PM +0000, Eric Biggers wrote:
> On Thu, Apr 06, 2023 at 08:26:46AM +1000, Dave Chinner wrote:
> > > We could certainly think about moving to a design where fs/verity/ asks the
> > > filesystem to just *read* a Merkle tree block, without adding it to a cache, and
> > > then fs/verity/ implements the caching itself.  That would require some large
> > > changes to each filesystem, though, unless we were to double-cache the Merkle
> > > tree blocks which would be inefficient.
> > 
> > No, that's unnecessary.
> > 
> > All we need if for fsverity to require filesystems to pass it byte
> > addressable data buffers that are externally reference counted. The
> > filesystem can take a page reference before mapping the page and
> > passing the kaddr to fsverity, then unmap and drop the reference
> > when the merkle tree walk is done as per Andrey's new drop callout.
> > 
> > fsverity doesn't need to care what the buffer is made from, how it
> > is cached, what it's life cycle is, etc. The caching mechanism and
> > reference counting is entirely controlled by the filesystem callout
> > implementations, and fsverity only needs to deal with memory buffers
> > that are guaranteed to live for the entire walk of the merkle
> > tree....
> 
> Sure.  Just a couple notes:
> 
> First, fs/verity/ does still need to be able to tell whether the buffer is newly
> instantiated or not.

Boolean flag from the caller.

> Second, fs/verity/ uses the ahash API to do the hashing.  ahash is a
> scatterlist-based API.  Virtual addresses can still be used (see sg_set_buf()),
> but the memory cannot be vmalloc'ed memory, since virt_to_page() needs to work.
> Does XFS use vmalloc'ed memory for these buffers?

Not vmalloc'ed, but vmapped. we allocate the pages individually, but
then call vm_map_page() to present the higher level code with a
single contiguous memory range if it is a multi-page buffer.

We do have the backing info held in the buffer, and that's what we
use for IO. If fsverity needs a page based scatter/gather list
for hardware offload, it could ask the filesystem to provide it
for that given buffer...

> BTW, converting fs/verity/ from ahash to shash is an option; I've really never
> been a fan of the scatterlist-based crypto APIs!  The disadvantage of doing
> this, though, would be that it would remove support for all the hardware crypto
> drivers.
>
> That *might* actually be okay, as that approach to crypto acceleration
> has mostly fallen out of favor, in favor of CPU-based acceleration.  But I do
> worry about e.g. someone coming out of the woodwork and saying they need to use
> fsverity on a low-powered ARM board that has a crypto accelerator like CAAM, and
> they MUST use their crypto accelerator to get acceptable performance.

True, but we are very unlikely to be using XFS on such small
systems and I don't think we really care about XFS performance on
android sized systems, either.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
