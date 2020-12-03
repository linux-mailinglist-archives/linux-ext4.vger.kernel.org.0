Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5232CD8D3
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 15:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbgLCOSQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 09:18:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58082 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730934AbgLCOSQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 09:18:16 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B3EFvTR026452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Dec 2020 09:15:57 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 13CB7420136; Thu,  3 Dec 2020 09:15:57 -0500 (EST)
Date:   Thu, 3 Dec 2020 09:15:57 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     xiakaixu1987@gmail.com, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] ext4: remove redundant operation that set bh to NULL
Message-ID: <20201203141557.GG441757@mit.edu>
References: <1603194069-17557-1-git-send-email-kaixuxia@tencent.com>
 <2677070f-f994-f20d-115b-55922d172da6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2677070f-f994-f20d-115b-55922d172da6@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 21, 2020 at 09:10:18AM +0800, zhangyi (F) wrote:
> On 2020/10/20 19:41, xiakaixu1987@gmail.com wrote:
> > From: Kaixu Xia <kaixuxia@tencent.com>
> > 
> > The out_fail branch path don't release the bh and the second bh is
> > valid only in the for statement, so we don't need to set them to NULL.
> > 
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> 
> Thanks for the patch. It looks good to me.
> Reviewed-by: zhangyi (F) <yi.zhang@huawei.com>

Applied, thanks.

					- Ted
