Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628EB6AF644
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 20:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjCGT6d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 14:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjCGT6D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 14:58:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73DF8FBD9
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 11:54:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 707FB61518
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 19:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B64C433EF
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 19:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678218852;
        bh=kAlO3iUr2C5YB0/INyx7E4wH9nyj0pdy6Cg3ZayA0Xo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=XIN8u+xvXdetvuHp2Xb1WnsINV9D6pWIYLgqwlluUE817rAM8Z314zFRFIEBBzhZW
         fZmFSFmzbQeuA5abOYe9ZHwNPOPuli8omlnoIQNZ3wesbuNL5Wd8j3Mij+0r1onL4l
         CeaeptsCx+UT7jEa9GYBhQOqUKcM1A1ft4bDnbI1Z4aL1FEwAo7FSOP79oLNfokdtD
         i9kSPFm8wUP/7z5cOdmD1fQDOfxVXUmq+o92FiZ/dr4hFEj7cWnD0YEKep6Lqma5zC
         YOGsmxJjFM/DHmS5kyQDihRAaHkRbDReK3OepeYd7NwK2cD9zQhXcZxHa7U830xGYz
         kzcSQTApPG5ew==
Date:   Tue, 7 Mar 2023 11:54:11 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] ci.yml: store the config.h files as workflow
 artifacts
Message-ID: <ZAeWY6dAVXLIZ284@sol.localdomain>
References: <20230208065858.227695-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208065858.227695-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 07, 2023 at 10:58:58PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Store the config.h file for each platform as a workflow artifact, so
> that it will be possible to download them and compare them to
> util/android_config.h.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  .github/workflows/ci.yml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Ping.
