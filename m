Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB076D826D
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbjDEPrZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbjDEPrX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 11:47:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7D75FC3;
        Wed,  5 Apr 2023 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/a4RYFvjJCESxZnfN0nD29LBSxPBoE93Z5aSyhucaTc=; b=uZ5h4XuoSXe9+bgTWZvctsPSxL
        J8n1Ti8TOouo/7zVirWNYVC1UyJOxKJpvj0IV+068Sq2z4depUOryc2RPjsLDhDshySk3s1ERkMpO
        twG0PSY4Y9A4gHSqC5CiZ3DMrNnYamMfG6SDrpa5Hbgson6ObhdtRptTunuu6/oiaeD91NhGeqxl2
        LLiW0vhAwI9MzSnUyZBwOw1mxO39uzvhLDuMN7ocWBeWMY6tdeepv0CTpk6k8mMGLRIx/k4z9ngyj
        nvah9ZylV5D24DoACN/gpECeBwawUgtXs3FnYtThZl3pWf+dDadXNQQ65Tb5WLmAhQS1NHqb3/aKN
        ufVxLm9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pk5LR-004xwQ-0b;
        Wed, 05 Apr 2023 15:46:45 +0000
Date:   Wed, 5 Apr 2023 08:46:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, djwong@kernel.org,
        dchinner@redhat.com, ebiggers@kernel.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 05/23] fsverity: make fsverity_verify_folio() accept
 folio's offset and size
Message-ID: <ZC2X5YlHMxzZQzhx@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-6-aalbersh@redhat.com>
 <ZCxCnC2lM9N9qtCc@infradead.org>
 <20230405103642.ykmgjgb7yi7htphf@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405103642.ykmgjgb7yi7htphf@aalbersh.remote.csb>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 12:36:42PM +0200, Andrey Albershteyn wrote:
> Hi Christoph,
> 
> On Tue, Apr 04, 2023 at 08:30:36AM -0700, Christoph Hellwig wrote:
> > On Tue, Apr 04, 2023 at 04:53:01PM +0200, Andrey Albershteyn wrote:
> > > Not the whole folio always need to be verified by fs-verity (e.g.
> > > with 1k blocks). Use passed folio's offset and size.
> > 
> > Why can't those callers just call fsverity_verify_blocks directly?
> > 
> 
> They can. Calling _verify_folio with explicit offset; size appeared
> more clear to me. But I'm ok with dropping this patch to have full
> folio verify function.

Well, there is no point in a wrapper if it has the exact same signature
and functionality as the functionality being wrapped.

That being said, right now fsverity_verify_folio, so it might make sense
to either rename it, or rename fsverity_verify_blocks to
fsverity_verify_folio.  But that's really a question for Eric.
