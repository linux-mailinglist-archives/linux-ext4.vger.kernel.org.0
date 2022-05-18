Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C352C2B1
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbiERSt5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 14:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbiERSt4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 14:49:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B3323BDD
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 11:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B117D618CF
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 18:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6754C385A5;
        Wed, 18 May 2022 18:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652899794;
        bh=+Apu+Nel2cEDwc+hc9Dn71n7RNyqrWqJjXXdOwbxaDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6ExxwSk+WU0hzWKNiP6k4MURxiYIRBOwkNNWsvVn/XELTkLBZBQTY0L6ojiC8538
         Nu68TmKdYlI6sW8Cbqa1wTsBu26wHnUIDiHEmpoOI/mwQkyPIG4rmBP+MCZ5BT38oG
         6SO+z/6VCtLV+pY+POMWSN/wYgDN4HTNwKu0bpYYGgE6iOBPPjNurfGEvTyhossmTW
         cE/ISHD6/1+JC+Izp+9PNhS6yRZ+YqCVn3oXvp+bUqHrBx5a+h7TZWDMPdool26Vq7
         b90/I5bpponsYE8ALi52lgsoArwQgaiW+pbekAqb07EGocvR/tE0RIdMvnGIs8mIU+
         gVXK26GpYsCDA==
Date:   Wed, 18 May 2022 11:49:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v5 1/8] ext4: Simplify the handling of cached insensitive
 names
Message-ID: <YoU/0I1CzfDqY/yU@sol.localdomain>
References: <20220518172320.333617-1-krisman@collabora.com>
 <20220518172320.333617-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518172320.333617-2-krisman@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 01:23:13PM -0400, Gabriel Krisman Bertazi wrote:
> Keeping it as qstr avoids the unnecessary conversion in ext4_match
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> --
> Changes since v1:
>   - Simplify hunk (eric)
> ---

The changelog needs to be deleted (or moved below the scissors line).

Otherwise this patch looks good:

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
