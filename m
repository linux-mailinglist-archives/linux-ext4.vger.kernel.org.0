Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929B16D675E
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjDDPcV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjDDPcT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 11:32:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F11985;
        Tue,  4 Apr 2023 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H6mc1gZhtXSneS6nte5uW4UZFELa9ivi94Hze/v8bew=; b=kS4170334H5m+oxgCVnmmbfs8Z
        HGcIrZO4ewhSv2x0uhcAurkfo8ppu67vASYNQq3Qd/M7iEqY5WYIWA/GGhfxTL0EqayVfGzm0ZgHC
        RchX/7zGEAnuEBysywlPXrCE17YdeutDLtHd4/UKlCfF6zaadmNmMBQRlJl7JNc1aJGI1/8ZBFQSX
        oTFeOYFfjZrVqlcF0ADAK6KzacZHHooO5I7DqGlmnK4NjCY3zQqecMMXo+G0O9qTZWVipvtosDIJI
        LaE1ceqK0n3y/4ZeJwIN/yytH+VCppgyUpHfoyunWwsKECUUoQYnJ48JKxsRMHBOhpLOZ0mtdfMi1
        q75JIVDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjidr-0020pf-02;
        Tue, 04 Apr 2023 15:32:15 +0000
Date:   Tue, 4 Apr 2023 08:32:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 08/23] iomap: hoist iomap_readpage_ctx from the
 iomap_readahead/_folio
Message-ID: <ZCxC/pQixOq03ltH@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-9-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-9-aalbersh@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 04, 2023 at 04:53:04PM +0200, Andrey Albershteyn wrote:
> Make filesystems create readpage context, similar as
> iomap_writepage_ctx in write path. This will allow filesystem to
> pass _ops to iomap for ioend configuration (->prepare_ioend) which
> in turn would be used to set BIO end callout (bio->bi_end_io).
> 
> This will be utilized in further patches by fs-verity to verify
> pages on BIO completion by XFS.

Hmm.  Can't we just have a version of the readpage helper that just
gets the ops passed instead of creating all this boilerplate code?

For writepage XFS embedds the context in it's own structure, so it's
kindof needed, but I don't think we'll need that here.
