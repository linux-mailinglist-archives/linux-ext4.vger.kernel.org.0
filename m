Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5B6DF5C0
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjDLMmi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjDLMmS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 08:42:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBEB7EC1;
        Wed, 12 Apr 2023 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ddg0vAHFen4K0AUyZN8TD9RJ8e2AKTjO8ch3srJurzE=; b=0NE81cyrNaY13C8K9Ohz51hMMT
        H8xLDlox7rtYU3JMpi/o1SAdWWlvObLHFQJfTqJCbAGM9dcW5OL8gHOZ2ZyXZ5JEpZ35YBRQ/SJDw
        Awg6JdUVWLxnk5KF/M2Zl8rnE5rVIWXzbsN5geWGxL03pJgn+yPqrtFK/f1rScaWvqKNiob9Q1uq4
        zwBzDQd4VSvi9A91DWhyreN5V2CWY4ROZWwPn6JruDwiEvPhDvD3Tdms4YsiY3X3AIsTMbXL2g90M
        hMjXbvq2r3mP+FN6fVrvENh5aI7Debl3VW76+MlDBh6fTbdSchuGtO8uG4TwA5+cmLhI6OwLIqLCA
        8ozb6KTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pmZnb-003BFA-1a;
        Wed, 12 Apr 2023 12:42:07 +0000
Date:   Wed, 12 Apr 2023 05:42:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrey Albershteyn <aalbersh@redhat.com>, djwong@kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <ZDanH46VI7KmQeSV@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <ZDTt8jSdG72/UnXi@infradead.org>
 <20230412023319.GA5105@sol.localdomain>
 <20230412031826.GI3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412031826.GI3223426@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 12, 2023 at 01:18:26PM +1000, Dave Chinner wrote:
> Right. It's not entirely simple to store metadata on disk beyond EOF
> in XFS because of all the assumptions throughout the IO path and
> allocator interfaces that it can allocate space beyond EOF at will
> and something else will clean it up later if it is not needed. This
> impacts on truncate, delayed allocation, writeback, IO completion,
> EOF block removal on file close, background garbage collection,
> ENOSPC/EDQUOT driven space freeing, etc.  Some of these things cross
> over into iomap infrastructure, too.

To me that actually makes it easier to support the metadata beyond
i_size.  Remember that the file is immutable after add fsverity
hash is added.  So basically we just need to skip freeing the
eofblocks if that flag is set.
