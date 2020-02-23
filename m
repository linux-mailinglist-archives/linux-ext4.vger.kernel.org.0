Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785A7169791
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Feb 2020 13:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgBWMe1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Feb 2020 07:34:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40335 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgBWMe1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Feb 2020 07:34:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id b185so3814683pfb.7;
        Sun, 23 Feb 2020 04:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nRX8NVb8sA2C3VRrxdRuHyU9n580bY1jnLZ5ycnXc1g=;
        b=GcrycDugcVqdCUcmBIoMWS8XlU6eP2VHnXtRb5ljzZB/lNgxgOfLukkm0iiJC3SCBH
         71tzTgUmdvE5lNwovktiv+CaTM190E0cXvQzNGHA/lJBFx8E1OHDKjd0Od6bdFaQK+1R
         WOtS30ts4scszykZ8dYj2LIh+yB1uGWPjjclxl88I+TL5OrOTAVoaGMhW/2p0M/8+qhj
         Q7JjVqrFF/RSnEwpGF6TK+Wy51zBSVK70IKuvjXccOdzpH2yeNUOSU+eISLBzChS0GDw
         MEghTyPcT2vRu96ePei9GREzpi4ecBhfiBPy5QGGK1z6MtUC5dVzR+68EfP+09mRtEAt
         JTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nRX8NVb8sA2C3VRrxdRuHyU9n580bY1jnLZ5ycnXc1g=;
        b=kXx2QLqRhuM6MMVjpnCEysgsOktToA7k+rr/umtb3z8FqygdrCAm4/vmH0gmcUiAIP
         V/ts0X54kdBVxhQiTNwakccHJW/LYEpj0c1yry6ZTc4H/R4r2IgNsJZ8MXTsk/dvGQX3
         BwtG0nbszOlTM3Jb/XBJE2hKUYBAjkoOv7xMJt5muFOzyDi4VSN0Gol+x9q5M7uI+M8L
         z6j+wq7swDpOLi440/pD6Z6bMImTj0TNgHOpcGSsMxS9XeTijUbQJSulCFo+ikTjGIcM
         VLUI7OzPn7PVMEf7a2zg+b8fdRKum687CMiu+X6vBdysrUfPUGB8NyPvP+vSJlpFS8fB
         41iw==
X-Gm-Message-State: APjAAAXG9MD9E4oQ/8DGGKSs3DXASib+t+Zq3ZjAvxWMctXWUsRAqNqK
        f9D4Q5a6g/4+bCkg+TEEAfY=
X-Google-Smtp-Source: APXvYqzdFqMm7kSXzVhPv5GT1bNmEy9NJ6q57kDe57Z1Vilv805KDBkDJnYKKrowLfCm2X9IDCDjcg==
X-Received: by 2002:a62:788a:: with SMTP id t132mr47299622pfc.134.1582461266702;
        Sun, 23 Feb 2020 04:34:26 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id r8sm8679385pjo.22.2020.02.23.04.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 04:34:25 -0800 (PST)
Date:   Sun, 23 Feb 2020 20:34:15 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4/021: make sure the fdatasync subprocess exits
Message-ID: <20200223123411.GA3840@desktop>
References: <20200214022001.15563-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214022001.15563-1-yi.zhang@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 14, 2020 at 10:20:01AM +0800, zhangyi (F) wrote:
> Now we just kill fdatasync_work process and wait nothing after the
> test, so a busy unmount failure may appear if the fdatasync syscall
> doesn't return in time.
> 
>   umount: /tmp/scratch: target is busy.
>   mount: /tmp/scratch: /dev/sdb already mounted on /tmp/scratch.
>   !!! failed to remount /dev/sdb on /tmp/scratch
> 
> This patch kill and wait the xfs_io fdatasync subprocess to make sure
> _check_scratch_fs success.

Yeah, that's a problem.

I think you could add another "trap" in fdatasync_work, as what
btrfs/036 does:

	trap "wait; exit" SIGTERM

So xfs_io will be waited by fdatasync_work before exiting.

Thanks,
Eryu

> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---
>  tests/ext4/021 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/ext4/021 b/tests/ext4/021
> index 519737e1..1b4a1ced 100755
> --- a/tests/ext4/021
> +++ b/tests/ext4/021
> @@ -18,6 +18,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  
>  _cleanup()
>  {
> +	$KILLALL_PROG -wq xfs_io
>  	cd /
>  	rm -f $tmp.*
>  }
> -- 
> 2.23.0.rc2.8.gff66981f45
> 
