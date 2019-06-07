Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D890E38A00
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jun 2019 14:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfFGMRb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jun 2019 08:17:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33821 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfFGMRb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jun 2019 08:17:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so1953601qtu.1
        for <linux-ext4@vger.kernel.org>; Fri, 07 Jun 2019 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gtVg7214Fw18jFmO0/trZn1VfZgS9o74gz+vruFWYvs=;
        b=AezT+tTAIxGyfB0KOhiZ4wlOnDCwDvYEe2UFeaP+bHsiFFJQ3quqmXBE4VmSizAzTs
         J5ODOdrIQHOFjGLrQ2kl8pD0ejEenWX2TUZIYKB59qg474XzKIZuOVjBRq+lQLrWj4M2
         iVSmY6vOHff8NwVO3HpVwZnoQ1jkfupA0SSt6+/EDEdGIfd2MHTCCINUJtnZE6aguk0H
         Rq46XtTgO8/RXptKjB7wYR1vu5zDzIPtlBUqsEOtO9gMF69yTuBc5m8Ime/ZPUvcZqrt
         ymNopsF+fiDS/oX9NSWKDQK6uJaybIPNjnDHpwGv1pap4mgqjUGIkS+C+1a2HU66vv8B
         gi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gtVg7214Fw18jFmO0/trZn1VfZgS9o74gz+vruFWYvs=;
        b=TS/Ed9LXMiQa6uAT7GFSfCZIaznEwVpOPMNaQUcA2+V9aYhgdvGbsxOIxlNWH0Qt2H
         Mva6I4oC6kXNdkUfCLzm6LXZq7YV/8GNVDSAYgCQMfNJ5Ng+xv62N0Cf2EVxCYw24tY4
         +WdwXrhNmVxXpYlvV86X2v5dmFqledifOEZWYlDjVrCyIYAFUjJWMO+/oLcWVdNkbll/
         +FW9lH+05m88xKTx65hiBAitRf96DneHh8kADsceo4uew5iGwSr+icDSSYrtZiOvvF5G
         Jf2pQ9e3L8RpFS7SjkWTSxmbGBUytEV6ovJG4HBnJsROcPkWtd24YtP4NjC1lNyI5KMG
         wGFw==
X-Gm-Message-State: APjAAAXjWHR1t1a+E2NucuF4uh6CEiFd4nxtoVgKvTQeOQqQa9o6/kjr
        0snvvQo4B+CtsYwTLKp7acHC9g==
X-Google-Smtp-Source: APXvYqwfuT8J8aHz9GDeVxlPBNadLwnaumAWGxao4r/2OtwvxxCdhCQDklOSjsDrPDzMrdJee4yNzw==
X-Received: by 2002:a0c:8a69:: with SMTP id 38mr24854894qvu.116.1559909850154;
        Fri, 07 Jun 2019 05:17:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q36sm1286394qtc.12.2019.06.07.05.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 05:17:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZDoH-0006pJ-3U; Fri, 07 Jun 2019 09:17:29 -0300
Date:   Fri, 7 Jun 2019 09:17:29 -0300
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
Message-ID: <20190607121729.GA14802@ziepe.ca>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607103636.GA12765@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 07, 2019 at 12:36:36PM +0200, Jan Kara wrote:

> Because the pins would be invisible to sysadmin from that point on. 

It is not invisible, it just shows up in a rdma specific kernel
interface. You have to use rdma netlink to see the kernel object
holding this pin.

If this visibility is the main sticking point I suggest just enhancing
the existing MR reporting to include the file info for current GUP
pins and teaching lsof to collect information from there as well so it
is easy to use.

If the ownership of the lease transfers to the MR, and we report that
ownership to userspace in a way lsof can find, then I think all the
concerns that have been raised are met, right?

> ugly to live so we have to come up with something better. The best I can
> currently come up with is to have a method associated with the lease that
> would invalidate the RDMA context that holds the pins in the same way that
> a file close would do it.

This is back to requiring all RDMA HW to have some new behavior they
currently don't have..

The main objection to the current ODP & DAX solution is that very
little HW can actually implement it, having the alternative still
require HW support doesn't seem like progress.

I think we will eventually start seein some HW be able to do this
invalidation, but it won't be universal, and I'd rather leave it
optional, for recovery from truely catastrophic errors (ie my DAX is
on fire, I need to unplug it).

Jason
