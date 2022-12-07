Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA786454B6
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 08:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLGHiz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 02:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLGHiy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 02:38:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7297D338
        for <linux-ext4@vger.kernel.org>; Tue,  6 Dec 2022 23:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A/eq4/wgg2rp1ld2NuQJrWGKee0voE45fREibRm9FUw=; b=23zWkMQ0yZoj9k5q6yInfok+g/
        +eKXpmTUpvK26qhTXssR43JuDx5KaBiJ6Y4NTXmY0HQa+kg67H8C0xsxE1u4sQMzSHTqFEW/Ys8P/
        mFDKrC3SkxdtAyZwE/oQoTtumJn8SoMniscm4Xvvf2UTgV1L5+ni7CrYAdfWDSFm93XJOUyJ49fm+
        l2LQghB/ezZ/5gYC/0duKvJgq957XVDuc32bqlprarj5Zujk5O4sjl9LIA4NN3Op74jMqD09eOwhG
        UpSDAxvwZ3q8NeZ+Gq8/BEgYWysrMfu3UYmrtXwBZHV/ZAwmYNcpVnSj/XX8Rgo3eJtoQT47fCVfX
        d8G/iZfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2p10-00E760-PT; Wed, 07 Dec 2022 07:38:50 +0000
Date:   Tue, 6 Dec 2022 23:38:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH v3 11/12] ext4: Stop providing .writepage hook
Message-ID: <Y5BDCtdcZooiMhy5@infradead.org>
References: <20221205122604.25994-1-jack@suse.cz>
 <20221205122928.21959-11-jack@suse.cz>
 <Y460RpKTCDuPKWmN@mit.edu>
 <20221206105225.nr734teqlkueqdph@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206105225.nr734teqlkueqdph@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 06, 2022 at 11:52:25AM +0100, Jan Kara wrote:
> I don't expect any objection. The only reason we didn't export that
> function when I've added it was that only blkdev code was using it and that
> cannot be compiled as a module. Should I send a patch to 
> 
> I've added a patch to the series to export this function. It is attached.
> 
> I can also repost the whole series if these are the only changes that block
> the inclusion.

I'd do an EXPORT_SYMBOL_GPL, but otherwise the export looks fine, and it
would be good to get this conversion going!
