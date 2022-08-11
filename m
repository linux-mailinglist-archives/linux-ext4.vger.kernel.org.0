Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11E758FC47
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Aug 2022 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiHKMcI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Aug 2022 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiHKMcI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Aug 2022 08:32:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52C15FC9;
        Thu, 11 Aug 2022 05:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+79OYJ7Im3e/mOIoPsacqwpwN5j8t1RaVccTNFCO2Tc=; b=udlPWSl4q+UOuV63UwCECSA2Gg
        EvGfWKgpwVX9YxxbmO/zHGHwBDgqD1yFQl0PygKdjbW6A46o+x9Dz7fQ+TCd3182OG3Xgy2zob0bu
        DhSXbj2KUouhABsvgertx8nNuEeelSYtjab3KBO59fulnm28Z/NYFFfL7c/1putq43edcOMQmfkfg
        TXMuQq4kTVPs160v2dRcFU+gbGwqVRc13ryjAuA02X5ZkWm30kOo0UfSqJcOLqtiizY3H0bOYt86G
        vyk2GHmRj04zcRwIIqR9e+MwwDdtubicOM/8Iq/esjriqinLqXDUEVVlR+7VeEOXxdhnYdDy7u8I4
        N1oyRnxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oM7M2-00C942-P1; Thu, 11 Aug 2022 12:32:02 +0000
Date:   Thu, 11 Aug 2022 05:32:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     guaneryu@gmail.com, zlang@redhat.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] common/rc: move ext4-specific helpers into a
 separate common/ext4 file
Message-ID: <YvT2wslkHNKKuDY8@infradead.org>
References: <166007884125.3276300.15348421560641051945.stgit@magnolia>
 <166007884681.3276300.8815951431509313240.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166007884681.3276300.8815951431509313240.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 09, 2022 at 02:00:46PM -0700, Darrick J. Wong wrote:
> --- a/common/config
> +++ b/common/config
> @@ -512,6 +512,10 @@ _source_specific_fs()
>  		;;
>  	ext4)
>  		[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
> +		. ./common/ext4
> +		;;
> +	ext2|ext3|ext4dev)
> +		. ./common/ext4

Not really new in this patch, but why does ext4 check for a specific
mkfs and the others don't?

Also can we drop ext4dev while we're at it?

The patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
