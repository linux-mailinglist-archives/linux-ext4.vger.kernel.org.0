Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82F6D8A6C
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 00:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjDEWPA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 18:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDEWO7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 18:14:59 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3985BA9
        for <linux-ext4@vger.kernel.org>; Wed,  5 Apr 2023 15:14:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id cm5so18813243pfb.0
        for <linux-ext4@vger.kernel.org>; Wed, 05 Apr 2023 15:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1680732898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sr4CJdOOx/6apQcfPjVNK8msYC2J6U4ttJpvFiO5hDA=;
        b=m04BZY35RD6EaPYELcRel51CNq6xM8X8aXbJWM0zpFJg5R9ZEfx3ALXHe27ZQTx/ML
         RjdLwwAr7+4sz13cFeM+4MFXL0NDeO0sDJVA9EpyReHBMnIHkm92ebNusykZudTLT4kb
         ZJt9w2GuxyrtFAj7oogjC2Nr0HL+r4kpZ6lzOt6rcmOuXKj15Zw+5iQ9+bIRQa16RXYd
         mqYE+wyM7waca64HeD0ztnx4PCy2qkyJsPtmJxS4X1sOHozTDe94atNRk2yRkagS/8TC
         Xykh3m9EUSbsut3dD/LJF9fvakINcF2XcNSqQnSe8WA/qL2Bzj/UsimauCtRgN2YOZNg
         vv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680732898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr4CJdOOx/6apQcfPjVNK8msYC2J6U4ttJpvFiO5hDA=;
        b=wKuVtMOHjqBP+Ts24gmXU3bOud+lEVlXCpK+0+M5HvczOmiVhMqgb8KKmPPp6mLBgf
         Jztnw9f7Kia/7aMeVzNyhQa+RPtY6SeSQbOMyMgNtGeH0B1bzi3j/9Ebi7q6r+jU1nrY
         NIgz9zf6vnT0o5SvS2wGS7l6lN6UspMGi1a+CXEB7mbRAwT61md3QYt+hmwRtBj5hfLX
         8kHnkoCKbLm4/vmvTINimq54xnwAyu7qdFSM+pmrHsL5y+mCRH5C4VqbUA3xcCgkasX/
         +cRkI15JBpM4Osjy/NUFrm+QW/zSR7opxlG5TENkcMIQ/6WmBSIczQSgih38dv6+KINx
         RaAA==
X-Gm-Message-State: AAQBX9cLg1ZAaMKRcRgduFWXEJq4+yN7SEn37PDqG5NjKH+coSgRd6tP
        1Xk5rlVWOkJFUZF+oxmLtFy69w==
X-Google-Smtp-Source: AKy350buwNZtgpjQjNrpY+dRBomVST4nFtdRBnQ6Mea8vZue8EC+2ZTK97MNMJLE5y0NZdZDQ14O+g==
X-Received: by 2002:aa7:9a44:0:b0:626:1c2a:2805 with SMTP id x4-20020aa79a44000000b006261c2a2805mr5960988pfj.25.1680732898541;
        Wed, 05 Apr 2023 15:14:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id t17-20020a62ea11000000b005a9ea5d43ddsm11542560pfh.174.2023.04.05.15.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 15:14:58 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pkBP4-00HUS4-Uz; Thu, 06 Apr 2023 08:14:54 +1000
Date:   Thu, 6 Apr 2023 08:14:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrey Albershteyn <aalbersh@redhat.com>, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 19/23] xfs: disable direct read path for fs-verity
 sealed files
Message-ID: <20230405221454.GQ3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-20-aalbersh@redhat.com>
 <20230404161047.GA109974@frogsfrogsfrogs>
 <20230405150142.3jmxzo5i27bbc4c4@aalbersh.remote.csb>
 <20230405150927.GD303486@frogsfrogsfrogs>
 <ZC2YsgYRsvBejGYY@infradead.org>
 <ZC23x22bxItnsANI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC23x22bxItnsANI@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 06:02:47PM +0000, Eric Biggers wrote:
> And I really hope that you don't want to do DIO to the *Merkle tree*, as that

Not for XFS - the merkle tree is not held as file data.

That said, the merkle tree in XFS is not page cache or block aligned
metadata either, so we really want the same memory buffer based
interface for the merkle tree reading so that the merkle tree code
can read directly from the xfs-buf rather than requiring us to copy
it out of the xfsbuf into temporary pages...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
