Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A903B8685
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 17:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhF3PyU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 11:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235726AbhF3PyT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 11:54:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE3D5611CA;
        Wed, 30 Jun 2021 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625068310;
        bh=7fhf6pxUaSFPwZo50RxCo5ZCrh3FKIYAtt1Da5hj71U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pUySNyTxHDI1iiQSxUcfoQPYKNDrn8ufSTuTj2Bf93zvp5F0m4wsioKZvLDqXAFcx
         KuTqdVwo/io0G3CcIfRcIBJ2xZ+MAlxHj19bIgsPJjVpBhbTfz2MXe8PIy/yTy34iG
         4Srv/tjXZLubB8UIh4Q+VcAVt4nT8ZNGnZXuYo+5C5V2saOagm11lTwFiMRjg6cmfB
         NEQeMCMcxMgr9CIYr+5uwYzEVACyDBCclAxU42nKg5/gE32IfTP3lFm19QGmmt7qBr
         ethFX0wR4sTd8Ls6KecTlA6Wjcit18FK9vrYmLKhRRfTB/ucqTEMVfHu2KERWRCI9Q
         /W4l5NIlol/lA==
Date:   Wed, 30 Jun 2021 08:51:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 9/9] common/attr: Reduce MAX_ATTRS to leave some overhead
 for 64K blocksize
Message-ID: <20210630155150.GC13743@locust>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <f23e6788b958849ec9c1fb7fed0081e58c02a13a.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23e6788b958849ec9c1fb7fed0081e58c02a13a.1623651783.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 14, 2021 at 11:58:13AM +0530, Ritesh Harjani wrote:
> Test generic/020 fails for ext4 with 64K blocksize. So increase some overhead
> value to reduce the MAX_ATTRS so that it can accomodate for 64K blocksize.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  common/attr | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/attr b/common/attr
> index d3902346..e8661d80 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -260,7 +260,7 @@ xfs|udf|pvfs2|9p|ceph|nfs)
>  	# Assume max ~1 block of attrs
>  	BLOCK_SIZE=`_get_block_size $TEST_DIR`
>  	# user.attribute_XXX="value.XXX" is about 32 bytes; leave some overhead
> -	let MAX_ATTRS=$BLOCK_SIZE/40
> +	let MAX_ATTRS=$BLOCK_SIZE/48

50% is quite a lot of overhead; maybe we should special-case this?

--D

>  esac
>  
>  export MAX_ATTRS
> -- 
> 2.31.1
> 
