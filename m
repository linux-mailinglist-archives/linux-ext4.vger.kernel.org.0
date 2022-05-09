Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A565209A0
	for <lists+linux-ext4@lfdr.de>; Tue, 10 May 2022 01:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiEIXse (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 May 2022 19:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiEIXrn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 May 2022 19:47:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B21BADEA;
        Mon,  9 May 2022 16:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C651B819D6;
        Mon,  9 May 2022 23:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B549DC385C5;
        Mon,  9 May 2022 23:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652139724;
        bh=5OD7u2labX3wXoga7vb5M7KUlFJtdxZpM/1BshqCnfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfJSeXVz5iDYMtN+3exeZQzUnY6o9Ksr/BscLY2rPbjyXWdNzUBM39yafRxV79S16
         I+avtLBZoDNKdkFc67ZCtOB8DnLWd5wmGv6/4FRc/+DQQXn7NaDZzwojRJZafaG/0n
         to56yvUwy2CuHV68sWkHBUJ0HmCqC8u4lpE1xxup2XVbgUCLzVHyeHcAvYiKDO2GjB
         AAbQKHY42AQVQtZxfpVzOCvZRpT0n3pXYx49cXQ++haNQNeeOOya1IBqW26aHweZST
         ODYcvFM/mqY+CwzJvndKzsmaO6UA6HJ+rNn1qyeF2X4rY58ukVZFabi0nijZv5vdz5
         sQznrfy7mcjCA==
Date:   Mon, 9 May 2022 16:42:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [xfstests PATCH] ext4/053: fix the rejected mount option testing
Message-ID: <Ynmmy+bWp0Q1/747@sol.localdomain>
References: <20220430192130.131842-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430192130.131842-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Apr 30, 2022 at 12:21:30PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> 'not_mnt OPTIONS' seems to have been intended to test that the
> filesystem cannot be mounted at all with the given OPTIONS, meaning that
> the mount fails as opposed to the options being ignored.  However, this
> doesn't actually work, as shown by the fact that the test case 'not_mnt
> test_dummy_encryption=v3' is passing in the !CONFIG_FS_ENCRYPTION case.
> Actually ext4 ignores this mount option when !CONFIG_FS_ENCRYPTION.
> (The ext4 behavior might be changed, but that is besides the point.)
> 
> The problem is that the do_mnt() helper function is being misused in a
> context where a mount failure is expected, and it does some additional
> remount tests that don't make sense in that context.  So if the mount
> unexpectedly succeeds, then one of these later tests can still "fail",
> causing the unexpected success to be shadowed by a later failure, which
> causes the overall test case to pass since it expects a failure.
> 
> Fix this by reworking not_mnt() and not_remount_noumount() to use
> simple_mount() in cases where they are expecting a failure.  Also fix
> up some of the naming and calling conventions to be less confusing.
> Finally, make sure to test that remounting fails too, not just mounting.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  tests/ext4/053 | 148 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 78 insertions(+), 70 deletions(-)

Lukas, any thoughts on this patch?  You're the author of this test.

- Eric
