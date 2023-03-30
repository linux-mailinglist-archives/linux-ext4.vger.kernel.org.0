Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF96CF7EA
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Mar 2023 02:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjC3AFt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 20:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC3AFs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 20:05:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BD92D48
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 17:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wfcpaQZ1NDBaNRb61sEVJGMkagHxtXwTcJUTY0B3et8=; b=uSG35dPg5bu7ibnWLGeLQpJHqa
        8yPtmO3971hx+XX9CEY56D3mYtCF9fQCfXWNzJJRmOhrCvd0q8Pqt5zb9a/NoU0hKgELUa61W83Mg
        DO7+Arl8yPLU6bxdlwr1OBUtCv+yp6IIMtlOxtUphTW0xdh5OmooXsVvs55pSfcC7ls8cNlZVJUaD
        GonMCWtBGU7+13NaKSrbUVlmvE+Dtj7nsSiN0ZiatJ8vwjb3WW1AoAXstlPr+hVayI091POb+D1LT
        M2w3ZlmFvPciCpHwUQKNxr8GGNDT0eLlHgyMXp+guftXtnrrYm2tHenus7xSs9uAGC/ucmt+Q+POv
        IpHTMzYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phfnV-0027Kj-1M;
        Thu, 30 Mar 2023 00:05:45 +0000
Date:   Wed, 29 Mar 2023 17:05:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 06/13] ext4: Drop special handling of journalled data
 from ext4_sync_file()
Message-ID: <ZCTSWQk+8jxQckXG@infradead.org>
References: <20230329125740.4127-1-jack@suse.cz>
 <20230329154950.19720-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329154950.19720-6-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 29, 2023 at 05:49:37PM +0200, Jan Kara wrote:
>  	/*
> -	 * data=writeback,ordered:
>  	 *  The caller's filemap_fdatawrite()/wait will sync the data.
>  	 *  Metadata is in the journal, we wait for proper transaction to
>  	 *  commit here.

Nit: without the list, the two space indent looks a bit weird here.

>  	if (!sbi->s_journal)
>  		ret = ext4_fsync_nojournal(inode, datasync, &needs_barrier);
> -	else if (ext4_should_journal_data(inode))
> -		ret = ext4_force_commit(inode->i_sb);
>  	else
>  		ret = ext4_fsync_journal(inode, datasync, &needs_barrier);

Also if there is not journale the above comment doesn't make much sense.
But I'm really not sure the comment adds any value to start with, so
maybe just drop it entirely?
