Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE36456ACF5
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jul 2022 22:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbiGGUvZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 16:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiGGUvY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 16:51:24 -0400
Received: from root.slava.cc (root.slava.cc [168.119.137.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0366C2CE06
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 13:51:23 -0700 (PDT)
Message-ID: <856b44ac-c85e-07a4-bb3a-f38829b34d0a@bacher09.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bacher09.org;
        s=reg; t=1657227082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yroZ1cmSTrktepjPMGwbgW0hPIuNJsg+hBP/hopVWTA=;
        b=nhorwB+Ofny+K75SA+IFgxi2fA3lzSpimzGXo0gJ/UeCko+W9CkeeP0mgc5vdW6WAbT68k
        vax+f+G6ey92RzA/JpQHslVciEK6Sy3BUcZQF9ktiI27bUxGPMGB6eQ1DPNBz28dvEghz7
        Ffpe/x8TB37G9lgFDuZoL722wPcbHig=
Date:   Thu, 7 Jul 2022 23:51:19 +0300
MIME-Version: 1.0
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org, krisman@collabora.com
References: <YscmTC3Mk9OXqOgL@gmail.com>
 <20220707190456.64972-1-slava@bacher09.org> <Ysc5HYPXUs6rW02S@gmail.com>
From:   Slava Bacherikov <slava@bacher09.org>
Subject: Re: [PATCH v2] tune2fs: allow disabling casefold feature
In-Reply-To: <Ysc5HYPXUs6rW02S@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



07.07.2022 22:50, Eric Biggers wrote:
> On Thu, Jul 07, 2022 at 10:04:56PM +0300, Slava Bacherikov wrote:

> Also, what are the semantics of disabling casefold, exactly?  Do the encoding
> and encoding flags fields in the superblock also get cleared?
> 
> - Eric

Sorry, I've totally missed that. It worked just fine on a kernel 
compiled without casefold, because kernel is ignoring encoding if there 
is no casefold flag. And dumpe2fs wasn't showing character encoding on 
fs that had no casefold feature.

Anyway, I've already updated patch.

--
Slava Bacherikov
