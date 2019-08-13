Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 968898B5D9
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2019 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfHMKqZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Aug 2019 06:46:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36733 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfHMKqZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Aug 2019 06:46:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id g4so2643974plo.3
        for <linux-ext4@vger.kernel.org>; Tue, 13 Aug 2019 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UpVcCmgtBaNRu9BwNrXN+Bj2qHIBPkkiOSGk8igbhsM=;
        b=bkAUIV/tgeTWL8Bvk3nigSvdkW3Y/fxdMOC3ZB+/q/7d00/4ZccplVLKAbNYFxH0Km
         N7MwDLg2ZFf9+vgC58v5cj171mS4jKG0A6YuAn0zT5KxIkxZ+arkrEXT2knw4BvDg7zJ
         Ihly5SB4/Id3tdtCSE3QNQOgaRBCtnr6EHTIZzmU8t3FiQ3MVe/a21mDaBsc8fkhQt73
         BBj1GhJXB6w1ckJ1HD0DKSIHWNxulBsMHLReJNVdmJvWPOq+c6BP59nh6TRgXF7kfbcy
         4kQ7j/CjzxolATFx0+5pqDH56SwKU8SSopIEj8VlxNTv0KzALrJ+8zgZ2oZ2JGYiCQ70
         q0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UpVcCmgtBaNRu9BwNrXN+Bj2qHIBPkkiOSGk8igbhsM=;
        b=ccTgPNV1/6r7dRuav/wBISC2LwKVXNTN8CWVim2SHcFKYAmUeGvsLDXsvWwHYhmgy+
         ciE2Ms9lMiBWFzg9+MlQfVnR59oUcspPHYmamlPSiyFnwVyRe5/D1fQEvkQH8p7gZB80
         SyR1F3kxNPKgOGNxay3Uoc/nRkTtC3edkuoBWxiGRAqtum+gJBxJS72p/Flo/H+lXTEg
         tdiPb0+XyJ8KCsubSttAMDkfv/YD8avNbEOLsRm9qBImUsMeGvAvv4Wurr06Z/7+hBKx
         fSQyyUpQicX8MOai/VSQYb/72LoUyNEziKSe43B5uEXI22Z3sZaynRBtxRj301w59hat
         maGg==
X-Gm-Message-State: APjAAAW1IMyA6uvb70NueNCVn1Phg8RK7S8davELTp+B683K7dTTi6GV
        fejJ1t8kRwPOphSeraB+PuvjA6LRUw==
X-Google-Smtp-Source: APXvYqxPIaXJRkfuyja+Cn32Dh+0f7OxRx2eIG6b1MDThHhSyK/qyigL6Qzp5BQ2ja388J0OAcANIQ==
X-Received: by 2002:a17:902:1e6:: with SMTP id b93mr36656083plb.295.1565693184460;
        Tue, 13 Aug 2019 03:46:24 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id q8sm975633pjq.20.2019.08.13.03.46.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:46:23 -0700 (PDT)
Date:   Tue, 13 Aug 2019 20:46:18 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 2/5] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
Message-ID: <20190813104616.GA4198@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <774754e9b2afc541df619921f7743d98c5c6a358.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812171839.GC24564@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812171839.GC24564@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 12, 2019 at 10:18:39AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 12, 2019 at 10:52:53PM +1000, Matthew Bobrowski wrote:
> > In preparation for implementing the direct IO write code path modifications
> > that make us of iomap infrastructure we need to move out the inode
> > extension/truncate code from ext4_iomap_end() callback. For direct IO, if the
> > current code remained it would behave incorrectly. If we update the inode size
> > prior to converting unwritten extents we run the risk of allowing a racing
> > direct IO read operation to find unwritten extents before they are converted.
> > 
> > The inode extension/truncate has been moved out into a new function
> > ext4_handle_inode_extension(). This will be used by both direct IO and DAX
> > code paths if the write results with the inode being extended.
> 
> ext4_iomap_end is empty now, so you could as well remove it entirely.

As mentioned in my other email (4/5), this is callback needs to remain.

--M
