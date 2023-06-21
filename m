Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB7273883B
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jun 2023 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjFUO7n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jun 2023 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjFUO72 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Jun 2023 10:59:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484A759E0;
        Wed, 21 Jun 2023 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/W9/jheQC0PHbu/G7Ry1IA2jeRwbRtdjPyXtz1VtfZU=; b=NP43NA6WiK1NEH+AXeeePXx1KS
        +TOGx6wqsJEFvgV9223aZqy6G7x/RmM9rIjKEjRl+e08eatmp4Jxwha+/YIi3CNR6CqttzGTUecu3
        ypicgGx+T3FFpHwBwYSJ2ig1Ka2sxSV65Ind5fVa0RHSkLVJhjP4a1Vd9lcID9rh9UsfetK1Usd6t
        26/ioXY05c20nbeUUXUfb2R+BSPK1dgDYURmmhVdUay87p41PRV9+c1Pm9Y1fHeUCCS2AMBECty6y
        YygaoIeauCXDaBmb5kkelLvx1L4zo1E6UQfRbokM3gFRMpsKy4bAQop+VA7c+hQ53IuwDH907qJ3o
        3pJTQSxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qBzD3-00EsAK-0Z;
        Wed, 21 Jun 2023 14:53:25 +0000
Date:   Wed, 21 Jun 2023 07:53:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: Fix crash in ext4_bdev_mark_dead()
Message-ID: <ZJMO5Qm3n0Eg8uam@infradead.org>
References: <20230621144354.10915-1-jack@suse.cz>
 <20230621144744.1580-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144744.1580-2-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 21, 2023 at 04:47:43PM +0200, Jan Kara wrote:
> xfs_bdev_mark_dead() passes bdev->bd_holder to ext4_force_shutdown()
> instead of bdev->bd_super leading to crashes. Fix it.

xfs_bdev_mark_dead is only called for the log and RT devices, for which
the mp is passed as holder to blkdev_get_by_path.  bd_super won't be
set for those devices, so this patch will introduce a crash and not fix
one.
