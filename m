Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDA167644
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2019 23:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfGLVj0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jul 2019 17:39:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39429 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfGLVj0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Jul 2019 17:39:26 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so23546863ioh.6
        for <linux-ext4@vger.kernel.org>; Fri, 12 Jul 2019 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SI4920KClKNHt7+dK/ZA2u8LWSZLFSdEOQjkAxQjmcg=;
        b=uFAHXEcUmgvbNE/zQLYk2GglrEBlZzBZOlPScnZwJvixgjq+NRDqPOaVjBp3h90DDw
         BL56nfBvQBo/Q8WnxPp/peoHoSbnndB06lPCU/kPkL0molzdsM5pDDhrEKpnDVZlULA4
         LTs4Ib/16hrVzL0AMN3QB3b/V2ei6AQXLjOqq0l5DVJpR3AS42dcB17wmZglukrt8Ex/
         0+P3a6l3m8s/ePcXurbJkR80xFoXAJqgbZNB29Y/vGAHmMlmycj5PdKVs+VcZZz+hLzv
         SmZFrPAuL4HxK5jjrpsj7x/bSupUUDOknlYxTvvNgGn3bxifwawekT9mblDUdMkTQAof
         Wlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SI4920KClKNHt7+dK/ZA2u8LWSZLFSdEOQjkAxQjmcg=;
        b=rWswGXUZq6pBu1UX+YzDXzcWPVfpQxHCTBe5aravcXRwKfxCtO+EBZghlOWz/0gDFu
         UrrV8Hk7hpOiOW5bS84j7qc/OdRARFoNWuR/jlrjSFjrE+aP3crt8VMFQsWqrBvVpgaL
         NfEIFGdbxlAG2Mu7QVgdgQkazy5M73L2wwo5dM49QPDcm/1ALwSS1DFSX1mN8UyZtQZ3
         qNP+DQozZ3N7UIlMC2VLTvYwqr04uUghnvbFNpgX+/0UYka33FZxwAsuyyhhUJWXowLv
         RSV/Gs6xIbIZmrswETN95JkgPRXAPaQMVm8zCHbqT5yO9Oi5Fag4DrGKVXS9hQ0oGehY
         PWVQ==
X-Gm-Message-State: APjAAAWvM9Sd+kkUH0O2SoJ+ANjCWmfYTu4JDyrTk3ip97znspPVZ4E5
        bEVVgYmqsMnR7vRHv3CEcL8Lbw==
X-Google-Smtp-Source: APXvYqzCwR7j3BQhlSF+3ocwbZIUgQWmdMJ5vIc3KMbJ118nreWQQ2H63MyU3vDPW12dh8is9YX+jQ==
X-Received: by 2002:a6b:5a0b:: with SMTP id o11mr12544072iob.98.1562967565187;
        Fri, 12 Jul 2019 14:39:25 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id p10sm17827679iob.54.2019.07.12.14.39.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 14:39:24 -0700 (PDT)
Date:   Fri, 12 Jul 2019 15:39:22 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, Theodore Ts'o <tytso@mit.edu>,
        Ross Zwisler <zwisler@chromium.org>,
        linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 1/2] ocfs2: use jbd2_inode dirty range scoping
Message-ID: <20190712213922.GB244046@google.com>
References: <1562914972-97318-1-git-send-email-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562914972-97318-1-git-send-email-joseph.qi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 12, 2019 at 03:02:51PM +0800, Joseph Qi wrote:
> commit 6ba0e7dc64a5 ("jbd2: introduce jbd2_inode dirty range scoping")
> allow us scoping each of the inode dirty ranges associated with a given
> transaction, and ext4 already does this way.
> Now let's also use the newly introduced jbd2_inode dirty range scoping
> to prevent us from waiting forever when trying to complete a journal
> transaction in ocfs2.
> 
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
 
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index a4c905d..bbb508a 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -942,7 +942,7 @@ static void ocfs2_write_failure(struct inode *inode,
>  
>  		if (tmppage && page_has_buffers(tmppage)) {
>  			if (ocfs2_should_order_data(inode))
> -				ocfs2_jbd2_file_inode(wc->w_handle, inode);
> +				ocfs2_jbd2_file_inode(wc->w_handle, inode, user_pos, user_len);

Line longer than 80 characters, should be wrapped.

> @@ -2024,7 +2024,9 @@ int ocfs2_write_end_nolock(struct address_space *mapping,
>  
>  		if (page_has_buffers(tmppage)) {
>  			if (handle && ocfs2_should_order_data(inode))
> -				ocfs2_jbd2_file_inode(handle, inode);
> +				ocfs2_jbd2_file_inode(handle, inode,
> +						      ((loff_t)tmppage->index << PAGE_SHIFT) + from,

Line longer than 80 characters, should be wrapped.

> diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
> index c0fe6ed..932e6a8 100644
> --- a/fs/ocfs2/journal.h
> +++ b/fs/ocfs2/journal.h
> @@ -603,9 +603,11 @@ static inline int ocfs2_calc_tree_trunc_credits(struct super_block *sb,
>  	return credits;
>  }
>  
> -static inline int ocfs2_jbd2_file_inode(handle_t *handle, struct inode *inode)
> +static inline int ocfs2_jbd2_file_inode(handle_t *handle, struct inode *inode,
> +					loff_t start_byte, loff_t length)
>  {
> -	return jbd2_journal_inode_add_write(handle, &OCFS2_I(inode)->ip_jinode);
> +	return jbd2_journal_inode_ranged_write(handle, &OCFS2_I(inode)->ip_jinode,
> +					       start_byte, length);
>  }

Perhaps ocfs2_jbd2_ranged_write() would be more informative if you're renaming
this function?

Aside from these nits, this all looked good to me.  You can add:
Reviewed-by: Ross Zwisler <zwisler@google.com>
