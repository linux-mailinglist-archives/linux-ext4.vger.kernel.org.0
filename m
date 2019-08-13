Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504738B776
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2019 13:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfHMLrJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Aug 2019 07:47:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46534 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfHMLrI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Aug 2019 07:47:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id j15so12380356qtl.13
        for <linux-ext4@vger.kernel.org>; Tue, 13 Aug 2019 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A5jSIc/RY/hZ7f+bEkMhOVRTEXKJZMsh3LcoJICOYZA=;
        b=QCZ4PvH+HERINAIC/rIX57CfHFpykExOSCWoiRBdSClOqTC5WAYKVE/wNtLd1ZCdXb
         KZp5v/22WAqZ0EMeHD9gQcL9jjBHQrauhwB1tY41cMyXOMQcHirf3q33hSp3+J4vow0U
         GPXzEq3gqF2wrMV1Rw/sgqnEqIShtnXpz04NN7ACpnW2Kb2z/8KWS7MN/hESlyb75tlS
         YMQH3uuf6z8f1q/jLKcYyFLyOZd7D+SDwoKD8lO4RahnM5opPz9OKgrwrp/X5BI8wvMd
         OzyT60/eIe57jrf+8q2zyLqpHM8YRV9JQevqDnSiRM5+NRuM8rm/DiPdBJOWMMsLftQz
         b4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A5jSIc/RY/hZ7f+bEkMhOVRTEXKJZMsh3LcoJICOYZA=;
        b=dp5ZeXHlzgQjKs9jXD/++ztwPDrTSKCPJNkNr55ShY3dXNLfIBgzm5yyzYsiVIxgQo
         8KKlpqZ59h9HtqTFxtL24Oaq698jRDHUxx/gEnzkzZwr8qN7sr73eZlSAGNmi3wwaWQS
         gQ52wAyr8gVEjbYAeNstJp8uK6+J8wegnYblyNiJkPBdC/ZBhTWhWOFB/xDayWDI9YY7
         RTM8JC0ffAOqHkILD78NvA0VWBmehiMZWgtgnwAZtj/Tqhkx9LulkVYAWd278TMRnz7o
         rVZhtTcz2Core0epaT4GmpQHfGx8UjJ9kViBWdde7E0MvcVjdygZx3yD1hYGz4OyHIhk
         Ra+w==
X-Gm-Message-State: APjAAAVEqbD5PCNUQAW4YjpMte657sT4tON6ncVaAiULqKRmWfe4mCk5
        bvk3nosRG7NvQTfH8AqszpSU+Q==
X-Google-Smtp-Source: APXvYqxNaQQNPStukKuBzbe7ho0VUZGNKPG9lP34sc9j+nxvDvhp77mkTMuiRQNU50cP5mt/nBqv4g==
X-Received: by 2002:ac8:3f86:: with SMTP id d6mr30794575qtk.346.1565696827682;
        Tue, 13 Aug 2019 04:47:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 67sm47417797qkh.108.2019.08.13.04.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 04:47:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hxVGc-0007jx-3A; Tue, 13 Aug 2019 08:47:06 -0300
Date:   Tue, 13 Aug 2019 08:47:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 15/19] mm/gup: Introduce vaddr_pin_pages()
Message-ID: <20190813114706.GA29508@ziepe.ca>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-16-ira.weiny@intel.com>
 <20190812122814.GC24457@ziepe.ca>
 <20190812214854.GF20634@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812214854.GF20634@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 12, 2019 at 02:48:55PM -0700, Ira Weiny wrote:
> On Mon, Aug 12, 2019 at 09:28:14AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 09, 2019 at 03:58:29PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The addition of FOLL_LONGTERM has taken on additional meaning for CMA
> > > pages.
> > > 
> > > In addition subsystems such as RDMA require new information to be passed
> > > to the GUP interface to track file owning information.  As such a simple
> > > FOLL_LONGTERM flag is no longer sufficient for these users to pin pages.
> > > 
> > > Introduce a new GUP like call which takes the newly introduced vaddr_pin
> > > information.  Failure to pass the vaddr_pin object back to a vaddr_put*
> > > call will result in a failure if pins were created on files during the
> > > pin operation.
> > 
> > Is this a 'vaddr' in the traditional sense, ie does it work with
> > something returned by valloc?
> 
> ...or malloc in user space, yes.  I think the idea is that it is a user virtual
> address.

valloc is a kernel call

> So I'm open to suggestions.  Jan gave me this one, so I figured it was safer to
> suggest it...

Should have the word user in it, imho

> > I also wish GUP like functions took in a 'void __user *' instead of
> > the unsigned long to make this clear :\
> 
> Not a bad idea.  But I only see a couple of call sites who actually use a 'void
> __user *' to pass into GUP...  :-/
> 
> For RDMA the address is _never_ a 'void __user *' AFAICS.

That is actually a bug, converting from u64 to a 'user VA' needs to go
through u64_to_user_ptr().

Jason
