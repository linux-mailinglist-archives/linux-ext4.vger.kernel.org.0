Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D59AEA6
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2019 14:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfHWMEb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Aug 2019 08:04:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34969 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbfHWMEb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Aug 2019 08:04:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34so10933671qte.2
        for <linux-ext4@vger.kernel.org>; Fri, 23 Aug 2019 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4WWnnUwkVly7nnLYY9/xwNxHF5WTTLqjxhffU6DvYt8=;
        b=LlubO/GS/GhZglMDymM8i9G+fFfCfYWxOMiJWGFKTJ+7MexkpK+xhGSSSSGIlCd8sh
         LYjJIWWBTfUmUOwrHHbjY3dTkOfMghu7dvZKY/xzOtIIPFg1CWAroOH7HI0rxZPUhekx
         NWkLeiB3PmZsjpNRdnJTAHo4jsoGVnnwr3u0SnIu9QiAcH/zcFhaPHa4bs0n9xRi82de
         1FsheC/kz3jFsXQoRjitUsUSSPOzGJ+zc5qrPsHbsgJ+e17Wx0jO8gKKg/uxK9a83up+
         7nNzKjJBOKbutD1rBLV9UoB3jzxfGlgc66BAN2T9uyH9XBVPLhqnZPQGkzxGFH3aJED5
         o38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4WWnnUwkVly7nnLYY9/xwNxHF5WTTLqjxhffU6DvYt8=;
        b=aPlRBTgmnwLVbFoZ3dN5c8lkqDydSuABPOAOAX5iAcTdHuVm9kEBYY89x/+/2XS3D8
         NEDBPaDVige/5dLLyVW0zfM5ksqOjwR/vBUVOkQol60EhfE/HPvz2ibW6BxrKYGK1DdM
         OAL7nbWARb8HOELFvb3rUM2uKX0GsCKV9KmkWK5HB7XZFHwFzjZky3b5NukqPcSr/2nW
         b+1T/bKoYuNhc0mekcRyiv9oY326o28ThuQ4RUCVVzcgHpC80C82LRHd6p6Y7Pv9RZTT
         kViyUSXdFvkXO3R+1S6Wwv6PaI1VPzTil14ATgCpwIF3VfwiHmr0F+TZg30h33caQko7
         KAWQ==
X-Gm-Message-State: APjAAAUTZcuKdDQzvhsgGYx91M2P0A1gvgx4pD1UL/Y9ADCNqri1WyGu
        tBCYXJ43gtStZpTV7JsgfjQ6HA==
X-Google-Smtp-Source: APXvYqyCs/rzVTzNRsPBfJ6LJC2PPTsVCNC51CTcK/BboosGBx8za229rn7rBII+tLDrCwrPqCn+Sg==
X-Received: by 2002:ac8:3933:: with SMTP id s48mr4377146qtb.232.1566561870183;
        Fri, 23 Aug 2019 05:04:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 145sm1353913qkm.1.2019.08.23.05.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 05:04:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i18Iv-0003Z7-0f; Fri, 23 Aug 2019 09:04:29 -0300
Date:   Fri, 23 Aug 2019 09:04:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190823120428.GA12968@ziepe.ca>
References: <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
 <20190823032345.GG1119@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823032345.GG1119@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 23, 2019 at 01:23:45PM +1000, Dave Chinner wrote:

> > But the fact that RDMA, and potentially others, can "pass the
> > pins" to other processes is something I spent a lot of time trying to work out.
> 
> There's nothing in file layout lease architecture that says you
> can't "pass the pins" to another process.  All the file layout lease
> requirements say is that if you are going to pass a resource for
> which the layout lease guarantees access for to another process,
> then the destination process already have a valid, active layout
> lease that covers the range of the pins being passed to it via the
> RDMA handle.

How would the kernel detect and enforce this? There are many ways to
pass a FD.

IMHO it is wrong to try and create a model where the file lease exists
independently from the kernel object relying on it. In other words the
IB MR object itself should hold a reference to the lease it relies
upon to function properly.

Then we don't have to wreck the unix FD model to fit this in.

Jason
