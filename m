Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB77D52CA7E
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 05:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiESDnR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 23:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiESDnQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 23:43:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9DB6EB31
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 20:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C0FAB822BE
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 03:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEA9C385B8;
        Thu, 19 May 2022 03:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652931789;
        bh=eN+YB322uw3mBoCdzG+0eJr0YGcK+eFnSZOu6Ac7z84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mk5u6CwF3JKOcFsw1A+FmfnPm2gEpggvWc3OS4aFz7ojJssuGqAfNw+Qh+O0HlW1K
         fDdR8jyNIaYvVAGrSMfJzvDJWmeBo0r0t1KQIP5w+EFA03vNr02Vn07sNqAOEZSWF8
         kejOkWr3Z5vdkCKy0NLWdZ8CUXZQJ55VtuSTwxVydbcHeszFzYIwR7+IboHc5AxrSk
         reNnUdAj8Ym6NGoFvuP0ZeEn/qkoNN3Z5qbqzCp4/lzLfcrfWazPJ2xKUL3jUA4K0v
         AlpxK9G+5dVVltDgwOh1oF9sytN2z/UotbJlaVwlltdY7uyvUh1H5FI1Z7kQAdKvw+
         UHIOiH1sH/GbA==
Date:   Wed, 18 May 2022 20:43:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v6 4/8] ext4: Reuse generic_ci_match for ci comparisons
Message-ID: <YoW8yx9Fw9Rwiaja@sol.localdomain>
References: <20220519014044.508099-1-krisman@collabora.com>
 <20220519014044.508099-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519014044.508099-5-krisman@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 09:40:40PM -0400, Gabriel Krisman Bertazi wrote:
> Instead of reimplementing ext4_match_ci, use the new libfs helper.
> 
> It should be fine to drop the fname->cf_name in the encrypted directory
> case for the hash verification optimization because the only two ways
> for fname->cf_name to be NULL on a case-insensitive lookup is
> 
>  (1) if name under lookup has an invalid encoding and the FS is not in
>  strict mode; or
> 
>  (2) if the directory is encrypted and we don't have the
>  key.
> 
> For case (1), it doesn't matter, because the lookup hash will be
> generated with fname->usr_name, the same as the disk (fallback to
> invalid encoding behavior on !strict mode).  Case (2) is caught by the
> previous check (!IS_ENCRYPTED(parent) ||
> fscrypt_has_encryption_key(parent)), so we never reach this code.

The code actually can be reached in case (2), because the key could have been
added between ext4_fname_setup_ci_filename() and ext4_match().

I *think* your change doesn't make it any worse, since in such a case the name
comparison is going to be comparing a no-key name to a regular one, which will
very likely fail.  So adding an additional way for the match to fail seems fine.

It's hard to reason about, though.  f2fs does things in a much cleaner way, as
I've mentioned before, since it decides which type of match it wants at the
beginning, when initializing struct f2fs_filename.

- Eric
