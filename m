Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28629641B3B
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Dec 2022 07:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiLDG4d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 4 Dec 2022 01:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiLDG4c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 4 Dec 2022 01:56:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8E1167E7
        for <linux-ext4@vger.kernel.org>; Sat,  3 Dec 2022 22:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Er3vyZP2X6fRoptLXpTof1mG8yiaROtq+j9btWt7Srs=; b=Z7ctLOkquyILpSi+cQ+2v2IhmP
        iVOw6wLY/vDqQhUhgQul2JQJExevqyUS21vu1yqlW4GdGOnZoGUSp14auTVpQ0uDWj3QKgb+2662Y
        GzpC0b/6usMJ3Ue7PdMCj6zfWCMOoOf4EQTBiDV1knHsgQJdjbSL5AexXslRuyPYMvKhv5JjT3HgT
        Nku+mzICULU8CtP+mu52jf+CSSFyBUomuQStG0O4te2774Y9ZCVVhLrCeJhcd723oW3n3ZOql5a0o
        8ppjmtuV1TC63yUmUJDcpW6tIL6U+LWmLRnzYcS2iEqUZKk3+4D/2XeM6cU+OqRc7Kp6Kd2/m9KZa
        p3ZggDjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1ivJ-006qPy-Ky; Sun, 04 Dec 2022 06:56:25 +0000
Date:   Sat, 3 Dec 2022 22:56:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 0/11] ext4: Stop using ext4_writepage() for writeout
 of ordered data
Message-ID: <Y4xEmSsj7sNCrsVG@infradead.org>
References: <20221202163815.22928-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202163815.22928-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 02, 2022 at 07:39:25PM +0100, Jan Kara wrote:
> I have also modified ext4_writepages() to use write_cache_pages() instead of
> generic_writepages() so now we don't expose .writepage hook at all. We still
> keep ext4_writepage() as a callback for write_cache_pages().

Nice!

> We should refactor
> that path as well and get rid of ext4_writepage() completely but that is for a
> separate cleanup.

Agreed.

> Also note that jbd2 still uses generic_writepages() in its
> jbd2_journal_submit_inode_data_buffers() helper because it is still used from
> OCFS2. Again, something to be dealt with in a separate patchset.

Indeed.  I think simply moving jbd2_journal_submit_inode_data_buffers to
ocfs2 and then open coding generic_writepages will be the right thing to
do here.
