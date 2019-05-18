Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889FF224BA
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2019 21:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfERTys (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 May 2019 15:54:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56015 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729182AbfERTys (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 May 2019 15:54:48 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4IJsc9g004184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 May 2019 15:54:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D70C6420027; Sat, 18 May 2019 15:54:24 -0400 (EDT)
Date:   Sat, 18 May 2019 15:54:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Variable to signed to check return code
Message-ID: <20190518195424.GC14277@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
 <20190517102506.GU4319@dell>
 <20190517202810.GA21961@mit.edu>
 <20190518063834.GX4319@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518063834.GX4319@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, May 18, 2019 at 07:38:34AM +0100, Lee Jones wrote:
>   "- Acked-by: indicates an agreement by another developer (often a
>      maintainer of the relevant code) that the patch is appropriate for
>      inclusion into the kernel."
> 
> And I, as a developer (and not a Maintainer in this case) do indicate
> that this patch is appropriate for inclusion into the kernel.
> 
> Reviewed-by has stronger connotations and implies I have in-depth
> knowledge of the subsystem/driver AND agree to the Reviewer's
> Statement.  I use Acked-by in this case as a weaker agreement after a
> shallow review of the patch based on its merits alone.

Note the "often a maintainer of the relevant code" bit.  And
"appropriate for inclusion into the kernel" means to me that you've
done the same level of review as Reviewed-by.  So I have very
different understanding of how Acked-by and Reviewed-by than you do.

That being said, no offence to you, but any kind of Acked-by or
Reviewed-by from you is not going to have as much weight as say, a
Reviewed-by: from someone like Jan Kara.  That's just because I don't
have a good sense to your technical ability, and so I'd be doing a
full review myself and not rely on your review at all....

Cheers,

					- Ted

P.S.  And if I find a problem in the patch, and someone had attached
their Acked-by or Reviewed-by to it, it would have the same negative
hit to their reputation either way.  Not a big deal if it happens only
once, or it's an esepcially tricky issue, but it if happens more than
once or is really blatent, I as the maintainer definitely do remember.

