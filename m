Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970561A8E0
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2019 19:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfEKRlf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 May 2019 13:41:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51298 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725879AbfEKRlf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 May 2019 13:41:35 -0400
Received: from callcc.thunk.org (rrcs-67-53-55-100.west.biz.rr.com [67.53.55.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4BHfQIM002914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 May 2019 13:41:28 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B987A420028; Fri, 10 May 2019 21:37:01 -0400 (EDT)
Date:   Fri, 10 May 2019 21:37:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Chengguang Xu <cgxu519@gmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] jbd2: fix potential double free
Message-ID: <20190511013701.GD2534@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Chengguang Xu <cgxu519@gmail.com>, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1557484608-23514-1-git-send-email-cgxu519@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557484608-23514-1-git-send-email-cgxu519@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 10, 2019 at 06:36:48PM +0800, Chengguang Xu wrote:
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 37e16d969925..0f1ac43d0560 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2299,7 +2299,7 @@ static void jbd2_journal_destroy_slabs(void)
>  	}
>  }
>  
> -static int jbd2_journal_create_slab(size_t size)
> +static int __init jbd2_journal_create_slab(size_t size)
>  {
>  	static DEFINE_MUTEX(jbd2_slab_create_mutex);
>  	int i = order_base_2(size) - 10;

I had to remove this hunk.  It's incorrect, since jbd2_journal_load
calls this function when mounting file systems.  So it can't be marked
__init.

						- Ted
