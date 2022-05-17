Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC8B52AC12
	for <lists+linux-ext4@lfdr.de>; Tue, 17 May 2022 21:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbiEQTi2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 May 2022 15:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245285AbiEQTiZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 May 2022 15:38:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D249D515A8
        for <linux-ext4@vger.kernel.org>; Tue, 17 May 2022 12:38:20 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24HJbmKM032272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 15:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652816271; bh=gjF3UmMC4ZyoJnTzFcqn/F3r7v+E//TAc0+qhfAKPdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YWZ6i/3IdBGwr4SyraXxcIhbLRAbOxr0dvLm3I5n7e241sNy6Ch6v2KncDvUDSpbR
         Lmro19q8OiJ7hQ1ll443cFRi1fn/I/p+bBFI890xz/sexmaPab50F9RXxg64+H8J47
         uS3Zr0VojaZnDQOW8Whwh64YGpaxbrgNZnTzb+qzbu0BQ9DUb03W9832yvasiOZCzD
         M6fEzqU1r6+viwSH+VTMnMShnFWGl7Ms9Z/CsxocpvZ2L3HWgmRMSzk0MLXa+JoqXf
         +QiW2Mmw4aa5SomGy3ojp3XS90hFpxQlHepDewrXiflqfjJZB8/hY46Ath5vzgbNTr
         C07Yz1RX0YpIQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 651DE15C3EC0; Tue, 17 May 2022 15:37:48 -0400 (EDT)
Date:   Tue, 17 May 2022 15:37:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 00/10] Clean up the case-insensitive lookup path
Message-ID: <YoP5jH5axe9ltX2Y@mit.edu>
References: <20220511193146.27526-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511193146.27526-1-krisman@collabora.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 11, 2022 at 03:31:36PM -0400, Gabriel Krisman Bertazi wrote:
> The case-insensitive implementations in f2fs and ext4 have quite a bit
> of duplicated code.  This series simplifies the ext4 version, with the
> goal of extracting ext4_ci_compare into a helper library that can be
> used by both filesystems.  It also reduces the clutter from many
> codeguards for CONFIG_UNICODE; as requested by Linus, they are part of
> the codeflow now.
> 
> While there, I noticed we can leverage the utf8 functions to detect
> encoded names that are corrupted in the filesystem. Therefore, it also
> adds an ext4 error on that scenario, to mark the filesystem as
> corrupted.

Gabriel, are you planning on doing another version of this patch series?

It looks like the first two patches for ext4 are not controversial, so
I could take those, while some of the other patches have questions
which Eric has raised.

Thanks,

						- Ted

