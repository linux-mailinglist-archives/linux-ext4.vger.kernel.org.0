Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307DD738837
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jun 2023 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjFUO6q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jun 2023 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjFUO60 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Jun 2023 10:58:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D555D525A;
        Wed, 21 Jun 2023 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P/S1P3OMvt32FkOL+BS2zKSFIy8MKzwk7N4UYyercEI=; b=1XKsiTjjucNPkB1y4htZ+KeKzl
        ng924PIgrB8Hr7841puBQKkoiIhrehLLPg6c2Dv1uOly/e5ynDFbtmMStFZrDZeaTg3Bj//kj2h79
        4glnzbay+OGhzBNoqrRDJJ4SP7c3gt7I3DqWmeluekCMFkhTab6dwyIUYuiGPZ8boj9w8VUYz5FSU
        01KchMUfQsa+xkQkXEoPHGHEKMdtVS+DDNyNPCNZyeIDqJrtCujgVslNWWnLANhaGCpqDVNubAaXu
        b6Hwx130i9rfva2YMz39pnK7/5YNWk+0imh8f8Ndd3qGpwYjsUh5+oeGAp/QataEBzLf2HselRgd2
        PDHmAT0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qBzC7-00Es1Y-0C;
        Wed, 21 Jun 2023 14:52:27 +0000
Date:   Wed, 21 Jun 2023 07:52:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: Fix crash in ext4_bdev_mark_dead()
Message-ID: <ZJMOqynQKadyBOXX@infradead.org>
References: <20230621144354.10915-1-jack@suse.cz>
 <20230621144744.1580-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144744.1580-1-jack@suse.cz>
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

On Wed, Jun 21, 2023 at 04:47:42PM +0200, Jan Kara wrote:
> ext4_bdev_mark_dead() passes bdev->bd_holder to ext4_force_shutdown()
> instead of bdev->bd_super leading to crashes. Fix it.

How does this crash? ext4_blkdev_get passes the sb as holder, and I
actually tested this code.

This is not to be confused with the blkdev_get_by_path in get_tree_bdev,
but that never ends up in ext4_bdev_mark_dead.
