Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C173B17B395
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2020 02:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCFBMs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 20:12:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35458 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726162AbgCFBMs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 20:12:48 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0261CWJq032675
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Mar 2020 20:12:32 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9922542045B; Thu,  5 Mar 2020 20:12:31 -0500 (EST)
Date:   Thu, 5 Mar 2020 20:12:31 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: namei: Replace zero-length array with
 flexible-array member
Message-ID: <20200306011231.GI20967@mit.edu>
References: <20200213160648.GA7054@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213160648.GA7054@embeddedor>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 13, 2020 at 10:06:48AM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks, applied.

						- Ted
