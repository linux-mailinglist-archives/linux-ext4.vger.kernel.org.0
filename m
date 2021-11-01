Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0D3441E09
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Nov 2021 17:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhKAQYE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Nov 2021 12:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232416AbhKAQYE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Nov 2021 12:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9idZ9g7Qiy202IHm24WOcqzjkMEWV4Amwu/3bidfKY=;
        b=g4IfObkWcAJ4mvs2ONiuidAZEUQaazQjSNNGt8XybxZMaR43u+xuMeCJYHlhIKnnq77A5w
        MEX43WJiPTdk3PwDDLmghGTPtNAolYml7lStetlnKRDPVXEFQ8UY+YVQ1LYQskZpB3oGgJ
        0d10ClBng5lXnwOVzd3jOk460xZ2GP8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-ya6T2CCVNqed-oAfxV5gMg-1; Mon, 01 Nov 2021 12:21:28 -0400
X-MC-Unique: ya6T2CCVNqed-oAfxV5gMg-1
Received: by mail-qt1-f197.google.com with SMTP id v16-20020a05622a145000b002ac6641f41fso6782831qtx.23
        for <linux-ext4@vger.kernel.org>; Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E9idZ9g7Qiy202IHm24WOcqzjkMEWV4Amwu/3bidfKY=;
        b=keeOdByhQyexpy6FZAXnnAz9QQyYJS/I3K2vI6vWXpANTI4/QnYb/6yEgTbsKL3zir
         XEHKcNR5gvLbKEB5GQ9z17zSKj623OoyWo6oGR+RHAzzghzxvyf8qHI4/1QVSRGnUhz3
         kaia17tbcw72WqAAiZxxifHerFCASnxPuPkc+6sONY51rDygsit81Px+cFYCOlBa+SI/
         w2znqgVXIfQBbI4Io9Y8eYn9eU3ZNJH5XCz2XG/SgfOw9Cr5tNbnYCILTdyVrWGVC2FH
         MmT3hcFPH7mjoM3E9TGTlckIr1cKgmw2pEp/yTYdu59QNHPbuBXs6RLC+31WW9Zt4TpW
         9IuA==
X-Gm-Message-State: AOAM530UBAJ0DBWkwzB7eDUEN7EuQwLF+G17WorcTdm9I6tUXJNSBf8s
        29GIAs0YR5pvgHmPBa5xqA6LFqpc488f/nf9CfnVmWTxXfQIlUxLGf0q6WO6Tsh7oAY6MC1TGr8
        shVrxWr3YnipuIgsn/T1i
X-Received: by 2002:ac8:7d04:: with SMTP id g4mr30472035qtb.183.1635783688233;
        Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXhGf8N2V91WU2Co6WJDyYs4GGgkn9JXnS/oEwWuG4J0RZNo7zMUQJUBh2KgjI9ZclpX5QJg==
X-Received: by 2002:ac8:7d04:: with SMTP id g4mr30472009qtb.183.1635783688071;
        Mon, 01 Nov 2021 09:21:28 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id bj3sm2670847qkb.75.2021.11.01.09.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:21:27 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:21:26 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 10/11] dm-stripe: add a stripe_dax_pgoff helper
Message-ID: <YYAUBkiPlRCVPnyv@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-11-hch@lst.de>
 <CAPcyv4iLbbqyAsy1yjFXT48D3Ssp+jy4EMJt+Sj_o2W-WMgK9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iLbbqyAsy1yjFXT48D3Ssp+jy4EMJt+Sj_o2W-WMgK9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 27 2021 at  9:41P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a helper to perform the entire remapping for DAX accesses.  This
> > helper open codes bdev_dax_pgoff given that the alignment checks have
> > already been done by the submitting file system and don't need to be
> > repeated.
> 
> Again, looks good. Kind of embarrassing when the open-coded version is
> less LOC than using the helper.
> 
> Mike, ack?

Acked-by: Mike Snitzer <snitzer@redhat.com>

