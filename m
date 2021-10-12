Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDA842ACEE
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhJLTHP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Oct 2021 15:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234764AbhJLTFb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 12 Oct 2021 15:05:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC15E60E09;
        Tue, 12 Oct 2021 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634065405;
        bh=41ZgXWvJqX6cNDtIQEONvKgmB5mmWoA3gdKQ9esdOVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0blFRlQK51dgu5FJKOqFr1L6t3mVBbILK25yhOQvYbDuiPk4p/Xlmnu0gZa3KlXFG
         piH0prBBWaQ3m2nPz29jPiijWku3bv4yF077HespUJB5jDIWOWf1wBVn/h4JIWCJTW
         NDX7+IpzU2qmix0bc6QUcCtixPz37PA42oiuSsT8=
Date:   Tue, 12 Oct 2021 12:03:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com
Subject: Re: [PATCH v1 00/12] MEMORY_DEVICE_COHERENT for CPU-accessible
 coherent device memory
Message-Id: <20211012120322.224d88dad0188160a40dd615@linux-foundation.org>
In-Reply-To: <20211012185629.GZ2744544@nvidia.com>
References: <20211012171247.2861-1-alex.sierra@amd.com>
        <20211012113957.53f05928dd60f3686331fede@linux-foundation.org>
        <20211012185629.GZ2744544@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 12 Oct 2021 15:56:29 -0300 Jason Gunthorpe <jgg@nvidia.com> wrote:

> > To what other uses will this infrastructure be put?
> > 
> > Because I must ask: if this feature is for one single computer which
> > presumably has a custom kernel, why add it to mainline Linux?
> 
> Well, it certainly isn't just "one single computer". Overall I know of
> about, hmm, ~10 *datacenters* worth of installations that are using
> similar technology underpinnings.
> 
> "Frontier" is the code name for a specific installation but as the
> technology is proven out there will be many copies made of that same
> approach.
> 
> The previous program "Summit" was done with NVIDIA GPUs and PowerPC
> CPUs and also included a very similar capability. I think this is a
> good sign that this coherently attached accelerator will continue to
> be a theme in computing going foward. IIRC this was done using out of
> tree kernel patches and NUMA localities.
> 
> Specifically with CXL now being standardized and on a path to ubiquity
> I think we will see an explosion in deployments of coherently attached
> accelerator memory. This is the high end trickling down to wider
> usage.
> 
> I strongly think many CXL accelerators are going to want to manage
> their on-accelerator memory in this way as it makes universal sense to
> want to carefully manage memory access locality to optimize for
> performance.

Thanks.  Can we please get something like the above into the [0/n]
changelog?  Along with any other high-level info which is relevant?

It's rather important.  "why should I review this", "why should we
merge this", etc.

