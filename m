Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126EB641B40
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Dec 2022 08:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLDHGy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 4 Dec 2022 02:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiLDHGv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 4 Dec 2022 02:06:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E1718346
        for <linux-ext4@vger.kernel.org>; Sat,  3 Dec 2022 23:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9G2RY6NvCFJf3gpw1eSTl3Jfm+d9uU1HCpKEJ4d5hKw=; b=vlAe9uMAVB8zwU8ab/+9gwIenE
        8LHSWOh+I8b7YWcdp16nH4sd+QARZRpBbezGdxypOayMKB5WOvTlqHUAM68QEmYTktzrLSibzUOiA
        5RSBYv2XdQY9B0NzLj4NU6AUhKPWYIG9NU8yUxG6SYx6tMR1Kjpa9zlH4+fUqbljnu6Gmys73MJIL
        7yoTgc91Po+SexNL/LVdgN5Ph6cWskr5G0G1ZBprAeascEPvWAqXnVAEabMm2o6ADKrzrPTf+DvxG
        giV9/cOJw3EHX74de70TEnM6IRVEKFt5nnhWlasa+GRu9U4ISj0n6m9frzpiN8ruirWZbtcjnTZVZ
        h0KHjjdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1j5L-006qzO-F3; Sun, 04 Dec 2022 07:06:47 +0000
Date:   Sat, 3 Dec 2022 23:06:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 1/11] ext4: Remove ordered data support from
 ext4_writepage()
Message-ID: <Y4xHB+fDxyfOCwu5@infradead.org>
References: <20221202163815.22928-1-jack@suse.cz>
 <20221202183943.22640-11-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183943.22640-11-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> + * This function is now used only when journaling data. We cannot start
> + * transaction directly because transaction start ranks above page lock so we
> + * have to do some magic.
>   */
> +static int ext4_writepage(struct page *page, struct writeback_control *wbc,
> +			  void *data)

Maybe call this ext4_journalled_writepage now to make the limitation
more clear?  And/or fold __ext4_journalled_writepage into while we're
at it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
