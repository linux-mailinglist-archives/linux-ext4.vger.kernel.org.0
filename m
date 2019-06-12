Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43A424A9
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2019 13:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfFLLrY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jun 2019 07:47:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41607 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfFLLrX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jun 2019 07:47:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id 33so9986639qtr.8
        for <linux-ext4@vger.kernel.org>; Wed, 12 Jun 2019 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=doRL6xBFBed4pJcj6qEQTvbXU3ur3CIYrFA1lN8ah30=;
        b=KEjL99IzABO4E8zOpgtHyEE7fDCc4xx1ObR/IKbq+ZUDqR6OX5HnV4sIUZFTf7RnZt
         b2Ynd/zlz64GKX5T4XDhbfMlrndVetU9EumvX37IkUOWJMmaxMkt+vAcxu1CdZPoc7EU
         ab05F8Xpa83TYkV6OHDY0iY2sudedN7HpmLMnCVeAmqMtt9fy753PUDc6q2lXgRHWuNb
         WbanwUiNhr0RXy5e3mIuwzswALCs1rX2s+SZhewD51kCAtF+shTYjgGV9IGTi7j7s9Wy
         MYyHNmVkN91noui2Vnp7/PPo2P6dBu6nZ6qFP8tAHWsLEKkJnaOd1W/VqIrOF8KjgmmJ
         M41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=doRL6xBFBed4pJcj6qEQTvbXU3ur3CIYrFA1lN8ah30=;
        b=NJi8zdPqiOU2c2gE+BpNr2JuKpHBXNjvtJeJHCpQ4vSR5yS27+pxvwbSbGlXLbSp1r
         /3uGCl+vlHAUUx3+0g778WQdJS+iKsTYCBgbElCTLUisWgBuyFsi+LlZieIT0sZ0lgUM
         0BsDfUlAlUWtfoWnw1dhjfmV6munhPXhp+2U9MrCQ7h/Hv8zhvqNhLiHeKo8ybD45YRw
         Qs/4+MWHRs3+duO7X+9zcgL4JEm7WIupLflhM9ul+T6125EM5Hia+7Fd8A9GaDXEbDiC
         fNVraNN+aS766V9Ffgawg9gZzUaCXi+PLX2jQATgDAcWvIQeCeH+i2ewdeD+lYghCVXv
         j9VQ==
X-Gm-Message-State: APjAAAVrcbIAdwEe19637YGOLJEHKi0iIsKaG46jRaXuqADg5YPDHwWW
        P//xZzRnsmUTUtmRGTig8O6tVQ==
X-Google-Smtp-Source: APXvYqycHb6gvBCa/U7QXKWMgTojD1Kl8PmNQRXZ9Diy9dAscbbAdH3XTO8f9by4yoHhgJdAhCfOmQ==
X-Received: by 2002:ac8:2eb9:: with SMTP id h54mr69874544qta.381.1560340042946;
        Wed, 12 Jun 2019 04:47:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v17sm10366715qtc.23.2019.06.12.04.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:47:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb1is-0002JC-07; Wed, 12 Jun 2019 08:47:22 -0300
Date:   Wed, 12 Jun 2019 08:47:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190612114721.GB3876@ziepe.ca>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612102917.GB14578@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 12, 2019 at 12:29:17PM +0200, Jan Kara wrote:

> > > The main objection to the current ODP & DAX solution is that very
> > > little HW can actually implement it, having the alternative still
> > > require HW support doesn't seem like progress.
> > > 
> > > I think we will eventually start seein some HW be able to do this
> > > invalidation, but it won't be universal, and I'd rather leave it
> > > optional, for recovery from truely catastrophic errors (ie my DAX is
> > > on fire, I need to unplug it).
> > 
> > Agreed.  I think software wise there is not much some of the devices can do
> > with such an "invalidate".
> 
> So out of curiosity: What does RDMA driver do when userspace just closes
> the file pointing to RDMA object? It has to handle that somehow by aborting
> everything that's going on... And I wanted similar behavior here.

It aborts *everything* connected to that file descriptor. Destroying
everything avoids creating inconsistencies that destroying a subset
would create.

What has been talked about for lease break is not destroying anything
but very selectively saying that one memory region linked to the GUP
is no longer functional.

Jason
