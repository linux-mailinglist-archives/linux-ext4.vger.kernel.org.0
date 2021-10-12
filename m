Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36D42AD10
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhJLTO5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Oct 2021 15:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhJLTO5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Oct 2021 15:14:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A781C061570;
        Tue, 12 Oct 2021 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DGWkbX/ZaEgRg7DRsLzrp9kIM60erHIxN+TZn8qPeGQ=; b=jufBdZSxirHSMU+jB+dOMAAzhO
        W5IV8MgdAw4khwIx6y6ygsZtrLZwKJVRD4JEtjwZLgaXvJ897DXP/epRStK+/+ovfOX0G919Brkr/
        x5gvSmZlPhvSdgqPj0NJgInaCNMA22qr8ULAI/bxEUattTNuOlZVeIAyrTfylH/izyBdUk04R5u7X
        bI9kqHFIPtbYyHxIX8xVXyBGOYpkKQ0C9dPtgzcGbroNxx4W2GN9MyPi/yKdOPcjNydxglA9ZHKyZ
        ZKo16MMcvtZKxBiEtOhc3LWdcpfJ1dM6yOuPHZnomIpMHDCRLjThDNZNlDtjfEdN4WjxxN5RdLD8Z
        bv4uqz0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maNBC-006lpm-KI; Tue, 12 Oct 2021 19:11:36 +0000
Date:   Tue, 12 Oct 2021 20:11:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com, apopple@nvidia.com
Subject: Re: [PATCH v1 00/12] MEMORY_DEVICE_COHERENT for CPU-accessible
 coherent device memory
Message-ID: <YWXd0leFtLepunVa@casper.infradead.org>
References: <20211012171247.2861-1-alex.sierra@amd.com>
 <20211012113957.53f05928dd60f3686331fede@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012113957.53f05928dd60f3686331fede@linux-foundation.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 12, 2021 at 11:39:57AM -0700, Andrew Morton wrote:
> Because I must ask: if this feature is for one single computer which
> presumably has a custom kernel, why add it to mainline Linux?

I think in particular patch 2 deserves to be merged because it removes
a ton of cruft from every call to put_page() (at least if you're using
a distro config).  It makes me nervous, but I think it's the right
thing to do.  It may well need more fixups after it has been merged,
but that's life.
