Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42ED01AD2D
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2019 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfELQwi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 May 2019 12:52:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43144 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfELQwi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 12 May 2019 12:52:38 -0400
Received: by mail-qk1-f193.google.com with SMTP id z6so5802760qkl.10
        for <linux-ext4@vger.kernel.org>; Sun, 12 May 2019 09:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tv7+SbtJTW406Xn58+T3o8cNYwcZMfaM6OpdKpHHAGI=;
        b=LdjVsrrLDOgfBPPdsAMAWHVj2MNhuuuvf0T0jOIHES2NJmZzhkzvvFhSfRG/XMAUU1
         pVyrBWzwwH29jUjQfaLlsPTbDfV6LQ292yb6KrUFgt6ymV9HXwcB/SueLoX5jR5Rp/K4
         4mQhjpg/WabmcXWyVCJf5u28JyviiyyLEdaFee1gzFmTWmvCLKOG/6nrwm1rwvp31fYq
         UwpeAeveLBFN+6/fUWDSJmV8PJ7mpCsAjGrHfoupmID651Nlg01FWfdBq7LHCizx2D3n
         RbKOiJriDzUVslwOcFM66KihksNg8b7TdGwCqU8u9WbMUJjYUje3iJqiqe0AeolnKryU
         mGdw==
X-Gm-Message-State: APjAAAW4KnOcQZdve+LULNKDRDFm40f7LHolFxoJ9QilQTBcsD3+5OIR
        fry0DLjgFloyh+G1IA6vTECO+w==
X-Google-Smtp-Source: APXvYqxk9SXE+foxB/6DAoFm93oskr+MiF5xkYgB0SEkfaz8myE/mnL8/ZXigyA4Y2k8vy6g71yM+Q==
X-Received: by 2002:a37:9fcb:: with SMTP id i194mr18869154qke.258.1557679957115;
        Sun, 12 May 2019 09:52:37 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id o37sm4708706qta.86.2019.05.12.09.52.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 12 May 2019 09:52:36 -0700 (PDT)
Date:   Sun, 12 May 2019 12:52:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        KVM list <kvm@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christoph Hellwig <hch@infradead.org>,
        Len Brown <lenb@kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        jmoyer <jmoyer@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        david <david@fromorbit.com>, cohuck@redhat.com,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Adam Borowski <kilobyte@angband.pl>,
        yuval shaia <yuval.shaia@oracle.com>, jstaron@google.com
Subject: Re: [PATCH v8 0/6] virtio pmem driver
Message-ID: <20190512125221-mutt-send-email-mst@kernel.org>
References: <20190510155202.14737-1-pagupta@redhat.com>
 <CAPcyv4joEZaePvzc__N9Q3nozoHgQn7hNFPjBVo5BP6cc4rkEA@mail.gmail.com>
 <1909759746.28039539.1557531183427.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1909759746.28039539.1557531183427.JavaMail.zimbra@redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 10, 2019 at 07:33:03PM -0400, Pankaj Gupta wrote:
> 
> > >
> > >  Hi Michael & Dan,
> > >
> > >  Please review/ack the patch series from LIBNVDIMM & VIRTIO side.
> > >  We have ack on ext4, xfs patches(4, 5 & 6) patch 2. Still need
> > >  your ack on nvdimm patches(1 & 3) & virtio patch 2.
> > 
> > I was planning to merge these via the nvdimm tree, not ack them. Did
> > you have another maintainer lined up to take these patches?
> 
> Sorry! for not being clear on this. I wanted to say same.
> 
> Proposed the patch series to be merged via nvdimm tree as kindly agreed
> by you. We only need an ack on virtio patch 2 from Micahel.
> 
> Thank you for all your help.
> 
> Best regards,
> Pankaj Gupta

Fine by me.

> > 
