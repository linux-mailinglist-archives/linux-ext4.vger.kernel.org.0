Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA0998820
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2019 01:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfHUXts (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Aug 2019 19:49:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45380 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbfHUXtr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Aug 2019 19:49:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id k13so5300131qtm.12
        for <linux-ext4@vger.kernel.org>; Wed, 21 Aug 2019 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Dz6lpgjK94wsk5MHL4jboQE1NnpsCOBFBvUAahO07A=;
        b=gPyjbbOlWbFMNLNEHlm3dVB7Uzz3AKtizx4gilO4AsJS5UDSi7tKtuKLliMJh4+rPu
         1Jf/sMigbAhn4QGVmiCQ6jvV0hXBmnUimeqP0xUMpcAFxLHy5mSvYZ2fitBb6fMv1QEd
         cZ2rJhYAzO91SSmOVmphbBBxbh+HSxrYlvJ3tgnRnP1JDEhZkz5GiMo9UEiNo9GyVRUF
         8WnH6kAl7p/wnpPhgEWF5q/2JAvm1wPyF94nsUIZ3Nn/qacJn/LeA6n513wpAcQCJroq
         gRk02pguSic3ESpZjlGMGpJT0L4SvQqRx3eSvDn9QgwMdBegopEE9vJkJ6UvTjj8CtPC
         e/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Dz6lpgjK94wsk5MHL4jboQE1NnpsCOBFBvUAahO07A=;
        b=YaY502BWRver6NlIRsRxejDtLIE9JjFxvCHdH42+6RfzQ72unXTWpS0cYq1v+ZUFwU
         pk/B+tTQkrx/sKJEx88GZJL6lxLyVYrp46eMAco5+9AreyYBXpvnFHlGtB38p9YSgnYt
         C1ppYdZQxhBTHxDfKnItUpuW2T98KzXwHbyR0ZuSsnvnVFtu4t7Q88GRPeaufIGdKHKi
         RqmWL4gK3keN6Ge8OtfpgbHWAoF3ZA/3dW9y1Dm+wcvK7YagauRRvMi7W3x1TBMiGD1F
         FhJ9KoUxoPd+AFkXpHV1cGhhzEKb4Vt9SdMyP4Tk2EeMHbkE6Ez5ZqNAn6/lFOqz7Vqr
         L8Ww==
X-Gm-Message-State: APjAAAVcUy9c0tkMGSLN8RQfpHL3iqxIWEB4mYHNIynPV8MX1H0J2F3r
        /UFjsvhLT7JmublhuUSS9e3/4Q==
X-Google-Smtp-Source: APXvYqydXtesxNmJNprP51Mg7fYbplLAQObHr5i5Uy4KKN0cJaAIkir0EBD/uw5rTQeKc1g+BuOcEQ==
X-Received: by 2002:ac8:22ac:: with SMTP id f41mr33955957qta.362.1566431386704;
        Wed, 21 Aug 2019 16:49:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 125sm11156870qkl.36.2019.08.21.16.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 16:49:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0aML-0008RC-Ks; Wed, 21 Aug 2019 20:49:45 -0300
Date:   Wed, 21 Aug 2019 20:49:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190821234945.GA31944@ziepe.ca>
References: <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 21, 2019 at 01:44:21PM -0700, Ira Weiny wrote:

> > The order FD's are closed during sigkill is not deterministic, so when
> > all the fputs happen during a kill'd exit we could end up blocking in
> > close(fd) as close(uverbs) will come after in the close
> > list. close(uverbs) is the thing that does the dereg_mr and releases
> > the pin.
> 
> Of course, that is a different scenario which needs to be fixed in my patch
> set.  Now that my servers are back up I can hopefully make progress.  (Power
> was down for them yesterday).

It isn't really a different scenario, the problem is that the
filesystem fd must be closable independenly of fencing the MR to avoid
deadlock cycles. Once you resolve that the issue of the uverbs FD out
living it won't matter one bit if it is in the same process or
another.

Jason
