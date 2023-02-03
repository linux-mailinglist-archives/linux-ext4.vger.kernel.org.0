Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8E68994A
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Feb 2023 13:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjBCM7x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Feb 2023 07:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjBCM7u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Feb 2023 07:59:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3B5E06A
        for <linux-ext4@vger.kernel.org>; Fri,  3 Feb 2023 04:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675429144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/GfsblX7fiP9DoE1ZO7fPATr7amcWgTVW69Pie1Ifo=;
        b=bcQ4TtAK//DTdGyPJXhcQ/EsNSQCoJpUq1TYxJ6QyUnM4AiaXuBIMTvwIGqconnvFeoqLe
        2ZmvMTcSwF/9vtgDYT7nPT1C8MBKBFEPm7pg8TscL7ywHC738GK9eFpE9zIvAEOMlBSNkr
        MkgOQHmeUIYWXc5PNHxWQETEd/PeZ7A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-AmBDV9cMMX60F0efGdr5iQ-1; Fri, 03 Feb 2023 07:59:03 -0500
X-MC-Unique: AmBDV9cMMX60F0efGdr5iQ-1
Received: by mail-qt1-f198.google.com with SMTP id p6-20020a05622a048600b003b9a3ab9153so2550852qtx.8
        for <linux-ext4@vger.kernel.org>; Fri, 03 Feb 2023 04:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/GfsblX7fiP9DoE1ZO7fPATr7amcWgTVW69Pie1Ifo=;
        b=CM3xpaB7DGAHFUGC8xyy7QY0NfiE72IXssZhPBC6hR39wgJFb/d1rWcDw55NjbEykk
         QZDnu1RJmcbZSKUHkPK1fOD255akMdQ/XfgJmnPVksC6UeVIsH0zn8jSbGDOKbxGq74c
         W5NjR6r0s9Hh4qA5iQ55Pgj9x6UOeYv9dXQvM8Asz9cOUeH3e1siFOls8aC6BnDlW4xs
         IW3Snp7TySo9DH/7bRHzjvOtllHWkuzocWd6E3VKp8vYF9vRnh3ePP8CmwBtq+5yXyzV
         tidlC0DfVDtS4MQcok6/wXTU/zPiMqkbgiG51iLKig+mOtQNSDenZ/9wiOQb80QK6gF1
         td0g==
X-Gm-Message-State: AO0yUKUuSVse/OGxKFPsg0h2RdDnY0poy4lzkyJMAVS+frN5Ygi5kppd
        /mA5067bZ2ZETOMp6MdpP1cfp71omHM5dYE7OAK7smgnzvMDI6owWEcPAWEboJ3VNIDrlKxYGyT
        bPbj3FIUH4ZcqZ3UyNDJXBQ==
X-Received: by 2002:ac8:58cd:0:b0:3b8:2b4e:cbca with SMTP id u13-20020ac858cd000000b003b82b4ecbcamr18450057qta.14.1675429142840;
        Fri, 03 Feb 2023 04:59:02 -0800 (PST)
X-Google-Smtp-Source: AK7set+JyEdhHV/y5OUx3a+8bJXzRzBigiwKr1DH/5NMkcZ56KgssbeiFk8LATo8Xmxpy2fqUTwKEQ==
X-Received: by 2002:ac8:58cd:0:b0:3b8:2b4e:cbca with SMTP id u13-20020ac858cd000000b003b82b4ecbcamr18450031qta.14.1675429142619;
        Fri, 03 Feb 2023 04:59:02 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id x8-20020ae9e908000000b0072526a43ef7sm1689338qkf.120.2023.02.03.04.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:59:01 -0800 (PST)
Date:   Fri, 3 Feb 2023 08:00:16 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] truncate: Zero bytes after 'oldsize' if we're
 expanding the file
Message-ID: <Y90FYG+tNtBIl62S@bfoster>
References: <20230202204428.3267832-1-willy@infradead.org>
 <20230202204428.3267832-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202204428.3267832-2-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 02, 2023 at 08:44:23PM +0000, Matthew Wilcox (Oracle) wrote:
> POSIX requires that "If the file size is increased, the extended area
> shall appear as if it were zero-filled".  It is possible to use mmap to
> write past EOF and that data will become visible instead of zeroes.
> This fixes the problem for the filesystems which simply call
> truncate_setsize().  More complex filesystems will need their own
> patches.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/truncate.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 7b4ea4c4a46b..cebfc5415e9a 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -763,9 +763,12 @@ void truncate_setsize(struct inode *inode, loff_t newsize)
>  	loff_t oldsize = inode->i_size;
>  
>  	i_size_write(inode, newsize);
> -	if (newsize > oldsize)
> +	if (newsize > oldsize) {
>  		pagecache_isize_extended(inode, oldsize, newsize);
> -	truncate_pagecache(inode, newsize);
> +		truncate_pagecache(inode, oldsize);
> +	} else {
> +		truncate_pagecache(inode, newsize);
> +	}

I don't think this alone quite addresses the problem. Looking at ext4
for example, if the eof page is dirty and writeback occurs between the
i_size update (because writeback also zeroes the post-eof portion of the
page) and the truncate_setsize() call, we end up with pagecache
inconsistency because pagecache truncate doesn't dirty the page it
zeroes.

So for example, with this series plus a nefariously placed
filemap_flush() in ext4_setattr():

# xfs_io -fc "truncate 1" -c "mmap 0 1k" -c "mwrite 0 10" -c "truncate 5" -c "mread -v 0 5" /mnt/file
00000000:  58 00 00 00 00  X....
# umount /mnt/; mount <dev> /mnt/
# xfs_io -c "mmap 0 1k" -c "mread -v 0 5" /mnt/file 
00000000:  58 58 58 58 58  XXXXX

Brian

>  }
>  EXPORT_SYMBOL(truncate_setsize);
>  
> -- 
> 2.35.1
> 
> 

