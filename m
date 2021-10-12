Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098CF42AE17
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 22:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhJLUqN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Oct 2021 16:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232986AbhJLUqN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 12 Oct 2021 16:46:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DCA460E09;
        Tue, 12 Oct 2021 20:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634071451;
        bh=UOkTy92XzuCtUq8OKvsR+eNtXmbw0VxKGgOP+U8fxCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVY6saMQJHCva5gnZHW+oNKn5KwkmHfFZvnbQUROIgps+NAUt0Tnuj+AqsHJKGtfH
         3fHCTg5zhTRFQBkE9DaPyIvLq6BgZgb8SXieAuio3g+RKCNgXkgj2AWekbStG3HwQO
         r73rCEMYuTl8wf6CXc8IiMyvMrwhuH6CgKQ+huUJhcN/Cd4ktmC/prwq5eZL1v+ETb
         IsvtcWhHGrY9FzkjvlwajnHPvRPZeA42AML/j40oo9r6dOSZcDR8bpbC4byAHmVUWD
         m/NklUM8bXYUZEkRRenKS/x7vwBaC5D6GLTajdI2rjR8bYJGchfnXx2irIqrJjqJN9
         pi/uIraLvn+lw==
Date:   Tue, 12 Oct 2021 13:44:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Sierra <alex.sierra@amd.com>, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hch@lst.de, jgg@nvidia.com,
        jglisse@redhat.com, apopple@nvidia.com
Subject: Re: [PATCH v1 00/12] MEMORY_DEVICE_COHERENT for CPU-accessible
 coherent device memory
Message-ID: <20211012204410.GR24307@magnolia>
References: <20211012171247.2861-1-alex.sierra@amd.com>
 <20211012113957.53f05928dd60f3686331fede@linux-foundation.org>
 <YWXd0leFtLepunVa@casper.infradead.org>
 <1bcea911-58c6-c730-35b2-e8f1f8eddcd8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bcea911-58c6-c730-35b2-e8f1f8eddcd8@amd.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 12, 2021 at 04:24:25PM -0400, Felix Kuehling wrote:
> 
> Am 2021-10-12 um 3:11 p.m. schrieb Matthew Wilcox:
> > On Tue, Oct 12, 2021 at 11:39:57AM -0700, Andrew Morton wrote:
> >> Because I must ask: if this feature is for one single computer which
> >> presumably has a custom kernel, why add it to mainline Linux?
> > I think in particular patch 2 deserves to be merged because it removes
> > a ton of cruft from every call to put_page() (at least if you're using
> > a distro config).  It makes me nervous, but I think it's the right
> > thing to do.  It may well need more fixups after it has been merged,
> > but that's life.
> 
> Maybe we should split the first two patches into a separate series, and
> get it merged first, while the more controversial stuff is still under
> review?

Yes, please.  I've seen that first patch several times already. :)

--D

> Thanks,
>   Felix
> 
> 
