Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2C479ECC
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Dec 2021 03:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhLSCVK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Dec 2021 21:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhLSCVK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Dec 2021 21:21:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FB7C061574
        for <linux-ext4@vger.kernel.org>; Sat, 18 Dec 2021 18:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92A5460C8A
        for <linux-ext4@vger.kernel.org>; Sun, 19 Dec 2021 02:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A115DC36AE0;
        Sun, 19 Dec 2021 02:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639880468;
        bh=WPezyHs1ybtTUsYAsbnfvU/yrttJikVXYxXszwgOADI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYeqIzu1LTu9/7JPFim87JT82CZwlCJoW5akKd6waVC9neZDenK8BwKdb3oRInr45
         JIZARD+lw321LT1YpmXQIUN/hAVOja7lWmHfky9Pt1rWg1TH7BSjow3UJOFWM7rTmR
         TXhIWsoWHZ2PYqzJkU1KTy+8yW4B+7Wl6aBNB5kPV9wMlTG4u4X7lcSgLpDAOZN6fy
         78fkssrw4HQuOUYbN6lrjRw9yvbokqwnRflwV/f9qixMAPb8+xdTlOGpIg6JFJ3ZC1
         4vdS2D0oV1LWbZhU5WcINe4O9nthFIgqC+vwo3yI0kvdySYYqJXrXwuP/zLRH7Q/oC
         YQ4QEK4YVE7xQ==
Date:   Sat, 18 Dec 2021 20:21:06 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: Re: [PATCH] test-appliance: add ext4/050 to encrypt.exclude
Message-ID: <Yb6XEo/RcXEZxSai@quark.localdomain>
References: <20211218040814.632571-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218040814.632571-1-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 17, 2021 at 11:08:14PM -0500, Theodore Ts'o wrote:
> The ext4/050 test can't handle encrypted directories, so skip it for
> now.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  .../test-appliance/files/root/fs/ext4/cfg/encrypt.exclude    | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
> index f3c7a959..21a8b45f 100644
> --- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
> +++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
> @@ -12,6 +12,11 @@ ext4/028
>  # file systems with encryption enabled can't be mounted with ext3
>  ext4/044
>  
> +# This test to make sure ext4 directory entries are appropriately
> +# wiped after a file is deleted, or after htree operations is
> +# incompatible with an encrypted directory.
> +ext4/048

The commit message says ext4/050, but the test added to the list is ext4/048.
Is ext4/048 the one intended?

- Eric
