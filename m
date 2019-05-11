Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD551A8AA
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2019 19:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfEKRTo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 May 2019 13:19:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47199 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbfEKRTo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 May 2019 13:19:44 -0400
Received: from callcc.thunk.org (rrcs-67-53-55-100.west.biz.rr.com [67.53.55.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4BHJaQN030274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 May 2019 13:19:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7A41242002B; Fri, 10 May 2019 22:01:59 -0400 (EDT)
Date:   Fri, 10 May 2019 22:01:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix use-after-free in dx_release()
Message-ID: <20190511020159.GF2534@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1557304443-18653-1-git-send-email-stummala@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557304443-18653-1-git-send-email-stummala@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 08, 2019 at 02:04:03PM +0530, Sahitya Tummala wrote:
> The buffer_head (frames[0].bh) and it's corresping page can be
> potentially free'd once brelse() is done inside the for loop
> but before the for loop exits in dx_release(). It can be free'd
> in another context, when the page cache is flushed via
> drop_caches_sysctl_handler(). This results into below data abort
> when accessing info->indirect_levels in dx_release().
> 
> Unable to handle kernel paging request at virtual address ffffffc17ac3e01e
> Call trace:
>  dx_release+0x70/0x90
>  ext4_htree_fill_tree+0x2d4/0x300
>  ext4_readdir+0x244/0x6f8
>  iterate_dir+0xbc/0x160
>  SyS_getdents64+0x94/0x174
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Nice catch.  Thanks, applied.

					- Ted
