Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40375E7290
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Sep 2022 05:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiIWDsv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Sep 2022 23:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiIWDst (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Sep 2022 23:48:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB658118B3D
        for <linux-ext4@vger.kernel.org>; Thu, 22 Sep 2022 20:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 708D6B819DB
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 03:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E123AC433C1;
        Fri, 23 Sep 2022 03:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663904926;
        bh=+Q6aM8zRScMQ2iGfiaiyZLKK4o8MFTRoU/8COnemOPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnpbsClmfb04NpMflLccEzDO4mH4k4XIK7/Gmrmco139wpNzgmh4kahmkGWQLi1Zr
         iQASs7IboeOiZzRlNykeekuhqyul+tH9QhLGPPQTyXv55lvTcMtX8NWaLiP7jdxIH1
         zeBYSen8kwQ0//cUVukq3dNdIs5aawFAt8teaJQZPRipqF4Q2JxFAysRBTdFG15lVY
         nRFktK2/1kSSY17d5zOYIl7otCJvOw6V7zg2BpWw+dMN9BF1jECviMzgj46xAD3Lxc
         ShGZmgLDzOpX1TfExaeYPhkAkuqxuHkeu4J+WhAJWAhR72xesrl6UxjJc9/UYtsbL1
         6qfjUOX8+krJA==
Date:   Thu, 22 Sep 2022 20:48:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v9 4/8] ext4: Reuse generic_ci_match for ci comparisons
Message-ID: <Yy0snGZYtLKtORT7@sol.localdomain>
References: <20220913234150.513075-1-krisman@collabora.com>
 <20220913234150.513075-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913234150.513075-5-krisman@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 13, 2022 at 07:41:46PM -0400, Gabriel Krisman Bertazi wrote:
> Instead of reimplementing ext4_match_ci, use the new libfs helper.
> 
> It also adds a comment explaining why fname->cf_name.name must be
> checked prior to the encryption hash optimization, because that tripped
> me before.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
