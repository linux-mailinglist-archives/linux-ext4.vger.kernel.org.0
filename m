Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F952C354
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 21:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbiERT06 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 15:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241962AbiERT06 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 15:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C45355211
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 12:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE58C6191C
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 19:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD69C385A5;
        Wed, 18 May 2022 19:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652902016;
        bh=6bK0g96KHKgmSLVgDc/esxHtkqrzJWXIyc5tLrYriNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2Wz/2Nvj4IMrE3hQMQPPRHCALP2EaKRug9MA4I0XX7WC/5AfQJY0lvZN+mFRZLkw
         RoxwlJF3mCK7hGxKuNfWOwCmr5JyS8BJm0mTLOINQpO2Oh6AA4yKBpcb3lz9AG6P04
         DXJk4MimjTgMHrgYigXWoHY/VZd//Cj7wWBVvyi+v/JlW92EweUrqC1Pc/VFnbCWbB
         pAZl6zwc68mXSlm4nextD9sS38g6I8wg8jCuqccKA1pbNgANC6SZN9VBvi6dhHLQ8U
         hSG/e3nnI8tqJ5OKiJWVlncLTQVjvhEt8oGO9gUvnJuthqXwPfPshuIfN6ylaB/DYx
         tRRp4rE5HydQA==
Date:   Wed, 18 May 2022 12:26:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v5 8/8] f2fs: Move CONFIG_UNICODE defguards into the code
 flow
Message-ID: <YoVIfsjT2OE6Wj2k@sol.localdomain>
References: <20220518172320.333617-1-krisman@collabora.com>
 <20220518172320.333617-9-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518172320.333617-9-krisman@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 01:23:20PM -0400, Gabriel Krisman Bertazi wrote:
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes since v4:
>   - Drop stub removal for !CONFIG_UNICODE case (eric)
> ---
>  fs/f2fs/namei.c | 11 +++++------
>  fs/f2fs/super.c |  8 ++++----
>  2 files changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
