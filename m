Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6233965DD5C
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 21:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjADUFP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 15:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjADUFO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 15:05:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8356D1C433
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 12:05:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37CA4B81896
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 20:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE418C433D2;
        Wed,  4 Jan 2023 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672862710;
        bh=ShcRG/NKnRtOXQu7Z1e/rZYXT+ybwKYzPUKZmw8uSkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfbK8mGjxdo9MHNoMFCIZAvwWCY+B4C2geOI+trdrYidmJ3uQuJk0YxJoh/aIjnbf
         5iKw6hxB79UipP4Rk/hNZhNpTTcd28tAzSRfiW0UfvJC/GepD1PHX5ZOPu0MG3EIuM
         d/7ODqwMZA3A7wbH6UhgMbruFuTu9CTRpY6WvUvVt6DvAJs1TwhgUV5SvahEU0OGXd
         pEoszR8MTI0v43M3GSANy0Hkhh67hAui5BwaEQVeBbIIHnnyrjlDpWFbn7ChMY/UFU
         K/xQ1HzJvyzHDGf5k5GkFd/EvzSNYlqn1jEoB9hP4saaRxhyhw4hxN0Ck35HCCvTG5
         svN+srOrK3itA==
Date:   Wed, 4 Jan 2023 20:05:09 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-ext4@vger.kernel.org,
        Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Subject: Re: [e2fsprogs PATCH] libext2fs: fix 32-bit Windows build
Message-ID: <Y7Xb9cYkymilfKLd@gmail.com>
References: <20230104090301.275976-1-ebiggers@kernel.org>
 <Y7WvQ9cqOZuF0YJR@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7WvQ9cqOZuF0YJR@magnolia>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 08:54:27AM -0800, Darrick J. Wong wrote:
> On Wed, Jan 04, 2023 at 01:03:01AM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > _WIN32 is the standard macro to detect Windows, regardless of 32-bit or
> > 64-bit.  _WIN64 is for 64-bit Windows only.  Use _WIN32 where _WIN64 was
> > incorrectly being used.
> > 
> > This fixes several 32-bit Windows build errors, for example this one:
> 
> Color me impressed, I would have applied to deprecate Windows support
> entirely, particularly given the existence of WSL.

Yes, now that everyone has migrated to GNU Hurd, which is fully supported by
e2fsprogs, there's no need for Windows which no one uses anymore :-)

The reason I have to care about e2fsprogs support for Windows is because the
Windows build of the Android SDK Platform tools includes a Windows binary of
mke2fs, so that it can be used by 'fastboot format'.

I am sure that Ted would be very unhappy if Android had to bring back
'make_ext4fs' due to e2fsprogs removing Windows support...

(One way out of this for Android would be to remove fastboot's support for
formatting filesystems, and just have it support wiping them.  The actual
formatting would then always happen on the Android device itself, using the
Linux build of e2fsprogs.  I'm not sure why that can't be done; however, I do
know that it's been brought up many times before and still hasn't happened...)

Of course, a second problem that I ran into after I sent this patch without
properly testing it, is that misc/mke2fs.c is hard-coding unix_io_manager.  So
an additional fix would be needed to make it use windows_io_manager on Windows,
now that Windows has its own windows_io_manager instead of unix_io_manager.

Paulo, just to double check: was your intent when adding the windows_io_manager
that it *always* replace unix_io_manager on Windows?

- Eric
