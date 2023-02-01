Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8DC685F4B
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 06:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBAFyU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Feb 2023 00:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBAFyT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Feb 2023 00:54:19 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BC7A24B
        for <linux-ext4@vger.kernel.org>; Tue, 31 Jan 2023 21:54:18 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3115s7Mh012406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 00:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675230849; bh=3lZ2pyjfJs98LSp6CBZGI40hiUOqXbzoOrXL2/yhqfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=W8GV7gNQbllv65fx7npWlErNQ0ruxwMjy2OEJ22BUZNgd3Ugoj+D98yZ6Y/LpRTp8
         ShGcnZL+1oD6HvnUoIaMWm0cw2hBR6EbSL0T2JknuUYw7zpjq4hI2MMJLPw3RPq5MU
         zgDA/22ngBwrd6L52vReplH0qxsDPn4FXoK+2xc9K3kA6w59eEHwjLJDq2aiOFVPif
         9J1hdf9gEgip/3RJlMYeeusgr85oPLwgTyBZMoWe/MWyjhRWFQfLu1iMRtfEdBclhq
         OUs6HRXVP9DvgpT8pZ7fA3ks3LXwnhwqZY+Z8sd4wtPOkqTy9kHPiUurhBgYhw7XYE
         0LuO7gXuo55SQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9C4ED15C359D; Wed,  1 Feb 2023 00:54:07 -0500 (EST)
Date:   Wed, 1 Feb 2023 00:54:07 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>, tytso@google.com
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] lib/support: don't assume qsort_r() is always
 available on Linux
