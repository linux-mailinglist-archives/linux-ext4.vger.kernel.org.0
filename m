Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA1A0640
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2019 17:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfH1P0L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Aug 2019 11:26:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34565 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726415AbfH1P0L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Aug 2019 11:26:11 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7SFPvYJ011335
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 11:25:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D3FE642049E; Wed, 28 Aug 2019 11:25:56 -0400 (EDT)
Date:   Wed, 28 Aug 2019 11:25:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: fix integer overflow when calculating commit
 interval
Message-ID: <20190828152556.GH24857@mit.edu>
References: <20190826143547.95169-1-yi.zhang@huawei.com>
 <20190826153014.GI10614@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826153014.GI10614@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 26, 2019 at 05:30:14PM +0200, Jan Kara wrote:
> On Mon 26-08-19 22:35:47, zhangyi (F) wrote:
> > If user specify a large enough value of "commit=" option, it may trigger
> > signed integer overflow which may lead to sbi->s_commit_interval becomes
> > a large or small value, zero in particular.
> > 
> > UBSAN: Undefined behaviour in ../fs/ext4/super.c:1592:31
> > signed integer overflow:
> > 536870912 * 1000 cannot be represented in type 'int'
> > [...]
> > Call trace:
> > [...]
> > [<ffffff9008a2d120>] ubsan_epilogue+0x34/0x9c lib/ubsan.c:166
> > [<ffffff9008a2d8b8>] handle_overflow+0x228/0x280 lib/ubsan.c:197
> > [<ffffff9008a2d95c>] __ubsan_handle_mul_overflow+0x4c/0x68 lib/ubsan.c:218
> > [<ffffff90086d070c>] handle_mount_opt fs/ext4/super.c:1592 [inline]
> > [<ffffff90086d070c>] parse_options+0x1724/0x1a40 fs/ext4/super.c:1773
> > [<ffffff90086d51c4>] ext4_remount+0x2ec/0x14a0 fs/ext4/super.c:4834
> > [...]
> > 
> > Although it is not a big deal, still silence the UBSAN by limit the
> > input value.
> > 
> > Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

						- Ted
