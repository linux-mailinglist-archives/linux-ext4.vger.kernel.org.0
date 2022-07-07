Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED9256AADB
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jul 2022 20:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiGGSds (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbiGGSdg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 14:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F067584
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 11:31:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 095096224A
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 18:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A686C3411E;
        Thu,  7 Jul 2022 18:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657218638;
        bh=s3FfaYpO2K8K2jJiyce9DcPqbhQbMHnDWbFZ1B8wZiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UxDrf1gGmPx5BS2LGiNgcjPWjhfAhQGxeW8V5mOzJoOyXSN3bra5Edo0CNYIS+sCk
         FQx99D7oNEhfVwdLHw32JC2R5q21fsrYzZknEP/mvkGzxUtHuhwZYarA3RIoUmrsan
         umOX72YFMW2f7mh/J+UdjCe8dHHWShFtUuhJs4PYqMD6M+2zsQKQs6OlLcGkoMe75m
         s1VntlkeN1/EWqwWxmGFU7ap7m/Pb4xQ0fH0t/BD3Q2mJCyasu7LiSlcgowuhQ9uXb
         wSSfAzGmEN4h2Ym6YKPHXiBjJi/cynbXh/hFSNzAwbP+1afdtnOKd3z/9zWoyvQeoO
         G464rREsFlxbQ==
Date:   Thu, 7 Jul 2022 18:30:36 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org, krisman@collabora.com
Subject: Re: [PATCH] tune2fs: allow disabling casefold feature
Message-ID: <YscmTC3Mk9OXqOgL@gmail.com>
References: <20220707165400.52951-1-slava@bacher09.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707165400.52951-1-slava@bacher09.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 07, 2022 at 07:54:00PM +0300, Slava Bacherikov wrote:
> Casefold can be safely disabled if there are no directories with +F
> attribute ( EXT4_CASEFOLD_FL ). This checks all inodes for that flag and in
> case there isn't any, it disables casefold FS feature. When FS has
> directories with +F attributes, user could convert these directories,
> probably by mounting FS and executing some script or by doing it
> manually. Afterwards, it would be possible to disable casefold FS flag
> via tune2fs.
> 
> Signed-off-by: Slava Bacherikov <slava@bacher09.org>

Can you please update the man page misc/tune2fs.8.in as well?

- Eric
