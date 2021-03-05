Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2682032ED28
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 15:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhCEOdH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 09:33:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46413 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230177AbhCEOcr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 09:32:47 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 125EWewb023284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 Mar 2021 09:32:41 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4EEE515C3A88; Fri,  5 Mar 2021 09:32:40 -0500 (EST)
Date:   Fri, 5 Mar 2021 09:32:40 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+a8b4b0c60155e87e9484@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fs/ext4: fix integer overflow in s_log_groups_per_flex
Message-ID: <YEJBCA362sKGD1jp@mit.edu>
References: <20210223170118.GD30433@quack2.suse.cz>
 <20210224095800.3350002-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224095800.3350002-1-snovitoll@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 24, 2021 at 03:58:00PM +0600, Sabyrzhan Tasbolatov wrote:
> syzbot found UBSAN: shift-out-of-bounds in ext4_mb_init [1], when
> 1 << sbi->s_es->s_log_groups_per_flex is bigger than UINT_MAX,
> where sbi->s_mb_prefetch is unsigned integer type.
> 
> 32 is the maximum allowed power of s_log_groups_per_flex. Following if
> check will also trigger UBSAN shift-out-of-bound:
> 
> if (1 << sbi->s_es->s_log_groups_per_flex >= UINT_MAX) {
> 
> So I'm checking it against the raw number, perhaps there is another way
> to calculate UINT_MAX max power. Also use min_t as to make sure it's
> uint type.
> 
> [1] UBSAN: shift-out-of-bounds in fs/ext4/mballoc.c:2713:24
> shift exponent 60 is too large for 32-bit type 'int'
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x137/0x1be lib/dump_stack.c:120
>  ubsan_epilogue lib/ubsan.c:148 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x432/0x4d0 lib/ubsan.c:395
>  ext4_mb_init_backend fs/ext4/mballoc.c:2713 [inline]
>  ext4_mb_init+0x19bc/0x19f0 fs/ext4/mballoc.c:2898
>  ext4_fill_super+0xc2ec/0xfbe0 fs/ext4/super.c:4983
> 
> Reported-by: syzbot+a8b4b0c60155e87e9484@syzkaller.appspotmail.com
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

Applied, thanks.

					- Ted
