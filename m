Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4506E6BE056
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 05:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCQE6n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 00:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQE6m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 00:58:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373821BAFD;
        Thu, 16 Mar 2023 21:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2B0AB81C3C;
        Fri, 17 Mar 2023 04:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D688C433EF;
        Fri, 17 Mar 2023 04:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679029118;
        bh=JpS7lSiVAa5ROcbP589KLEjo9s5dmVcm1sS229Jdobs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmC/25I1+Kwb3Rx8Hhyl/J+hOvTJxf4vn4LUyBmzd+MGYIr7rRiGOD82/E56jhmhJ
         oLN3QvF0XlFKuJmN95TpNXaK5cvG9QsVkMSY1n+9cojMQ4OihZbauVaFgMirSJEfmH
         yt68EuTs19EoW+N41UVBjtwHLkicQH9/Xa7x4q8Ny8v3JhDYjzON1owckv4pvaKCIY
         rmsgGuJk/CjMCdRrsk6+N9sTy1rSmQaR3nRdZBsLQGsSUGTELqvl77J9CyUB27Psk3
         w5jYXwHfjHfqHac3OXDU73SWHSniCQXz7Pc7R/ISHGrzbjJr0fBQC8XF+IcNrnazA/
         wAuxS2YG8ad+g==
Date:   Thu, 16 Mar 2023 21:58:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove unneeded check of nr_to_submit
Message-ID: <20230317045836.GA882@sol.localdomain>
References: <20230316204831.2472537-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316204831.2472537-1-trix@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 16, 2023 at 04:48:31PM -0400, Tom Rix wrote:
> cppcheck reports
> fs/ext4/page-io.c:516:51: style:
>   Condition 'nr_to_submit' is always true [knownConditionTrueFalse]
>  if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
>                                                   ^
> This earlier check to bail, makes this check unncessary
> 	/* Nothing to submit? Just unlock the page... */
> 	if (!nr_to_submit)
> 		return 0;
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Maybe add:

Fixes: dff4ac75eeee ("ext4: move keep_towrite handling to ext4_bio_write_page()")

Either way, looks good to me.

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
