Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B9E248DD1
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHRSSx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 14:18:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45724 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbgHRSSw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 14:18:52 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07IIImXU013569
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 14:18:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5556B420DC0; Tue, 18 Aug 2020 14:18:48 -0400 (EDT)
Date:   Tue, 18 Aug 2020 14:18:48 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: optimize the implementation of ext4_mb_good_group()
Message-ID: <20200818181848.GD34125@mit.edu>
References: <e20b2d8f-1154-adb7-3831-a9e11ba842e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e20b2d8f-1154-adb7-3831-a9e11ba842e9@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 07, 2020 at 10:01:39PM +0800, brookxu wrote:
> It might be better to adjust the code in two places:
> 1. Determine whether grp is currupt or not should be placed first.
> 2. (cr<=2 && free <ac->ac_g_ex.fe_len)should may belong to the crx
>    strategy, and it may be more appropriate to put it in the
>    subsequent switch statement block. For cr1, cr2, the conditions
>    in switch potentially realize the above judgment. For cr0, we
>    should add (free <ac->ac_g_ex.fe_len) judgment, and then delete
>    (free / fragments) >= ac->ac_g_ex.fe_len), because cr0 returns
>    true by default.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Thanks, applied.

					- Ted
