Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE1D249AA0
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 12:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHSKmA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 06:42:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:56726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgHSKlm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Aug 2020 06:41:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B198CAC98;
        Wed, 19 Aug 2020 10:42:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2A2AA1E1312; Wed, 19 Aug 2020 12:41:39 +0200 (CEST)
Date:   Wed, 19 Aug 2020 12:41:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: Re: [RFC PATCH v2 3/5] ext4: data=journal: write-protect pages on
 submit inode data buffers callback
Message-ID: <20200819104139.GJ1902@quack2.suse.cz>
References: <20200810010210.3305322-1-mfo@canonical.com>
 <20200810010210.3305322-4-mfo@canonical.com>
 <20200819084421.GD1902@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819084421.GD1902@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 19-08-20 10:44:21, Jan Kara wrote:
> I was thinking about this and we may need to do this somewhat differently.
> I've realized that there's the slight trouble that we now use page dirty
> bit for two purposes in data=journal mode - to track pages that need write
> protection during commit and also to track pages which have buffers that
> need checkpointing. And this mixing is making things complex. So I was
> thinking that we could simply leave PageDirty bit for checkpointing
> purposes and always make sure buffers are appropriately attached to a
> transaction as dirty in ext4_page_mkwrite(). This will make mmap writes in
> data=journal mode somewhat less efficient (all the pages written through
> mmap while transaction T was running will be written to the journal during
> transaction T commit while currently, we write only pages that also went
> through __ext4_journalled_writepage() while T was running which usually
> happens less frequently). But the code should be simpler and we don't care
> about mmap write performance for data=journal mode much. Furthermore I
> don't think that the tricks with PageChecked logic we play in data=journal
> mode are really needed as well which should bring further simplifications.
> I'll try to code this cleanup.

I was looking more into this but it isn't as simple as I thought because
get_user_pages() users can still modify data and call set_page_dirty() when
the page is no longer writeably mapped. And by the time set_page_dirty() is
called page buffers are not necessarily part of any transaction so we need
to do effectively what's in ext4_journalled_writepage(). To handle this
corner case I didn't find anything considerably simpler than the current
code.

So let's stay with what we have in
ext4_journalled_submit_inode_data_buffers(), we just have to also redirty
the page if we find any dirty buffers.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