Message-ID: <Y9n+fyZdBd6cu8Ul@mit.edu>
References: <20230130215829.863455-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130215829.863455-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 30, 2023 at 09:58:29PM +0000, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since commit 4e5f24ae4267 ("Use an autoconf test to detect for a BSD- or
> GNU-style qsort_r function"), e2fsck fails to build for Android because
> lib/support/sort_r.h assumes that qsort_r() is always available on
> "Linux", but in fact it's not supported by Android's libc.
> 
> Rename _SORT_R_LINUX to _SORT_R_GNU to clarify that it's really the
> glibc convention for qsort_r(), not the "Linux" convention per se, and
> make sort_r.h stop setting it automatically when __linux__ is defined.
> 
> Note: this change does *not* prevent glibc's qsort_r() from being used
> when e2fsprogs is built using the autotools-based build system, as
> 'configure' checks for qsort_r() too.  This change just affects the
> fallback behavior for when qsort_r() was not already detected.
> 
> Fixes: 4e5f24ae4267 ("Use an autoconf test to detect for a BSD- or GNU-style qsort_r function")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted

P.S.  Actually, I ended applying it first when I was reviewing the
AOSP commits from https://android.googlesource.com/platform/external/e2fsprogs
that weren't yet upstream.  I haven't yet updated
go/aosp-e2fsprogs-reconcilation as of this writing, but I'll get to
that tomorrow.


Reconcilation up to AOSP commit 1c856d2bbde5:

AOSP commit: df8e49a9d7e691a148e3fc59df77c9aca86034f9
Upstream commit: n/a

    Update generated files for Android
    
Change-Id: I7da01654acdf39f4a7e7f6f3829c1043c1a6f079


AOSP commit: 30fa5b9af82695711cc1bf749fbb0cd18afa008a
Upstream commit: cdc9dbf348a99b94a9f750ffdb7e6191d8ac0f39

    Android: run bpfmt on all bp files
    
Change-Id: Ia08c8d481199dfa917dbed2dc218df167f101ce5


AOSP commit: d08d59557a34c6362e3660e7e35bc118591dbbfaa
Upstream commit: 9aaccbc6fded1b3cfb7c9521665b8b7162f2150f

    Android: consolidate warning suppressions
    
Change-Id: Icebc03289dae920cb1b673e605c48f7f2b517625


AOSP commit: 890e23673b7496bbf400e6bb5fd555bbb3c4b88f
Upstream commit: dd4a98cc743f87768877a567561bc67506fe9cc7

    Android: stop suppressing warnings from macOS build
    
Change-Id: Ie6a1c098a2e5b9db42c9a239ddfbf682cbd3bad2


AOSP commit: 0ef947d1d4890b3fd4509bc1f3c98bb0f0a525f5
Upstream commit: c4749950337327946f969b3bfeb67b3cdf60672a

    Android: stop suppressing warnings controlled by -Wall
    
Change-Id: Ida895a1c5dfdf168bc6f50049680b2d2bfbb2942


AOSP commit: c9aa74eac41f8feeabb2321383161c7cf92cb49b
Upstream commit: 23081a924a098243730d721f941c032ca4addf3a

    Android: consolidate addition of include/mingw/
    
Change-Id: I92fdaf3e58029dfca3187af928d943270b2a2109


AOSP commit: f22381d07818ff7e55e89698a1daf23ba2357d69
Upstream commit: 62267969523e27604806cb6b149cbf5e0019cf79

    Android: add a new upstream source file
    
Change-Id: Iafeccde9acca678e665b49a4cdb42ac0672e2a84


AOSP commit: 9f289d0add4f12fa2e4b21754141363a2759d152
Upstream commit: 3d2214e50ce1a69f718427e1c125eb476af54611

    lib/support: don't assume qsort_r() is always available on Linux
    
Change-Id: I4ed2fd6aef5a0d62960988d29e35acd337bb7d02


AOSP commit: c30a15e5d615748d4824dec26f1bda1a86be979c
Upstream commit: 6605a07f6afe3d9d667ff31855bc607c1904d18b

    Stop explicitly specifying -fno-strict-aliasing
    
    Change-Id: Ifa637058fd95fdc2b6994a8b801b238e929c1f13


AOSP commit: 7c581e836497595d0748953eb2b533777d9f4fd4
Upstream commit: 97f9109b6633dbf086645c21750ecc5f022d72a3

    mke2fs: stop suppressing warnings for Windows build
    
Change-Id: I12de1b58e839658568c2f7cd30f1c2a227fe15f2


AOSP commit: c3b223fedcb94e5763c48b93a4445289d13a5eb0
Upstream commit: 0c7e1296e4a1b4318d2a388e8a9832c2e6d0c5f3

    e2fsdroid: stop disabling address sanitization
    
Change-Id: I89a7a1ec1a45d0a2ed76d2e5938dbc127eb267a6


AOSP commit: 854b5e3e7e21294f560565195cbf925d7ea57c92
Upstream commit: n/a

    mke2fs: stop disabling memory leak detection
    
Change-Id: I0800b66134c9502b504bda02a71d85f341b057c3


AOSP commit: 3f6a1f7d271c5df9c3d2494c26d8ee108e1c2904
Upstream commit: n/a

    Update generated files for Android
    
Change-Id: Ia147859dbaed58d6e3d157acf6f0e695bc326b23


AOSP commit: 8c1a8b9620cb7752c8e9406fb4cbc77aa77d7e0d
Upstream commit: 70cbe94019cd24018d28887cf79953a0b41f4bee

    mke2fs: fix Windows build
    
Change-Id: I24d5ceae1cb72dd68968997c549117bfa0870220


AOSP commit: babec051ea643665d0f0d46c46482841ec62e2d2
Upstream commit: f8a9d77cea1fc924f59f24955a1c8d6878410f5c

    libext2fs: fix 32-bit Windows build
    
Change-Id: I548b204edd1d7b30ddf9fa3a9c1020179d2cbae9


AOSP commit 0c82cec0d1aa70c993b5231a2c2244eb5175e638
Upstream commit: 7bda04ec457e662c0abb3b55c0e5e5bc625b0fee

    Update lib/ext2fs/Android.bp for upstream change
    
Change-Id: Ieab0b9ad5a9f7c275153e0f90553761693967762


AOSP commit: 110cf8fb95e1850b5bc64007c9e5ee0f7e1adaf9
Upstream commit: 997902106fab2bc7cb0f7251eb55fad4b721b51a

    resize2fs: remove unused variable 'c'
    
Change-Id: I959a021ced55127340449380d37046b6b841351c


AOSP commit: 54818f635e4249db903dd17fca22ae11b3c0f3a0
Upstream commit: 810f73f2e58d36f60f11bcb80f03d94efa752a31

    mke2fs.microdroid: Allow non-APEX version of libs
    
Change-Id: I1aa493bfc188bb78e21efe98423f4a79215f7d95


AOSP commit 2aa5b65667e71bc278117caffa46c331d75d2803
Upstream commit 1f8c70161734a245dc151e2e8c45d2378d6f8a70

    Create blkid_static
    
Change-Id: I191840a21df1c10f4371acbe8067f39f148f28b8


AOSP commit f12ebffc345741380d9a30ddac528a9b995657cd
Upstream commit 218695a0a746eb5fc2875359dff3226c9709be4b

    Make blkid host_supported
    
Change-Id: I46c1e18b9dbdbeb41c7dfe4e26496004d1b2b3de
