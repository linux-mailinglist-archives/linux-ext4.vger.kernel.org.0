Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B523AA87E
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jun 2021 03:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhFQBRt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 21:17:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43357 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231920AbhFQBRs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 21:17:48 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15H1FbjR031347
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 21:15:37 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D49AD15C3CB8; Wed, 16 Jun 2021 21:15:36 -0400 (EDT)
Date:   Wed, 16 Jun 2021 21:15:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: fix memory leak in ext4_fill_super
Message-ID: <YMqiOJwJfvqPyOmy@mit.edu>
References: <YIt9IFY4Xsf5K+eZ@mit.edu>
 <20210430185046.15742-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430185046.15742-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 30, 2021 at 09:50:46PM +0300, Pavel Skripkin wrote:
> static int kthread(void *_create) will return -ENOMEM
> or -EINTR in case of internal failure or
> kthread_stop() call happens before threadfn call.
> 
> To prevent fancy error checking and make code
> more straightforward we moved all cleanup code out
> of kmmpd threadfn.
> 
> Also, dropped struct mmpd_data at all. Now struct super_block
> is a threadfn data and struct buffer_head embedded into
> struct ext4_sb_info.
> 
> Reported-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>

Applied, thanks!  (And apologies for the delay)

						- Ted

