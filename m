Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2712DD49E
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgLQPwh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 10:52:37 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55511 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727260AbgLQPwh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 10:52:37 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BHFpkRp010300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 10:51:47 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 65281420280; Thu, 17 Dec 2020 10:51:46 -0500 (EST)
Date:   Thu, 17 Dec 2020 10:51:46 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 2/8] ext4: Drop sync argument of ext4_commit_super()
Message-ID: <X9t+koV64m23nBWt@mit.edu>
References: <20201216101844.22917-1-jack@suse.cz>
 <20201216101844.22917-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216101844.22917-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 16, 2020 at 11:18:38AM +0100, Jan Kara wrote:
> Everybody passes 1 as sync argument of ext4_commit_super(). Just drop
> it.
> 
> Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
