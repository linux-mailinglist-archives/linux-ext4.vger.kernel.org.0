Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46795699CD6
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 20:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBPTH7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 14:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBPTH6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 14:07:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF5F16AFB;
        Thu, 16 Feb 2023 11:07:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34D7F60A54;
        Thu, 16 Feb 2023 19:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74702C433D2;
        Thu, 16 Feb 2023 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676574476;
        bh=yrjdiEesNIFfMenZTZuZqyUWgAI/SirIUzvfM3o+UyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TrtQzDxMdqVVGbKpUaNHWxsjLu32jQD+kpKoxcm+sOWgyN1B/lvTShLZmewVZG1AQ
         PQOJKK9ioz8svyFgcR9rukWQYm95K85c4WWqN+5c297q/TsqLnhbgO6J9lijzIEQp3
         CDm+R9ZSlcRw0BRrmx1OmVuRCLaadXFuP6jtHJdcsakUG7iAIki4/2SCTan/hvqXG8
         R4+D0c7AvFjy8xLXI3utIls2DxWUDOQCMgAY6rIUZmZLPazeyjSnGhPQjHgDQQP597
         gmNHOcindc/nvmVpgUE2nn+Z6USs/RysfPJXsS+f2MzcqM+LdoyiWzTfuHB7kJeb9s
         MORSGGJcinsMA==
Date:   Thu, 16 Feb 2023 19:07:55 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Jun Nie <jun.nie@linaro.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <joneslee@google.com>
Subject: Re: [PATCH] ext4: fix another off-by-one fsmap error on 1k block
 filesystems
Message-ID: <Y+5/C6wi6UC9rOCy@gmail.com>
References: <Y+58NPTH7VNGgzdd@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+58NPTH7VNGgzdd@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 16, 2023 at 10:55:48AM -0800, Darrick J. Wong wrote:
> Fixes: 4a4956249dac ("ext4: fix off-by-one fsmap error on 1k block filesystems")
> Link: https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Please add:

Reported-by: syzbot+6be2b977c89f79b6b153@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org

- Eric
