Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC86C3B55A2
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jun 2021 00:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhF0Woq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Jun 2021 18:44:46 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:45699 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231644AbhF0Wop (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 27 Jun 2021 18:44:45 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id A5D9F1B093D;
        Mon, 28 Jun 2021 08:42:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lxdTl-0009vs-If; Mon, 28 Jun 2021 08:42:17 +1000
Date:   Mon, 28 Jun 2021 08:42:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Wang Shilong <wshilong@ddn.com>
Subject: Re: [PATCH] ext4: forbid U32_MAX project ID
Message-ID: <20210627224217.GL2419729@dread.disaster.area>
References: <20210625124033.5639-1-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625124033.5639-1-wangshilong1991@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=lB0dNpNiAAAA:8 a=7-415B0cAAAA:8
        a=olheZxfBlaoEw9cQjO0A:9 a=CjuIK1q_8ugA:10 a=c-ZiYqmG3AbHTdtsH08C:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 25, 2021 at 08:40:33AM -0400, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> U32_MAX is reserved for special purpose,
> qid_has_mapping() will return false if projid is
> 4294967295, dqget() will return NULL for it.
> 
> So U32_MAX is unsupported Project ID, fix to forbid
> it.

Actually, it's INVALID_PROJID, not U32_MAX, and we already have a
check function for that:

static inline bool projid_valid(kprojid_t projid)
{
        return !projid_eq(projid, INVALID_PROJID);
}

> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>  fs/ext4/ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 31627f7dc5cd..f3a8d962c291 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -744,6 +744,9 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
>  	u32 flags = fa->flags;
>  	int err = -EOPNOTSUPP;
>  
> +	if (fa->fsx_projid >= U32_MAX)
> +		return -EINVAL;
> +

This should actually be calling qid_valid() or projid_valid(),
and it should be in generic code because multiple filesystems
support project quotas.  i.e this should be checked in
fileattr_set_prepare(), not in ext4 specific code.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
