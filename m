Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F5D2DD4CC
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 17:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgLQQDo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 11:03:44 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57255 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728668AbgLQQDo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 11:03:44 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BHG2q1o014245
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 11:02:53 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B3B97420280; Thu, 17 Dec 2020 11:02:52 -0500 (EST)
Date:   Thu, 17 Dec 2020 11:02:52 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>
Subject: Re: [PATCH 7/8] ext4: Fix superblock checksum failure when setting
 password salt
Message-ID: <X9uBLMhQFPQIGUFT@mit.edu>
References: <20201216101844.22917-1-jack@suse.cz>
 <20201216101844.22917-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216101844.22917-8-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 16, 2020 at 11:18:43AM +0100, Jan Kara wrote:
> When setting password salt in the superblock, we forget to recompute the
> superblock checksum so it will not match until the next superblock
> modification which recomputes the checksum. Fix it.
> 
> CC: Michael Halcrow <mhalcrow@google.com>
> Reported-by: Andreas Dilger <adilger@dilger.ca>
> Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

						- Ted
