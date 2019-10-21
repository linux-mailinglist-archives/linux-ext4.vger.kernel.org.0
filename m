Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9C0DF2D7
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfJUQUx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 12:20:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35626 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727211AbfJUQUx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 12:20:53 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9LGKlUK005322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 12:20:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F17C3420458; Mon, 21 Oct 2019 12:20:46 -0400 (EDT)
Date:   Mon, 21 Oct 2019 12:20:46 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 08/22] ext4: Provide function to handle transaction
 restarts
Message-ID: <20191021162046.GA27850@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003220613.10791-8-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 04, 2019 at 12:05:54AM +0200, Jan Kara wrote:
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index fb0f99dc8c22..32f2c22c7ef2 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c

> +/*
> + * Make sure 'handle' has at least 'check_cred' credits. If not, restart
> + * transaction with 'restart_cred' credits. The function drops i_data_sem
> + * when restarting transaction and gets it after transaction is restarted.
> + *
> + * The function returns 0 on success, 1 if transaction had to be restarted,
> + * and < 0 in case of fatal error.
> + */
> +int ext4_datasem_ensure_credits(handle_t *handle, struct inode *inode,
> +				int check_cred, int restart_cred)

This makes me super nervous.  This gets called by ext4_access_path(),
which in turn is called by the insert_range, and collapse_range (among
others) where we previously were not dropping i_data_sem.  This means
we will be dropping i_data_sem while they are in the middle of doing
surgery to the extent tree, which makes me super nervous.

Granted, insert_range and collapse_range take a lot of locks,
including the inode lock, but it's not obvious to me that this is
safe, and at the very least the documentation for ext4_access_path
should have a warning note in its comments that i_data_sem can get
dropped, and its call sites audited if they haven't already.

Thanks,

							- Ted
