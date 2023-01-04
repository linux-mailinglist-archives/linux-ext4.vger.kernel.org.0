Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11CF65DDE5
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 21:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjADUyD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 15:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbjADUyC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 15:54:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E73AA80
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 12:54:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03B39B818E9
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 20:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A1BC433D2;
        Wed,  4 Jan 2023 20:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672865638;
        bh=rtQnG+pLm1aLgTuyzcUAbSs+N7TPkj8txsDRK8YK/eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/iPOrlWgSv8dVj5O4vijY4N9GmTVb6vb0bIi0W3IkjmoqQBEKni77kluKD8ekRSJ
         MD12OjbLC7vOgYTh0u4z4JF926DUvYvFLYUQv25xArKq0x201E+/TqlQB8FOWRcpHZ
         EuTxXR6L6K4/s4tvUZweyyv/EtlD2o8mnTgQarLTH9mPkY5+V+Cj5O6NU1e7o6+a86
         tsDP8cXU999J2mbDU8XRE9A8+yMX+kuTUsabwVYFlVuo+z8ayc/May2roS2BLSz3Dx
         26VqD2kLrTFq+81OwRQ2V1bVg7BNcLsbsKrUzYTWOzAgmxP8Nk5Jpa7AVPECvimQuH
         Q4tqn2jVZR50w==
Date:   Wed, 4 Jan 2023 20:53:57 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-ext4@vger.kernel.org,
        Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Subject: Re: [e2fsprogs PATCH] libext2fs: fix 32-bit Windows build
Message-ID: <Y7XnZWqRFeuN1Hzn@gmail.com>
References: <20230104090301.275976-1-ebiggers@kernel.org>
 <Y7WvQ9cqOZuF0YJR@magnolia>
 <Y7Xb9cYkymilfKLd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Xb9cYkymilfKLd@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 08:05:09PM +0000, Eric Biggers wrote:
> On Wed, Jan 04, 2023 at 08:54:27AM -0800, Darrick J. Wong wrote:
> > On Wed, Jan 04, 2023 at 01:03:01AM -0800, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > _WIN32 is the standard macro to detect Windows, regardless of 32-bit or
> > > 64-bit.  _WIN64 is for 64-bit Windows only.  Use _WIN32 where _WIN64 was
> > > incorrectly being used.
> > > 
> > > This fixes several 32-bit Windows build errors, for example this one:
> > 
> > Color me impressed, I would have applied to deprecate Windows support
> > entirely, particularly given the existence of WSL.

Note that WSL doesn't really eliminate the need for native Windows binaries,
since WSL is something that has to be explicitly enabled and configured; see
https://learn.microsoft.com/en-us/windows/wsl/install.  It's not like running a
32-bit binary on a 64-bit system which is something that just works.  You can't
just take a Linux binary and run it on Windows.

- Eric
