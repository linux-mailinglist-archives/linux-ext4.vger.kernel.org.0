Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847001DD36C
	for <lists+linux-ext4@lfdr.de>; Thu, 21 May 2020 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgEUQzy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 May 2020 12:55:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59063 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728546AbgEUQzy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 May 2020 12:55:54 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04LGtmjc007703
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 12:55:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2F56A420304; Thu, 21 May 2020 12:55:48 -0400 (EDT)
Date:   Thu, 21 May 2020 12:55:48 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Anna Pendleton <pendleton@google.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH] ext4: avoid ext4_error()'s caused by ENOMEM in the
 truncate path
Message-ID: <20200521165548.GA2946569@mit.edu>
References: <20200507175028.15061-1-pendleton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507175028.15061-1-pendleton@google.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 07, 2020 at 10:50:28AM -0700, Anna Pendleton wrote:
> From: Theodore Ts'o <tytso@mit.edu>
> 
> We can't fail in the truncate path without requiring an fsck.
> Add work around for this by using a combination of retry loops
> and the __GFP_NOFAIL flag.
> 
> From: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Anna Pendleton <pendleton@google.com>
> Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks, applied.

Per the feedback from the kbuild test robot, I changed "int gfp_flags =..." to
"gfp_t gfp_flags=..." in three places in the patches.

Cheers,

						- Ted
