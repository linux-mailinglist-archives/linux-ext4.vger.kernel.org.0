Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44C16D8282
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbjDEPtI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 11:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbjDEPtH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 11:49:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87D96A7B;
        Wed,  5 Apr 2023 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0N3bnEoqyxD9JBa9a3Jw/h398bdzAlmE4MCZrbnnAyo=; b=jOrY6DoC95aQn3Vv3VAZND7yl3
        m/hXKJSP8boSFOIai+u31LfUiKZoGUmX/xp4vPr2Sa4RL85kbsf6Lwnp3H3kLpt8V3g8BNHuYEXTQ
        wONj00nh8D1I8/iYMjQUF7yh8yBKD0gu19Rxi60u40GbOrJPRmpaFoCyRyO3aOYxAxoOytrqPRQb5
        99dNgh/6QHoQwvKeFp1L8sZLbahEtSmp0Wr0v0/2ug5W9kpxw2A9YkmVeQcxYuvP2zMfKAaisAzse
        ZbSboN0UYogpn15gaXKO0zCWpYuCPGAvWfMqKwR/k38KllD4rrVbRB9+Aidw4KtsBb8XxeGSYDpv4
        m6odhUjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pk5Mv-004zVF-1j;
        Wed, 05 Apr 2023 15:48:17 +0000
Date:   Wed, 5 Apr 2023 08:48:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, dchinner@redhat.com,
        ebiggers@kernel.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 09/23] iomap: allow filesystem to implement read path
 verification
Message-ID: <ZC2YQalRTGxzmNDK@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-10-aalbersh@redhat.com>
 <ZCxEHkWayQyGqnxL@infradead.org>
 <20230405110116.ia5wv3qxbnpdciui@aalbersh.remote.csb>
 <20230405150627.GC303486@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405150627.GC303486@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 08:06:27AM -0700, Darrick J. Wong wrote:
> > > I wonder if that also makes sense and keep all the deferral in the
> > > file system.  We'll need that for the btrfs iomap conversion anyway,
> > > and it seems more flexible.  The ioend processing would then move into
> > > XFS.
> > > 
> > 
> > Not sure what you mean here.
> 
> I /think/ Christoph is talking about allowing callers of iomap pagecache
> operations to supply a custom submit_bio function and a bio_set so that
> filesystems can add in their own post-IO processing and appropriately
> sized (read: minimum you can get away with) bios.  I imagine btrfs has
> quite a lot of (read) ioend processing they need to do, as will xfs now
> that you're adding fsverity.

Exactly.

> I think the point is that this is a general "check what we just read"
> hook, so it could be in readpage_ops since we're never going to need to
> re-validate verity contents, right?  Hence it could be in readpage_ops
> instead of the general iomap_folio_ops.
> 
> <shrug> Is there a use case for ->verify_folio that isn't a read post-
> processing step?

Yes.  In fact I wonder if the verification might actually be done
in the per-bio end_io handler in the file system.  But I'll need
to find some more time to read through the XFS parts of series to
come up with a more intelligent suggestion on that.
