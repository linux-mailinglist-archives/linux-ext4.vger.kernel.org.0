Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4473D542A8F
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jun 2022 11:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiFHJFL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jun 2022 05:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiFHJCi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jun 2022 05:02:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD84959319;
        Wed,  8 Jun 2022 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=FO21TYVkz1GrrEA1IBdTPO89xn
        0ZhoZYnarKm0rAuq/YROa1HKdkFK7QK0hedDX/nrx+C0C2WNrc/8GnSud7y6U9FtPf82+dd7N0Y3l
        YkFhhl+68leXo0KExqTjSVhImfkr7x818ptZ7rQAQnAkTTOK+3RQ8NAQ4BjzwC9dwB3ryaKIKFgst
        1az6zm3xoKy7M0JoPyTQjX3ItTvX0lzR7C46szzxNnX5fxrRlYwh8C8eGy+4fFWsfWohqoXnJV1lk
        NUoZvYeV3VZL9xeXVFDRQELmcTse8V//KXOCpI/WLAYTfRuTB+WtV9TBIRC4l0VSz8+pKNnzTprVG
        gQVinkwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyqrs-00BsOk-6N; Wed, 08 Jun 2022 08:16:44 +0000
Date:   Wed, 8 Jun 2022 01:16:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 06/20] btrfs: Convert btree_migratepage to migrate_folio
Message-ID: <YqBa7ENPoZ1ofJZj@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606204050.2625949-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
