Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA954606F5
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Nov 2021 15:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357847AbhK1OjA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Nov 2021 09:39:00 -0500
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:34934 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353175AbhK1OhA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Nov 2021 09:37:00 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07725649|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0149221-0.00481884-0.980259;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.M-fxwva_1638110021;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.M-fxwva_1638110021)
          by smtp.aliyun-inc.com(10.147.41.138);
          Sun, 28 Nov 2021 22:33:42 +0800
Date:   Sun, 28 Nov 2021 22:33:41 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] common/rc: set maximum label length for ext4
Message-ID: <YaOTRYYkEwlbnvPb@desktop>
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

Some background info included in commit log would be good, e.g. ext4
didn't support get/set label ioctl but we're going to add that support
in both kernel and e2fsprogs.

And I noticed the kernel patch is still in review, and has no comments
so far. So I'd like to wait and make sure the new ioctl will be accepted
first.

Thanks,
Eryu

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
> +		;;
>  	*)
>  		_notrun "$FSTYP does not define maximum label length"
>  		;;
> -- 
> 2.31.1
