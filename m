Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39394641B3D
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Dec 2022 07:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLDG7M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 4 Dec 2022 01:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiLDG7L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 4 Dec 2022 01:59:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A8B19C21
        for <linux-ext4@vger.kernel.org>; Sat,  3 Dec 2022 22:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h5gOa+zBeoJDrpaGHnhNgEFDklwXxuJATZOupDqVXv8=; b=ig81CPmD+TQ5cdBitdcFwQHRQH
        RDAwitLQUOBjWqMJ/dEmtPEuvhIjRmQ0qB4FxkRe73k8tpNR62wQIAH5KD5E3Wq+K2fHYIPDYNc9r
        sEttHuUlxl+NbPIw14wEiKt2bZJe4al0E6nr7OK9zll6LLj70lQDA5rnw0t1BIihf/NfBPYcS3dp+
        pppnqNFLOg9pb9Zxabq2lBg+TKV0zrYuBqilHFBlAD5f5/V71uwC9Lz9/1Z2mzr3hqKGi0lf8Rwn/
        l4BM+Wy68SLdxgI+oS8dW2xi5T7oeyyZLBb7GYzjKp+I0cJ4BF/2GhkY6+uciLSzpW3tFkL0oFH0c
        Zc1tz0ZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1ixv-006qX9-QJ; Sun, 04 Dec 2022 06:59:07 +0000
Date:   Sat, 3 Dec 2022 22:59:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 0/11] ext4: Stop providing .writepage hook
Message-ID: <Y4xFO0PcgYQeNb05@infradead.org>
References: <20221202163815.22928-1-jack@suse.cz>
 <20221202183943.22640-10-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183943.22640-10-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 02, 2022 at 07:39:35PM +0100, Jan Kara wrote:
> Now we don't need .writepage hook for anything anymore. Reclaim is fine
> with relying on .writepages to clean pages and we often couldn't do much
> from the .writepage callback anyway. We only need to provide
> .migrate_folio callback for the ext4_journalled_aops - let's use
> buffer_migrate_page_norefs() there so that buffers cannot be modified
> under jdb2's hands.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

