Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB8173D4
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2019 10:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfEHI3e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 May 2019 04:29:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46776 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfEHI3d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 May 2019 04:29:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF7FF60AA2; Wed,  8 May 2019 08:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557304172;
        bh=JL+KL9NDzZtsBMK7FH7QU5ffLKSntazKn+sY+Xh+/Ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0WY4XC8/Rt0I4zxcl9ODg5P2Q8r0yT8uSsBPSTcxH66MRfmzWHmJjdLP7wjnzuGo
         uVwjSzYj8xnTFGufo6JL4sP8DkZDdA/tqJZZK80MECVTy779iOHZ7OZ6FjUi8rIp/2
         twNSQ7zfI2qB818Oij+axyPX2VJrAKDTaq0RyQsM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4480260364;
        Wed,  8 May 2019 08:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557304172;
        bh=JL+KL9NDzZtsBMK7FH7QU5ffLKSntazKn+sY+Xh+/Ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0WY4XC8/Rt0I4zxcl9ODg5P2Q8r0yT8uSsBPSTcxH66MRfmzWHmJjdLP7wjnzuGo
         uVwjSzYj8xnTFGufo6JL4sP8DkZDdA/tqJZZK80MECVTy779iOHZ7OZ6FjUi8rIp/2
         twNSQ7zfI2qB818Oij+axyPX2VJrAKDTaq0RyQsM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4480260364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 8 May 2019 13:59:26 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix use-after-free in dx_release()
Message-ID: <20190508082926.GC19198@codeaurora.org>
References: <1557295997-13377-1-git-send-email-stummala@codeaurora.org>
 <9EA5FF19-6602-46AC-AD1A-A2E5B7209040@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9EA5FF19-6602-46AC-AD1A-A2E5B7209040@dilger.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 08, 2019 at 01:09:47AM -0600, Andreas Dilger wrote:
> On May 8, 2019, at 12:13 AM, Sahitya Tummala <stummala@codeaurora.org> wrote:
> > 
> > The buffer_head (frames[0].bh) and it's corresping page can be
> > potentially free'd once brelse() is done inside the for loop
> > but before the for loop exits in dx_release(). It can be free'd
> > in another context, when the page cache is flushed via
> > drop_caches_sysctl_handler(). This results into below data abort
> > when accessing info->indirect_levels in dx_release().
> > 
> > Unable to handle kernel paging request at virtual address ffffffc17ac3e01e
> > Call trace:
> > dx_release+0x70/0x90
> > ext4_htree_fill_tree+0x2d4/0x300
> > ext4_readdir+0x244/0x6f8
> > iterate_dir+0xbc/0x160
> > SyS_getdents64+0x94/0x174
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> 
> The patch looks reasonable, but there is a danger that it may be
> "optimized" back to the pre-patch form again.  It probably makes
> sense to include a comment like:
> 
> 	/* save local copy, "info" may be freed after brelse() */

Thanks for reviewing it. Sure, I will add the comment.

> 
> Looks fine otherwise.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> 
> > ---
> > fs/ext4/namei.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index 4181c9c..7e6c298 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> > @@ -871,12 +871,14 @@ static void dx_release(struct dx_frame *frames)
> > {
> > 	struct dx_root_info *info;
> > 	int i;
> > +	unsigned int indirect_levels;
> > 
> > 	if (frames[0].bh == NULL)
> > 		return;
> > 
> > 	info = &((struct dx_root *)frames[0].bh->b_data)->info;
> > -	for (i = 0; i <= info->indirect_levels; i++) {
> > +	indirect_levels = info->indirect_levels;
> > +	for (i = 0; i <= indirect_levels; i++) {
> > 		if (frames[i].bh == NULL)
> > 			break;
> > 		brelse(frames[i].bh);
> > --
> > Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> > 
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 



-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
