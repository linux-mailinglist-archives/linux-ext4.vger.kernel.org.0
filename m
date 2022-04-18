Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ADF504D2C
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Apr 2022 09:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiDRHYm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 03:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiDRHYm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 03:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F5413CD3;
        Mon, 18 Apr 2022 00:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C620560FFE;
        Mon, 18 Apr 2022 07:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CE9C385A1;
        Mon, 18 Apr 2022 07:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650266523;
        bh=WB0hDSq33uWzhf8ZYeluPQDa2r3gGlOJliR7GwrV2NA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ErE79ArV4+vZoQCN0ISqsipGetzHRrkIVd8pWwhFjn23X7Vx3VIwim9Fj9bCPsA0v
         di4M8ckLmb9pU+i6akjE5rxuT6pGSxjetluYIx2qnRnYgktqcFLRXmKqhVyIwvNlrs
         ENgF7SPs1tfpeWYTXCPyTaT1xf3S/+ab9oeRppisFBrF2zIfO3YRkrN6+JMAnlZfRx
         2ewTh/KOm3zU7dpsJPPnHk0E7BPNiEHsga6bLMK1PGDXeJVRCeJFpO8xF5ohvq57Ce
         MoRJBJd5q+sNxXLexpTDEJyKi9iC0uihK3PC79c5NQjUoIKG76MWHN+5MSl/Ys9559
         B9HWXHdHfsywA==
Date:   Mon, 18 Apr 2022 00:22:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Fengnan Chang <changfengnan@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/3] f2fs: notify when device not supprt inlinecrypt
Message-ID: <Yl0RmUoZypbVmayj@sol.localdomain>
References: <20220418063312.63181-1-changfengnan@vivo.com>
 <20220418063312.63181-2-changfengnan@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418063312.63181-2-changfengnan@vivo.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 18, 2022 at 02:33:11PM +0800, Fengnan Chang via Linux-f2fs-devel wrote:
> Notify when mount filesystem with -o inlinecrypt option, but the device
> not support inlinecrypt.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>

You didn't include a cover letter in this patchset.  Can you explain what
problem this patchset is meant to solve?

Note that there are multiple factors that affect whether inline encryption can
be used with a particular file, such as whether the device supports the required
encryption mode, data unit size, and data unit number size.  So your warning
might not trigger even if inline encryption can't be used.  Also, your warning
will never trigger if the kernel has CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y.

I recently sent out a patch that makes fs/crypto/ consistently log a message
when starting to use an encryption implementation for the first time:
https://lore.kernel.org/r/20220414053415.158986-1-ebiggers@kernel.org.  It
already did this for the crypto API, but not blk-crypto.  Being silent for
blk-crypto was somewhat of an oversight.  These log messages make it clear which
encryption implementations are in use.

Does that patch solve the problem you are trying to solve?

- Eric
