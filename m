Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE44A4CBA
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jan 2022 18:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380699AbiAaRHD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jan 2022 12:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiAaRHC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 Jan 2022 12:07:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2D1C061714;
        Mon, 31 Jan 2022 09:07:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A750C60D29;
        Mon, 31 Jan 2022 17:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03070C340E8;
        Mon, 31 Jan 2022 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643648821;
        bh=ZTKVQCc+94eGzJ1trmzZG4GCQ0nYIOn8VXLhmFckBOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1AC4+CUtL2rGnRxTmWhbpT0Pm/zINOohwzh2/6MvO6O0iKSIMPpfT99BoqfZ/fvB
         A2+WW3W86HTmLMiThqR+6yOso2QYeV22ZKVD+IAaZ9LhUklY8O35witLlTapMuZf/G
         bi0+RRlgBbpt0fqPVWxa/XSe2r30qhLDJqjXaQ1m2qQEhFKNQvLBFlxAe/1j21VEIq
         64e6Q0Tr4h1QiEPbWq7B4f0dkxChxLNQorHBfH43mEJ/qyLBoeT/luzhzk8GBTufkl
         Ql97zq0u+bTAn+3iUtWfII85XEw/3wRxI/k1qiChy+rrRQjAaq98Yblirq3ye0gbIQ
         xVQXv45LfbT7w==
Date:   Mon, 31 Jan 2022 09:07:00 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] common/rc: set maximum label length for ext4
Message-ID: <20220131170700.GA8288@magnolia>
References: <20211123101119.5112-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123101119.5112-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 23, 2021 at 11:11:19AM +0100, Lukas Czerner wrote:
> Set maximum label length for ext4 in _label_get_max() to be able to test
> online file system label set/get ioctls.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 8e351f17..50d6d0bd 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4545,6 +4545,9 @@ _label_get_max()
>  	f2fs)
>  		echo 255
>  		;;
> +	ext2|ext3|ext4)
> +		echo 16

After reviewing the ext4 ondisk format, 16 is the correct value.

Though I wonder, what actually prevents generic/492 from running on old
kernels without GETLABEL support?

Either way this patch is ok, so...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +		;;
>  	*)
>  		_notrun "$FSTYP does not define maximum label length"
>  		;;
> -- 
> 2.31.1
> 
