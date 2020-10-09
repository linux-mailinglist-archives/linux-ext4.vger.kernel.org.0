Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF9F28919E
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 21:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgJITON (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 15:14:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34820 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726118AbgJITON (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Oct 2020 15:14:13 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 099JE7t3019589
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Oct 2020 15:14:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A3DA7420107; Fri,  9 Oct 2020 15:14:07 -0400 (EDT)
Date:   Fri, 9 Oct 2020 15:14:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v9 5/9] ext4: main fast-commit commit path
Message-ID: <20201009191407.GO235506@mit.edu>
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-6-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919005451.3899779-6-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 18, 2020 at 05:54:47PM -0700, Harshad Shirwadkar wrote:
>  fs/jbd2/commit.c            |   42 ++
>  fs/jbd2/journal.c           |  119 +++-

Why are these changes here instead of the previous commit (jbd2: add
fast commit machinery)?

> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index ba35ecb18616..dadd9994e74b 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -202,6 +202,47 @@ static int journal_submit_inode_data_buffers(struct address_space *mapping,
>  	return ret;
>  }
>  
> +/* Send all the data buffers related to an inode */
> +int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)
> +{
> +	struct address_space *mapping;
> +	loff_t dirty_start;
> +	loff_t dirty_end;
> +	int ret;
> +
> +	if (!jinode)
> +		return 0;
> +
> +	dirty_start = jinode->i_dirty_start;
> +	dirty_end = jinode->i_dirty_end;
> +
> +	if (!(jinode->i_flags & JI_WRITE_DATA))
> +		return 0;
> +
> +	dirty_start = jinode->i_dirty_start;
> +	dirty_end = jinode->i_dirty_end;

Why is dirty_start and dirty_end initialized twice?

Also, this is going to conflcit with Mauricio's data=journal patches,
which you'll notice when you rebase these patches on the current dev branch.

(The dev branch temporarily had your v9 patches merged in, so we could
get the test bots to comment on your changes, but I've since pulled
the fc patches back out.)

					- Ted
