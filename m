Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181D54D4051
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Mar 2022 05:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiCJEcO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Mar 2022 23:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbiCJEcO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Mar 2022 23:32:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029E812D09F
        for <linux-ext4@vger.kernel.org>; Wed,  9 Mar 2022 20:31:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0B1FB8216C
        for <linux-ext4@vger.kernel.org>; Thu, 10 Mar 2022 04:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2765CC340E8;
        Thu, 10 Mar 2022 04:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646886671;
        bh=3Ii2Fa/P+lK3XJc01WeLDWVWit3uKbNd46Xro7cHO90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nulpx7NjpFlg8KfT22thY3XIfCIOTvekKjF/6GGEQOD338zHrAxxk6CG7LxlxOqGS
         ehNmfdtsh6F0q9mN7MYusNePA+m172Iq1wv2cJ9cBkb5r9DKFre8F2JP6hmqdq/m2c
         XOD9Xkht6EWNIBegU0GbkFMnhJYrRxjUWIWgyp83mZW7JtckQaHqChzDRz494TAaVi
         pifnBzwTe3PQpMNBlppSNx+d3yT35TBAcDFS70gAObRAe+IzG+A2SqYNPtwzorgKCQ
         oVvGnqRVHrkp4ny2UvR5MuMnlReXVpGzwN3eCuu7u0zTbQfpCDRvrQARHAJkV9gcA5
         9OLcXBLN+tjHw==
Date:   Wed, 9 Mar 2022 20:31:09 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: fix fallocate to use file_modified to update
 permissions consistently
Message-ID: <Yil/Dac4kraFdMuy@sol.localdomain>
References: <20220308185043.GA117678@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308185043.GA117678@magnolia>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 08, 2022 at 10:50:43AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Since the initial introduction of (posix) fallocate back at the turn of
> the century, it has been possible to use this syscall to change the
> user-visible contents of files.  This can happen by extending the file
> size during a preallocation, or through any of the newer modes (punch,
> zero, collapse, insert range).  Because the call can be used to change
> file contents, we should treat it like we do any other modification to a
> file -- update the mtime, and drop set[ug]id privileges/capabilities.
> 
> The VFS function file_modified() does all this for us if pass it a
> locked inode, so let's make fallocate drop permissions correctly.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/ext4/ext4.h    |    2 +-
>  fs/ext4/extents.c |   32 +++++++++++++++++++++++++-------
>  fs/ext4/inode.c   |    7 ++++++-
>  3 files changed, 32 insertions(+), 9 deletions(-)

Is there a test in xfstests that tests for this?

- Eric
